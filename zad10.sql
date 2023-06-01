EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"
--1. Napisz zapytanie,kt�re wykorzystuje transakcj� (zaczyna j�), 
--a nast�pnie aktualizuje cen� produktu o ProductID r�wnym 680 w tabeli 
--Production.Product o 10% i nast�pnie zatwierdza transakcj�.

BEGIN TRANSACTION
UPDATE Production.Product SET ListPrice=ListPrice*1.1
WHERE ProductID=680
COMMIT;

SELECT ProductID, ListPrice FROM Production.Product
WHERE ProductID=680;

--2. Napisz zapytanie, kt�re zaczyna transakcj�, usuwa produkt o ProductID r�wnym
--707 z tabeli Production.Product, ale nast�pnie wycofuje transakcj�.

BEGIN TRANSACTION
DELETE FROM Production.Product
WHERE ProductID=707
PRINT 'Wycofano'
ROLLBACK;

--3. Napisz zapytanie, kt�re zaczyna transakcj�, dodaje nowy produkt do tabeli
--Production.Product, a nast�pnie zatwierdza transakcj�.
SELECT * FROM Production.Product

SET IDENTITY_INSERT Production.Product ON; --pozwala dodawa� PK
BEGIN TRANSACTION
INSERT INTO Production.Product(ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color,SafetyStockLevel,ReorderPoint, StandardCost, ListPrice,DaysToManufacture, SellStartDate)
VALUES (1000, '...', 'EB-0511', 1, 1, 'Pink', 500, 100,350, 600, 0,'2008-04-30 00:00:00.000')
COMMIT;
SET IDENTITY_INSERT Production.Product OFF;  

--4. Napisz zapytanie, kt�re zaczyna transakcj� i aktualizuje StandardCost wszystkich
--produkt�w w tabeli Production.Product o 10%, je�eli suma wszystkich
--StandardCost po aktualizacji nie przekracza 50000. W przeciwnym razie zapytanie
--powinno wycofa� transakcj�.

BEGIN TRANSACTION
UPDATE Production.Product SET ListPrice=ListPrice*1.1
IF (SELECT SUM(StandardCost) FROM Production.Product) <=50000
COMMIT
ELSE
PRINT 'Odrzucono'
ROLLBACK;

--5. Napisz zapytanie SQL, kt�re zaczyna transakcj� i pr�buje doda� nowy produkt do tabeli
--Production.Product. Je�li ProductNumber ju� istnieje w tabeli, zapytanie powinno
--wycofa� transakcj�.
SET IDENTITY_INSERT Production.Product ON;
BEGIN TRANSACTION
IF NOT EXISTS(SELECT ProductNumber FROM Production.Product WHERE ProductNumber = 'EB-0511')
BEGIN
INSERT INTO Production.Product(ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color,SafetyStockLevel,ReorderPoint, StandardCost, ListPrice,DaysToManufacture, SellStartDate)
VALUES (1000, '...', 'EB-0511', 1, 1, 'Pink', 500, 100,350, 600, 0,'2008-04-30 00:00:00.000')
COMMIT
END
ELSE 
ROLLBACK
SET IDENTITY_INSERT Production.Product OFF;

--6. Napisz zapytanie SQL, kt�re zaczyna transakcj� i aktualizuje warto�� OrderQty
--dla ka�dego zam�wienia w tabeli Sales.SalesOrderDetail. Je�eli kt�rykolwiek z
--zam�wie� ma OrderQty r�wn� 0, zapytanie powinno wycofa� transakcj�.

BEGIN TRANSACTION
UPDATE Sales.SalesOrderDetail SET OrderQty=2*OrderQty
IF EXISTS (SELECT OrderQty FROM Sales.SalesOrderDetail WHERE OrderQty=0)
ROLLBACK;
ELSE 
COMMIT;

--7. Napisz zapytanie SQL, kt�re zaczyna transakcj� i usuwa wszystkie produkty,
--kt�rych StandardCost jest wy�szy ni� �redni koszt wszystkich produkt�w w tabeli
--Production.Product. Je�eli liczba produkt�w do usuni�cia przekracza 10,
--zapytanie powinno wycofa� transakcj�

BEGIN TRANSACTION
IF (SELECT COUNT(StandardCost) FROM Production.Product WHERE StandardCost > (SELECT AVG(ListPrice) FROM Production.Product)) <10
BEGIN
DELETE FROM Production.Product
WHERE StandardCost > (SELECT AVG(StandardCost) FROM Production.Product)
COMMIT
END
ELSE
ROLLBACK;

