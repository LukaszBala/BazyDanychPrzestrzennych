--1
CREATE DATABASE s298232;
--
CREATE SCHEMA firma;
--3
CREATE ROLE ksiegowosc;
GRANT SELECT ON ALL TABLES IN SCHEMA firma TO ksiegowosc;
--4a
CREATE TABLE firma.pracownicy( id_pracownika INT NOT NULL, imie TEXT NOT NULL, nazwisko TEXT NOT NULL, adres TEXT NOT NULL, telefon TEXT NOT NULL);
CREATE TABLE firma.godziny( id_godziny INT NOT NULL, data  DATE NOT NULL, liczba_godzin INT NOT NULL, id_pracownika INT NOT NULL);
CREATE TABLE firma.pensja_stanowisko( id_pensji INT NOT NULL, stanowisko TEXT NOT NULL, kwota FLOAT(2));
CREATE TABLE firma.premia( id_premii INT NOT NULL, rodzaj TEXT, kwota FLOAT(2));
CREATE TABLE firma.wynagrodzenie( id_wynagrodzenia INT NOT NULL, data DATE NOT NULL, id_pracownika INT NOT NULL, id_godziny INT, id_pensji INT NOT NULL, id_premii INT);

--4b
ALTER TABLE firma.pracownicy ADD PRIMARY KEY(id_pracownika);
ALTER TABLE firma.godziny ADD PRIMARY KEY(id_godziny);
ALTER TABLE firma.pensja_stanowisko ADD PRIMARY KEY(id_pensji);
ALTER TABLE firma.premia ADD PRIMARY KEY(id_premii);
ALTER TABLE firma.wynagrodzenie ADD PRIMARY KEY(id_wynagrodzenia);

--4c
ALTER TABLE firma.godziny ADD CONSTRAINT pracownik FOREIGN KEY(id_pracownika) REFERENCES firma.pracownicy(id_pracownika);
ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT pracownik FOREIGN KEY(id_pracownika) REFERENCES firma.pracownicy(id_pracownika);
ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT pensja FOREIGN KEY(id_pensji) REFERENCES firma.pensja_stanowisko(id_pensji);
ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT premia FOREIGN KEY(id_premii) REFERENCES firma.premia(id_premii);
ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT godzina FOREIGN KEY(id_godziny) REFERENCES firma.godziny(id_godziny);

--4d
CREATE INDEX dataGodziny ON firma.godziny(data);
CREATE INDEX dataWynagrodzenie ON firma.wynagrodzenie(data);

--4e
COMMENT ON TABLE firma.pracownicy IS 'Tabela informacji o pracownikach';
COMMENT ON TABLE firma.godziny IS 'Tabela informacji o godzinach';
COMMENT ON TABLE firma.pensja_stanowisko IS 'Tabela informacji o pensjach i stanowiskach';
COMMENT ON TABLE firma.premia IS 'Tabela informacji o premiach';
COMMENT ON TABLE firma.wynagrodzenie IS 'Tabela informacji o wynagrodzeniach';

--5

INSERT INTO firma.pracownicy VALUES (1,'Marcin', 'Grabowski', 'Kraków', '111 111 111'),
                                    (2,'Karolina','Chmielewska','Myślenice','222 222 222'),
                                    (3,'Patryk', 'Frasiok', 'Warszawa', '333 333 333'),
                                    (4,'Paweł', 'Domaradzki','Konin','444 444 444'),
                                    (5,'Maciej', 'Sopata', 'Zakopane','555 555 555'),
                                    (6,'Adrian', 'Dul','Bysina','666 666 666'),
                                    (7,'Piotr', 'Wysocki','Siepraw','777 777 777'),
                                    (8,'Magda', 'Kuc', 'Swoszowice','888 888 888'),
                                    (9,'Zbigniew', 'Bober', 'Krabowice', '999 999 999'),
                                    (10,'Rafał', 'Golec', 'Pieprz', '100 000 000');

INSERT INTO firma.godziny VALUES (1,'2020-07-10',15,1), (2,'2020-07-10',164,2),
                                 (3,'2020-07-10',184,3), (4,'2020-07-10',178,4),
                                 (5,'2020-07-10',200,5), (6,'2020-07-10',160,6),
                                 (7,'2020-07-10',160,7), (8,'2020-07-10',143,8),
                                 (9,'2020-07-10',160,9), (10,'2020-07-10',120,10);

