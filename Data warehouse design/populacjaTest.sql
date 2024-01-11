USE KPL

-- Usuwanie wszystkich danych z tabeli Przejazd_autobusu
DELETE FROM Przejazd_autobusu;

-- Usuwanie wszystkich danych z tabeli Autobus
DELETE FROM Autobus;

-- Usuwanie wszystkich danych z tabeli Przystanek
DELETE FROM Przystanek;

-- Usuwanie wszystkich danych z tabeli Kierowca
DELETE FROM Kierowca;

-- Usuwanie wszystkich danych z tabeli Kontroler
DELETE FROM Kontroler;

-- Usuwanie wszystkich danych z tabeli Junk
DELETE FROM Junk;

-- Usuwanie wszystkich danych z tabeli Data
DELETE FROM Data;

-- Usuwanie wszystkich danych z tabeli Czas
DELETE FROM Czas;

INSERT INTO Przystanek (ID_Przystanku, Czy_jest_poczatkowy, Miasto, Ulica, Numer_budynku)
VALUES
    (0,'Tak', 'Miasto1', 'Ulica1', '1'),
    (1,'Nie', 'Miasto2', 'Ulica2', '2'),
    (2,'Tak', 'Miasto3', 'Ulica3', '3'),
    (3,'Nie', 'Miasto4', 'Ulica4', '4'),
    (4,'Nie', 'Miasto5', 'Ulica5', '5');

INSERT INTO Kontroler (ID_Kontrolera, PESEL, Imie_i_nazwisko, Znak_zodiaku, Plec, Staz_pracy, Stawka_godzinowa, Rok_zatrudnienia, Czy_aktualne)
VALUES
	 (0,'98765432101', 'Kontroler1', 'Wodnik', 'Kobieta', 'Miêdzy rokiem a dwoma latami', 'Œrednia', '2015', 'Tak'),
    (1,'87654321012', 'Kontroler2', 'Baran', 'Mê¿czyzna', 'Powy¿ej piêciu lat', 'Du¿a', '2014', 'Tak'),
    (2,'76543210923', 'Kontroler3', 'Rak', 'Kobieta', 'Miêdzy dwoma latami a czterema latami', 'Ma³a', '2016', 'Tak'),
    (3,'65432109834', 'Kontroler4', 'Byk', 'Mê¿czyzna', 'Powy¿ej piêciu lat', 'Du¿a', '2013', 'Tak'),
    (4,'54321098745', 'Kontroler5', 'Bliznieta', 'Kobieta', 'Miêdzy rokiem a dwoma latami', 'Wolontariat', '2017', 'Tak');

INSERT INTO Kierowca (ID_Kierowcy, PESEL, Imie_i_nazwisko, Znak_zodiaku, Plec, Staz_pracy, Rok_zatrudnienia, Czy_aktualne)
VALUES
    (0,'12345678901', 'Kierowca1', 'Rak', 'Mê¿czyzna', 'Powy¿ej piêciu lat', '2010', 'Tak'),
    (1,'23456789012', 'Kierowca2', 'Byk', 'Kobieta', 'Miêdzy dwoma latami a czterema latami', '2015', 'Tak'),
    (2,'34567890123', 'Kierowca3', 'Bliznieta', 'Mê¿czyzna', 'Miêdzy rokiem a dwoma latami', '2018', 'Tak'),
    (3,'45678901234', 'Kierowca4', 'Rak', 'Kobieta', 'Miêdzy rokiem a dwoma latami', '2017', 'Tak'),
    (4,'56789012345', 'Kierowca5', 'Byk', 'Mê¿czyzna', 'Powy¿ej piêciu lat', '2012', 'Tak');

INSERT INTO Junk (ID_Junk, Linia)
VALUES
    (0,1),
    (1,2),
    (2,3),
    (3,4),
    (4,5);

	INSERT INTO Data (ID_Daty, Data, Rok, Miesiac, Numer_miesiaca, Dzien_tygodnia, Numer_dnia_tygodnia)
VALUES
    (0,'01', '2022', 'Styczeñ', '1', 'Poniedzia', '1'),
    (1,'02', '2022', 'Luty', '2', 'Wtorek', '2'),
    (2,'03', '2022', 'Marzec', '3', 'Sroda', '3'),
    (3,'04', '2022', 'Kwiecieñ', '4', 'Czwartek', '4'),
    (4,'05', '2022', 'Maj', '5', 'Piatek', '5');

	INSERT INTO Czas (ID_Czas, Godzina, Minuta)
VALUES
    (0,'12', '30'),
    (1,'14', '45'),
    (2,'16', '15'),
    (3,'18', '20'),
    (4,'20', '55');

	INSERT INTO Autobus (ID_Autobusu,Number_taborowy, Model, Pojemnosc, Rocznik)
VALUES
    (0,'1234', 'Model1', 'Mala', '2020'),
    (1,'5678', 'Model2', 'Srednia', '2019'),
    (2,'9101', 'Model3', 'Duza', '2022'),
    (3,'1213', 'Model4', 'Srednia', '2020'),
    (4,'4151', 'Model5', 'Duza', '2021');

	INSERT INTO Przejazd_autobusu (Nazwa, Opoznienie, Planowany_czas_trwania, Czy_kontrola_wystepuje, Ilosc_osob_z_poprawnym_biletem, Ilosc_mandatow_za_jazde_bez_biletu, Ilosc_mandatow_za_jazde_bez_dokumentu_uprawniajacego_do_ulgi, Kurs_no, ID_Junk, ID_Autobusu, ID_Daty, ID_Kierowcy, ID_Przystanku_rozpoczecia, ID_Przystanku_zakonczenia, ID_Czasu_rozpoczecia, ID_Kontrolera)
VALUES
    ('Przejazd1', 5, 60, 1, 50, 2, 1, 0, 4, 0, 4, 0, 1, 2, 1, 1),
    ('Przejazd2', 2, 45, 0, 30, 0, 1, 1, 3, 1, 3, 1, 2, 3, 2, 2),
    ('Przejazd3', 8, 75, 1, 70, 5, 2, 2, 2, 2, 2, 2, 2, 4, 3, 3),
    ('Przejazd4', 3, 50, 0, 40, 0, 0, 3, 1, 3, 1, 3, 4, 0, 4, 4),
    ('Przejazd5', 6, 65, 1, 60, 3, 1, 4, 0, 4, 0, 4, 0, 1, 2, 1);