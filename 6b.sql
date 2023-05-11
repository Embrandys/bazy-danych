--6b
-- a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj�c do niego kierunkowy dla Polski w nawiasie (+48)

ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon char(12);

UPDATE ksiegowosc.pracownicy 
SET telefon='111222333';

UPDATE ksiegowosc.pracownicy 
SET telefon=CONCAT('+48',ksiegowosc.pracownicy.telefon);

--b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by� my�lnikami wg wzoru: �555-222-333� 
ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN telefon char(15);
UPDATE ksiegowosc.pracownicy 
SET telefon=CONCAT(LEFT(ksiegowosc.pracownicy.telefon,6),'-', SUBSTRING(ksiegowosc.pracownicy.telefon,7,3),'-', RIGHT(ksiegowosc.pracownicy.telefon,3));


--c) Wy�wietl dane pracownika, kt�rego nazwisko jest najd�u�sze, u�ywaj�c du�ych liter
SELECT id_pracownika, UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko FROM ksiegowosc.pracownicy
WHERE LEN(nazwisko)= (SELECT MAX(LEN(nazwisko)) FROM ksiegowosc.pracownicy );

--d) Wy�wietl dane pracownik�w i ich pensje zakodowane przy pomocy algorytmu md5 
SELECT HASHBYTES('md5',imie) AS imie, HASHBYTES('md5',nazwisko) AS nazwisko, HASHBYTES('md5', CAST(kwota AS NVARCHAR(32))) AS pensja
FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji
INNER JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika

--e)Wy�wietl pracownik�w, ich pensje oraz premie. Wykorzystaj z��czenie lewostronne.

SELECT imie, nazwisko, pensje.kwota AS kwota_pensji , premie.kwota AS kwota_premii
FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji
LEFT JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
LEFT JOIN ksiegowosc.premie ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premie.id_premii

--g) wygeneruj raport (zapytanie), kt�re zwr�ci w wyniki tre�� wg poni�szego szablonu: Pracownik Jan Nowak, w dniu 7.08.2017 
--otrzyma� pensj� ca�kowit� na kwot� 7540 z�, gdzie wynagrodzenie zasadnicze wynosi�o: 5000 z�, premia: 2000 z�, nadgodziny: 540 z�


SELECT CONCAT('Pracownik ',imie,' ',nazwisko,', w dniu ',godziny.dataa,' otrzyma� pensj� ca�kowit� na kwot� ',
pensje.kwota+ISNULL(premie.kwota, 0)+(CASE WHEN (liczba_godzin-160 <= 0) THEN 0 ELSE (liczba_godzin-160)*40 END),
' z�,
gdzie wynagrodzenie zasadnicze wynosi�o: ',pensje.kwota,' z�, premia: ',ISNULL(premie.kwota, 0),' z�, nadgodziny: ',
(CASE WHEN (liczba_godzin-160 <= 0) THEN 0 ELSE (liczba_godzin-160)*40 END),' z�') AS raport

FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika=ksiegowosc.pracownicy.id_pracownika
LEFT JOIN ksiegowosc.godziny ON ksiegowosc.wynagrodzenie.id_godziny=ksiegowosc.godziny.id_godziny
LEFT JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji=ksiegowosc.pensje.id_pensji
LEFT JOIN ksiegowosc.premie ON ksiegowosc.wynagrodzenie.id_premii=ksiegowosc.premie.id_premii
