USE KPL
DROP TABLE Przejazd_autobusu
DROP TABLE Kontroler
DROP TABLE Kierowca
DROP TABLE Autobus
DROP TABLE Czas
DROP TABLE Data
DROP TABLE Przystanek
DROP TABLE Junk

-- Tworzenie tabeli Kierowca
CREATE TABLE Kierowca (
    ID_Kierowcy NUMERIC IDENTITY(0, 1) PRIMARY KEY,
    PESEL VARCHAR(11) NOT NULL,
    Imie_i_nazwisko VARCHAR(51),
    Znak_zodiaku VARCHAR(15),
    Plec VARCHAR(10),
    Staz_pracy VARCHAR(43),
    Rok_zatrudnienia VARCHAR(4),
    Czy_aktualne VARCHAR(3)
);

-- Tworzenie tabeli Autobus
CREATE TABLE Autobus (
    ID_Autobusu NUMERIC IDENTITY(0, 1) PRIMARY KEY,
    Number_taborowy VARCHAR(4) NOT NULL,
    Model VARCHAR(30),
    Pojemnosc VARCHAR(7),
    Rocznik VARCHAR(4)
);

-- Tworzenie tabeli Przystanek
CREATE TABLE Przystanek (
    ID_Przystanku NUMERIC IDENTITY(0, 1) PRIMARY KEY,
    Czy_jest_poczatkowy VARCHAR(3),
    Miasto VARCHAR(20),
    Ulica VARCHAR(20),
    Numer_budynku VARCHAR(3)
);

-- Tworzenie tabeli Kontroler
CREATE TABLE Kontroler (
    ID_Kontrolera NUMERIC IDENTITY(0, 1) PRIMARY KEY,
    PESEL VARCHAR(11) NOT NULL,
    Imie_i_nazwisko VARCHAR(51),
    Znak_zodiaku VARCHAR(15),
    Plec VARCHAR(10),
    Staz_pracy VARCHAR(40),
    Stawka_godzinowa VARCHAR(12),
    Rok_zatrudnienia VARCHAR(4),
    Czy_aktualne VARCHAR(3)
);

-- Tworzenie tabeli Junk
CREATE TABLE Junk (
    ID_Junk NUMERIC IDENTITY(0, 1) PRIMARY KEY,
    Linia NUMERIC
);

-- Tworzenie tabeli Data
CREATE TABLE Data (
    ID_Daty NUMERIC IDENTITY(0, 1) PRIMARY KEY,
    Data VARCHAR(2),
    Rok VARCHAR(4),
    Miesiac VARCHAR(11),
    Numer_miesiaca NUMERIC,
    Dzien_tygodnia VARCHAR(12),
    Numer_dnia_tygodnia VARCHAR(1)
);

-- Tworzenie tabeli Czas
CREATE TABLE Czas (
    ID_Czas NUMERIC IDENTITY(0, 1) PRIMARY KEY,
    Godzina VARCHAR(2),
    Minuta VARCHAR(2)
);

-- Tworzenie tabeli Przejazd_autobusu
CREATE TABLE Przejazd_autobusu (
    Opoznienie NUMERIC NOT NULL,
    Planowany_czas_trwania NUMERIC,
    Czy_kontrola_wystepuje NUMERIC,
    Ilosc_osob_z_poprawnym_biletem NUMERIC,
    Ilosc_mandatow_za_jazde_bez_biletu NUMERIC,
    Ilosc_mandatow_za_jazde_bez_dokumentu_uprawniajacego_do_ulgi NUMERIC,
    Kurs_no NUMERIC,
    ID_Junk NUMERIC,
    ID_Autobusu NUMERIC,
    ID_Daty NUMERIC,
    ID_Kierowcy NUMERIC,
    ID_Przystanku_rozpoczecia NUMERIC,
    ID_Przystanku_zakonczenia NUMERIC,
    ID_Czasu_rozpoczecia NUMERIC,
    ID_Kontrolera NUMERIC,
    FOREIGN KEY (ID_Junk) REFERENCES Junk(ID_Junk),
    FOREIGN KEY (ID_Autobusu) REFERENCES Autobus(ID_Autobusu),
    FOREIGN KEY (ID_Daty) REFERENCES Data(ID_Daty),
    FOREIGN KEY (ID_Kierowcy) REFERENCES Kierowca(ID_Kierowcy),
    FOREIGN KEY (ID_Przystanku_rozpoczecia) REFERENCES Przystanek(ID_Przystanku),
    FOREIGN KEY (ID_Przystanku_zakonczenia) REFERENCES Przystanek(ID_Przystanku),
    FOREIGN KEY (ID_Czasu_rozpoczecia) REFERENCES Czas(ID_Czas),
    FOREIGN KEY (ID_Kontrolera) REFERENCES Kontroler(ID_Kontrolera)
);