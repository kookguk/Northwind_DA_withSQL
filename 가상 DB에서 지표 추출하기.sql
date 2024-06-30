#1 상품(product)의 카테고리(category)별로, 상품 수와 평균 가격대(list_price)를 찾는 쿼리를 작성하세요.
SELECT category, COUNT(*) AS product_count, AVG(list_price) AS average_price
FROM products
GROUP BY category

#2 2006년 1분기에 고객(customer)별 주문(order) 횟수, 주문한 상품(product)의 카테고리(category) 수, 총 주문 금액(quantity * unit_price)을 찾는 쿼리를 작성하세요.
SELECT o.customer_id, COUNT(DISTINCT o.id) AS order_count,
COUNT(DISTINCT p.category) AS category_count,
SUM(od. quantity * od.unit_price) AS total_order_amount
FROM orders o
JOIN order_details od ON o. id = od.order_id
JOIN products p ON od. product_id = p.id
WHERE o.order_date BETWEEN '2006-01-01' AND '2006-03-31'
GROUP BY o. customer_id

#3 2006년 3월에 주문(order)된 건의 주문 상태(status_name)를 찾는 쿼리를 작성하세요.
SELECT status_name
FROM orders_status
WHERE id IN 
(SELECT status_id
FROM orders
WHERE order_date BETWEEN '2006-03-01' AND '2006-03-31')

#4 2006년 1분기 동안 세 번 이상 주문(order) 된 상품(product)과 그 상품의 주문 수를 찾는 쿼리를 작성하세요.
SELECT product_id, COUNT (*) AS order_count
FROM order_details
WHERE order_id IN 
(SELECT id
FROM orders
WHERE order_date BETWEEN '2006-01-01' AND '2006-03-31')
GROUP BY product_id
HAVING COUNT(*) >= 3

#5-1 2006년 1분기, 2분기 연속으로 주문(order)을 받은 직원(employee)을 찾는 쿼리를 작성하세요. 
SELECT DISTINCT e.id
FROM employees e
JOIN (SELECT employee_id
FROM orders
WHERE order_date BETWEEN '2006-01-01' AND '2006-03-31'
GROUP BY employee_id) AS Q1
ON e.id = Q1.employee_id
JOIN (SELECT employee_id
FROM orders
WHERE order_date BETWEEN '2006-04-01' AND '2006-06-30'
GROUP BY employee_id) AS Q2
ON e. id = Q2. employee_id

#5-2 2006년 1분기, 2분기 연속으로 주문(order)을 받은 직원(employee)별로, 2006년 월별 주문 수를 찾는 쿼리를 작성하세요.
SELECT
    o.employee_id,
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    COUNT(o.id) AS order_count
FROM orders o
WHERE o.employee_id IN (
        SELECT Q1.employee_id
        FROM (SELECT employee_id
            FROM orders
            WHERE order_date BETWEEN '2006-01-01' AND '2006-03-31'
            GROUP BY employee_id
            HAVING COUNT(id) > 0) AS Q1
         JOIN (SELECT employee_id
            FROM orders
            WHERE order_date BETWEEN '2006-04-01' AND '2006-06-30'
            GROUP BY employee_id
            HAVING COUNT(id) > 0) AS Q2
        ON Q1.employee_id = Q2.employee_id)
    AND o.order_date BETWEEN '2006-01-01' AND '2006-12-31'
GROUP BY o.employee_id, order_month
