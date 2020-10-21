--2
CREATE DATABASE postgis;
--3
CREATE EXTENSION postgis;


--4
CREATE TABLE budynki(id_budynku SERIAL, geometria geometry, nazwa VARCHAR(50) NOT NULL);
CREATE TABLE drogi(id_drogi SERIAL, geometria geometry, nazwa VARCHAR(50) NOT NULL);
CREATE TABLE punkty_informacyjne(id_punktu SERIAL, geometria geometry, nazwa VARCHAR(50) NOT NULL);


--5
INSERT INTO budynki (nazwa, geometria)
VALUES ('BuildingA', 'POLYGON((10.5 4, 10.5 1.5, 8 1.5, 8 4, 10.5 4))'),
       ('BuildingB', 'POLYGON((6 7, 6 5, 4 5, 4 7, 6 7))'),
       ('BuildingC', 'POLYGON((5 8, 5 6, 3 6, 3 8, 5 8))'),
       ('BuildingD', 'POLYGON((10 9, 10 8, 9 8, 9 9, 10 9))'),
       ('BuildingF', 'POLYGON((2 2, 2 1, 1 1, 1 2, 2 2))');

INSERT INTO drogi (nazwa, geometria)
VALUES ('RoadX', 'LINESTRING(0 4.5, 12 4.5)'),
       ('RoadY', 'LINESTRING(7.5 0, 7.5 10.5)');

INSERT INTO punkty_informacyjne (nazwa, geometria)
VALUES ('G','POINT(1 3.5)'),
       ('H', 'POINT(5.5 1.5)'),
       ('I', 'POINT(9.5 6)'),
       ('J', 'POINT(6.5 6)'),
       ('K', 'POINT(6 9.5)');


--6
--a
SELECT SUM(ST_Length(geometria)) FROM drogi;


--b
SELECT ST_AsEWKT(geometria), ST_Area(geometria), ST_Perimeter(geometria)
FROM budynki WHERE nazwa LIKE 'BuildingA';


--c
SELECT nazwa, ST_Area(geometria) FROM budynki ORDER BY nazwa;

--d
SELECT nazwa, ST_Perimeter(geometria) FROM budynki ORDER BY ST_Area(geometria) DESC LIMIT 2;

--e
SELECT ST_Distance(budynki.geometria, punkty_informacyjne.geometria)
FROM budynki, punkty_informacyjne WHERE budynki.nazwa LIKE 'BuildingC' AND punkty_informacyjne.nazwa LIKE 'G';


--f
SELECT ST_Area(g) FROM (SELECT ST_Intersection(ST_Buffer((SELECT geometria FROM budynki WHERE nazwa LIKE 'BuildingB'), 0.5),
(SELECT geometria FROM budynki WHERE nazwa LIKE 'BuildingC')) AS g) AS foo;

--g
SELECT budynki.nazwa FROM budynki WHERE ST_X(ST_Centroid(budynki.geometria)) > 4.5;
SELECT ST_Area((SELECT geometria FROM budynki WHERE nazwa LIKE 'BuildingC')) + ST_Area('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))') -
2*ST_Area(ST_Intersection((SELECT geometria FROM budynki WHERE nazwa LIKE 'BuildingC'), 'POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))')) AS area;