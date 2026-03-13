-- =====================================================
-- SUPPLY CHAIN LOGISTICS DATA ANALYSIS
-- =====================================================
-- Tools: PostgreSQL
-- Dataset: logistics_shipments_dataset
-- Description: Analyze shipment activity, supplier performance,
-- and logistics patterns using SQL.
-- =====================================================



-- =====================================================
-- 1. DATA LOADING AND PREPARATION
-- =====================================================
-- Create table structure based on dataset columns

CREATE TABLE shipments (
    shipment_id TEXT,
    origin_warehouse TEXT,
    destination TEXT,
    carrier TEXT,
    shipment_date DATE,
    delivery_date DATE,
    weight_kg NUMERIC,
    cost NUMERIC,
    status TEXT,
    distance_miles NUMERIC,
    transit_days INT
);

-- Import CSV file into the table
-- \copy shipments FROM 'file_path/logistics_shipments_dataset.csv' CSV HEADER;



-- =====================================================
-- 2. DATA EXPLORATION
-- =====================================================

-- Total number of shipments in dataset
SELECT COUNT(*) AS total_shipments
FROM shipments;

-- Date range of shipment data
SELECT 
MIN(shipment_date) AS first_shipment,
MAX(shipment_date) AS last_shipment
FROM shipments;

-- Shipment status distribution
SELECT 
status,
COUNT(*) AS shipment_count
FROM shipments
GROUP BY status
ORDER BY shipment_count DESC;



-- =====================================================
-- 3. SHIPMENT TRENDS OVER TIME
-- =====================================================

-- Analyze how shipment volume changes over time

SELECT
TO_CHAR(DATE_TRUNC('month', shipment_date), 'YYYY-MM') AS month,
COUNT(*) AS shipment_volume
FROM shipments
GROUP BY month
ORDER BY month;



-- =====================================================
-- 4. TOP SUPPLIERS BY SHIPMENT VOLUME
-- =====================================================

-- Identify suppliers (warehouses) with the highest shipment activity

SELECT
origin_warehouse,
COUNT(*) AS shipment_volume
FROM shipments
GROUP BY origin_warehouse
ORDER BY shipment_volume DESC;



-- =====================================================
-- 5. SHIPPING MODE DISTRIBUTION
-- =====================================================

-- Analyze which carriers are most frequently used

SELECT
carrier,
COUNT(*) AS shipment_count
FROM shipments
GROUP BY carrier
ORDER BY shipment_count DESC;



-- =====================================================
-- 6. AVERAGE DELIVERY TIME ANALYSIS
-- =====================================================

-- Compare delivery performance across carriers

SELECT
carrier,
ROUND(AVG(transit_days),2) AS avg_delivery_days
FROM shipments
GROUP BY carrier
ORDER BY avg_delivery_days;