use datasources_p2

BULK INSERT dbo.Autobus FROM 'C:\Users\a9sar\Desktop\data_generator\csvs\Buses.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.Przystanek FROM 'C:\Users\a9sar\Desktop\data_generator\csvs\BusStops.csv' WITH (
    FIELDTERMINATOR = ';',
    FIRSTROW = 2
);
BULK INSERT dbo.Kurs FROM 'C:\Users\a9sar\Desktop\data_generator\csvs\Courses.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.Przejazd_pomiedzy_przystankami FROM 'C:\Users\a9sar\Desktop\data_generator\csvs\Rides.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.Kontrola FROM 'C:\Users\a9sar\Desktop\data_generator\csvs\Controls.csv' WITH (FIELDTERMINATOR=',')

INSERT INTO Przystanek
VALUES ('-1', null, null, null)

INSERT INTO Autobus
VALUES ('-1', null, null, null)

INSERT INTO Kurs
VALUES ('-1', null, null, null, null, null, '-1')

INSERT INTO Przejazd_pomiedzy_przystankami
VALUES ('-1', null, null, null, '-1', '-1', '-1')

INSERT INTO Kontrola
VALUES ('-1', '-1', null, null, null)