# Graphical User Interfaces in `.NET`

- `.NET` unterstützt mittlerweile einige unterschiedliche Graphical User Interface (GUI) Frameworks.
- Diese unterscheiden sich vor allem 
    - in Einsatzgebiet (e.g. auf welchem Betriebssystem muss es laufen)
    - Wartbarkeit und Erweiterbarkeit (e.g. Library Ökosystem, Trennung von Logik und UI)
    - Lernkurve (wie schwierig ist die Lernkurve)
    - Technologie (e.g. HTML als UI, oder XAML als UI)

## Vergleich

| Framework               | Plattform                | Architektur            | Lernkurve    | Wartbarkeit/Testbarkeit           | Praxisrelevanz                    |
| ----------------------- | ------------------------ | ---------------------- | ------------ | --------------------------------- | --------------------------------- |
| **WPF**                 | Windows                  | **MVVM**, XAML         | mittel       | **hoch** (Bindings, Commands, DI) | hoch (Enterprise/Legacy & modern) |
| **.NET MAUI**           | Win, macOS, iOS, Android | **MVVM** (oder MVU)    | mittel       | hoch (MVVM, DI, Shell)            | steigt (moderne Cross-Platform)   |
| **Avalonia UI**         | Win, macOS, Linux        | **MVVM**, XAML-ähnlich | mittel       | hoch                              | wächst (OSS, cross-desktop)       |
| **Blazor (Web/Hybrid)** | Browser / Hybrid         | Komponenten (Razor)    | mittel       | hoch (Komponenten, DI)            | hoch (Web-Stacks)                 |
| **WinForms**            | Windows                  | ereignisgetrieben      | sehr niedrig | **niedrig**                       | noch verbreitet, aber rückläufig  |


!!! info
    Kurze Erklärung zu **MVVM**: MVVM ist ein Entwurfsmuster (=Lösungsansätze für wiederkehrende Probleme), bei dem die Daten, die Logik und die Darstellung einer App klar getrennt werden, damit Programme übersichtlicher, leichter verständlich und einfacher zu ändern sind.


## Die Qual der Wahl

- **Nur Windows-PCs und Windows Deployments, Fokus auf saubere Architektur:** WPF + MVVM.
    - Stabil, didaktisch ideal, viel Material; übertragbar auf Avalonia/MAUI.
- **Teil Cross-Platform (z. B. auch MacBooks/Android-Phones, aber ohne embedded Linux):** .NET MAUI + MVVM.
    - Moderner Tech-Stack, praxisnah (Mobile + Desktop).
- **Full Cross-Platform (Linux-Rechner/Labore, FOSS-Fokus, Linux Embedded Systems):** Avalonia UI.
    - Nahe an WPF, sehr angenehm zu lehren, echtes Cross-Desktop.
- **Starker Web-Fokus:** Blazor (evtl. Blazor Hybrid für Desktop-Shell).
    - Komponentenbasiert, Wiederverwendung zwischen Web & Desktop.
- **Nur Prototypen bauen:** WinForms, aber **nur für sehr einfache Tools**; später zu MVVM-fähigem Stack wechseln.