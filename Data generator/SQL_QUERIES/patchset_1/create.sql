use datasources

-- Tabela Autobus
CREATE TABLE Autobus (
    Numer_taborowy VARCHAR(4) PRIMARY KEY,
    Pojemnosc INT,
    Rocznik INT,
	Model VARCHAR(20)
);

-- Tabela Kurs
CREATE TABLE Kurs (
    ID_kurs VARCHAR(10) PRIMARY KEY,
    Planowany_czas_trwania INT,
    Czas_rozpoczecia DATETIME,
    Czas_zakonczenia DATETIME,
    Linia INT,
    PESEL_kierowcy VARCHAR(11),
    Numer_taborowy_autobusu VARCHAR(4),
    FOREIGN KEY (Numer_taborowy_autobusu) REFERENCES Autobus(Numer_taborowy)
);

-- Tabela Przystanek
CREATE TABLE Przystanek (
    Nazwa VARCHAR(30) PRIMARY KEY,
    Ulica VARCHAR(20),
    Numer INT,
    Miejscowosc VARCHAR(20)
);

-- Tabela Przejazd_pomiedzy_przystankami
CREATE TABLE Przejazd_pomiedzy_przystankami (
    ID_Przejazd_pomiedzy_przystankami VARCHAR(12) PRIMARY KEY,
    Planowany_czas_trwania_przejazdu INT,
    Czas_odjazdu DATETIME,
    Czas_przyjazdu DATETIME,
    Przystanek_odjazdu VARCHAR(30),
    Przystanek_przyjazdu VARCHAR(30),
    ID_kursu VARCHAR(10),
    FOREIGN KEY (Przystanek_odjazdu) REFERENCES Przystanek(Nazwa),
    FOREIGN KEY (Przystanek_przyjazdu) REFERENCES Przystanek(Nazwa),
    FOREIGN KEY (ID_kursu) REFERENCES Kurs(ID_kurs)
);

-- Tabela Kontrola
CREATE TABLE Kontrola (
    ID_Przejazd_pomiedzy_przystankami VARCHAR(12),
    ID_Kontrolera VARCHAR(10),
    Ilosc_osob_z_poprawnym_biletem INT,
    Ilosc_mandatow_za_jazde_bez_biletu INT,
    Ilosc_mandatow_za_jazde_bez_dokumentu_uprawniajacego_do_ulgi INT,
    PRIMARY KEY (ID_Przejazd_pomiedzy_przystankami, ID_Kontrolera),
    FOREIGN KEY (ID_Przejazd_pomiedzy_przystankami) REFERENCES Przejazd_pomiedzy_przystankami(ID_Przejazd_pomiedzy_przystankami)
);
