--1. Polecenie, które tworzy bazê danych 
CREATE DATABASE firma;

--2. Polecenie, które tworzy nowy schemat
CREATE SCHEMA ksiegowosc;

--3.Polecenia, do powy¿szego schematu dodaj¹ tabelê oraz komentarze 
CREATE TABLE ksiegowosc.pracownicy (
id_pracownika INT PRIMARY KEY,
imie NVARCHAR(50),
nazwisko NVARCHAR(70) NOT NULL,
adres NVARCHAR(150) NOT NULL,
telefon NVARCHAR(12)
);


CREATE TABLE ksiegowosc.godziny (
id_godziny INT PRIMARY KEY,
dataa DATE ,
liczba_godzin INT NOT NULL,
id_pracownika INT NOT NULL FOREIGN KEY REFERENCES ksiegowosc.pracownicy(id_pracownika)
);


CREATE TABLE ksiegowosc.pensje (
id_pensji INT PRIMARY KEY,
stanowisko NVARCHAR(50) NOT NULL,
kwota DECIMAL NOT NULL,
);


CREATE TABLE ksiegowosc.premie (
id_premii INT PRIMARY KEY,
rodzaj NVARCHAR(50),
kwota DECIMAL NOT NULL
);



CREATE TABLE ksiegowosc.wynagrodzenie (
id_wynagrodzenia INT PRIMARY KEY,
dataa DATE,
id_pracownika INT FOREIGN KEY REFERENCES ksiegowosc.pracownicy(id_pracownika),
id_godziny INT FOREIGN KEY REFERENCES ksiegowosc.godziny(id_godziny),
id_pensji INT FOREIGN KEY REFERENCES ksiegowosc.pensje(id_pensji),
id_premii INT FOREIGN KEY REFERENCES ksiegowosc.premie(id_premii) 
);

--Komentarze  
EXEC sys.sp_addextendedproperty 
@name=N'Comment', 
@value=N'Tabela pracownikow ',
@level0type=N'SCHEMA', @level0name='ksiegowosc',
@level1type=N'TABLE', @level1name='pracownicy'
GO

SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.pracownicy')
  AND minor_id = 0
  AND class = 1;

 EXEC sys.sp_addextendedproperty 
@name=N'Comment', 
@value=N'Tabela z iloscia godzin ',
@level0type=N'SCHEMA', @level0name='ksiegowosc',
@level1type=N'TABLE', @level1name='godziny'
GO

SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.godziny')
  AND minor_id = 0
  AND class = 1;

 EXEC sys.sp_addextendedproperty 
@name=N'Comment', 
@value=N'Tabela z wysokoscia pensji ',
@level0type=N'SCHEMA', @level0name='ksiegowosc',
@level1type=N'TABLE', @level1name='pensje'
GO

SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.pensje')
  AND minor_id = 0
  AND class = 1;

EXEC sys.sp_addextendedproperty 
@name=N'Comment', 
@value=N'Tabela z wysokoscia premii',
@level0type=N'SCHEMA', @level0name='ksiegowosc',
@level1type=N'TABLE', @level1name='premie'
GO

SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.premie')
  AND minor_id = 0
  AND class = 1;

EXEC sys.sp_addextendedproperty 
@name=N'Comment', 
@value=N'Tabela z wysokoscia wynagrodzenia dla pracownikow',
@level0type=N'SCHEMA', @level0name='ksiegowosc',
@level1type=N'TABLE', @level1name='wynagrodzenie'
GO

SELECT value AS Comment
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('ksiegowosc.wynagrodzenie')
  AND minor_id = 0
  AND class = 1;


--4.Wype³nianie ka¿dej tabeli 10 rekordami 
INSERT INTO ksiegowosc.pracownicy VALUES (1, 'Joanna', 'Kêpny', 'ul. Kolorowa 31, Elbl¹g, 91-001', '+48111222333')
INSERT INTO ksiegowosc.pracownicy VALUES (2, 'Kasia', 'Kowalczyk', 'ul. Szkolna 56, Elbl¹g, 91-001', '+48151222373')
INSERT INTO ksiegowosc.pracownicy VALUES (3, 'Ireneusz', 'Wa³ek', 'ul. Fio³kowa 37, Kraków, 71-054', '+48111458663')
INSERT INTO ksiegowosc.pracownicy VALUES (4, 'Hubert', 'D¹browski', 'ul. M³yñska 18, Katowice, 45-056', '+48123423433')
INSERT INTO ksiegowosc.pracownicy VALUES (5, 'Hania', 'Skarbek', 'ul. £adna 92, Lublin, 83-034', '+48114522335')
INSERT INTO ksiegowosc.pracownicy VALUES (6, 'Joanna', 'Ko³ek', 'ul. Widokowa 26, Zakopane, 34-001', '+48111229993')
INSERT INTO ksiegowosc.pracownicy VALUES (7, 'Klaudia', 'Kowal', 'ul. Mickiewicza 56, Katowice, 53-678', '+48151964373')
INSERT INTO ksiegowosc.pracownicy VALUES (8, 'Mateusz', 'Rybak', 'ul. Fio³kowa 37, Kraków, 71-054', '+48112358663')
INSERT INTO ksiegowosc.pracownicy VALUES (9, 'Alicja', 'D¹browska', 'ul. G³ówna 13, Katowice, 45-056', '+48125453433')
INSERT INTO ksiegowosc.pracownicy VALUES (10, 'Maja', 'Skarbek', 'ul. Wolna 32, Lublin, 23-034', '+48114545335')

