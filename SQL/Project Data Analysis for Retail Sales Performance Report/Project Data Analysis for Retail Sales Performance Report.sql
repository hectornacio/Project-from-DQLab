-- Mentor: Nelda Ampulembang Parenta (Senior Data Analyst at Logisly)

-- # DESKRIPSI
-- Project ini adalah salah satu project yang terdapat di DQLab dan merupakan bagian dari proses pembelajaran saya di platform DQLab. 
-- DQLab adalah salah satu platform kursus data science di Indonesia.


-- # CHAPTER 2
-- ## DQLab Store Overall Performance
-- ### Overall Performance by Year
SELECT
    LEFT(order_date, 4) AS years,
    SUM(sales) AS sales,
    COUNT(order_status) AS number_of_order
FROM
    dqlab_sales_store
WHERE
    order_status = 'Order Finished'
GROUP BY
    years;

-- ### Overall Performance by Product Sub Category
SELECT
    YEAR(order_date) AS years,
    product_sub_category,
    SUM(sales) AS sales
FROM
    dqlab_sales_store
WHERE
    YEAR(order_date) BETWEEN 2011
    AND 2012
    AND order_status LIKE 'Order Finished'
GROUP BY
    years,
    product_sub_category
ORDER BY
    years,
    sales DESC;

-- # CHAPTER 3
-- ## DQLab Store Promotion Effectiveness and Efficiency
-- ### Promotion Effectiveness and Efficiency by Years
SELECT
    YEAR(order_date) AS years,
    SUM(sales) AS sales,
    SUM(discount_value) AS promotion_value,
    ROUND(SUM(discount_value) / SUM(sales) * 100, 2) as burn_rate_percentage
FROM
    dqlab_sales_store
WHERE
    YEAR(order_date) BETWEEN 2009
    AND 2012
    AND order_status LIKE 'Order Finished'
GROUP BY
    years
ORDER BY
    years;

-- ### Promotion Effectiveness and Efficiency by Product Sub Category
SELECT
    YEAR(order_date) AS years,
    product_sub_category,
    product_category,
    SUM(sales) AS sales,
    SUM(discount_value) AS promotion_value,
    ROUND(SUM(discount_value) / SUM(sales) * 100, 2) as burn_rate_percentage
FROM
    dqlab_sales_store
WHERE
    YEAR(order_date) = 2012
    AND order_status LIKE 'Order Finished'
GROUP BY
    years,
    product_sub_category,
    product_category
ORDER BY
    sales DESC;

-- # CHAPTER 4
-- ## Customer Analytics
-- ### Customers Transactions per Year
SELECT
    YEAR(order_date) AS years,
    COUNT(DISTINCT customer) AS number_of_customer
FROM
    dqlab_sales_store
WHERE
    YEAR(order_date) BETWEEN 2009
    AND 2012
    AND order_status LIKE 'Order Finished'
GROUP BY
    years;
