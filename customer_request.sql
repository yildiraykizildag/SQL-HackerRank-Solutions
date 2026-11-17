-- ==============================================================================
-- Author: Yıldıray  Kızıldağ
-- Description: ERP Sales Data Validation and QA Testing Query
-- Skills Demonstrated: JOINS, Aggregations, Subqueries, Data Integrity Checks
-- ==============================================================================

-- 1. High-Value Customers Analysis (Veri Analitiği)
-- 2026 yılı içinde 50.000 TL üzeri alım yapan premium müşterilerin tespiti
SELECT 
    c.customer_id,
    c.company_name,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2026-01-01'
GROUP BY c.customer_id, c.company_name
HAVING SUM(o.total_amount) > 50000
ORDER BY total_revenue DESC;

-- 2. Departmental Performance Metrics (ERP / İş Analitiği)
-- Departman ortalamasının üzerinde maaş/prim alan personellerin listelenmesi
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary) 
    FROM employees 
    WHERE department_id = e.department_id
);

-- 3. Data Integrity & QA Check (Yazılım Test / QA)
-- Sistemdeki hatalı/sahipsiz (müşteri kaydı olmayan) siparişlerin tespit edilmesi
SELECT 
    order_id,
    order_date,
    customer_id
FROM orders
WHERE customer_id NOT IN (SELECT customer_id FROM customers);
