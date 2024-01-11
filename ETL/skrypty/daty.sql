DECLARE @Rok INT = 2010;
DECLARE @Miesiac INT = 1;
DECLARE @IloscDni INT;

WHILE @Rok <= 2023
BEGIN
    WHILE @Miesiac <= 12
    BEGIN
        SET @IloscDni = DAY(EOMONTH(CONVERT(DATE, CONVERT(VARCHAR(4), @Rok) + '-' + CONVERT(VARCHAR(2), @Miesiac) + '-01')));

        DECLARE @Dzien INT = 1;

        WHILE @Dzien <= @IloscDni
        BEGIN
            INSERT INTO KPL.dbo.Data (Data, Rok, Miesiac, Numer_miesiaca, Dzien_tygodnia, Numer_dnia_tygodnia)
            VALUES (
                CONVERT(VARCHAR(2), @Dzien),
                CONVERT(VARCHAR(4), @Rok),
                CASE @Miesiac
                    WHEN 1 THEN 'Styczen'
                    WHEN 2 THEN 'Luty'
                    WHEN 3 THEN 'Marzec'
                    WHEN 4 THEN 'Kwiecien'
                    WHEN 5 THEN 'Maj'
                    WHEN 6 THEN 'Czerwiec'
                    WHEN 7 THEN 'Lipiec'
                    WHEN 8 THEN 'Sierpien'
                    WHEN 9 THEN 'Wrzesien'
                    WHEN 10 THEN 'Pazdziernik'
                    WHEN 11 THEN 'Listopad'
                    WHEN 12 THEN 'Grudzien'
                END,
                @Miesiac,
                DATENAME(dw, CONVERT(VARCHAR(10), @Miesiac) + '/' + CONVERT(VARCHAR(2), @Dzien) + '/' + CONVERT(VARCHAR(4), @Rok)),
                DATEPART(dw, CONVERT(VARCHAR(10), @Miesiac) + '/' + CONVERT(VARCHAR(2), @Dzien) + '/' + CONVERT(VARCHAR(4), @Rok))
            );

            SET @Dzien = @Dzien + 1;
        END

        SET @Miesiac = @Miesiac + 1;
    END

    SET @Miesiac = 1;
    SET @Rok = @Rok + 1;
END