INSERT INTO firma.pensja_stanowisko VALUES (1,'Menadżer',250),
                                           (2,'Komik', 50),
                                           (3,'Malarz',80),
                                           (4,'Tynkarz',30),
                                           (5,'Akrobata',35),
                                           (6,'Tester',25),
                                           (7,'Programista',1000),
                                           (8,'Bazodanowiec',100),
                                           (9,'DevOps',120),
                                           (10,'Muzyk',0);

INSERT INTO firma.premia VALUES (1,'Stablinośc',200),
                                (2,'Osiągniecia',2000),
                                (3,'Awans',3000),
                                (4,'Szybkość',500),
                                (5,'Wakacyjna',1500),
                                (6,'Zdrowotna',600),
                                (7,'Znajmości',5000),
                                (8,'Wyniki',800),
                                (9,'Nadgodziny',700),
                                (10,'Roczna',300);

INSERT INTO firma.wynagrodzenie VALUES (1,'2020-07-10',1,1,1,1),
                                       (2,'2020-07-10',2,2,2,2),
                                       (3,'2020-07-10',3,3,3,3),
                                       (4,'2020-07-10',4,4,4,4),
                                       (5,'2020-07-10',5,5,5,NULL),
                                       (6,'2020-07-10',6,6,6,6),
                                       (7,'2020-07-10',7,7,7,NULL),
                                       (8,'2020-07-10',8,8,8,5),
                                       (9,'2020-07-10',9,9,9,9),
                                       (10,'2020-07-10',10,10,10,NULL);

--5a
ALTER TABLE firma.godziny ADD COLUMN miesiac DATE;
ALTER TABLE firma.godziny ADD COLUMN tydzien DATE;

--5b
ALTER TABLE firma.wynagrodzenie ALTER COLUMN data TYPE TEXT;

--6a
SELECT id_pracownika, nazwisko FROM firma.pracownicy;
--6b
SELECT prac.id_pracownika FROM firma.pracownicy AS prac JOIN firma.wynagrodzenie AS wyn ON wyn.id_pracownika=prac.id_pracownika
                                                    JOIN firma.pensja_stanowisko AS pens ON wyn.id_pensji=pens.id_pensji
                                                    JOIN firma.godziny AS godz ON godz.id_pracownika=wyn.id_pracownika
                                                    WHERE liczba_godzin*kwota>1000;
--6c
SELECT prac.id_pracownika FROM firma.pracownicy AS prac JOIN firma.wynagrodzenie AS wyn ON wyn.id_pracownika=prac.id_pracownika
                                                    JOIN firma.pensja_stanowisko AS pens ON wyn.id_pensji=pens.id_pensji
                                                    JOIN firma.godziny AS godz ON godz.id_pracownika=wyn.id_pracownika
                                                    FULL JOIN firma.premia ON premia.id_premii=wyn.id_premii
                                                    WHERE liczba_godzin*pens.kwota>2000
                                                    AND wyn.id_premii is null
                                                    AND prac.id_pracownika is not null;
--6d
SELECT imie,nazwisko FROM firma.pracownicy WHERE imie LIKE 'J%';
--6e
SELECT imie, nazwisko FROM firma.pracownicy WHERE imie LIKE '%a' AND  nazwisko LIKE '%n%';
--6f
SELECT prac.id_pracownika,imie,nazwisko,liczba_godzin FROM firma.pracownicy AS prac
                                                    JOIN firma.godziny  AS godz ON prac.id_pracownika=godz.id_pracownika
                                                    WHERE liczba_godzin>160;
--6g
SELECT prac.id_pracownika FROM firma.pracownicy AS prac JOIN firma.wynagrodzenie AS wyn ON wyn.id_pracownika=prac.id_pracownika
                                                    JOIN firma.pensja_stanowisko AS pens ON wyn.id_pensji=pens.id_pensji
                                                    JOIN firma.godziny AS godz ON godz.id_pracownika=wyn.id_pracownika
                                                    WHERE liczba_godzin*kwota BETWEEN 1500 AND 3000;
--6h
SELECT prac.id_pracownika,imie,nazwisko,liczba_godzin FROM firma.pracownicy AS prac
                                                    JOIN firma.wynagrodzenie AS wyn ON wyn.id_pracownika=prac.id_pracownika
                                                    JOIN firma.pensja_stanowisko AS pens ON wyn.id_pensji=pens.id_pensji
                                                    JOIN firma.godziny AS godz ON godz.id_pracownika=wyn.id_pracownika
                                                    WHERE liczba_godzin>160 AND id_premii IS NULL;


