--zadanie 8

--1) Wykorzystuj�c wyra�enie CTE zbuduj zapytanie, kt�re znajdzie informacje na temat stawki
--pracownika oraz jego danych, a nast�pnie zapisze je do tabeli tymczasowej TempEmployeeInfo. Rozwi�� w oparciu o AdventureWorks.

WITH TempEmployeeInfo (NationalIDNumber,LoginID,JobTitle,BirthDate,Gender, Rate)
AS
(
SELECT	NationalIDNumber,
		LoginID,
		JobTitle,
		BirthDate,
		Gender,
		Rate
FROM AdventureWorks2019.HumanResources.Employee AS emp
INNER JOIN AdventureWorks2019.HumanResources.EmployeePayHistory AS pay
ON emp.BusinessEntityID=pay.BusinessEntityID
)
SELECT * FROM TempEmployeeInfo;

--2)Uzyskaj informacje na temat przychod�w ze sprzeda�y wed�ug firmy i kontaktu (za pomoc� CTE i bazy AdventureWorksL). USE AdventureWorksLT2019WITH zad2 (CompanyContact, Revenue)AS(SELECT	CONCAT(CompanyName,' (',FirstName, ' ', LastName, ')') AS CompanyContact,		TotalDue AS RevenueFROM AdventureWorksLT2019.SalesLT.Customer AS custINNER JOIN AdventureWorksLT2019.SalesLT.SalesOrderHeader AS salesON cust.CustomerID=sales.CustomerID)SELECT * FROM zad2ORDER BY CompanyContact;--3) Napisz zapytanie, kt�re zwr�ci warto�� sprzeda�y dla poszczeg�lnych kategorii produkt�w. Wykorzystaj CTE i baz� AdventureWorksLT.WITH zad3 (Category, SalesValue)AS(SELECT cat."Name" AS Category, CAST(SUM(LineTotal) AS decimal(8,2)) AS SalesValueFROM AdventureWorksLT2019.SalesLT.Product AS prodINNER JOIN AdventureWorksLT2019.SalesLT.ProductCategory AS catON prod.ProductCategoryID = cat.ProductCategoryIDINNER JOIN AdventureWorksLT2019.SalesLT.SalesOrderDetail as ordON prod.ProductID = ord.ProductIDGROUP BY cat."Name")SELECT * FROM zad3