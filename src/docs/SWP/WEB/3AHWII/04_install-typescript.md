
Bevor wir TypeScript installieren können, benötigen wir **Node.js** und den zugehörigen **npm**-Paketmanager.

## Was ist Node.js?

- **JavaScript-Laufzeitumgebung** außerhalb des Browsers.
- Ermöglicht das Ausführen von JavaScript (und damit auch TypeScript) direkt auf dem Rechner.
- Wird häufig für Serveranwendungen, Build-Tools und CLI-Programme verwendet.

## Was ist npm?

- **Node Package Manager** – installiert automatisch mit Node.js.
- Ermöglicht das Herunterladen, Installieren und Verwalten von Bibliotheken und Tools.
- Beispiel: `npm install typescript` lädt den TypeScript-Compiler herunter.

## Warum brauchen wir Node.js und npm für TypeScript?

TypeScript ist ein **Entwicklerwerkzeug**, das vor der Ausführung in JavaScript **übersetzt** werden muss.  
Der **TypeScript-Compiler (`tsc`)** wird über npm installiert und benötigt Node.js als Laufzeitumgebung.

> Kurz gesagt:  
> **Node.js** → führt Programme aus  
> **npm** → lädt die nötigen Werkzeuge herunter

---

## Installation unter Windows

1. **Node.js herunterladen**  
   Gehe auf die offizielle Website:  
   [https://nodejs.org/](https://nodejs.org/)  
   Lade die **LTS-Version** („Long Term Support“) herunter – diese ist stabiler und wird länger unterstützt.

2. **Installer ausführen**  
   - Lizenzbedingungen akzeptieren  
   - Standardpfade beibehalten  
   - Option „npm package manager“ aktiviert lassen  
   - Optional: „Add to PATH“ aktivieren (meist standardmäßig gesetzt)

3. **Installation überprüfen**  
   Öffne die Eingabeaufforderung (oder PowerShell) und tippe:
   ```powershell
   node -v   # Zeigt die Node.js-Version
   npm -v    # Zeigt die npm-Version

---

## TypeScript installieren

Wenn Node.js und npm funktionieren, können wir den TypeScript-Compiler installieren:

```powershell
npm install -g typescript
```

> Danach steht der Befehl `tsc` im Terminal zur Verfügung.