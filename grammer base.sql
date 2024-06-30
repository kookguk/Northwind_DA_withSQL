select Country, count(CustomerID) as cnt
from Customers
where ContactName like 'A%'
group by Country

select a.CustomerID, sum(b.Quantity) as TotalQuantity
from Orders a
join OrderDetails b
on a.OrderID = b.OrderID
group by a.CustomerID

select a.OrderDate, a.EmployeeID, sum(b.ProductID) as TotalProduct
from Orders a
join OrderDetails b
on a.OrderID = b.OrderID
group by OrderDate, EmployeeID

