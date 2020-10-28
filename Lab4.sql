--4
CREATE TABLE tableB AS
SELECT popp.gid, popp.cat, popp.f_codedesc, popp.f_code, popp.type, popp.geom
FROM popp, majrivers GROUP BY popp.gid HAVING MIN(ST_Distance(majrivers.geom, popp.geom)) < 100000 AND popp.f_codedesc LIKE 'Building';
SELECT COUNT(*) FROM tableB;

--5
CREATE TABLE airportsNew AS
SELECT name, geom, elev FROM airports;

--5a
SELECT MIN(ST_Y(geom)), MAX(ST_Y(geom)) FROM airportsNew;

--5b
INSERT INTO airportsNew(name, geom, elev) VALUES
('airportB',
(SELECT ST_LineInterpolatePoint(ST_ShortestLine(a.geom,b.geom),0.5)
FROM twoAirports a,twoAirports b
WHERE a.id=1 AND b.id=2),8);

--6
SELECT ST_Area(ST_Buffer((SELECT ST_ShortestLine(lakes.geom, airports.geom) FROM lakes, airports
WHERE lakes.names LIKE 'Iliamna Lake' AND airports.name LIKE 'AMBLER'), 1000));


--7
SELECT SUM(ST_Area(ST_Intersection(a.geom, b.geom))), a.vegdesc FROM trees AS a,
  (SELECT geom FROM tundra UNION ALL SELECT geom FROM swamp) AS b
  WHERE ST_Intersects(a.geom, b.geom) IS TRUE GROUP BY a.vegdesc;

