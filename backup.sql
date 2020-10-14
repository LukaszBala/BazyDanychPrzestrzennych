PGDMP         -            	    x           s298232    13.0 (Debian 13.0-1.pgdg100+1)    13.0      �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24830    s298232    DATABASE     [   CREATE DATABASE s298232 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE s298232;
                admin    false                        2615    24832    firma    SCHEMA        CREATE SCHEMA firma;
    DROP SCHEMA firma;
                admin    false            �            1259    24840    godziny    TABLE     �   CREATE TABLE firma.godziny (
    id_godziny integer NOT NULL,
    data date NOT NULL,
    liczba_godzin integer NOT NULL,
    id_pracownika integer NOT NULL,
    miesiac date,
    tydzien date
);
    DROP TABLE firma.godziny;
       firma         heap    admin    false    5            �           0    0    TABLE godziny    COMMENT     C   COMMENT ON TABLE firma.godziny IS 'Tabela informacji o godzinach';
          firma          admin    false    202            �            1259    24843    pensja_stanowisko    TABLE     w   CREATE TABLE firma.pensja_stanowisko (
    id_pensji integer NOT NULL,
    stanowisko text NOT NULL,
    kwota real
);
 $   DROP TABLE firma.pensja_stanowisko;
       firma         heap    admin    false    5            �           0    0    TABLE pensja_stanowisko    COMMENT     [   COMMENT ON TABLE firma.pensja_stanowisko IS 'Tabela informacji o pensjach i stanowiskach';
          firma          admin    false    203            �            1259    24834 
   pracownicy    TABLE     �   CREATE TABLE firma.pracownicy (
    id_pracownika integer NOT NULL,
    imie text NOT NULL,
    nazwisko text NOT NULL,
    adres text NOT NULL,
    telefon text NOT NULL
);
    DROP TABLE firma.pracownicy;
       firma         heap    admin    false    5            �           0    0    TABLE pracownicy    COMMENT     I   COMMENT ON TABLE firma.pracownicy IS 'Tabela informacji o pracownikach';
          firma          admin    false    201            �            1259    24849    premia    TABLE     _   CREATE TABLE firma.premia (
    id_premii integer NOT NULL,
    rodzaj text,
    kwota real
);
    DROP TABLE firma.premia;
       firma         heap    admin    false    5            �           0    0    TABLE premia    COMMENT     A   COMMENT ON TABLE firma.premia IS 'Tabela informacji o premiach';
          firma          admin    false    204            �            1259    24855    wynagrodzenie    TABLE     �   CREATE TABLE firma.wynagrodzenie (
    id_wynagrodzenia integer NOT NULL,
    data text NOT NULL,
    id_pracownika integer NOT NULL,
    id_godziny integer,
    id_pensji integer NOT NULL,
    id_premii integer
);
     DROP TABLE firma.wynagrodzenie;
       firma         heap    admin    false    5            �           0    0    TABLE wynagrodzenie    COMMENT     O   COMMENT ON TABLE firma.wynagrodzenie IS 'Tabela informacji o wynagrodzeniach';
          firma          admin    false    205            �          0    24840    godziny 
   TABLE DATA           b   COPY firma.godziny (id_godziny, data, liczba_godzin, id_pracownika, miesiac, tydzien) FROM stdin;
    firma          admin    false    202   "       �          0    24843    pensja_stanowisko 
   TABLE DATA           H   COPY firma.pensja_stanowisko (id_pensji, stanowisko, kwota) FROM stdin;
    firma          admin    false    203   w"       �          0    24834 
   pracownicy 
   TABLE DATA           R   COPY firma.pracownicy (id_pracownika, imie, nazwisko, adres, telefon) FROM stdin;
    firma          admin    false    201   #       �          0    24849    premia 
   TABLE DATA           9   COPY firma.premia (id_premii, rodzaj, kwota) FROM stdin;
    firma          admin    false    204   O$       �          0    24855    wynagrodzenie 
   TABLE DATA           o   COPY firma.wynagrodzenie (id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii) FROM stdin;
    firma          admin    false    205   �$       
           2606    24861    godziny godziny_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY firma.godziny
    ADD CONSTRAINT godziny_pkey PRIMARY KEY (id_godziny);
 =   ALTER TABLE ONLY firma.godziny DROP CONSTRAINT godziny_pkey;
       firma            admin    false    202                       2606    24863 (   pensja_stanowisko pensja_stanowisko_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY firma.pensja_stanowisko
    ADD CONSTRAINT pensja_stanowisko_pkey PRIMARY KEY (id_pensji);
 Q   ALTER TABLE ONLY firma.pensja_stanowisko DROP CONSTRAINT pensja_stanowisko_pkey;
       firma            admin    false    203                       2606    24859    pracownicy pracownicy_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY firma.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (id_pracownika);
 C   ALTER TABLE ONLY firma.pracownicy DROP CONSTRAINT pracownicy_pkey;
       firma            admin    false    201                       2606    24865    premia premia_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY firma.premia
    ADD CONSTRAINT premia_pkey PRIMARY KEY (id_premii);
 ;   ALTER TABLE ONLY firma.premia DROP CONSTRAINT premia_pkey;
       firma            admin    false    204                       2606    24867     wynagrodzenie wynagrodzenie_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY firma.wynagrodzenie
    ADD CONSTRAINT wynagrodzenie_pkey PRIMARY KEY (id_wynagrodzenia);
 I   ALTER TABLE ONLY firma.wynagrodzenie DROP CONSTRAINT wynagrodzenie_pkey;
       firma            admin    false    205                       1259    24893    datagodziny    INDEX     >   CREATE INDEX datagodziny ON firma.godziny USING btree (data);
    DROP INDEX firma.datagodziny;
       firma            admin    false    202                       1259    24895    datawynagrodzenie    INDEX     J   CREATE INDEX datawynagrodzenie ON firma.wynagrodzenie USING btree (data);
 $   DROP INDEX firma.datawynagrodzenie;
       firma            admin    false    205                       2606    24888    wynagrodzenie godzina    FK CONSTRAINT        ALTER TABLE ONLY firma.wynagrodzenie
    ADD CONSTRAINT godzina FOREIGN KEY (id_godziny) REFERENCES firma.godziny(id_godziny);
 >   ALTER TABLE ONLY firma.wynagrodzenie DROP CONSTRAINT godzina;
       firma          admin    false    2826    205    202                       2606    24878    wynagrodzenie pensja    FK CONSTRAINT     �   ALTER TABLE ONLY firma.wynagrodzenie
    ADD CONSTRAINT pensja FOREIGN KEY (id_pensji) REFERENCES firma.pensja_stanowisko(id_pensji);
 =   ALTER TABLE ONLY firma.wynagrodzenie DROP CONSTRAINT pensja;
       firma          admin    false    203    2828    205                       2606    24868    godziny pracownik    FK CONSTRAINT     �   ALTER TABLE ONLY firma.godziny
    ADD CONSTRAINT pracownik FOREIGN KEY (id_pracownika) REFERENCES firma.pracownicy(id_pracownika);
 :   ALTER TABLE ONLY firma.godziny DROP CONSTRAINT pracownik;
       firma          admin    false    201    2823    202                       2606    24873    wynagrodzenie pracownik    FK CONSTRAINT     �   ALTER TABLE ONLY firma.wynagrodzenie
    ADD CONSTRAINT pracownik FOREIGN KEY (id_pracownika) REFERENCES firma.pracownicy(id_pracownika);
 @   ALTER TABLE ONLY firma.wynagrodzenie DROP CONSTRAINT pracownik;
       firma          admin    false    205    2823    201                       2606    24883    wynagrodzenie premia    FK CONSTRAINT     {   ALTER TABLE ONLY firma.wynagrodzenie
    ADD CONSTRAINT premia FOREIGN KEY (id_premii) REFERENCES firma.premia(id_premii);
 =   ALTER TABLE ONLY firma.wynagrodzenie DROP CONSTRAINT premia;
       firma          admin    false    2830    205    204            �   _   x�]��	� ��sK������稔�6����
TT�x.��P���%� �P	�����"h�7��'8a��A���$����>!�+�� �4-O      �   �   x��1�0�Ǡ�M � :dA��� �LldP�6Z�EB�3�U�.H���]1ib�yL���]RAʹD3?�a���)^d��Vh\�wZ��-I��)*f�;)��ߝ�Ύ6ػ��4�b�g=��"���'�      �   2  x�M��N1�׷O�Rc�����HdAH�,H��;C�:Ôt �����c���� ���uq�{��4W���N
۵�����绣��(���� �*��8[�F��}kt�q@h��jݘR_�A� �*���]_ѓ��؊V��A:�d�0d�a!���'M�V���S۠�9E��K�?hiw�z�
��Z!�cV	=����&���}{�N%I� �*���{G���%/��9�>C��0�2�ެ�f����m���=�2V9�f����ڝ��������ѳ�	n?��.���/x��<�S��J�_?�x      �   �   x���
�@F��}�-Z����u�Z3�����!z{��,ρ�IP��>����"5�R\&�޽�������݄}��5�����5�l��I9���?�ȕ4��g\H,����QP*q���*.�P�\�]��!�vD�b0�      �   T   x�M��	 1D��L/YԼ��
��*���"�&�,#�$0�P8��ʱ4����k�����t��
������7�� �s"/     