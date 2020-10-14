--6
INSERT INTO sklep.producenci(nazwa_producenta, mail, telefon) VALUES
('Producent1','producent1@mail.com','111111111'),
('Producent2','producent2@mail.com','111111111'),
('Producent3','producent3@mail.com','111111111'),
('Producent4','producent4@mail.com','111111111'),
('Producent5','producent5@mail.com','111111111'),
('Producent6','producent6@mail.com','111111111'),
('Producent7','producent7@mail.com','111111111'),
('Producent8','producent8@mail.com','111111111'),
('Producent9','producent9@mail.com','111111111'),
('Producent10','producent10@mail.com','111111111');

INSERT INTO sklep.produkty(nazwa_produktu, cena, id_producencta) VALUES
('Japko',1,4),
('Japko',2,5),
('Japko',3,6),
('Japko',4,7),
('Japko',5,8),
('Japko',6,9),
('Japko',7,10),
('Japko',8,11),
('Japko',9,12),
('Japko',0.5,13);

INSERT INTO sklep.zamowienia(ilosc, data, id_produktu) VALUES
(21,'2020-10-7',1),
(21,'2020-10-7',2),
(21,'2020-10-7',3),
(21,'2020-10-7',4),
(21,'2020-10-7',5),
(21,'2020-10-7',6),
(21,'2020-10-7',7),
(21,'2020-10-7',8),
(21,'2020-10-7',9),
(21,'2020-10-7',10);

-- 7 Backup pgAdmin

-- 8 DROP DATABASE s298232;

-- 9 PgAdmin

-- 10 done

--11a
SELECT CONCAT('Producent: ', nazwa_producenta, ', liczba_zamowien: ', COUNT(producenci.id_producencta), ', wartosc_zamowienia', ilosc*cena) FROM zamowienia INNER JOIN produkty ON zamowienia.id_produktu = produkty.id_produktu INNER JOIN producenci ON produkty.id_producencta = producenci.id_producencta GROUP BY producenci.id_producencta,zamowienia.ilosc,produkty.cena;
--11b
SELECT CONCAT('Produkt: ', nazwa_produktu, ', liczba_zamowien: ', COUNT(id_zamowienia)) FROM produkty INNER JOIN zamowienia ON produkty.id_produktu = zamowienia.id_produktu GROUP BY produkty.id_produktu;
--11c
SELECT * FROM produkty NATURAL JOIN zamowienia;
--11e
SELECT * FROM zamowienia WHERE EXTRACT(MONTH FROM data) = 01;
--11f
SELECT EXTRACT(ISODOW FROM data),COUNT(id_zamowienia) FROM zamowienia GROUP BY EXTRACT(ISODOW FROM data) ORDER BY COUNT(id_zamowienia) DESC;
--11g
SELECT nazwa_produktu,COUNT(produkty.id_produktu) FROM zamowienia INNER JOIN produkty ON zamowienia.id_produktu = produkty.id_produktu GROUP BY produkty.id_produktu ORDER BY COUNT(produkty.id_produktu) DESC;

--12
--a
SELECT CONCAT('Produkt ',UPPER(nazwa_produktu), ' którego producentem jest ', LOWER(nazwa_producenta), ', zamówiono ', COUNT(id_zamowienia), ' razy') AS opis FROM zamowienia INNER JOIN produkty ON zamowienia.id_produktu = produkty.id_produktu INNER JOIN producenci ON produkty.id_producencta = producenci.id_producencta GROUP BY nazwa_produktu,nazwa_producenta;
--b
SELECT * FROM zamowienia INNER JOIN produkty ON zamowienia.id_produktu = produkty.id_produktu WHERE (cena*ilosc) NOT IN (SELECT cena*ilosc FROM zamowienia INNER JOIN produkty ON zamowienia.id_produktu = produkty.id_produktu ORDER BY cena*ilosc DESC LIMIT 3);
--c
CREATE TABLE klienci(id_klienta SERIAL PRIMARY KEY,email VARCHAR(255) NOT NULL,numer_telefonu VARCHAR(255) NOT NULL);
--d
ALTER TABLE zamowienia ADD id_klienta INT;
ALTER TABLE zamowienia ADD CONSTRAINT fk_zamowienia_klienci FOREIGN KEY (id_klienta) REFERENCES klienci(id_klienta);


INSERT INTO klienci(email,numer_telefonu) VALUES('klient1','111-222-333');
INSERT INTO klienci(email,numer_telefonu) VALUES('klient2','122-222-333');
INSERT INTO klienci(email,numer_telefonu) VALUES('klient3','113-222-333');
INSERT INTO klienci(email,numer_telefonu) VALUES('klient4','144-222-333');
INSERT INTO klienci(email,numer_telefonu) VALUES('klient5','155-222-333');
INSERT INTO klienci(email,numer_telefonu) VALUES('klient6','166-222-333');
INSERT INTO klienci(email,numer_telefonu) VALUES('klient7','177-222-333');
INSERT INTO klienci(email,numer_telefonu) VALUES('klient8','188-222-333');
INSERT INTO klienci(email,numer_telefonu) VALUES('klient9','199-222-333');
INSERT INTO klienci(email,numer_telefonu) VALUES('klient10','175-222-333');

