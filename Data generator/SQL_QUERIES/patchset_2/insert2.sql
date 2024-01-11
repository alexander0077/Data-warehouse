use datasources_p2

BULK INSERT dbo.Kurs FROM 'C:\Users\a9sar\Desktop\data_generator\csvs_patchset2\Courses.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.Przejazd_pomiedzy_przystankami FROM 'C:\Users\a9sar\Desktop\data_generator\csvs_patchset2\Rides.csv' WITH (FIELDTERMINATOR=',')
BULK INSERT dbo.Kontrola FROM 'C:\Users\a9sar\Desktop\data_generator\csvs_patchset2\Controls.csv' WITH (FIELDTERMINATOR=',')