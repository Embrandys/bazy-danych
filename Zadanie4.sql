--1. Polecenie, kt�re tworzy baz� danych 
CREATE DATABASE firma;
--2. Polecenie, kt�re tworzy nowy schemat
CREATE SCHEMA rozliczenia;
--3.Polecenia, do powy�szego schematu dodaj� tabel�
CREATE TABLE rozliczenia.pracownicy (
id_pracownika INT PRIMARY KEY,
imie VARCHAR(50),
nazwisko VARCHAR(70) NOT NULL,
adres VARCHAR(150) NOT NULL,
telefon VARCHAR(12)
);
CREATE TABLE rozliczenia.godziny (
id_godziny INT PRIMARY KEY,
dataa DATE NOT NULL,
liczba_godzin INT NOT NULL,
id_pracownika INT
);
CREATE TABLE rozliczenia.pensje (
id_pensji INT PRIMARY KEY,
stanowisko VARCHAR(50) NOT NULL,
kwota DECIMAL NOT NULL,
id_premii INT,
);
CREATE TABLE rozliczenia.premie (
id_premii INT PRIMARY KEY,
rodzaj VARCHAR(50),
kwota DECIMAL NOT NULL
);

--Dodawanie obcych kluczy

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);


--4.Wype�nianie ka�dej tabeli 10 rekordami 
INSERT INTO rozliczenia.pracownicy VALUES (1, 'Joanna', 'K�pny', 'ul. Kolorowa 31, Elbl�g, 91-001', '+48111222333')
INSERT INTO rozliczenia.pracownicy VALUES (2, 'Kasia', 'Kowalczyk', 'ul. Szkolna 56, Elbl�g, 91-001', '+48151222373')
INSERT INTO rozliczenia.pracownicy VALUES (3, 'Ireneusz', 'Wa�ek', 'ul. Fio�kowa 37, Krak�w, 71-054', '+48111458663')
INSERT INTO rozliczenia.pracownicy VALUES (4, 'Hubert', 'D�browski', 'ul. M�y�ska 18, Katowice, 45-056', '+48123423433')
INSERT INTO rozliczenia.pracownicy VALUES (5, 'Hania', 'Skarbek', 'ul. �adna 92, Lublin, 83-034', '+48114522335')
INSERT INTO rozliczenia.pracownicy VALUES (6, 'Joanna', 'Ko�ek', 'ul. Widokowa 26, Zakopane, 34-001', '+48111229993')
INSERT INTO rozliczenia.pracownicy VALUES (7, 'Klaudia', 'Kowal', 'ul. Mickiewicza 56, Katowice, 53-678', '+48151964373')
INSERT INTO rozliczenia.pracownicy VALUES (8, 'Mateusz', 'Rybak', 'ul. Fio�kowa 37, Krak�w, 71-054', '+48112358663')
INSERT INTO rozliczenia.pracownicy VALUES (9, 'Alicja', 'D�browska', 'ul. G��wna 13, Katowice, 45-056', '+48125453433')
INSERT INTO rozliczenia.pracownicy VALUES (10, 'Maja', 'Skarbek', 'ul. Wolna 32, Lublin, 23-034', '+48114545335')

INSERT INTO rozliczenia.godziny VALUES (1915, '2019-09-05', 8, 1)
INSERT INTO rozliczenia.godziny VALUES (1654, '2019-09-05', 8, 3)
INSERT INTO rozliczenia.godziny VALUES (1543, '2019-09-05', 8, 4)
INSERT INTO rozliczenia.godziny VALUES (1634, '2019-09-05', 8, 8)
INSERT INTO rozliczenia.godziny VALUES (1204, '2019-09-05', 8, 2)
INSERT INTO rozliczenia.godziny VALUES (1704, '2019-09-05', 8, 9)
INSERT INTO rozliczenia.godziny VALUES (1702, '2019-09-05', 8, 10)
INSERT INTO rozliczenia.godziny VALUES (1804, '2019-09-06', 8, 5)
INSERT INTO rozliczenia.godziny VALUES (1705, '2019-09-06', 8, 6)
INSERT INTO rozliczenia.godziny VALUES (1700, '2019-09-06', 8, 7)

INSERT INTO rozliczenia.pensje VALUES (21,'asystent', 5045.54,31)
INSERT INTO rozliczenia.pensje VALUES (22,'prezes', 10490.84,34)
INSERT INTO rozliczenia.pensje VALUES (23,'manager', 6732.52,37)
INSERT INTO rozliczenia.pensje VALUES (24,'specjalista', 7045.64,35)
INSERT INTO rozliczenia.pensje VALUES (25,'specjalista', 7045.94,32)
INSERT INTO rozliczenia.pensje VALUES (26,'starszy specjalista', 8523.11,33)
INSERT INTO rozliczenia.pensje VALUES (27,'asystent', 5045.74,39)
INSERT INTO rozliczenia.pensje VALUES (28,'m�odszy specjalista', 6023.11,38)
INSERT INTO rozliczenia.pensje VALUES (29,'asystent', 5045.83,36)
INSERT INTO rozliczenia.pensje VALUES (30,'m�odszy specjalista', 6023.11,40)

INSERT INTO rozliczenia.premie VALUES (31, '�wi�teczna', 500)
INSERT INTO rozliczenia.premie VALUES (32, '�wi�teczna', 500)
INSERT INTO rozliczenia.premie VALUES (33, '�wi�teczna', 500)
INSERT INTO rozliczenia.premie VALUES (36, '�wi�teczna', 500)
INSERT INTO rozliczenia.premie VALUES (35, 'kwartalna', 300)
INSERT INTO rozliczenia.premie VALUES (34, '�wi�teczna', 500)
INSERT INTO rozliczenia.premie VALUES (37, '�wi�teczna', 500)
INSERT INTO rozliczenia.premie VALUES (38, 'kwartalna', 300)
INSERT INTO rozliczenia.premie VALUES (39, '�wi�teczna', 500)
INSERT INTO rozliczenia.premie VALUES (40, 'kwartalna', 300)

--5.Wy�wietlanie kolumny nazwisko i adres 
SELECT nazwisko, adres  FROM rozliczenia.pracownicy

--6. Konwertowanie daty
SELECT DATEPART ( w , dataa ) as 'dzien_tygodnia ', DATEPART ( m , dataa ) as 'miesiac' FROM rozliczenia.godziny;

--7. Zmiana kwoty na kwot� brutto oraz utworzenie nowego atrybutu oraz wyliczenie kwoty netto 
EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje ADD kwota_netto decimal(7,2);
UPDATE rozliczenia.pensje set kwota_netto=kwota_brutto*0.81;
