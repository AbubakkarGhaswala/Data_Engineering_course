-- Databricks notebook source
show databases;

-- COMMAND ----------

show tables in information_schema;

-- COMMAND ----------

select * from information_schema.routine_columns;

-- COMMAND ----------

show tables from samples.nyctaxi;

-- COMMAND ----------

select * from samples.nyctaxi.trips;

-- COMMAND ----------

select * from samples.nyctaxi.trips limit 10;

-- COMMAND ----------

select tpep_pickup_datetime, trip_distance , fare_amount from samples.nyctaxi.trips limit 10;

-- COMMAND ----------

select count(*) as total_trips from samples.nyctaxi.trips

-- COMMAND ----------

select avg(trip_distance) as avg_trip_distance from samples.nyctaxi.trips;

-- COMMAND ----------

select * from samples.nyctaxi.trips where trip_distance > 10;

-- COMMAND ----------

select pickup_zip ,dropoff_zip , count(*) as total_trips from samples.nyctaxi.trips 
group by pickup_zip,dropoff_zip;

-- COMMAND ----------

select pickup_zip , count(*) as total_trips from samples.nyctaxi.trips 
group by pickup_zip having count(*) > 100; 

-- COMMAND ----------

select * from samples.nyctaxi.trips order by trip_distance desc limit 10;
