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

1️⃣ **Assoziation** → lose Bekanntschaft 

2️⃣ **Aggregation** → Zusammenarbeit  

3️⃣ **Komposition** → untrennbare Zugehörigkeit

---

# Assoziation – lose Bekanntschaft

- Objekte **kennen** einander,  
- aber keines gehört dem anderen.

<br>

**Beispiel:**

Ein **Arzt** behandlet einen **Patienten**, <br>
aber beide **existieren unabhängig** voneinander.

> ➡️ Eine **einfache Verbindung** zwischen zwei Klassen – keine Abhängigkeit in der Lebensdauer.

---

# Beispiel: Assoziation

```csharp{all|6,21}{lines:true}
public class Doctor
{
    public string Name { get; set; }
    public Doctor(string name) => Name = name;

    public void Treat(Patient patient)
    {
        Console.WriteLine($"Dr. {Name} gives {patient.Name} medical treatment.");
    }
}

public class Patient
{
    public string Name { get; set; }
    public Patient(string name) => Name = name;
}

var doctor = new Doctor("King");
var patient = new Patient("James");

doctor.Treat(patient);
```

---

# Aggregation - lose Beziehung

- **Aggregation** beschreibt eine „hat-ein“-Beziehung,  
- bei der ein Objekt Teil eines anderen ist,  
- aber **auch unabhängig existieren kann**.

<br>

**Beispiel:**
- Eine **Schule** hat viele **Lehrer**  
- Aber ein Lehrer kann **auch ohne Schule** existieren (z. B. wechseln)

➡️ Das ist **Aggregation** – eine *lockere Besitzbeziehung*.

---

# Beispiel: Aggregation

```csharp{all|6,11,16,21-22}{lines:true}
public class Teacher { ... } // Felder: Name

public class School
{
    public string Name { get; set; }
    public List<Teacher> Teachers { get; set; } // hat Objekt(e)

    public School(string name)
    {
        Name = name;
        Teachers = new List<Teacher>(); // leer initialisiert, beim Erstellen
    }

    public void AddTeacher(Teacher t)
    {
        Teachers.Add(t); // bekommt erst Objekte nachdem `School` erstellt wurde
    }
}

var school = new School("HTL Wolfsberg");
school.AddTeacher(new Lehrer("Anna")); // Erstellung außerhalb der `School` Klasse
school.AddTeacher(new Lehrer("Markus"));
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

| Beziehung       | Beispiel        | Lebensdauer | Besitz | 
| --------------- | --------------- | ----------- | ------ | 
| **Assoziation** | Arzt – Patient  | unabhängig  | kein   | 
| **Aggregation** | Schule – Lehrer | unabhängig  | lose   |
| **Komposition** | Haus – Raum     | gemeinsam   | stark  |