INSERT INTO ksiegowosc.godziny VALUES (1915, '2019-09-05', 8, 1)
INSERT INTO ksiegowosc.godziny VALUES (1654, '2019-09-05', 8, 3)
INSERT INTO ksiegowosc.godziny VALUES (1543, '2019-09-05', 8, 4)
INSERT INTO ksiegowosc.godziny VALUES (1634, '2019-09-05', 8, 8)
INSERT INTO ksiegowosc.godziny VALUES (1204, '2019-09-05', 8, 2)
INSERT INTO ksiegowosc.godziny VALUES (1704, '2019-09-05', 8, 9)
INSERT INTO ksiegowosc.godziny VALUES (1702, '2019-09-05', 8, 10)
INSERT INTO ksiegowosc.godziny VALUES (1804, '2019-09-06', 8, 5)
INSERT INTO ksiegowosc.godziny VALUES (1705, '2019-09-06', 8, 6)
INSERT INTO ksiegowosc.godziny VALUES (1700, '2019-09-06', 8, 7)

INSERT INTO ksiegowosc.pensje VALUES (21,'asystent', 5045.54)
INSERT INTO ksiegowosc.pensje VALUES (22,'prezes', 10490.84)
INSERT INTO ksiegowosc.pensje VALUES (23,'manager', 6732.52)
INSERT INTO ksiegowosc.pensje VALUES (24,'specjalista', 7045.64)
INSERT INTO ksiegowosc.pensje VALUES (25,'specjalista', 7045.94)
INSERT INTO ksiegowosc.pensje VALUES (26,'starszy specjalista', 8523.11)
INSERT INTO ksiegowosc.pensje VALUES (27,'asystent', 5045.74)
INSERT INTO ksiegowosc.pensje VALUES (28,'m³odszy specjalista', 6023.11)
INSERT INTO ksiegowosc.pensje VALUES (29,'asystent', 5045.83)
INSERT INTO ksiegowosc.pensje VALUES (30,'m³odszy specjalista', 6023.11)

INSERT INTO ksiegowosc.premie VALUES (31, 'œwi¹teczna', 500)
INSERT INTO ksiegowosc.premie VALUES (32, 'œwi¹teczna', 500)
INSERT INTO ksiegowosc.premie VALUES (33, 'œwi¹teczna', 500)
INSERT INTO ksiegowosc.premie VALUES (36, 'œwi¹teczna', 500)
INSERT INTO ksiegowosc.premie VALUES (35, 'kwartalna', 300)
INSERT INTO ksiegowosc.premie VALUES (34, 'œwi¹teczna', 500)
INSERT INTO ksiegowosc.premie VALUES (37, 'œwi¹teczna', 500)
INSERT INTO ksiegowosc.premie VALUES (38, 'kwartalna', 300)
INSERT INTO ksiegowosc.premie VALUES (39, 'œwi¹teczna', 500)
INSERT INTO ksiegowosc.premie VALUES (40, 'kwartalna', 300)

INSERT INTO ksiegowosc.wynagrodzenie VALUES (51, '2019-09-10', 1, 1543, 27, 35);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (52, '2019-09-10', 8, 1915, 26, NULL);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (53, '2019-09-10', 3, 1654, 23, NULL);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (54, '2019-09-10', 7, 1634, 28, 31);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (55, '2019-09-10', 6, 1204, 21, 34);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (56, '2019-09-10', 5, 1702, 29,36);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (57, '2019-09-10', 4, 1704, 30, NULL); 
INSERT INTO ksiegowosc.wynagrodzenie VALUES (58, '2019-09-10', 10, 1700, 24, 40);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (59, '2019-09-10', 2, 1705, 22, NULL);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (60, '2019-09-10', 9, 1804, 25, 38);


SELECT * FROM ksiegowosc.pracownicy 
SELECT * FROM ksiegowosc.godziny
SELECT * FROM ksiegowosc.pensje
SELECT * FROM ksiegowosc.premie
SELECT * FROM ksiegowosc.wynagrodzenie 

--5. Zapytania:

--a)Wyœwietl tylko id pracownika oraz jego nazwisko

SELECT id_pracownika,nazwisko 
FROM ksiegowosc.pracownicy

--b) Wyœwietl id pracowników, których p³aca jest wiêksza ni¿ 1000.

