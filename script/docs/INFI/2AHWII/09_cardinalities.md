

- **Kardinalität** beschreibt wie viele Entitäten einer Menge zu einer Entität der anderen Menge gehören
- In anderen Worten: Welcher Tabelleneintrag wie oft in anderen Tabellen referenziert wird 
- **Optionalität** beschreibt ob es mindestens eine Referenzierung gibt


## Arten von Kardinalitäten

### 1:1 (One-to-One)

Beispiel: Person <-> Pass

- Eine Person hat **höchstens einen** Pass
- Ein Pass gehört **genau einer** Person

**Umsetzung:**

- **FK mit UNIQUE** auf der "Pass"-Seite. Stellt "höchstens einen" sicher, da eindeutig sein muss.

=== "SQLite"

    ```sql
    PRAGMA foreign_keys = ON;

    CREATE TABLE person (
        person_id INTEGER PRIMARY KEY,
        name      TEXT NOT NULL
    );

    CREATE TABLE pass (
        pass_id   INTEGER PRIMARY KEY,
        person_id INTEGER NOT NULL UNIQUE,     -- UNIQUE => 1:1
        nummer    TEXT NOT NULL UNIQUE,
        FOREIGN KEY (person_id) REFERENCES person(person_id)
    );
    ```
=== "MS SQL Server"

    ```sql
    CREATE TABLE Person (
        PersonID INT IDENTITY(1,1) CONSTRAINT PK_Person PRIMARY KEY,
        Name     NVARCHAR(100) NOT NULL
    );

    CREATE TABLE Pass (
        PassID   INT IDENTITY(1,1) CONSTRAINT PK_Pass PRIMARY KEY,
        PersonID INT NOT NULL UNIQUE,  -- UNIQUE => 1:1
        Nummer   NVARCHAR(30) NOT NULL UNIQUE,
        CONSTRAINT FK_Pass_Person FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
    );
    ```
    
### 1:n (One-to-Many)

Beispiel: Abteilung (1) - Mitarbeiter (n)

- Eine Abteilung hat viele (n) Mitarbeiter
- Aber ein Mitarbeiter kann nur in einer (1) Abteilung arbeiten

**Umsetzung:**

- **FK in der „n“-Tabelle**. Optionalität steuerst du über NULL/NOT NULL.

=== "SQLite"

    ```sql
    PRAGMA foreign_keys = ON;

    CREATE TABLE department (
    dept_id INTEGER PRIMARY KEY,
    name    TEXT NOT NULL UNIQUE
    );

    CREATE TABLE employee (
    emp_id  INTEGER PRIMARY KEY,
    name    TEXT NOT NULL,
    dept_id INTEGER NOT NULL,  -- NOT NULL => jeder Employee hat Department
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
        ON DELETE RESTRICT   -- Alternativen: CASCADE / SET NULL
        ON UPDATE CASCADE
    );
    ```
=== "SQL Server"

    ```sql
    CREATE TABLE Department (
        DeptID INT IDENTITY(1,1) CONSTRAINT PK_Department PRIMARY KEY,
        Name   NVARCHAR(80) NOT NULL UNIQUE
    );

    CREATE TABLE Employee (
        EmpID  INT IDENTITY(1,1) CONSTRAINT PK_Employee PRIMARY KEY,
        Name   NVARCHAR(100) NOT NULL,
        DeptID INT NOT NULL,
        CONSTRAINT FK_Employee_Department
            FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
            ON DELETE NO ACTION  -- Alternativ: CASCADE / SET NULL
            ON UPDATE CASCADE
    );
    ```

!!! tip "Hinweis"
    Optionalität modellieren:

    - `DeptID NULL`: 0:n (optional)
    - `DeptID NOT NULL`: 1:n (obligatorisch) 

### m:n (Many-to-Many)

Beispiel: Student (n) <-> Kurs (m)

- Ein Student kann in vielen (n) Kursen teilnehmen
- Ein Kurs kann viele (m) Studenten behinhalten

**Umsetzung:**

- **Zwischentabelle** (Junction/Bridge) mit **Composite PK** aus beiden FKs
- Weitere Beziehungsattribute (z. B. `grade`, `semester`) können in die Zwischentabelle

=== "SQLite"

    ```sql
    PRAGMA foreign_keys = ON;

    CREATE TABLE student (
        student_id INTEGER PRIMARY KEY,
        name       TEXT NOT NULL
    );

    CREATE TABLE course (
        course_id INTEGER PRIMARY KEY,
        title     TEXT NOT NULL
    );

    CREATE TABLE enrollment (
        student_id INTEGER NOT NULL,
        course_id  INTEGER NOT NULL,
        semester   INTEGER NOT NULL,
        grade      TEXT,
        PRIMARY KEY (student_id, course_id, semester),  -- verhindert Duplikate
        FOREIGN KEY (student_id) REFERENCES student(student_id)
            ON DELETE CASCADE,
        FOREIGN KEY (course_id)  REFERENCES course(course_id)
            ON DELETE CASCADE
    );
    ```

=== "MS SQL Server"

    ```sql
    CREATE TABLE Student (
        StudentID INT IDENTITY(1,1) CONSTRAINT PK_Student PRIMARY KEY,
        Name      NVARCHAR(100) NOT NULL
    );

    CREATE TABLE Course (
        CourseID INT IDENTITY(1,1) CONSTRAINT PK_Course PRIMARY KEY,
        Title    NVARCHAR(100) NOT NULL
    );

    CREATE TABLE Enrollment (
        StudentID INT NOT NULL,
        CourseID  INT NOT NULL,
        Semester  TINYINT NOT NULL,
        Grade     NVARCHAR(5) NULL,
        CONSTRAINT PK_Enrollment PRIMARY KEY (StudentID, CourseID, Semester),
        CONSTRAINT FK_Enrollment_Student FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE,
        CONSTRAINT FK_Enrollment_Course  FOREIGN KEY (CourseID)  REFERENCES Course(CourseID)  ON DELETE CASCADE
    );
    ```
    