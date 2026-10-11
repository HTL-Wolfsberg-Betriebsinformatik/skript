CREATE DATABASE OnlineShop;
GO
USE OnlineShop;
GO
CREATE TABLE Kunde (
    Id        INT IDENTITY PRIMARY KEY,
    Vorname   NVARCHAR(50)  NOT NULL,
    Nachname  NVARCHAR(50)  NOT NULL,
    Email     NVARCHAR(100) NULL,
    Ort       NVARCHAR(50)  NOT NULL
);
CREATE TABLE Artikel (
    Id          INT IDENTITY PRIMARY KEY,
    Bezeichnung NVARCHAR(100) NOT NULL,
    Preis       DECIMAL(10,2) NOT NULL,
    Lagerstand  INT NOT NULL DEFAULT 0
);
CREATE TABLE Bestellung (
    Id       INT IDENTITY PRIMARY KEY,
    KundeId  INT NOT NULL REFERENCES Kunde(Id),
    Datum    DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
CREATE TABLE Bestellposition (
    Id            INT IDENTITY PRIMARY KEY,
    BestellungId  INT NOT NULL REFERENCES Bestellung(Id),
    ArtikelId     INT NOT NULL REFERENCES Artikel(Id),
    Menge         INT NOT NULL CHECK (Menge > 0),
    Einzelpreis   DECIMAL(10,2) NOT NULL
);

INSERT INTO Kunde (Vorname, Nachname, Email, Ort) VALUES
 ('Anna','Berger','anna.berger@example.at','Wolfsberg'),
 ('Lukas','Pichler',NULL,'Wolfsberg'),
 ('Sophie','Wallner','s.wallner@example.at','St. Andrä'),
 ('Tobias','Krenn','tobias.krenn@example.at','Klagenfurt'),
 ('Lena','Fuchs','lena.fuchs@example.at','Villach');

INSERT INTO Artikel (Bezeichnung, Preis, Lagerstand) VALUES
 ('USB-Stick 64 GB', 12.90, 50),
 ('Funkmaus', 24.90, 30),
 ('Mechanische Tastatur', 89.00, 12),
 ('27-Zoll-Monitor', 229.00, 5),
 ('HDMI-Kabel 2 m', 7.50, 100),
 ('Webcam Full HD', 49.90, 0);

INSERT INTO Bestellung (KundeId, Datum) VALUES
 (1,'2026-09-14'), (1,'2026-10-02'), (3,'2026-10-05'), (4,'2026-10-06');

INSERT INTO Bestellposition (BestellungId, ArtikelId, Menge, Einzelpreis) VALUES
 (1,1,2,12.90), (1,5,1,7.50),
 (2,4,1,229.00), (2,2,1,24.90),
 (3,3,1,89.00),
 (4,1,5,12.90), (4,5,3,7.50);