SELECT ksiegowosc.wynagrodzenie.id_pracownika, ksiegowosc.pensje.kwota
FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji =ksiegowosc.pensje.id_pensji
WHERE ksiegowosc.pensje.kwota>1000

--c) Wyœwietl id pracowników nieposiadaj¹cych premii, których p³aca jest wiêksza ni¿ 2000. 

SELECT ksiegowosc.wynagrodzenie.id_pracownika, ksiegowosc.wynagrodzenie.id_premii, ksiegowosc.pensje.kwota
FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji 
WHERE kwota > 2000 AND wynagrodzenie.id_premii IS NULL;

--d)Wyœwietl pracowników, których pierwsza litera imienia zaczyna siê na literê ‘J’.
SELECT imie
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%'

--e)Wyœwietl pracowników, których nazwisko zawiera literê ‘n’ oraz imiê koñczy siê na literê ‘a’.
SELECT imie, nazwisko
FROM ksiegowosc.pracownicy
WHERE imie LIKE '%a' AND nazwisko LIKE '%n%'

--f) Wyœwietl imiê i nazwisko pracowników oraz liczbê ich nadgodzin, przyjmuj¹c, i¿ standardowy czas pracy to 160 h miesiêcznie.
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ((ksiegowosc.godziny.liczba_godzin*20)-160) AS nad_godz
FROM ksiegowosc.pracownicy INNER JOIN ksiegowosc.godziny ON ksiegowosc.pracownicy.id_pracownika=ksiegowosc.godziny.id_pracownika

--g) Wyœwietl imiê i nazwisko pracowników, których pensja zawiera siê w przedziale 1500 – 3000 PLN.
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensje.kwota
FROM (ksiegowosc.pracownicy INNER JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika) 
INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
WHERE ksiegowosc.pensje.kwota BETWEEN 1500 and 3000;

--h) Wyœwietl imiê i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii.
SELECT ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ((ksiegowosc.godziny.liczba_godzin*20)-160) AS nad_godz, ksiegowosc.wynagrodzenie.id_premii
FROM ksiegowosc.pracownicy INNER JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika 
INNER JOIN ksiegowosc.godziny ON ksiegowosc.wynagrodzenie.id_godziny = ksiegowosc.godziny.id_godziny 
INNER JOIN ksiegowosc.premie ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premie.id_premii 
WHERE ((ksiegowosc.godziny.liczba_godzin*20)-160)>0 AND ksiegowosc.wynagrodzenie.id_premii IS NULL

--i) Uszereguj pracowników wed³ug pensji.
SELECT ksiegowosc.pracownicy.id_pracownika ,ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensje.kwota
FROM ksiegowosc.pracownicy INNER JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
ORDER BY pensje.kwota

--j) Uszereguj pracowników wed³ug pensji i premii malej¹co.
SELECT ksiegowosc.pracownicy.id_pracownika ,ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko, ksiegowosc.pensje.kwota, ksiegowosc.premie.kwota
FROM ksiegowosc.pracownicy INNER JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
INNER JOIN ksiegowosc.premie ON premie.id_premii= wynagrodzenie.id_premii
ORDER BY pensje.kwota, premie.kwota DESC

--k) Zlicz i pogrupuj pracowników wed³ug pola ‘stanowisko’.

SELECT ksiegowosc.pensje.stanowisko, COUNT(ksiegowosc.pensje.stanowisko) AS liczba
FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji
GROUP BY ksiegowosc.pensje.stanowisko;

--l) Policz œredni¹, minimaln¹ i maksymaln¹ p³acê dla stanowiska ‘kierownik’ (je¿eli takiego nie masz, to przyjmij dowolne inne).

SELECT stanowisko, AVG(kwota) AS srednia, MIN(kwota) AS min, MAX(kwota) AS max
FROM ksiegowosc.pensje
WHERE stanowisko LIKE 'specjalista'
GROUP BY stanowisko;

--m) Policz sumê wszystkich wynagrodzeñ.

SELECT SUM(ksiegowosc.pensje.kwota + ksiegowosc.premie.kwota) AS suma_wynagrodzen
FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji
INNER JOIN ksiegowosc.premie ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premie.id_premii;

--f) Policz sumê wynagrodzeñ w ramach danego stanowiska.
SELECT ksiegowosc.pensje.stanowisko, SUM(ksiegowosc.pensje.kwota) AS wynagrodzenie
FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji
GROUP BY stanowisko;

--g) Wyznacz liczbê premii przyznanych dla pracowników danego stanowiska.
SELECT COUNT(id_premii) AS liczba_premii, stanowisko 
FROM ksiegowosc.wynagrodzenie INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
GROUP BY stanowisko;

--h) Usuñ wszystkich pracowników maj¹cych pensjê mniejsz¹ ni¿ 1200 z³.
DELETE pracownicy 
FROM ((ksiegowosc.pracownicy INNER JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika)
INNER JOIN ksiegowosc.pensje ON pensje.id_pensji = wynagrodzenie.id_pensji)
WHERE pensje.kwota < 1200;