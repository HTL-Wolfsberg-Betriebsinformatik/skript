## Definition

Wiederverwendbare Schablonen für wiederkehrende Probleme in der Softwareentwicklung.

---

### Kategorien
- **Erzeugungsmuster:** Objekt-Erstellung (z. B. Singleton, Factory Method)  
- **Strukturmuster:** Aufbau von Klassen und Objekten (z. B. Adapter, Composite)  
- **Verhaltensmuster:** Interaktion und Kommunikation (z. B. Observer, Strategy)  

---

### Beispiele

**Singleton**  
- Stellt sicher, dass nur eine Instanz einer Klasse existiert.  
- Anwendung: Konfiguration, Logger.  
- **Vorteile:** kontrollierter Zugriff, Ressourcen sparen  
- **Nachteile:** erschwert Unit Tests, kann zu Abhängigkeiten führen  

**Observer**  
- Definiert eine 1:n-Abhängigkeit zwischen Objekten.  
- Wenn sich das „Subject“ ändert, werden alle Beobachter informiert.  
- Anwendung: Event-Systeme, GUI.  
- **Vorteile:** lose Kopplung  
- **Nachteile:** viele Benachrichtigungen können ineffizient sein  

**Strategy**  
- Kapselt austauschbare Algorithmen in eigenen Klassen.  
- Anwendung: Zahlungsarten, Sortierverfahren.  
- **Vorteile:** flexibel, offene Erweiterbarkeit  
- **Nachteile:** erhöhter Klassendefinitionsaufwand  