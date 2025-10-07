SELECT
    c.name AS client_name,
    SUM(p.price * oi.quantity) AS total_order_sum
FROM
    clients c
JOIN
    orders o ON c.id = o.client_id
JOIN
    order_items oi ON o.id = oi.order_id
JOIN
    products p ON oi.product_id = p.id
GROUP BY
    c.name
ORDER BY
    total_order_sum DESC;

SELECT
    parent.name AS category_name,
    COUNT(child.id) AS direct_children_count
FROM
    categories AS parent
LEFT JOIN
    categories AS child ON parent.id = child.parent_id
-- Если нужны только корневые категории, как в примере, добавляем WHERE:
-- WHERE parent.parent_id IS NULL
GROUP BY
    parent.id, parent.name -- Группируем по id для надежности, а name выводим
ORDER BY
    parent.name;