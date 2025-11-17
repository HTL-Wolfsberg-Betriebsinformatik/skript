---
theme: seriph
routerMode: hash
title: Aggregation und Komposition in C#
info: |
  ## Aggregation und Komposition in C#
background: https://github.com/HTL-Wolfsberg-Betriebsinformatik/skript/blob/main/slides/content/slides/background-cover-16-9.webp?raw=true
class: text-center
drawings:
    persist: false
transition: slide-left
mdc: true
layout: cover
hideInToc: true
download: true
export:
    format: pdf
    dark: false
    withClicks: true
    withToc: true
selectable: true
---

# Objektbeziehungen in C#

## *"Wenn Objekte mit anderen Objekten in Beziehung stehen"*

---
hideInToc: true
---

# Inhalt

<Toc minDepth="1" maxDepth="1" />

---

# Stufen der Objektbeziehung

<br>

1️⃣ **Abhängigkeit** → temporäre Nutzung

2️⃣ **Assoziation** → lose Bekanntschaft 

3️⃣ **Aggregation** → Zusammenarbeit  

4️⃣ **Komposition** → untrennbare Zugehörigkeit


---

# Abhängigkeit - temporäre Nutzung

Eine **Dependency** (Abhängigkeit) beschreibt, dass eine Klasse eine andere kurzzeitig benutzt, ohne dass eine dauerhafte Beziehung entsteht.

- Es gibt **kein Feld/Property**, also keine langfristige Beziehung
- Das Objekt wird nur für eine einzelne Operation benötigt
- Die Lebensdauer der beiden Objekte ist nicht verbunden

<br>

**Beispiel:**

Eine **Person** ruft ein **Taxi-Service**. <br>
Das ist **keine Beziehung**, sondern **kurzzeitige Nutzung**.


> ➡️ **Dependency** = Wird kurz benutzt, aber nicht behalten..

---

# Beispiel: Abhängigkeit

```csharp{all|14}{lines:true}
public class TaxiService
{
    public void CallTaxi(string address)
    {
        Console.WriteLine($"Taxi is on the way to {address}");
    }
}

public class Person
{
    public string Name { get; set; }
    public Person(string name) => Name = name;

    public void OrderTaxi(TaxiService taxiService)
    {
        taxiService.CallTaxi("Main Street 12");
    }
}
```

---

# Assoziation – lose Bekanntschaft

- Objekte **kennen** einander,  
- aber keines gehört dem anderen bzw ist Teil eines anderen.

<br>

**Beispiel:**

Ein **Krankenhaus** behandelt **Patienten**, <br>
aber beide **existieren unabhängig** voneinander.

> ➡️ Eine **einfache Verbindung** zwischen zwei Klassen – keine Abhängigkeit in der Lebensdauer.

---

# Beispiel: Assoziation

```csharp{all|8}{lines:true}
public class Patient
{
    public string Name { get; set; }
}

public class Hospital
{
    public List<Patient> Patients { get; } = new();

    public void PrintPatientList()
    {
        foreach (var patient in Patients)
        {
            Console.WriteLine($"{patient.Name}");
        }
    }

    public void AddPatient(Patient patient)
    {
        Patients.Add(patient);
    }
}
```

---

# Aggregation - lose Beziehung

- **Aggregation** beschreibt eine „hat-ein“-Beziehung,  
- bei der ein Objekt Teil eines anderen ist,  
- aber **auch unabhängig existieren kann**.

<br>

**Beispiel:**
- Eine **Krankenhaus** hat viele **Ärzte**  
- Aber ein Arzt kann **auch ohne Krankenhaus** existieren (z. B. durch Wechsel, oder Selbstständig nebenbei)

➡️ Das ist **Aggregation** – eine *lockere Besitzbeziehung*.

---

# Beispiel: Aggregation

```csharp{all|8}{lines:true}
public class Doctor
{
    public string Name { get; set; }
}

public class Hospital
{
    public List<Doctor> Doctors { get; } = new();

    public void AddDoctor(Doctor doctor)
    {
        Doctors.Add(doctor);
    }
}
```
---

# Komposition - starke Bindung

- Eine Klasse **besteht aus** anderen Objekten (*=Teile*),
- die **nur innerhalb** dieses Objekts (*=Ganzes*) **existieren**.
- Teile werden automatisch gelöscht, wenn es kein Ganzes mehr gibt.

<br>

**Beispiel:**
- Ein Raum existiert nicht ohne Haus 
- Der Raum ist ein Teil des Hauses.

➡️ Komposition = *„besitzt und verwaltet“*. Die Lebensdauer der Teile hängt vollständig vom Ganzen ab.

---

# Beispiel: Komposition


```csharp{all|6,15,20-22}{lines:true}
public class Room { ... } // Felder: Name, Area

public class House
{
    public string Address { get; }
    public List<Room> Rooms { get; } = new();

    public House(string address)
    {
        Address = address;
    }

    public void AddRoom(string name, double area)
    {
        Rooms.Add(new Room(name, area)); // Raum wird in der Klasse `House` erstellt (Methode oder Konstruktor)
    }
}

var house = new House("Main Street 12");
house.AddRoom("Living Room", 30); // Anweisungen zum Räume erstellen außerhalb, aber nicht der `Raum` selbst
house.AddRoom("Kitchen", 15);
house.AddRoom("Bedroom", 20);
```

---

# Zusammenfassung

<br>

| Beziehung       | Beispiel        | Lebensdauer | Grund | 
| --------------- | --------------- | ----------- | ------ |
| **Abhängigkeit** | Person – Taxi Service  | unabhängig  | kurzfristige Nutzung   |  
| **Assoziation** | Krankenhaus – Patient  | unabhängig  | kennt, aber besitzt nicht   | 
| **Aggregation** | Krankenhaus – Arzt | unabhängig  | hat ein, aber existiert alleine   |
| **Komposition** | Haus – Raum     | gemeinsam   | besitzt, Lebensdauer ist gebunden  |

