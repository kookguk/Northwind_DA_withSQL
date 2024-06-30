#1 2분기 총 매출액
select concat(round(sum(od.quantity*od.unit_price),1),' $') as '매출액' 
from orders o
left join order_details od on o.id=od.order_id
where order_date between '2006-04-01' and '2006-06-30';

#2 상반기 월별  매출액
select substr(order_date,1,7) as '월',sum(quantity*unit_price) as '매출량'
from customers a left join orders b on a.id=customer_id left join order_details c on b.id=order_id
where substr(order_date,1,7)>="2006-01" and substr(order_date,1,7)<"2006-07"
group by substr(order_date,1,7);

#3 카테고리별 판매량 합계
select product_id, category, sum(quantity) 판매량
from order_details
left join products on order_details.product_id = products.id
group by product_id;

#4 사원별 판매량(실적)
select e.last_name, count(*) orders
from orders as o
left join order_details od on o.id=od.order_id
left join employees e on e.id=o.employee_id
where '2006-06-01'<=o.order_date and o.order_date<'2006-07-01'
group by e.last_name;