--7a
SELECT prac.id_pracownika FROM firma.pracownicy AS prac JOIN firma.wynagrodzenie AS wyn ON wyn.id_pracownika=prac.id_pracownika  
                                                    JOIN firma.pensja_stanowisko AS pens ON wyn.id_pensji=pens.id_pensji 
                                                    JOIN firma.godziny AS godz ON godz.id_pracownika=wyn.id_pracownika 
                                                    ORDER BY liczba_godzin*kwota;

--7b
SELECT  prac.id_pracownika,liczba_godzin*pens.kwota AS pensja,premia.kwota 
                                                FROM firma.pracownicy AS prac 
                                                JOIN firma.wynagrodzenie AS wyn ON wyn.id_pracownika=prac.id_pracownika
                                                JOIN firma.pensja_stanowisko AS pens ON wyn.id_pensji=pens.id_pensji
                                                JOIN firma.godziny AS godz ON godz.id_pracownika=wyn.id_pracownika
                                                FULL JOIN firma.premia ON premia.id_premii=wyn.id_premii WHERE  prac.id_pracownika is not null
                                                ORDER BY liczba_godzin*pens.kwota DESC, premia.kwota DESC ;

--7c
SELECT COUNT(prac.id_pracownika),stanowisko FROM firma.pracownicy AS prac 
                                            JOIN firma.wynagrodzenie AS wyn ON wyn.id_pracownika=prac.id_pracownika  
                                            JOIN firma.pensja_stanowisko AS pens ON wyn.id_pensji=pens.id_pensji 
                                            JOIN firma.godziny AS godz ON godz.id_pracownika=wyn.id_pracownika 
                                            GROUP BY stanowisko;
--7d
SELECT MIN(liczba_godzin*kwota),  AVG(liczba_godzin*kwota) ,  MAX(liczba_godzin*kwota) ,stanowisko 
                                            FROM firma.pracownicy AS prac 
                                            JOIN firma.wynagrodzenie AS wyn ON wyn.id_pracownika=prac.id_pracownika  
                                            JOIN firma.pensja_stanowisko AS pens ON wyn.id_pensji=pens.id_pensji 
                                            JOIN firma.godziny AS godz ON godz.id_pracownika=wyn.id_pracownika 
                                            GROUP BY stanowisko HAVING stanowisko='Kierownik';

--7e
SELECT SUM(liczba_godzin*kwota) FROM firma.pracownicy AS prac  
                                JOIN firma.wynagrodzenie AS wyn ON wyn.id_pracownika=prac.id_pracownika  
                                JOIN firma.pensja_stanowisko AS pens ON wyn.id_pensji=pens.id_pensji 
                                JOIN firma.godziny AS godz ON godz.id_pracownika=wyn.id_pracownika;

--7f
SELECT SUM(liczba_godzin*kwota),stanowisko FROM firma.pracownicy AS prac 
                                            JOIN firma.wynagrodzenie AS wyn ON wyn.id_pracownika=prac.id_pracownika  
                                            JOIN firma.pensja_stanowisko AS pens ON wyn.id_pensji=pens.id_pensji 
                                            JOIN firma.godziny AS godz ON godz.id_pracownika=wyn.id_pracownika 
                                            GROUP BY stanowisko;

--8c
SELECT UPPER(imie), UPPER(nazwisko) FROM firma.pracownicy 
                                    WHERE (LENGTH(pracownicy.nazwisko))=(SELECT MAX(LENGTH(pracownicy.nazwisko)) 
                                    FROM firma.pracownicy);
--8d
SELECT MD5(imie||nazwisko||adres||telefon||liczba_godzin*pens.kwota) FROM firma.pracownicy AS prac 
                                                    JOIN firma.wynagrodzenie AS wyn ON wyn.id_pracownika=prac.id_pracownika
                                                    JOIN firma.pensja_stanowisko AS pens ON wyn.id_pensji=pens.id_pensji
                                                    JOIN firma.godziny AS godz ON godz.id_pracownika=wyn.id_pracownika
                                                    FULL JOIN firma.premia ON premia.id_premii=wyn.id_premii 
                                                    WHERE prac.id_pracownika is not null;