UPDATE zamowienia SET id_klienta = 1 WHERE id_zamowienia = 1;
UPDATE zamowienia SET id_klienta = 1 WHERE id_zamowienia = 2;
UPDATE zamowienia SET id_klienta = 1 WHERE id_zamowienia = 3;
UPDATE zamowienia SET id_klienta = 2 WHERE id_zamowienia = 4;
UPDATE zamowienia SET id_klienta = 3 WHERE id_zamowienia = 5;
UPDATE zamowienia SET id_klienta = 6 WHERE id_zamowienia = 6;
UPDATE zamowienia SET id_klienta = 6 WHERE id_zamowienia = 7;
UPDATE zamowienia SET id_klienta = 8 WHERE id_zamowienia = 8;
UPDATE zamowienia SET id_klienta = 9 WHERE id_zamowienia = 9;
UPDATE zamowienia SET id_klienta = 10 WHERE id_zamowienia = 10;

--e
SELECT email, numer_telefonu, nazwa_produktu, ilosc, (ilosc * cena) AS wartość_zamówienia FROM zamowienia INNER JOIN klienci ON zamowienia.id_klienta = klienci.id_klienta INNER JOIN produkty ON produkty.id_produktu = zamowienia.id_produktu;
--f
SELECT CONCAT('NAJCZĘŚCIEJ ZAMAWIAJĄCY: ', email, ' telefon: ',numer_telefonu, ' całkowita kwota zamówień: ', cena) FROM (SELECT email,numer_telefonu,SUM(cena*ilosc) AS cena FROM zamowienia INNER JOIN klienci ON zamowienia.id_klienta=klienci.id_klienta INNER JOIN produkty ON produkty.id_produktu=zamowienia.id_produktu GROUP BY zamowienia.id_klienta,email,numer_telefonu ORDER BY COUNT(zamowienia.id_klienta) DESC LIMIT 1) as Najczestszy UNION SELECT CONCAT('NAJRZADZIEJ ZAMAWIAJĄCY: ', email, ' telefon: ',numer_telefonu, ' całkowita kwota zamówień: ', cena) FROM (SELECT email,numer_telefonu,SUM(cena*ilosc) AS cena FROM zamowienia INNER JOIN klienci ON zamowienia.id_klienta=klienci.id_klienta INNER JOIN produkty ON produkty.id_produktu = zamowienia.id_produktu GROUP BY zamowienia.id_klienta,email,numer_telefonu ORDER BY COUNT(zamowienia.id_klienta) LIMIT 1) AS najrzadziej;
--g
DELETE FROM produkty WHERE id_produktu IN (SELECT produkty.id_produktu FROM produkty WHERE id_produktu NOT IN (SELECT id_produktu FROM zamowienia));

--13
--a
CREATE TABLE numer(liczba INT, CONSTRAINT valid_number CHECK (liczba <= 999 AND liczba >= 100));
--b
CREATE SEQUENCE liczba_seq INCREMENT 5 MINVALUE 100 MAXVALUE 125 CYCLE;
--c
INSERT INTO numer(liczba) VALUES(NEXTVAL('liczba_seq'));
INSERT INTO numer(liczba) VALUES(NEXTVAL('liczba_seq'));
INSERT INTO numer(liczba) VALUES(NEXTVAL('liczba_seq'));
INSERT INTO numer(liczba) VALUES(NEXTVAL('liczba_seq'));
INSERT INTO numer(liczba) VALUES(NEXTVAL('liczba_seq'));
INSERT INTO numer(liczba) VALUES(NEXTVAL('liczba_seq'));
INSERT INTO numer(liczba) VALUES(NEXTVAL('liczba_seq'));
--d
ALTER SEQUENCE liczba_seq INCREMENT BY 6;
--e
SELECT CURRVAL('liczba_seq');
SELECT NEXTVAL('liczba_seq');
--f
DROP SEQUENCE liczba_seq;

--14
--a
SELECT * FROM pg_catalog.pg_user;
--b
CREATE USER Superuser298232 WITH SUPERUSER;
CREATE USER guest298232;
GRANT SELECT ON ALL TABLES IN SCHEMA sklep TO guest298232;
SELECT * FROM pg_catalog.pg_user;
--c
ALTER USER Superuser298232 RENAME TO student;
ALTER USER student WITH NOSUPERUSER;
GRANT SELECT ON ALL TABLES IN SCHEMA sklep TO student;