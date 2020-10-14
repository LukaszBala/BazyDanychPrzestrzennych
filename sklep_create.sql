-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-10-14 17:15:33.317

-- tables
-- Table: producenci
CREATE TABLE producenci (
    id_producencta serial  NOT NULL,
    nazwa_producenta varchar  NOT NULL,
    mail varchar  NOT NULL,
    telefon varchar  NOT NULL,
    CONSTRAINT producenci_pk PRIMARY KEY (id_producencta)
);

-- Table: produkty
CREATE TABLE produkty (
    id_produktu serial  NOT NULL,
    nazwa_produktu varchar  NOT NULL,
    cena decimal(16,2)  NOT NULL,
    id_producencta int  NOT NULL,
    CONSTRAINT produkty_pk PRIMARY KEY (id_produktu)
);

-- Table: zamowienia
CREATE TABLE zamowienia (
    id_zamowienia serial  NOT NULL,
    ilosc int  NOT NULL,
    data date  NOT NULL,
    id_produktu int  NOT NULL,
    CONSTRAINT zamowienia_pk PRIMARY KEY (id_zamowienia)
);

INSERT INTO producenci(nazwa_producenta, mail, telefon) values
('Bober','bober@mail.com','999999999'),
('Chmiel','chmielu@mail.com','111111111'),
('Frsq','frs@mail.com','222222222');
INSERT INTO produkty(nazwa_produktu, cena, id_producencta) values
('marchew',0.5,1),
('japka',1.0,2),
('ogorki',0.3,3);
INSERT INTO zamowienia(ilosc, data, id_produktu) values
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1),
(1,'2020-10-7',1);;

-- foreign keys
-- Reference: produkty_producenci (table: produkty)
ALTER TABLE produkty ADD CONSTRAINT produkty_producenci
    FOREIGN KEY (id_producencta)
    REFERENCES producenci (id_producencta)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: zamowienia_produkty (table: zamowienia)
ALTER TABLE zamowienia ADD CONSTRAINT zamowienia_produkty
    FOREIGN KEY (id_produktu)
    REFERENCES produkty (id_produktu)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

