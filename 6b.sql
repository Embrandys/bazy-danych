--6b
-- a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj¹c do niego kierunkowy dla Polski w nawiasie (+48)

ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon char(12);

UPDATE ksiegowosc.pracownicy 
SET telefon='111222333';

UPDATE ksiegowosc.pracownicy 
SET telefon=CONCAT('+48',ksiegowosc.pracownicy.telefon);

--b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by³ myœlnikami wg wzoru: ‘555-222-333’ 
ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon char(15);
UPDATE ksiegowosc.pracownicy 
SET telefon=CONCAT(LEFT(ksiegowosc.pracownicy.telefon,6),'-', SUBSTRING(ksiegowosc.pracownicy.telefon,7,3),'-', RIGHT(ksiegowosc.pracownicy.telefon,3));


--c) Wyœwietl dane pracownika, którego nazwisko jest najd³u¿sze, u¿ywaj¹c du¿ych liter
SELECT id_pracownika, UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko FROM ksiegowosc.pracownicy
WHERE LEN(nazwisko)= (SELECT MAX(LEN(nazwisko)) FROM ksiegowosc.pracownicy );

--d) Wyœwietl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5 
SELECT HASHBYTES('md5',imie) AS imie, HASHBYTES('md5',nazwisko) AS nazwisko, HASHBYTES('md5', CAST(kwota AS NVARCHAR(32))) AS pensja
FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji
INNER JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika

--e)Wyœwietl pracowników, ich pensje oraz premie. Wykorzystaj z³¹czenie lewostronne.

SELECT imie, nazwisko, pensje.kwota AS kwota_pensji , premie.kwota AS kwota_premii
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji
LEFT JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
LEFT JOIN ksiegowosc.premie ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premie.id_premii

--g) wygeneruj raport (zapytanie), które zwróci w wyniki treœæ wg poni¿szego szablonu: Pracownik Jan Nowak, w dniu 7.08.2017 
--otrzyma³ pensjê ca³kowit¹ na kwotê 7540 z³, gdzie wynagrodzenie zasadnicze wynosi³o: 5000 z³, premia: 2000 z³, nadgodziny: 540 z³


SELECT CONCAT('Pracownik ',imie,' ',nazwisko,', w dniu ',godziny.dataa,' otrzyma³ pensjê ca³kowit¹ na kwotê ',
pensje.kwota+ISNULL(premie.kwota, 0)+(CASE WHEN (liczba_godzin-160 <= 0) THEN 0 ELSE (liczba_godzin-160)*40 END),
' z³,
gdzie wynagrodzenie zasadnicze wynosi³o: ',pensje.kwota,' z³, premia: ',ISNULL(premie.kwota, 0),' z³, nadgodziny: ',
(CASE WHEN (liczba_godzin-160 <= 0) THEN 0 ELSE (liczba_godzin-160)*40 END),' z³') AS raport

FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
LEFT JOIN ksiegowosc.godziny ON ksiegowosc.wynagrodzenie.id_godziny=ksiegowosc.godziny.id_godziny
LEFT JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji
LEFT JOIN ksiegowosc.premie ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premie.id_premii
