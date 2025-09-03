- Sequenzdiagramme zeigen Abläufe im Zeitverlauf: Wer schickt welche Nachricht an wen – und in welcher Reihenfolge.
- Ideal, um Interaktionen zwischen Objekten/Teilsystemen zu klären (z. B. Login, Bezahlung, Bestellung, API-Aufruf).

!!! tip "Merke"
    Sequenzdiagramme beantworten: *„Welche Beteiligten interagieren, in welcher Reihenfolge, mit welchen Nachrichten?“*

## Elemente

- Teilnehmer/Lifelines: Akteure/Objekte/Services entlang der X-Achse (Zeit läuft nach unten).
- Nachrichten: Pfeile zwischen Lifelines (synchron/async, mit Rückgaben).
- Aktivierungen: Ausführungsbalken, wenn ein Teilnehmer gerade arbeitet.
- Fragmente: Steuerlogik wie `alt`, `opt`, `loop`, `par`, `break`.

## Syntax

**Teilnehmer:**

```mermaid
sequenceDiagram
    actor Benutzer
    participant UI as LoginUI
    participant Auth as AuthService
    participant DB as UserDB
```

**Synchrone Nachricht & Rückgabe:**

```mermaid
sequenceDiagram
    participant A
    participant B
    participant C
    A->>B: Anfrage()
    B->>C: Weiterleitung()
    C-->>B: Zwischenergebnis
    B-->>A: Ergebnis
```

**Asynchrone Nachricht:**

- Asynchrone Nachrichten unterscheiden sich an der Pfeilspitze

```mermaid
sequenceDiagram
    participant Publisher
    participant Broker
    participant Worker
    Publisher-)Broker: Publish(Event)
    Broker-)Worker: Dispatch(Event)
```

- Da die Pfeilspitzen oft übersehen werden für asynchrone Nachrichten, sollte man gleich `[async]` an die Nachrichtenbeschreibung hinzufügen.

```mermaid
sequenceDiagram
    participant Publisher
    participant Broker
    participant Worker
    Publisher-)Broker: Publish(Event) [async]
    Broker-)Worker: Dispatch(Event) [async]
```


**Aktivierungsbalken:**

```mermaid
sequenceDiagram
    participant A
    participant B
    A->>+B: DoWork()
    B-->>-A: Done
```

**`opt` - Optional (if ohne else)**

```mermaid
sequenceDiagram
    participant Shop
    participant Bonus
    Shop->>Bonus: CheckCoupon(code)
    opt gültiger Gutschein
        Bonus-->>Shop: ApplyDiscount()
    end
```


**`alt` - Alternative Pfade (if/else):**

```mermaid
sequenceDiagram
    participant UI
    participant Auth
    UI->>Auth: Login(user, pass)
    alt gültig
        Auth-->>UI: Success
    else ungültig
        Auth-->>UI: Error("Bad credentials")
    end
```

**`loop` - Schleifen:**

```mermaid
sequenceDiagram
    participant Client
    participant API
    loop bis alle Seiten geladen
        Client->>API: GET /items?page=n
        API-->>Client: items
    end
```

**`par` - Parallele Aktionen:**

```mermaid
sequenceDiagram
    participant Orchestrator
    participant S1
    participant S2
    par Aufgabe A
        Orchestrator->>S1: DoA()
        S1-->>Orchestrator: A done
    and Aufgabe B
        Orchestrator->>S2: DoB()
        S2-->>Orchestrator: B done
    end
```

**`break` - Abbruch eines Flows:**

```mermaid
sequenceDiagram
    participant UI
    participant Pay
    UI->>Pay: Pay(amount)
    break Abbruch durch Nutzer
        Pay-->>UI: Cancelled
    end
```

## Praxisbeispiele

### Beispiel: Bestellung im Shop

- Payment & Lager

