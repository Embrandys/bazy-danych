EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"
--1. Napisz zapytanie,które wykorzystuje transakcjê (zaczyna j¹), 
--a nastêpnie aktualizuje cenê produktu o ProductID równym 680 w tabeli 
--Production.Product o 10% i nastêpnie zatwierdza transakcjê.

BEGIN TRANSACTION
UPDATE Production.Product SET ListPrice=ListPrice*1.1
WHERE ProductID=680
COMMIT;

SELECT ProductID, ListPrice FROM Production.Product
WHERE ProductID=680;

--2. Napisz zapytanie, które zaczyna transakcjê, usuwa produkt o ProductID równym
--707 z tabeli Production.Product, ale nastêpnie wycofuje transakcjê.

BEGIN TRANSACTION
DELETE FROM Production.Product
WHERE ProductID=707
PRINT 'Wycofano'
ROLLBACK;

--3. Napisz zapytanie, które zaczyna transakcjê, dodaje nowy produkt do tabeli
--Production.Product, a nastêpnie zatwierdza transakcjê.
SELECT * FROM Production.Product

SET IDENTITY_INSERT Production.Product ON; --pozwala dodawaæ PK
BEGIN TRANSACTION
INSERT INTO Production.Product(ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color,SafetyStockLevel,ReorderPoint, StandardCost, ListPrice,DaysToManufacture, SellStartDate)
VALUES (1000, '...', 'EB-0511', 1, 1, 'Pink', 500, 100,350, 600, 0,'2008-04-30 00:00:00.000')
COMMIT;
SET IDENTITY_INSERT Production.Product OFF;  

--4. Napisz zapytanie, które zaczyna transakcjê i aktualizuje StandardCost wszystkich
--produktów w tabeli Production.Product o 10%, je¿eli suma wszystkich
--StandardCost po aktualizacji nie przekracza 50000. W przeciwnym razie zapytanie
--powinno wycofaæ transakcjê.

BEGIN TRANSACTION
UPDATE Production.Product SET ListPrice=ListPrice*1.1
IF (SELECT SUM(StandardCost) FROM Production.Product) <=50000
COMMIT
ELSE
PRINT 'Odrzucono'
ROLLBACK;

--5. Napisz zapytanie SQL, które zaczyna transakcjê i próbuje dodaæ nowy produkt do tabeli
--Production.Product. Jeœli ProductNumber ju¿ istnieje w tabeli, zapytanie powinno
--wycofaæ transakcjê.
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

--6. Napisz zapytanie SQL, które zaczyna transakcjê i aktualizuje wartoœæ OrderQty
--dla ka¿dego zamówienia w tabeli Sales.SalesOrderDetail. Je¿eli którykolwiek z
--zamówieñ ma OrderQty równ¹ 0, zapytanie powinno wycofaæ transakcjê.

BEGIN TRANSACTION
UPDATE Sales.SalesOrderDetail SET OrderQty=2*OrderQty
IF EXISTS (SELECT OrderQty FROM Sales.SalesOrderDetail WHERE OrderQty=0)
ROLLBACK;
ELSE 
COMMIT;

--7. Napisz zapytanie SQL, które zaczyna transakcjê i usuwa wszystkie produkty,
--których StandardCost jest wy¿szy ni¿ œredni koszt wszystkich produktów w tabeli
--Production.Product. Je¿eli liczba produktów do usuniêcia przekracza 10,
--zapytanie powinno wycofaæ transakcjê

BEGIN TRANSACTION
IF (SELECT COUNT(StandardCost) FROM Production.Product WHERE StandardCost > (SELECT AVG(ListPrice) FROM Production.Product)) <10
BEGIN
DELETE FROM Production.Product
WHERE StandardCost > (SELECT AVG(StandardCost) FROM Production.Product)
COMMIT
END
ELSE
ROLLBACK;

