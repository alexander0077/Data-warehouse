

-- Tworzenie tabeli Autobus
CREATE TABLE Autobus (
    ID_Autobusu NUMERIC PRIMARY KEY,
    Number_taborowy VARCHAR(4),
    Model VARCHAR(30),
    Pojemnosc VARCHAR(7),
    Rocznik VARCHAR(4)
);

-- Tworzenie tabeli Przystanek
CREATE TABLE Przystanek (
    ID_Przystanku NUMERIC PRIMARY KEY,
    Czy_jest_poczatkowy VARCHAR(3),
    Miasto VARCHAR(20),
    Ulica VARCHAR(20),
    Numer_budynku VARCHAR(3)
);

-- Tworzenie tabeli Kierowca
CREATE TABLE Kierowca (
    ID_Kierowcy NUMERIC PRIMARY KEY,
    PESEL VARCHAR(11),
    Imie_i_nazwisko VARCHAR(50),
    Znak_zodiaku VARCHAR(10),
    Plec VARCHAR(10),
    Staz_pracy VARCHAR(40),
    Rok_zatrudnienia VARCHAR(4),
    Czy_aktualne VARCHAR(3)
);

-- Tworzenie tabeli Kontroler
CREATE TABLE Kontroler (
    ID_Kontrolera NUMERIC PRIMARY KEY,
    PESEL VARCHAR(11),
    Imie_i_nazwisko VARCHAR(50),
    Znak_zodiaku VARCHAR(10),
    Plec VARCHAR(10),
    Staz_pracy VARCHAR(40),
    Stawka_godzinowa VARCHAR(12),
    Rok_zatrudnienia VARCHAR(4),
    Czy_aktualne VARCHAR(3)
);

-- Tworzenie tabeli Junk
CREATE TABLE Junk (
    ID_Junk NUMERIC PRIMARY KEY,
    Linia NUMERIC
);

-- Tworzenie tabeli Data
CREATE TABLE Data (
    ID_Daty NUMERIC PRIMARY KEY,
    Data VARCHAR(2),
    Rok VARCHAR(4),
    Miesiac VARCHAR(10),
    Numer_miesiaca VARCHAR(2),
    Dzien_tygodnia VARCHAR(12),
    Numer_dnia_tygodnia VARCHAR(1)
);

-- Tworzenie tabeli Czas
CREATE TABLE Czas (
    ID_Czas NUMERIC PRIMARY KEY,
    Godzina VARCHAR(2),
    Minuta VARCHAR(2)
);

-- Tworzenie tabeli Przejazd_autobusu
CREATE TABLE Przejazd_autobusu (
    Nazwa VARCHAR(50),
    Opoznienie NUMERIC NOT NULL,
    Planowany_czas_trwania NUMERIC NOT NULL,
    Czy_kontrola_wystepuje NUMERIC NOT NULL,
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