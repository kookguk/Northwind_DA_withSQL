#1 분기별, 제품별 총 매출
select a.`분기`, a.ProductName, a.`매출액`
from (select quarter(OrderDate) as '분기', Product.ProductName, sum(OrderDetail.Quantity * OrderDetail.UnitPrice) as '매출액' from OrderDetail 
    inner join Orders on Orders.Id = OrderDetail.OrderId
    inner join Product on Product.Id = OrderDetail.ProductId
    where quarter(OrderDate) = 1
    group by quarter(OrderDate), ProductName
    order by sum(Quantity * UnitPrice) desc
    limit 5) as a

union
    
select b.`분기`, b.ProductName, b.`매출액`
from (select quarter(OrderDate) as '분기', Product.ProductName, sum(OrderDetail.Quantity * OrderDetail.UnitPrice) as '매출액' from OrderDetail 
    inner join Orders on Orders.Id = OrderDetail.OrderId
    inner join Product on Product.Id = OrderDetail.ProductId
    where quarter(OrderDate) = 2
    group by quarter(OrderDate), ProductName
    order by sum(Quantity * UnitPrice) desc
    limit 5) as b
    
union

select c.`분기`, c.ProductName, c.`매출액`
from (select quarter(OrderDate) as '분기', Product.ProductName, sum(OrderDetail.Quantity * OrderDetail.UnitPrice) as '매출액' from OrderDetail 
    inner join Orders on Orders.Id = OrderDetail.OrderId
    inner join Product on Product.Id = OrderDetail.ProductId
    where quarter(OrderDate) = 3
    group by quarter(OrderDate), ProductName
    order by sum(Quantity * UnitPrice) desc
    limit 5) as c
    
union

select d.`분기`, d.ProductName, d.`매출액`
from (select quarter(OrderDate) as '분기', Product.ProductName, sum(OrderDetail.Quantity * OrderDetail.UnitPrice) as '매출액' from OrderDetail 
    inner join Orders on Orders.Id = OrderDetail.OrderId
    inner join Product on Product.Id = OrderDetail.ProductId
    where quarter(OrderDate) = 4
    group by quarter(OrderDate), ProductName
    order by sum(Quantity * UnitPrice) desc
    limit 5) as d
    
#2 분기별, 배송지별 총 매출
select a.`분기`, a.`매출액`, ANY_VALUE(a.ShipAddress) as '배송 지역' ,  a.ProductName as '상품'
from (select quarter(OrderDate) as '분기', Orders.ShipAddress ,Product.ProductName, sum(OrderDetail.Quantity * OrderDetail.UnitPrice) as '매출액' from OrderDetail
    inner join Orders on Orders.Id = OrderDetail.OrderId
    inner join Product on Product.Id = OrderDetail.ProductId
    where quarter(OrderDate) = 1
    group by quarter(OrderDate), Orders.ShipAddress, Product.ProductName
    order by sum(Quantity * UnitPrice) desc
    limit 5) as a

union

select b.`분기`, b.`매출액`, ANY_VALUE(b.ShipAddress) as '배송 지역' ,  b.ProductName as '상품'
from (select quarter(OrderDate) as '분기', Orders.ShipAddress ,Product.ProductName, sum(OrderDetail.Quantity * OrderDetail.UnitPrice) as '매출액' from OrderDetail
    inner join Orders on Orders.Id = OrderDetail.OrderId
    inner join Product on Product.Id = OrderDetail.ProductId
    where quarter(OrderDate) = 2
    group by quarter(OrderDate), Orders.ShipAddress, Product.ProductName
    order by sum(Quantity * UnitPrice) desc
    limit 5) as b
    
union

select c.`분기`, c.`매출액`, ANY_VALUE(c.ShipAddress) as '배송 지역' ,  c.ProductName as '상품'
from (select quarter(OrderDate) as '분기', Orders.ShipAddress ,Product.ProductName, sum(OrderDetail.Quantity * OrderDetail.UnitPrice) as '매출액' from OrderDetail
    inner join Orders on Orders.Id = OrderDetail.OrderId
    inner join Product on Product.Id = OrderDetail.ProductId
    where quarter(OrderDate) = 3
    group by quarter(OrderDate), Orders.ShipAddress, Product.ProductName
    order by sum(Quantity * UnitPrice) desc
    limit 5) as c
    
union

select d.`분기`, d.`매출액`, ANY_VALUE(d.ShipAddress) as '배송 지역' ,  d.ProductName as '상품'
from (select quarter(OrderDate) as '분기', Orders.ShipAddress ,Product.ProductName, sum(OrderDetail.Quantity * OrderDetail.UnitPrice) as '매출액' from OrderDetail
    inner join Orders on Orders.Id = OrderDetail.OrderId
    inner join Product on Product.Id = OrderDetail.ProductId
    where quarter(OrderDate) = 4
    group by quarter(OrderDate), Orders.ShipAddress, Product.ProductName
    order by sum(Quantity * UnitPrice) desc
    limit 5) as d

#3 고객 직업별 구매액
select  c.job_title, sum(od.quantity * od.unit_price) `구매금액` from orders o 
left join order_details od 
on o.id = od.order_id
left join customers c 
on c.id = o.customer_id
group by c.job_title
order by  `구매금액` desc