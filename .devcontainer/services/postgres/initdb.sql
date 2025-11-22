-- Create the main schema
CREATE SCHEMA IF NOT EXISTS main;
GRANT ALL ON SCHEMA main TO app;

-- Restrict privileges on the public schema
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM app;
GRANT USAGE ON SCHEMA public TO app;

-- Set the search_path for the app role (cluster-wide)
ALTER ROLE app SET search_path = main, public;

-- Create citext extension inside the main schema
CREATE EXTENSION IF NOT EXISTS citext SCHEMA main;

-- Create the test database
CREATE DATABASE app_test ENCODING 'UTF-8' LC_COLLATE 'C' LC_CTYPE 'C';

-- Grant privileges on the test database to the app role
GRANT ALL PRIVILEGES ON DATABASE app_test TO app;

-- Connect to the test database
\c app_test

-- Create the main schema in the test database
CREATE SCHEMA IF NOT EXISTS main;
GRANT ALL ON SCHEMA main TO app;

-- Restrict privileges on the public schema (test DB)
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM app;
GRANT USAGE ON SCHEMA public TO app;

-- Create citext extension inside the main schema (test DB)
CREATE EXTENSION IF NOT EXISTS citext SCHEMA main;