```mermaid
sequenceDiagram
    actor Kunde
    participant UI as ShopUI
    participant Order as OrderService
    participant Inv as Inventory
    participant Pay as PaymentGateway

    Kunde->>UI: Bestellung aufgeben
    UI->>Order: CreateOrder(cart)
    Order->>Inv: ReserveItems(cart)
    alt Lager ok
        Inv-->>Order: Reserved
        Order->>Pay: Charge(amount)
        alt Zahlung ok
            Pay-->>Order: Paid
            Order-->>UI: OrderConfirmed(123)
        else Zahlung fehlgeschlagen
            Pay-->>Order: Declined
            Order->>Inv: ReleaseReservation(cart)
            Order-->>UI: PaymentError
        end
    else nicht genug Bestand
        Inv-->>Order: OutOfStock
        Order-->>UI: OutOfStockHint
    end
```

### Beispiel: Login mit 2-FA (2-Factor Authentication)

```mermaid
sequenceDiagram
    actor Benutzer
    participant UI as LoginUI
    participant Auth as AuthService
    participant DB as UserDB
    participant OTP as OtpService

    Benutzer->>UI: Benutzername+Passwort eingeben
    UI->>Auth: Authenticate(user, pass)
    Auth->>+DB: GetUser(user)
    DB-->>-Auth: UserRecord {Hash, Has2FA}
    Auth->>Auth: VerifyHash(pass, Hash)

    alt Passwort korrekt
        alt 2FA aktiviert
            Auth->>+OTP: SendCode(to:user)
            OTP-->>-Auth: OK
            Auth-->>UI: Prompt2FA()
            Benutzer->>UI: Code eingeben
            UI->>Auth: Verify2FA(code)
            Auth->>+OTP: Validate(code)
            OTP-->>-Auth: Valid/Invalid
            alt gültig
                Auth-->>UI: Success(Token)
            else ungültig
                Auth-->>UI: Error("2FA falsch")
            end
        else keine 2FA
            Auth-->>UI: Success(Token)
        end
    else Passwort falsch
        Auth-->>UI: Error("Bad credentials")
    end
```

### Beispiel: Chat-Nachrichten (asynchron)

```mermaid
sequenceDiagram
    autonumber
    actor ClientA as Client A (Sender)
    participant S as ChatServer
    participant DB as MessageStore
    participant ClientB as Client B (Empfänger)
    participant ClientC as Client C (Empfänger)

    %% Sender schickt Nachricht asynchron an den Server
    ClientA-)S: SendMessage(msg) [async]

    %% Server persistiert synchron (z. B. DB-Write)
    S->>+DB: Save(msg) [sync]
    DB-->>-S: OK

    %% optionales Ack zurück an den Sender
    opt Ack an Sender
        S-->>ClientA: Ack(msgId) [sync]
    end

    %% Parallel: Broadcast an andere Clients (asynchron)
    par Broadcast an Empfänger
        %% Empfänger B
        alt B online
            S-)ClientB: Deliver(msg) [async]
            opt Zustellbestätigung
                ClientB-->>S: Delivered(msgId) [sync]
            end
        else B offline
            S->>DB: QueueForLater(B, msgId) [sync]
        end

        %% Empfänger C (analog)
        alt C online
            S-)ClientC: Deliver(msg) [async]
            opt Zustellbestätigung
                ClientC-->>S: Delivered(msgId) [sync]
            end
        else C offline
            S->>DB: QueueForLater(C, msgId) [sync]
        end
    end
```

!!! note "Hinweis"
    Da wir einen System-zu-System Ablauf darstellen (Nachricht wird vom Server an andere Client-Programme verteilt), macht es mehr Sinn, B und C als `participants` (Rechteck) zu zeigen.
    Wenn wir die Interaktion Mensch ↔ Client-App betonen wollten, wären B und C `actors` (also Strichmännchen).


# Test

```mermaid
flowchart TD
    Start([Start])
    Decision{Graphviz installed?}
    ProcessAll["process all diagrams"]
    ProcessSome["process only<br/>sequence and activity diagrams"]
    End([Stop])

    Start --> Decision
    Decision -- Yes --> ProcessAll
    Decision -- No --> ProcessSome
    ProcessAll --> End
    ProcessSome --> End
```