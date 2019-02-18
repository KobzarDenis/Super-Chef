--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: bookkeeping; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA bookkeeping;


ALTER SCHEMA bookkeeping OWNER TO postgres;

--
-- Name: personal; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA personal;


ALTER SCHEMA personal OWNER TO postgres;

--
-- Name: service; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA service;


ALTER SCHEMA service OWNER TO postgres;

--
-- Name: stock; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA stock;


ALTER SCHEMA stock OWNER TO postgres;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: enum_caterers_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_caterers_status AS ENUM (
    'active',
    'inactive'
);


ALTER TYPE public.enum_caterers_status OWNER TO postgres;

--
-- Name: enum_employees_sex; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_employees_sex AS ENUM (
    'male',
    'female'
);


ALTER TYPE public.enum_employees_sex OWNER TO postgres;

--
-- Name: enum_orders_paymentType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."enum_orders_paymentType" AS ENUM (
    'cash',
    'card'
);


ALTER TYPE public."enum_orders_paymentType" OWNER TO postgres;

--
-- Name: enum_orders_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_orders_status AS ENUM (
    'opened',
    'closed'
);


ALTER TYPE public.enum_orders_status OWNER TO postgres;

--
-- Name: enum_tables_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_tables_status AS ENUM (
    'free',
    'reserved',
    'busy'
);


ALTER TYPE public.enum_tables_status OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: bookkeeping; Owner: postgres
--

CREATE TABLE bookkeeping.accounts (
    id integer NOT NULL,
    number character varying(100) NOT NULL,
    "bankId" integer NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    CONSTRAINT accounts_number_lenght CHECK ((char_length((number)::text) >= 8))
);


ALTER TABLE bookkeeping.accounts OWNER TO postgres;

--
-- Name: COLUMN accounts.number; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.accounts.number IS 'Type varchar(100) number can be shorter but can not be longer than 100 characters. Required.';


--
-- Name: COLUMN accounts."isActive"; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.accounts."isActive" IS 'Type boolean because we need only 2 values (true/false). Required.';


--
-- Name: COLUMN accounts."createdAt"; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.accounts."createdAt" IS 'Type timestamptz because we can have worldwide restaurant. Required.';


--
-- Name: COLUMN accounts."updatedAt"; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.accounts."updatedAt" IS 'Type timestamptz because we can have worldwide restaurant. Required.';


--
-- Name: CONSTRAINT accounts_number_lenght ON accounts; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON CONSTRAINT accounts_number_lenght ON bookkeeping.accounts IS 'Number can not be shorter than 8.';


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: bookkeeping; Owner: postgres
--

CREATE SEQUENCE bookkeeping.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bookkeeping.accounts_id_seq OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: bookkeeping; Owner: postgres
--

ALTER SEQUENCE bookkeeping.accounts_id_seq OWNED BY bookkeeping.accounts.id;


--
-- Name: banks; Type: TABLE; Schema: bookkeeping; Owner: postgres
--

CREATE TABLE bookkeeping.banks (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    "transitAccount" character varying(100) NOT NULL,
    bic character varying(100) NOT NULL,
    bin character varying(100) NOT NULL,
    CONSTRAINT banks_bic_length CHECK ((char_length((bic)::text) >= 4)),
    CONSTRAINT banks_bin_lenght CHECK ((char_length((bin)::text) >= 4)),
    CONSTRAINT "banks_transitAccount_length" CHECK ((char_length(("transitAccount")::text) >= 8))
);


ALTER TABLE bookkeeping.banks OWNER TO postgres;

--
-- Name: COLUMN banks.name; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.banks.name IS 'Type varchar(100) name can be shorter but can not be longer than 100 characters. Required. Uniq for each banks.';


--
-- Name: COLUMN banks."transitAccount"; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.banks."transitAccount" IS 'Type varchar(100) transitAccount can be shorter but can not be longer than 100 characters. Required. Uniq for each banks.';


--
-- Name: COLUMN banks.bic; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.banks.bic IS 'Type varchar(100) bic can be shorter but can not be longer than 100 characters. Required. Uniq for each banks.';


--
-- Name: COLUMN banks.bin; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.banks.bin IS 'Type varchar(100) bin can be shorter but can not be longer than 100 characters. Required. Uniq for each banks.';


--
-- Name: CONSTRAINT banks_bic_length ON banks; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON CONSTRAINT banks_bic_length ON bookkeeping.banks IS 'BIC number can not be shorter than 4 characters. Uniq for each banks.';


--
-- Name: CONSTRAINT banks_bin_lenght ON banks; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON CONSTRAINT banks_bin_lenght ON bookkeeping.banks IS 'BIN number can not be shorter than 4 characters. Uniq for each banks.';


--
-- Name: CONSTRAINT "banks_transitAccount_length" ON banks; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON CONSTRAINT "banks_transitAccount_length" ON bookkeeping.banks IS 'Transit account can not be shorter than 8 characters. Uniq for each banks.';


--
-- Name: banks_id_seq; Type: SEQUENCE; Schema: bookkeeping; Owner: postgres
--

CREATE SEQUENCE bookkeeping.banks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bookkeeping.banks_id_seq OWNER TO postgres;

--
-- Name: banks_id_seq; Type: SEQUENCE OWNED BY; Schema: bookkeeping; Owner: postgres
--

ALTER SEQUENCE bookkeeping.banks_id_seq OWNED BY bookkeeping.banks.id;


--
-- Name: incomes; Type: TABLE; Schema: bookkeeping; Owner: postgres
--

CREATE TABLE bookkeeping.incomes (
    id integer NOT NULL,
    "transactionId" character varying(50) DEFAULT concat('in-', public.uuid_generate_v4()) NOT NULL,
    description text,
    "timestamp" timestamp with time zone NOT NULL,
    amount numeric(5,2) NOT NULL,
    "incomeType" smallint NOT NULL,
    CONSTRAINT incomes_positive_amount CHECK ((amount > (0)::numeric))
);


ALTER TABLE bookkeeping.incomes OWNER TO postgres;

--
-- Name: COLUMN incomes."transactionId"; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.incomes."transactionId" IS 'Type varchar(50) transactionId can be shorter but can not be longer than 50 characters. Special key with prefix "in-" and uuid. Required. Uniq for each incomes.';


--
-- Name: COLUMN incomes.description; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.incomes.description IS 'Type text because description will be able to have unlimited length.';


--
-- Name: COLUMN incomes."timestamp"; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.incomes."timestamp" IS 'Type timestamptz because we can have worldwide restaurant. Required.';


--
-- Name: COLUMN incomes.amount; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.incomes.amount IS 'Type numeric(5,2) because we need only 2 digits scale. Required.';


--
-- Name: COLUMN incomes."incomeType"; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.incomes."incomeType" IS 'Income type. Value from table transactionTypes. Required.';


--
-- Name: CONSTRAINT incomes_positive_amount ON incomes; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON CONSTRAINT incomes_positive_amount ON bookkeeping.incomes IS 'Amount can not be smallest than 0.1.';


--
-- Name: incomes_id_seq; Type: SEQUENCE; Schema: bookkeeping; Owner: postgres
--

CREATE SEQUENCE bookkeeping.incomes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bookkeeping.incomes_id_seq OWNER TO postgres;

--
-- Name: incomes_id_seq; Type: SEQUENCE OWNED BY; Schema: bookkeeping; Owner: postgres
--

ALTER SEQUENCE bookkeeping.incomes_id_seq OWNED BY bookkeeping.incomes.id;


--
-- Name: outcomes; Type: TABLE; Schema: bookkeeping; Owner: postgres
--

CREATE TABLE bookkeeping.outcomes (
    id integer NOT NULL,
    "transactionId" character varying(50) DEFAULT concat('out-', public.uuid_generate_v4()) NOT NULL,
    "accountId" integer NOT NULL,
    "employeeId" integer NOT NULL,
    description text,
    "timestamp" timestamp with time zone NOT NULL,
    amount numeric(5,2) NOT NULL,
    "outcomeType" smallint NOT NULL,
    status smallint NOT NULL,
    CONSTRAINT outcomes_positive_amount CHECK ((amount > (0)::numeric))
);


ALTER TABLE bookkeeping.outcomes OWNER TO postgres;

--
-- Name: COLUMN outcomes."transactionId"; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.outcomes."transactionId" IS 'Type varchar(50) transactionId can be shorter but can not be longer than 50 characters. Special key with prefix "out-" and uuid. Required. Uniq for each incomes.';


--
-- Name: COLUMN outcomes.description; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.outcomes.description IS 'Type text because description will be able to have unlimited length.';


--
-- Name: COLUMN outcomes."timestamp"; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.outcomes."timestamp" IS 'Type timestamptz because we can have worldwide restaurant. Required.';


--
-- Name: COLUMN outcomes.amount; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.outcomes.amount IS 'Type numeric(5,2) because we need only 2 digits scale. Required.';


--
-- Name: COLUMN outcomes."outcomeType"; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.outcomes."outcomeType" IS 'Outcome type. Value from table transactionTypes. Required.';


--
-- Name: COLUMN outcomes.status; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON COLUMN bookkeeping.outcomes.status IS 'Transaction status. Value from table transactionStatuses. Required.';


--
-- Name: CONSTRAINT outcomes_positive_amount ON outcomes; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON CONSTRAINT outcomes_positive_amount ON bookkeeping.outcomes IS 'Amount can not be smallest than 0.1.';


--
-- Name: outcomes_id_seq; Type: SEQUENCE; Schema: bookkeeping; Owner: postgres
--

CREATE SEQUENCE bookkeeping.outcomes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bookkeeping.outcomes_id_seq OWNER TO postgres;

--
-- Name: outcomes_id_seq; Type: SEQUENCE OWNED BY; Schema: bookkeeping; Owner: postgres
--

ALTER SEQUENCE bookkeeping.outcomes_id_seq OWNED BY bookkeeping.outcomes.id;


--
-- Name: transactionStatuses; Type: TABLE; Schema: bookkeeping; Owner: postgres
--

CREATE TABLE bookkeeping."transactionStatuses" (
    id integer NOT NULL,
    name character varying(20),
    description character varying(300)
);


ALTER TABLE bookkeeping."transactionStatuses" OWNER TO postgres;

--
-- Name: transactionStatuses_id_seq; Type: SEQUENCE; Schema: bookkeeping; Owner: postgres
--

CREATE SEQUENCE bookkeeping."transactionStatuses_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bookkeeping."transactionStatuses_id_seq" OWNER TO postgres;

--
-- Name: transactionStatuses_id_seq; Type: SEQUENCE OWNED BY; Schema: bookkeeping; Owner: postgres
--

ALTER SEQUENCE bookkeeping."transactionStatuses_id_seq" OWNED BY bookkeeping."transactionStatuses".id;


--
-- Name: transactionTypes; Type: TABLE; Schema: bookkeeping; Owner: postgres
--

CREATE TABLE bookkeeping."transactionTypes" (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(300) NOT NULL
);


ALTER TABLE bookkeeping."transactionTypes" OWNER TO postgres;

--
-- Name: transactionTypes_id_seq; Type: SEQUENCE; Schema: bookkeeping; Owner: postgres
--

CREATE SEQUENCE bookkeeping."transactionTypes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bookkeeping."transactionTypes_id_seq" OWNER TO postgres;

--
-- Name: transactionTypes_id_seq; Type: SEQUENCE OWNED BY; Schema: bookkeeping; Owner: postgres
--

ALTER SEQUENCE bookkeeping."transactionTypes_id_seq" OWNED BY bookkeeping."transactionTypes".id;


--
-- Name: employeeRoles; Type: TABLE; Schema: personal; Owner: postgres
--

CREATE TABLE personal."employeeRoles" (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE personal."employeeRoles" OWNER TO postgres;

--
-- Name: COLUMN "employeeRoles".name; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON COLUMN personal."employeeRoles".name IS 'Type varchar(50) name can be shorter but can not be longer than 50 characters.';


--
-- Name: COLUMN "employeeRoles".description; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON COLUMN personal."employeeRoles".description IS 'Type text because description will be able to have unlimited length.';


--
-- Name: employeeRoles_id_seq; Type: SEQUENCE; Schema: personal; Owner: postgres
--

CREATE SEQUENCE personal."employeeRoles_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE personal."employeeRoles_id_seq" OWNER TO postgres;

--
-- Name: employeeRoles_id_seq; Type: SEQUENCE OWNED BY; Schema: personal; Owner: postgres
--

ALTER SEQUENCE personal."employeeRoles_id_seq" OWNED BY personal."employeeRoles".id;


--
-- Name: employees; Type: TABLE; Schema: personal; Owner: postgres
--

CREATE TABLE personal.employees (
    id integer NOT NULL,
    "firstName" character varying(100) NOT NULL,
    "lastName" character varying(100) NOT NULL,
    ein character varying(20) NOT NULL,
    "accountId" integer NOT NULL,
    "passportCode" character varying(5) NOT NULL,
    "passportSeries" character varying(10) NOT NULL,
    sex public.enum_employees_sex NOT NULL,
    salary numeric(5,2) NOT NULL,
    address character varying(100) NOT NULL,
    "phoneNumber" character varying(20) NOT NULL,
    email character varying(50),
    "roleId" integer NOT NULL,
    "offerDate" timestamp with time zone NOT NULL,
    "fireDate" timestamp with time zone,
    CONSTRAINT "employees_passCode_length" CHECK ((char_length(("passportCode")::text) >= 2)),
    CONSTRAINT "employees_passSeries_length" CHECK ((char_length(("passportSeries")::text) >= 5))
);


ALTER TABLE personal.employees OWNER TO postgres;

--
-- Name: COLUMN employees."firstName"; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON COLUMN personal.employees."firstName" IS 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';


--
-- Name: COLUMN employees."lastName"; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON COLUMN personal.employees."lastName" IS 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';


--
-- Name: COLUMN employees.ein; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON COLUMN personal.employees.ein IS 'Type varchar(20) because ein can not be longer. Not null because it is required. Uniq because it is uniq for each employee.';


--
-- Name: COLUMN employees."passportCode"; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON COLUMN personal.employees."passportCode" IS 'Type varchar(2) because passportCode can not be longer. Not null because it is required';


--
-- Name: COLUMN employees."passportSeries"; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON COLUMN personal.employees."passportSeries" IS 'Type varchar(10) because passportSeries wont be super long. Not null because it is required';


--
-- Name: COLUMN employees."phoneNumber"; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON COLUMN personal.employees."phoneNumber" IS 'Type varchar(20) because phoneNumber can not be longer. Not null because it is required.';


--
-- Name: COLUMN employees.email; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON COLUMN personal.employees.email IS 'Type varchar(50) because it is variable type and doesnt matter if email will be shorter. Null because it is not required.';


--
-- Name: COLUMN employees."offerDate"; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON COLUMN personal.employees."offerDate" IS 'Type timestamptz because we can have worldwide restaurant. Not null because it is required';


--
-- Name: COLUMN employees."fireDate"; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON COLUMN personal.employees."fireDate" IS 'Type timestamptz because we can have worldwide restaurant. Not null because it is required';


--
-- Name: CONSTRAINT "employees_passCode_length" ON employees; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON CONSTRAINT "employees_passCode_length" ON personal.employees IS 'Passport code can not be smallest than 2.';


--
-- Name: CONSTRAINT "employees_passSeries_length" ON employees; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON CONSTRAINT "employees_passSeries_length" ON personal.employees IS 'Passport series can not be smallest than 5.';


--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: personal; Owner: postgres
--

CREATE SEQUENCE personal.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE personal.employees_id_seq OWNER TO postgres;

--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: personal; Owner: postgres
--

ALTER SEQUENCE personal.employees_id_seq OWNED BY personal.employees.id;


--
-- Name: clients_sequense; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_sequense
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_sequense OWNER TO postgres;

--
-- Name: clientDiscounts; Type: TABLE; Schema: service; Owner: postgres
--

CREATE TABLE service."clientDiscounts" (
    "clientId" integer NOT NULL,
    "discountId" integer NOT NULL
);


ALTER TABLE service."clientDiscounts" OWNER TO postgres;

--
-- Name: clients; Type: TABLE; Schema: service; Owner: postgres
--

CREATE TABLE service.clients (
    id integer NOT NULL,
    "firstName" character varying(100) NOT NULL,
    "lastName" character varying(100),
    email character varying(50),
    "phoneNumber" character varying(20) NOT NULL
);


ALTER TABLE service.clients OWNER TO postgres;

--
-- Name: COLUMN clients."firstName"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.clients."firstName" IS 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';


--
-- Name: COLUMN clients."lastName"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.clients."lastName" IS 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter. Null because it is not required';


--
-- Name: COLUMN clients.email; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.clients.email IS 'Type varchar(50) because it is variable type and doesnt matter if email will be shorter. Null because it doesnt required.';


--
-- Name: COLUMN clients."phoneNumber"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.clients."phoneNumber" IS 'Type varchar(20) because phoneNumber can not be longer. Not null because it is required.';


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: service; Owner: postgres
--

CREATE SEQUENCE service.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE service.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: service; Owner: postgres
--

ALTER SEQUENCE service.clients_id_seq OWNED BY service.clients.id;


--
-- Name: discountGroups; Type: TABLE; Schema: service; Owner: postgres
--

CREATE TABLE service."discountGroups" (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE service."discountGroups" OWNER TO postgres;

--
-- Name: COLUMN "discountGroups".name; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service."discountGroups".name IS 'Type varchar(50) name can be shorter but can not be longer than 50 characters.';


--
-- Name: discountGroups_id_seq; Type: SEQUENCE; Schema: service; Owner: postgres
--

CREATE SEQUENCE service."discountGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE service."discountGroups_id_seq" OWNER TO postgres;

--
-- Name: discountGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: service; Owner: postgres
--

ALTER SEQUENCE service."discountGroups_id_seq" OWNED BY service."discountGroups".id;


--
-- Name: discounts; Type: TABLE; Schema: service; Owner: postgres
--

CREATE TABLE service.discounts (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    count numeric(5,2) NOT NULL,
    "accumulativeBonuses" numeric(5,2) DEFAULT 0 NOT NULL,
    description text,
    "groupId" integer NOT NULL,
    "startDate" timestamp with time zone NOT NULL,
    "endDate" timestamp with time zone,
    CONSTRAINT discounts_code_length CHECK ((char_length((code)::text) = 10)),
    CONSTRAINT "discounts_positive_accumulativeBonuses" CHECK (("accumulativeBonuses" >= (0)::numeric)),
    CONSTRAINT discounts_positive_count CHECK ((count > (0)::numeric))
);


ALTER TABLE service.discounts OWNER TO postgres;

--
-- Name: COLUMN discounts.code; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.discounts.code IS 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';


--
-- Name: COLUMN discounts.count; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.discounts.count IS 'Type numeric(5,2) because we need only 2 digits scale.';


--
-- Name: COLUMN discounts."accumulativeBonuses"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.discounts."accumulativeBonuses" IS 'Type float4 because it wont be super long.';


--
-- Name: COLUMN discounts.description; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.discounts.description IS 'Type text because description will be able to have unlimited length.';


--
-- Name: COLUMN discounts."startDate"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.discounts."startDate" IS 'Type timestamptz because we can have worldwide restaurant. Null because we dont need this data during insert';


--
-- Name: COLUMN discounts."endDate"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.discounts."endDate" IS 'Type timestamptz because we can have worldwide restaurant. Not null because it is required';


--
-- Name: CONSTRAINT discounts_code_length ON discounts; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON CONSTRAINT discounts_code_length ON service.discounts IS 'Code can not be shorter or longer than 10 characters.';


--
-- Name: CONSTRAINT "discounts_positive_accumulativeBonuses" ON discounts; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON CONSTRAINT "discounts_positive_accumulativeBonuses" ON service.discounts IS 'Bonuses can not be smallest than 0.';


--
-- Name: CONSTRAINT discounts_positive_count ON discounts; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON CONSTRAINT discounts_positive_count ON service.discounts IS 'Discount can not be smallest than 0.1.';


--
-- Name: discounts_id_seq; Type: SEQUENCE; Schema: service; Owner: postgres
--

CREATE SEQUENCE service.discounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE service.discounts_id_seq OWNER TO postgres;

--
-- Name: discounts_id_seq; Type: SEQUENCE OWNED BY; Schema: service; Owner: postgres
--

ALTER SEQUENCE service.discounts_id_seq OWNED BY service.discounts.id;


--
-- Name: foodGroups; Type: TABLE; Schema: service; Owner: postgres
--

CREATE TABLE service."foodGroups" (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE service."foodGroups" OWNER TO postgres;

--
-- Name: COLUMN "foodGroups".name; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service."foodGroups".name IS 'Type varchar(100) name can be shorter but can not be longer than 100 characters.';


--
-- Name: foodGroups_id_seq; Type: SEQUENCE; Schema: service; Owner: postgres
--

CREATE SEQUENCE service."foodGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE service."foodGroups_id_seq" OWNER TO postgres;

--
-- Name: foodGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: service; Owner: postgres
--

ALTER SEQUENCE service."foodGroups_id_seq" OWNED BY service."foodGroups".id;


--
-- Name: foodIngredients; Type: TABLE; Schema: service; Owner: postgres
--

CREATE TABLE service."foodIngredients" (
    "foodId" integer NOT NULL,
    "ingredientId" integer NOT NULL,
    weight numeric(5,4) NOT NULL,
    CONSTRAINT "foodIngredients_positive_weight" CHECK ((weight > (0)::numeric))
);


ALTER TABLE service."foodIngredients" OWNER TO postgres;

--
-- Name: COLUMN "foodIngredients".weight; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service."foodIngredients".weight IS 'Type numeric(5,4) because we need only 4 digits scale, not longer.';


--
-- Name: CONSTRAINT "foodIngredients_positive_weight" ON "foodIngredients"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON CONSTRAINT "foodIngredients_positive_weight" ON service."foodIngredients" IS 'Food ingredient weight can not be negative or 0.';


--
-- Name: foods; Type: TABLE; Schema: service; Owner: postgres
--

CREATE TABLE service.foods (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    price numeric(5,2) NOT NULL,
    "groupId" integer NOT NULL,
    CONSTRAINT foods_positive_price CHECK ((price > (0)::numeric))
);


ALTER TABLE service.foods OWNER TO postgres;

--
-- Name: COLUMN foods.name; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.foods.name IS 'Type varchar(100) name can be shorter but can not be longer than 100 characters.';


--
-- Name: COLUMN foods.description; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.foods.description IS 'Type text because description will be able to have unlimited length.';


--
-- Name: COLUMN foods.price; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.foods.price IS 'Type numeric(5,2) because we need only 2 digits scale.';


--
-- Name: CONSTRAINT foods_positive_price ON foods; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON CONSTRAINT foods_positive_price ON service.foods IS 'Price can not be negative or 0.';


--
-- Name: foods_id_seq; Type: SEQUENCE; Schema: service; Owner: postgres
--

CREATE SEQUENCE service.foods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE service.foods_id_seq OWNER TO postgres;

--
-- Name: foods_id_seq; Type: SEQUENCE OWNED BY; Schema: service; Owner: postgres
--

ALTER SEQUENCE service.foods_id_seq OWNED BY service.foods.id;


--
-- Name: ingredients; Type: TABLE; Schema: service; Owner: postgres
--

CREATE TABLE service.ingredients (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE service.ingredients OWNER TO postgres;

--
-- Name: COLUMN ingredients.name; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.ingredients.name IS 'Type varchar(100) name can be shorter but can not be longer than 100 characters.';


--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: service; Owner: postgres
--

CREATE SEQUENCE service.ingredients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE service.ingredients_id_seq OWNER TO postgres;

--
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: service; Owner: postgres
--

ALTER SEQUENCE service.ingredients_id_seq OWNED BY service.ingredients.id;


--
-- Name: orderFoods; Type: TABLE; Schema: service; Owner: postgres
--

CREATE TABLE service."orderFoods" (
    "orderId" integer NOT NULL,
    "foodId" integer NOT NULL,
    count smallint NOT NULL,
    price numeric(5,2) NOT NULL,
    CONSTRAINT "orderFoods_positive_count" CHECK ((count > 0)),
    CONSTRAINT "orderFoods_positive_price" CHECK ((price > (0)::numeric))
);


ALTER TABLE service."orderFoods" OWNER TO postgres;

--
-- Name: COLUMN "orderFoods".count; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service."orderFoods".count IS 'Type smallint because it wont be super long.';


--
-- Name: COLUMN "orderFoods".price; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service."orderFoods".price IS 'Type numeric(5,2) because we need only 2 digits scale.';


--
-- Name: CONSTRAINT "orderFoods_positive_count" ON "orderFoods"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON CONSTRAINT "orderFoods_positive_count" ON service."orderFoods" IS 'Count can not be smallest than 0.';


--
-- Name: CONSTRAINT "orderFoods_positive_price" ON "orderFoods"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON CONSTRAINT "orderFoods_positive_price" ON service."orderFoods" IS 'Price can not be smallest than 0.1.';


--
-- Name: orders; Type: TABLE; Schema: service; Owner: postgres
--

CREATE TABLE service.orders (
    id integer NOT NULL,
    "clientId" integer,
    "employeeId" integer NOT NULL,
    "tableId" integer NOT NULL,
    "discountId" integer,
    "startDate" timestamp with time zone NOT NULL,
    "endDate" timestamp with time zone,
    "totalPrice" numeric(5,2),
    "priceWithDiscount" numeric(5,2),
    tips numeric(5,2) DEFAULT 0,
    "paymentType" public."enum_orders_paymentType" NOT NULL,
    status public.enum_orders_status DEFAULT 'opened'::public.enum_orders_status NOT NULL,
    CONSTRAINT service_orders_positive_tips CHECK ((tips >= (0)::numeric)),
    CONSTRAINT "service_orders_positive_totalPrice" CHECK (("totalPrice" > (0)::numeric))
);


ALTER TABLE service.orders OWNER TO postgres;

--
-- Name: COLUMN orders."clientId"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.orders."clientId" IS 'Null because the client can be incognito. It means that we have no him in our DB.';


--
-- Name: COLUMN orders."startDate"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.orders."startDate" IS 'Type timestamptz because we can have worldwide restaurant. Null because we dont need this data during insert.';


--
-- Name: COLUMN orders."endDate"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.orders."endDate" IS 'Type timestamptz because we can have worldwide restaurant. Not null because it is required.';


--
-- Name: COLUMN orders."totalPrice"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.orders."totalPrice" IS 'Type numeric(5,2) because we need only 2 digits scale.';


--
-- Name: COLUMN orders."priceWithDiscount"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.orders."priceWithDiscount" IS 'Type numeric(5,2) because we need only 2 digits scale. Null because client will be able for pay without discount.';


--
-- Name: COLUMN orders.tips; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.orders.tips IS 'Type numeric(5,2) because we need only 2 digits scale. Null because can to let nothing.';


--
-- Name: COLUMN orders."paymentType"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.orders."paymentType" IS 'Type enum_orders_paymentType because we have only 2 options.';


--
-- Name: CONSTRAINT service_orders_positive_tips ON orders; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON CONSTRAINT service_orders_positive_tips ON service.orders IS 'Tips can not be smallest than 0.';


--
-- Name: CONSTRAINT "service_orders_positive_totalPrice" ON orders; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON CONSTRAINT "service_orders_positive_totalPrice" ON service.orders IS 'Total price can not be smallest than 0.1.';


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: service; Owner: postgres
--

CREATE SEQUENCE service.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE service.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: service; Owner: postgres
--

ALTER SEQUENCE service.orders_id_seq OWNED BY service.orders.id;


--
-- Name: tables; Type: TABLE; Schema: service; Owner: postgres
--

CREATE TABLE service.tables (
    id integer NOT NULL,
    "seatCount" smallint,
    status public.enum_tables_status DEFAULT 'free'::public.enum_tables_status NOT NULL,
    CONSTRAINT "tables_positive_seatCount" CHECK (("seatCount" > 0))
);


ALTER TABLE service.tables OWNER TO postgres;

--
-- Name: COLUMN tables."seatCount"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.tables."seatCount" IS 'Type smallint it is smallest integer type. Not null because it is required.';


--
-- Name: COLUMN tables.status; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON COLUMN service.tables.status IS 'Type enum_tables_status for check table status.';


--
-- Name: CONSTRAINT "tables_positive_seatCount" ON tables; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON CONSTRAINT "tables_positive_seatCount" ON service.tables IS 'Seat count can not be smallest than 2 places.';


--
-- Name: tables_id_seq; Type: SEQUENCE; Schema: service; Owner: postgres
--

CREATE SEQUENCE service.tables_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE service.tables_id_seq OWNER TO postgres;

--
-- Name: tables_id_seq; Type: SEQUENCE OWNED BY; Schema: service; Owner: postgres
--

ALTER SEQUENCE service.tables_id_seq OWNED BY service.tables.id;


--
-- Name: catererProducts; Type: TABLE; Schema: stock; Owner: postgres
--

CREATE TABLE stock."catererProducts" (
    "catererId" integer NOT NULL,
    "productId" integer NOT NULL
);


ALTER TABLE stock."catererProducts" OWNER TO postgres;

--
-- Name: caterers; Type: TABLE; Schema: stock; Owner: postgres
--

CREATE TABLE stock.caterers (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(200) NOT NULL,
    address character varying(300) NOT NULL,
    "phoneNumber" character varying(20) NOT NULL,
    email character varying(50),
    site text,
    "accountId" integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "deletedAt" timestamp with time zone,
    status public.enum_caterers_status DEFAULT 'active'::public.enum_caterers_status NOT NULL,
    CONSTRAINT caterers_code_length CHECK ((char_length((code)::text) >= 5))
);


ALTER TABLE stock.caterers OWNER TO postgres;

--
-- Name: COLUMN caterers.code; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.caterers.code IS 'Type varchar(200) code can be shorter but can not be longer than 50 characters. Uniq identifier between the same kind of products.';


--
-- Name: COLUMN caterers.name; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.caterers.name IS 'Type varchar(200) name can be shorter but can not be longer than 200 characters. Uniq for each caterers.';


--
-- Name: COLUMN caterers.address; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.caterers.address IS 'Type varchar(300) address can be shorter but can not be longer than 300 characters.';


--
-- Name: COLUMN caterers."phoneNumber"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.caterers."phoneNumber" IS 'Type varchar(20) because phoneNumber can not be longer. Required.';


--
-- Name: COLUMN caterers.email; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.caterers.email IS 'Type varchar(50) because it is variable type and doesnt matter if email will be shorter. Not required.';


--
-- Name: COLUMN caterers.site; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.caterers.site IS 'Type text because it is link on web-site and it will be long string.Not required.';


--
-- Name: COLUMN caterers."createdAt"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.caterers."createdAt" IS 'Type timestamptz because we can have worldwide restaurant. Required.';


--
-- Name: COLUMN caterers."updatedAt"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.caterers."updatedAt" IS 'Type timestamptz because we can have worldwide restaurant. Required.';


--
-- Name: COLUMN caterers."deletedAt"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.caterers."deletedAt" IS 'Type timestamptz because we can have worldwide restaurant. Not required.';


--
-- Name: CONSTRAINT caterers_code_length ON caterers; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON CONSTRAINT caterers_code_length ON stock.caterers IS 'Code can not be shorter than 5 characters. Uniq for each caterers.';


--
-- Name: caterers_id_seq; Type: SEQUENCE; Schema: stock; Owner: postgres
--

CREATE SEQUENCE stock.caterers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stock.caterers_id_seq OWNER TO postgres;

--
-- Name: caterers_id_seq; Type: SEQUENCE OWNED BY; Schema: stock; Owner: postgres
--

ALTER SEQUENCE stock.caterers_id_seq OWNED BY stock.caterers.id;


--
-- Name: orders; Type: TABLE; Schema: stock; Owner: postgres
--

CREATE TABLE stock.orders (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    "catererId" integer NOT NULL,
    "employeeId" integer NOT NULL,
    "invoiceNumber" character varying(100) NOT NULL,
    count numeric(5,2) NOT NULL,
    "orderDate" timestamp with time zone NOT NULL,
    "supplyDate" timestamp with time zone,
    "statusId" smallint NOT NULL,
    amount numeric(5,2) NOT NULL,
    CONSTRAINT stock_orders_amount CHECK ((amount > (0)::numeric)),
    CONSTRAINT stock_orders_count CHECK ((count > (0)::numeric))
);


ALTER TABLE stock.orders OWNER TO postgres;

--
-- Name: COLUMN orders."invoiceNumber"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.orders."invoiceNumber" IS 'Type varchar(100) invoiceNumber can be shorter but can not be longer than 50 characters. Uniq for each caterers.';


--
-- Name: COLUMN orders.count; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.orders.count IS 'Type numeric(5,2) because we need only 2 digits scale. Required';


--
-- Name: COLUMN orders."orderDate"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.orders."orderDate" IS 'Type timestamptz because we can have worldwide restaurant. Required.';


--
-- Name: COLUMN orders."supplyDate"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.orders."supplyDate" IS 'Type timestamptz because we can have worldwide restaurant. Set only after supply.';


--
-- Name: COLUMN orders.amount; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.orders.amount IS 'Type numeric(5,2) because we need only 2 digits scale. Required';


--
-- Name: CONSTRAINT stock_orders_amount ON orders; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON CONSTRAINT stock_orders_amount ON stock.orders IS 'Amount can not be smallest than 0.1.';


--
-- Name: CONSTRAINT stock_orders_count ON orders; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON CONSTRAINT stock_orders_count ON stock.orders IS 'Count can not be smallest than 0.1.';


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: stock; Owner: postgres
--

CREATE SEQUENCE stock.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stock.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: stock; Owner: postgres
--

ALTER SEQUENCE stock.orders_id_seq OWNED BY stock.orders.id;


--
-- Name: productApplying; Type: TABLE; Schema: stock; Owner: postgres
--

CREATE TABLE stock."productApplying" (
    "productId" integer NOT NULL,
    count numeric(5,2) NOT NULL,
    date timestamp with time zone NOT NULL,
    CONSTRAINT "productApplying_positive_count" CHECK ((count > (0)::numeric))
);


ALTER TABLE stock."productApplying" OWNER TO postgres;

--
-- Name: COLUMN "productApplying".count; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock."productApplying".count IS 'Type numeric(5,2) because we need only 2 digits scale. Required';


--
-- Name: COLUMN "productApplying".date; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock."productApplying".date IS 'Type timestamptz because we can have worldwide restaurant. Required.';


--
-- Name: CONSTRAINT "productApplying_positive_count" ON "productApplying"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON CONSTRAINT "productApplying_positive_count" ON stock."productApplying" IS 'Count can not be smallest than 0.';


--
-- Name: productGroups; Type: TABLE; Schema: stock; Owner: postgres
--

CREATE TABLE stock."productGroups" (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    description text
);


ALTER TABLE stock."productGroups" OWNER TO postgres;

--
-- Name: COLUMN "productGroups".name; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock."productGroups".name IS 'Type varchar(200) name can be shorter but can not be longer than 200 characters.';


--
-- Name: COLUMN "productGroups".description; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock."productGroups".description IS 'Type text because description will be able to have unlimited length.';


--
-- Name: productGroups_id_seq; Type: SEQUENCE; Schema: stock; Owner: postgres
--

CREATE SEQUENCE stock."productGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stock."productGroups_id_seq" OWNER TO postgres;

--
-- Name: productGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: stock; Owner: postgres
--

ALTER SEQUENCE stock."productGroups_id_seq" OWNED BY stock."productGroups".id;


--
-- Name: productOrderStatus; Type: TABLE; Schema: stock; Owner: postgres
--

CREATE TABLE stock."productOrderStatus" (
    id integer NOT NULL,
    name character varying(20)
);


ALTER TABLE stock."productOrderStatus" OWNER TO postgres;

--
-- Name: productOrderStatus_id_seq; Type: SEQUENCE; Schema: stock; Owner: postgres
--

CREATE SEQUENCE stock."productOrderStatus_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stock."productOrderStatus_id_seq" OWNER TO postgres;

--
-- Name: productOrderStatus_id_seq; Type: SEQUENCE OWNED BY; Schema: stock; Owner: postgres
--

ALTER SEQUENCE stock."productOrderStatus_id_seq" OWNED BY stock."productOrderStatus".id;


--
-- Name: products; Type: TABLE; Schema: stock; Owner: postgres
--

CREATE TABLE stock.products (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    rest numeric(5,2) NOT NULL,
    code character varying(50) NOT NULL,
    "groupId" integer NOT NULL,
    price numeric(5,2) NOT NULL,
    CONSTRAINT product_price CHECK ((price > (0)::numeric)),
    CONSTRAINT products_code_length CHECK ((char_length((code)::text) >= 5)),
    CONSTRAINT products_positive_rest CHECK ((rest >= (0)::numeric))
);


ALTER TABLE stock.products OWNER TO postgres;

--
-- Name: COLUMN products.name; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.products.name IS 'Type varchar(200) name can be shorter but can not be longer than 200 characters.';


--
-- Name: COLUMN products.rest; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.products.rest IS 'Type numeric(5,2) because we need only 2 digits scale. Required';


--
-- Name: COLUMN products.code; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON COLUMN stock.products.code IS 'Type varchar(200) code can be shorter but can not be longer than 50 characters. Uniq identifier between the same kind of products.';


--
-- Name: CONSTRAINT products_code_length ON products; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON CONSTRAINT products_code_length ON stock.products IS 'Code can not be shorter than 5 characters. Uniq for each products.';


--
-- Name: CONSTRAINT products_positive_rest ON products; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON CONSTRAINT products_positive_rest ON stock.products IS 'Rest can not be smallest than 0.';


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: stock; Owner: postgres
--

CREATE SEQUENCE stock.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stock.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: stock; Owner: postgres
--

ALTER SEQUENCE stock.products_id_seq OWNED BY stock.products.id;


--
-- Name: accounts id; Type: DEFAULT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.accounts ALTER COLUMN id SET DEFAULT nextval('bookkeeping.accounts_id_seq'::regclass);


--
-- Name: banks id; Type: DEFAULT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.banks ALTER COLUMN id SET DEFAULT nextval('bookkeeping.banks_id_seq'::regclass);


--
-- Name: incomes id; Type: DEFAULT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.incomes ALTER COLUMN id SET DEFAULT nextval('bookkeeping.incomes_id_seq'::regclass);


--
-- Name: outcomes id; Type: DEFAULT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.outcomes ALTER COLUMN id SET DEFAULT nextval('bookkeeping.outcomes_id_seq'::regclass);


--
-- Name: transactionStatuses id; Type: DEFAULT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping."transactionStatuses" ALTER COLUMN id SET DEFAULT nextval('bookkeeping."transactionStatuses_id_seq"'::regclass);


--
-- Name: transactionTypes id; Type: DEFAULT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping."transactionTypes" ALTER COLUMN id SET DEFAULT nextval('bookkeeping."transactionTypes_id_seq"'::regclass);


--
-- Name: employeeRoles id; Type: DEFAULT; Schema: personal; Owner: postgres
--

ALTER TABLE ONLY personal."employeeRoles" ALTER COLUMN id SET DEFAULT nextval('personal."employeeRoles_id_seq"'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: personal; Owner: postgres
--

ALTER TABLE ONLY personal.employees ALTER COLUMN id SET DEFAULT nextval('personal.employees_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.clients ALTER COLUMN id SET DEFAULT nextval('service.clients_id_seq'::regclass);


--
-- Name: discountGroups id; Type: DEFAULT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."discountGroups" ALTER COLUMN id SET DEFAULT nextval('service."discountGroups_id_seq"'::regclass);


--
-- Name: discounts id; Type: DEFAULT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.discounts ALTER COLUMN id SET DEFAULT nextval('service.discounts_id_seq'::regclass);


--
-- Name: foodGroups id; Type: DEFAULT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."foodGroups" ALTER COLUMN id SET DEFAULT nextval('service."foodGroups_id_seq"'::regclass);


--
-- Name: foods id; Type: DEFAULT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.foods ALTER COLUMN id SET DEFAULT nextval('service.foods_id_seq'::regclass);


--
-- Name: ingredients id; Type: DEFAULT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.ingredients ALTER COLUMN id SET DEFAULT nextval('service.ingredients_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.orders ALTER COLUMN id SET DEFAULT nextval('service.orders_id_seq'::regclass);


--
-- Name: tables id; Type: DEFAULT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.tables ALTER COLUMN id SET DEFAULT nextval('service.tables_id_seq'::regclass);


--
-- Name: caterers id; Type: DEFAULT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.caterers ALTER COLUMN id SET DEFAULT nextval('stock.caterers_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.orders ALTER COLUMN id SET DEFAULT nextval('stock.orders_id_seq'::regclass);


--
-- Name: productGroups id; Type: DEFAULT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock."productGroups" ALTER COLUMN id SET DEFAULT nextval('stock."productGroups_id_seq"'::regclass);


--
-- Name: productOrderStatus id; Type: DEFAULT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock."productOrderStatus" ALTER COLUMN id SET DEFAULT nextval('stock."productOrderStatus_id_seq"'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.products ALTER COLUMN id SET DEFAULT nextval('stock.products_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: bookkeeping; Owner: postgres
--

COPY bookkeeping.accounts (id, number, "bankId", "isActive", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: banks; Type: TABLE DATA; Schema: bookkeeping; Owner: postgres
--

COPY bookkeeping.banks (id, name, "transitAccount", bic, bin) FROM stdin;
\.


--
-- Data for Name: incomes; Type: TABLE DATA; Schema: bookkeeping; Owner: postgres
--

COPY bookkeeping.incomes (id, "transactionId", description, "timestamp", amount, "incomeType") FROM stdin;
\.


--
-- Data for Name: outcomes; Type: TABLE DATA; Schema: bookkeeping; Owner: postgres
--

COPY bookkeeping.outcomes (id, "transactionId", "accountId", "employeeId", description, "timestamp", amount, "outcomeType", status) FROM stdin;
\.


--
-- Data for Name: transactionStatuses; Type: TABLE DATA; Schema: bookkeeping; Owner: postgres
--

COPY bookkeeping."transactionStatuses" (id, name, description) FROM stdin;
\.


--
-- Data for Name: transactionTypes; Type: TABLE DATA; Schema: bookkeeping; Owner: postgres
--

COPY bookkeeping."transactionTypes" (id, name, description) FROM stdin;
\.


--
-- Data for Name: employeeRoles; Type: TABLE DATA; Schema: personal; Owner: postgres
--

COPY personal."employeeRoles" (id, name, description) FROM stdin;
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: personal; Owner: postgres
--

COPY personal.employees (id, "firstName", "lastName", ein, "accountId", "passportCode", "passportSeries", sex, salary, address, "phoneNumber", email, "roleId", "offerDate", "fireDate") FROM stdin;
\.


--
-- Data for Name: clientDiscounts; Type: TABLE DATA; Schema: service; Owner: postgres
--

COPY service."clientDiscounts" ("clientId", "discountId") FROM stdin;
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: service; Owner: postgres
--

COPY service.clients (id, "firstName", "lastName", email, "phoneNumber") FROM stdin;
\.


--
-- Data for Name: discountGroups; Type: TABLE DATA; Schema: service; Owner: postgres
--

COPY service."discountGroups" (id, name) FROM stdin;
\.


--
-- Data for Name: discounts; Type: TABLE DATA; Schema: service; Owner: postgres
--

COPY service.discounts (id, code, count, "accumulativeBonuses", description, "groupId", "startDate", "endDate") FROM stdin;
\.


--
-- Data for Name: foodGroups; Type: TABLE DATA; Schema: service; Owner: postgres
--

COPY service."foodGroups" (id, name) FROM stdin;
\.


--
-- Data for Name: foodIngredients; Type: TABLE DATA; Schema: service; Owner: postgres
--

COPY service."foodIngredients" ("foodId", "ingredientId", weight) FROM stdin;
\.


--
-- Data for Name: foods; Type: TABLE DATA; Schema: service; Owner: postgres
--

COPY service.foods (id, name, description, price, "groupId") FROM stdin;
\.


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: service; Owner: postgres
--

COPY service.ingredients (id, name) FROM stdin;
\.


--
-- Data for Name: orderFoods; Type: TABLE DATA; Schema: service; Owner: postgres
--

COPY service."orderFoods" ("orderId", "foodId", count, price) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: service; Owner: postgres
--

COPY service.orders (id, "clientId", "employeeId", "tableId", "discountId", "startDate", "endDate", "totalPrice", "priceWithDiscount", tips, "paymentType", status) FROM stdin;
\.


--
-- Data for Name: tables; Type: TABLE DATA; Schema: service; Owner: postgres
--

COPY service.tables (id, "seatCount", status) FROM stdin;
\.


--
-- Data for Name: catererProducts; Type: TABLE DATA; Schema: stock; Owner: postgres
--

COPY stock."catererProducts" ("catererId", "productId") FROM stdin;
\.


--
-- Data for Name: caterers; Type: TABLE DATA; Schema: stock; Owner: postgres
--

COPY stock.caterers (id, code, name, address, "phoneNumber", email, site, "accountId", "createdAt", "updatedAt", "deletedAt", status) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: stock; Owner: postgres
--

COPY stock.orders (id, "productId", "catererId", "employeeId", "invoiceNumber", count, "orderDate", "supplyDate", "statusId", amount) FROM stdin;
\.


--
-- Data for Name: productApplying; Type: TABLE DATA; Schema: stock; Owner: postgres
--

COPY stock."productApplying" ("productId", count, date) FROM stdin;
\.


--
-- Data for Name: productGroups; Type: TABLE DATA; Schema: stock; Owner: postgres
--

COPY stock."productGroups" (id, name, description) FROM stdin;
\.


--
-- Data for Name: productOrderStatus; Type: TABLE DATA; Schema: stock; Owner: postgres
--

COPY stock."productOrderStatus" (id, name) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: stock; Owner: postgres
--

COPY stock.products (id, name, rest, code, "groupId", price) FROM stdin;
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('bookkeeping.accounts_id_seq', 1, false);


--
-- Name: banks_id_seq; Type: SEQUENCE SET; Schema: bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('bookkeeping.banks_id_seq', 1, false);


--
-- Name: incomes_id_seq; Type: SEQUENCE SET; Schema: bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('bookkeeping.incomes_id_seq', 1, false);


--
-- Name: outcomes_id_seq; Type: SEQUENCE SET; Schema: bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('bookkeeping.outcomes_id_seq', 1, false);


--
-- Name: transactionStatuses_id_seq; Type: SEQUENCE SET; Schema: bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('bookkeeping."transactionStatuses_id_seq"', 1, false);


--
-- Name: transactionTypes_id_seq; Type: SEQUENCE SET; Schema: bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('bookkeeping."transactionTypes_id_seq"', 1, false);


--
-- Name: employeeRoles_id_seq; Type: SEQUENCE SET; Schema: personal; Owner: postgres
--

SELECT pg_catalog.setval('personal."employeeRoles_id_seq"', 1, false);


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: personal; Owner: postgres
--

SELECT pg_catalog.setval('personal.employees_id_seq', 1, false);


--
-- Name: clients_sequense; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_sequense', 1, false);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: service; Owner: postgres
--

SELECT pg_catalog.setval('service.clients_id_seq', 1, false);


--
-- Name: discountGroups_id_seq; Type: SEQUENCE SET; Schema: service; Owner: postgres
--

SELECT pg_catalog.setval('service."discountGroups_id_seq"', 1, false);


--
-- Name: discounts_id_seq; Type: SEQUENCE SET; Schema: service; Owner: postgres
--

SELECT pg_catalog.setval('service.discounts_id_seq', 1, false);


--
-- Name: foodGroups_id_seq; Type: SEQUENCE SET; Schema: service; Owner: postgres
--

SELECT pg_catalog.setval('service."foodGroups_id_seq"', 1, false);


--
-- Name: foods_id_seq; Type: SEQUENCE SET; Schema: service; Owner: postgres
--

SELECT pg_catalog.setval('service.foods_id_seq', 1, false);


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: service; Owner: postgres
--

SELECT pg_catalog.setval('service.ingredients_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: service; Owner: postgres
--

SELECT pg_catalog.setval('service.orders_id_seq', 1, false);


--
-- Name: tables_id_seq; Type: SEQUENCE SET; Schema: service; Owner: postgres
--

SELECT pg_catalog.setval('service.tables_id_seq', 1, false);


--
-- Name: caterers_id_seq; Type: SEQUENCE SET; Schema: stock; Owner: postgres
--

SELECT pg_catalog.setval('stock.caterers_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: stock; Owner: postgres
--

SELECT pg_catalog.setval('stock.orders_id_seq', 1, false);


--
-- Name: productGroups_id_seq; Type: SEQUENCE SET; Schema: stock; Owner: postgres
--

SELECT pg_catalog.setval('stock."productGroups_id_seq"', 1, false);


--
-- Name: productOrderStatus_id_seq; Type: SEQUENCE SET; Schema: stock; Owner: postgres
--

SELECT pg_catalog.setval('stock."productOrderStatus_id_seq"', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: stock; Owner: postgres
--

SELECT pg_catalog.setval('stock.products_id_seq', 1, false);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: banks banks_bic_key; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.banks
    ADD CONSTRAINT banks_bic_key UNIQUE (bic);


--
-- Name: banks banks_bin_key; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.banks
    ADD CONSTRAINT banks_bin_key UNIQUE (bin);


--
-- Name: banks banks_name_key; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.banks
    ADD CONSTRAINT banks_name_key UNIQUE (name);


--
-- Name: banks banks_pkey; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.banks
    ADD CONSTRAINT banks_pkey PRIMARY KEY (id);


--
-- Name: banks banks_transitAccount_key; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.banks
    ADD CONSTRAINT "banks_transitAccount_key" UNIQUE ("transitAccount");


--
-- Name: incomes incomes_pkey; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.incomes
    ADD CONSTRAINT incomes_pkey PRIMARY KEY (id);


--
-- Name: incomes incomes_transactionId_key; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.incomes
    ADD CONSTRAINT "incomes_transactionId_key" UNIQUE ("transactionId");


--
-- Name: outcomes outcomes_pkey; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.outcomes
    ADD CONSTRAINT outcomes_pkey PRIMARY KEY (id);


--
-- Name: outcomes outcomes_transactionId_key; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.outcomes
    ADD CONSTRAINT "outcomes_transactionId_key" UNIQUE ("transactionId");


--
-- Name: transactionStatuses transactionStatuses_pkey; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping."transactionStatuses"
    ADD CONSTRAINT "transactionStatuses_pkey" PRIMARY KEY (id);


--
-- Name: transactionTypes transactionTypes_pkey; Type: CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping."transactionTypes"
    ADD CONSTRAINT "transactionTypes_pkey" PRIMARY KEY (id);


--
-- Name: employeeRoles employeeRoles_pkey; Type: CONSTRAINT; Schema: personal; Owner: postgres
--

ALTER TABLE ONLY personal."employeeRoles"
    ADD CONSTRAINT "employeeRoles_pkey" PRIMARY KEY (id);


--
-- Name: employees employees_ein_key; Type: CONSTRAINT; Schema: personal; Owner: postgres
--

ALTER TABLE ONLY personal.employees
    ADD CONSTRAINT employees_ein_key UNIQUE (ein);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: personal; Owner: postgres
--

ALTER TABLE ONLY personal.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: clientDiscounts clientDiscounts_pkey; Type: CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."clientDiscounts"
    ADD CONSTRAINT "clientDiscounts_pkey" PRIMARY KEY ("clientId", "discountId");


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: discountGroups discountGroups_pkey; Type: CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."discountGroups"
    ADD CONSTRAINT "discountGroups_pkey" PRIMARY KEY (id);


--
-- Name: discounts discounts_pkey; Type: CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.discounts
    ADD CONSTRAINT discounts_pkey PRIMARY KEY (id);


--
-- Name: foodGroups foodGroups_pkey; Type: CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."foodGroups"
    ADD CONSTRAINT "foodGroups_pkey" PRIMARY KEY (id);


--
-- Name: foodIngredients foodIngredients_pkey; Type: CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."foodIngredients"
    ADD CONSTRAINT "foodIngredients_pkey" PRIMARY KEY ("foodId", "ingredientId");


--
-- Name: foods foods_pkey; Type: CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.foods
    ADD CONSTRAINT foods_pkey PRIMARY KEY (id);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- Name: orderFoods orderFoods_pkey; Type: CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."orderFoods"
    ADD CONSTRAINT "orderFoods_pkey" PRIMARY KEY ("orderId", "foodId");


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: tables tables_pkey; Type: CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.tables
    ADD CONSTRAINT tables_pkey PRIMARY KEY (id);


--
-- Name: catererProducts catererProducts_pkey; Type: CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock."catererProducts"
    ADD CONSTRAINT "catererProducts_pkey" PRIMARY KEY ("catererId", "productId");


--
-- Name: caterers caterers_accountId_key; Type: CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.caterers
    ADD CONSTRAINT "caterers_accountId_key" UNIQUE ("accountId");


--
-- Name: caterers caterers_code_key; Type: CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.caterers
    ADD CONSTRAINT caterers_code_key UNIQUE (code);


--
-- Name: caterers caterers_name_key; Type: CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.caterers
    ADD CONSTRAINT caterers_name_key UNIQUE (name);


--
-- Name: caterers caterers_phoneNumber_key; Type: CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.caterers
    ADD CONSTRAINT "caterers_phoneNumber_key" UNIQUE ("phoneNumber");


--
-- Name: caterers caterers_pkey; Type: CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.caterers
    ADD CONSTRAINT caterers_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: productGroups productGroups_pkey; Type: CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock."productGroups"
    ADD CONSTRAINT "productGroups_pkey" PRIMARY KEY (id);


--
-- Name: productOrderStatus productOrderStatus_pkey; Type: CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock."productOrderStatus"
    ADD CONSTRAINT "productOrderStatus_pkey" PRIMARY KEY (id);


--
-- Name: products products_code_key; Type: CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.products
    ADD CONSTRAINT products_code_key UNIQUE (code);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: accounts_number; Type: INDEX; Schema: bookkeeping; Owner: postgres
--

CREATE INDEX accounts_number ON bookkeeping.accounts USING btree (number);


--
-- Name: INDEX accounts_number; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON INDEX bookkeeping.accounts_number IS 'This index created for optimized accounts search by number.';


--
-- Name: accounts_uniq_number_per_bank; Type: INDEX; Schema: bookkeeping; Owner: postgres
--

CREATE UNIQUE INDEX accounts_uniq_number_per_bank ON bookkeeping.accounts USING btree (number, "bankId");


--
-- Name: INDEX accounts_uniq_number_per_bank; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON INDEX bookkeeping.accounts_uniq_number_per_bank IS 'This index created for save unique number account for each banks.';


--
-- Name: banks_bin_bic; Type: INDEX; Schema: bookkeeping; Owner: postgres
--

CREATE INDEX banks_bin_bic ON bookkeeping.banks USING btree (bin, bic);


--
-- Name: INDEX banks_bin_bic; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON INDEX bookkeeping.banks_bin_bic IS 'This index created for optimized banks search by bin and bic numbers.';


--
-- Name: incomes_dates; Type: INDEX; Schema: bookkeeping; Owner: postgres
--

CREATE INDEX incomes_dates ON bookkeeping.incomes USING btree ("timestamp");


--
-- Name: INDEX incomes_dates; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON INDEX bookkeeping.incomes_dates IS 'This index created for optimized incomes search by dates.';


--
-- Name: incomes_transactions; Type: INDEX; Schema: bookkeeping; Owner: postgres
--

CREATE INDEX incomes_transactions ON bookkeeping.incomes USING btree ("transactionId");


--
-- Name: INDEX incomes_transactions; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON INDEX bookkeeping.incomes_transactions IS 'This index created for optimized incomes search by transactionId.';


--
-- Name: outcomes_dates; Type: INDEX; Schema: bookkeeping; Owner: postgres
--

CREATE INDEX outcomes_dates ON bookkeeping.outcomes USING btree ("timestamp");


--
-- Name: INDEX outcomes_dates; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON INDEX bookkeeping.outcomes_dates IS 'This index created for optimized outcomes search by dates.';


--
-- Name: outcomes_transactions; Type: INDEX; Schema: bookkeeping; Owner: postgres
--

CREATE INDEX outcomes_transactions ON bookkeeping.outcomes USING btree ("transactionId");


--
-- Name: INDEX outcomes_transactions; Type: COMMENT; Schema: bookkeeping; Owner: postgres
--

COMMENT ON INDEX bookkeeping.outcomes_transactions IS 'This index created for optimized outcomes search by transactionId.';


--
-- Name: employeeRoles_name; Type: INDEX; Schema: personal; Owner: postgres
--

CREATE INDEX "employeeRoles_name" ON personal."employeeRoles" USING btree (name);


--
-- Name: INDEX "employeeRoles_name"; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON INDEX personal."employeeRoles_name" IS 'This index created for optimized search employees by role name.';


--
-- Name: employees_ein; Type: INDEX; Schema: personal; Owner: postgres
--

CREATE INDEX employees_ein ON personal.employees USING btree (ein);


--
-- Name: INDEX employees_ein; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON INDEX personal.employees_ein IS 'This index created for optimized search employees by ein.';


--
-- Name: employees_firstName_lastName; Type: INDEX; Schema: personal; Owner: postgres
--

CREATE INDEX "employees_firstName_lastName" ON personal.employees USING btree ("firstName", "lastName");


--
-- Name: INDEX "employees_firstName_lastName"; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON INDEX personal."employees_firstName_lastName" IS 'This index created for optimized employees search by first and last names.';


--
-- Name: employees_passCode_passSeries; Type: INDEX; Schema: personal; Owner: postgres
--

CREATE INDEX "employees_passCode_passSeries" ON personal.employees USING btree ("passportCode", "passportSeries");


--
-- Name: INDEX "employees_passCode_passSeries"; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON INDEX personal."employees_passCode_passSeries" IS 'This index created for optimized employees search by passCode and passSeries.';


--
-- Name: employees_phoneNumber_email; Type: INDEX; Schema: personal; Owner: postgres
--

CREATE INDEX "employees_phoneNumber_email" ON personal.employees USING btree ("phoneNumber", email);


--
-- Name: INDEX "employees_phoneNumber_email"; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON INDEX personal."employees_phoneNumber_email" IS 'This index created for optimized search employees by phone number and email.';


--
-- Name: employees_uniq_accountId; Type: INDEX; Schema: personal; Owner: postgres
--

CREATE UNIQUE INDEX "employees_uniq_accountId" ON personal.employees USING btree (id, "accountId");


--
-- Name: employees_uniq_ein; Type: INDEX; Schema: personal; Owner: postgres
--

CREATE UNIQUE INDEX employees_uniq_ein ON personal.employees USING btree (id, ein);


--
-- Name: INDEX employees_uniq_ein; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON INDEX personal.employees_uniq_ein IS 'This index created for uniq ein for each employee.';


--
-- Name: employees_uniq_passport; Type: INDEX; Schema: personal; Owner: postgres
--

CREATE UNIQUE INDEX employees_uniq_passport ON personal.employees USING btree (id, "passportCode", "passportSeries");


--
-- Name: INDEX employees_uniq_passport; Type: COMMENT; Schema: personal; Owner: postgres
--

COMMENT ON INDEX personal.employees_uniq_passport IS 'This index created for uniq passCode + passSeries for each employee.';


--
-- Name: clients_firstName_lastName; Type: INDEX; Schema: service; Owner: postgres
--

CREATE INDEX "clients_firstName_lastName" ON service.clients USING btree ("firstName", "lastName");


--
-- Name: INDEX "clients_firstName_lastName"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON INDEX service."clients_firstName_lastName" IS 'This index created for optimized client search by first and last names.';


--
-- Name: clients_phoneNumber; Type: INDEX; Schema: service; Owner: postgres
--

CREATE INDEX "clients_phoneNumber" ON service.clients USING btree ("phoneNumber");


--
-- Name: INDEX "clients_phoneNumber"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON INDEX service."clients_phoneNumber" IS 'This index created for optimized client search by phone number.';


--
-- Name: discounts_code; Type: INDEX; Schema: service; Owner: postgres
--

CREATE INDEX discounts_code ON service.discounts USING btree (code);


--
-- Name: INDEX discounts_code; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON INDEX service.discounts_code IS 'This index created for optimized search discounts by code.';


--
-- Name: foods_price; Type: INDEX; Schema: service; Owner: postgres
--

CREATE INDEX foods_price ON service.foods USING btree (price);


--
-- Name: INDEX foods_price; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON INDEX service.foods_price IS 'This index created for optimized food search by prices.';


--
-- Name: orders_dates; Type: INDEX; Schema: service; Owner: postgres
--

CREATE INDEX orders_dates ON service.orders USING btree ("startDate", "endDate");


--
-- Name: INDEX orders_dates; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON INDEX service.orders_dates IS 'This index created for optimized search orders by dates.';


--
-- Name: orders_paymentType; Type: INDEX; Schema: service; Owner: postgres
--

CREATE INDEX "orders_paymentType" ON service.orders USING btree ("paymentType");


--
-- Name: INDEX "orders_paymentType"; Type: COMMENT; Schema: service; Owner: postgres
--

COMMENT ON INDEX service."orders_paymentType" IS 'This index created for optimized search orders by payment type.';


--
-- Name: caterers_code; Type: INDEX; Schema: stock; Owner: postgres
--

CREATE INDEX caterers_code ON stock.caterers USING btree (code);


--
-- Name: INDEX caterers_code; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON INDEX stock.caterers_code IS 'This index created for optimized caterers search by code.';


--
-- Name: caterers_name_code; Type: INDEX; Schema: stock; Owner: postgres
--

CREATE INDEX caterers_name_code ON stock.caterers USING btree (name, code);


--
-- Name: INDEX caterers_name_code; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON INDEX stock.caterers_name_code IS 'This index created for optimized caterers search both name and code.';


--
-- Name: caterers_phoneNumber; Type: INDEX; Schema: stock; Owner: postgres
--

CREATE INDEX "caterers_phoneNumber" ON stock.caterers USING btree ("phoneNumber");


--
-- Name: INDEX "caterers_phoneNumber"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON INDEX stock."caterers_phoneNumber" IS 'This index created for optimized caterers search by phone number.';


--
-- Name: orders_amount; Type: INDEX; Schema: stock; Owner: postgres
--

CREATE INDEX orders_amount ON stock.orders USING btree (amount);


--
-- Name: INDEX orders_amount; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON INDEX stock.orders_amount IS 'This index created for optimized product orders search by order amount.';


--
-- Name: orders_invoiceNumber; Type: INDEX; Schema: stock; Owner: postgres
--

CREATE INDEX "orders_invoiceNumber" ON stock.orders USING btree ("invoiceNumber");


--
-- Name: INDEX "orders_invoiceNumber"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON INDEX stock."orders_invoiceNumber" IS 'This index created for optimized product orders search by invoice number.';


--
-- Name: orders_invoiceNumber_catererId; Type: INDEX; Schema: stock; Owner: postgres
--

CREATE UNIQUE INDEX "orders_invoiceNumber_catererId" ON stock.orders USING btree ("invoiceNumber", "catererId");


--
-- Name: orders_orderDate; Type: INDEX; Schema: stock; Owner: postgres
--

CREATE INDEX "orders_orderDate" ON stock.orders USING btree ("orderDate");


--
-- Name: INDEX "orders_orderDate"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON INDEX stock."orders_orderDate" IS 'This index created for optimized product orders search by order date.';


--
-- Name: orders_supplyDate; Type: INDEX; Schema: stock; Owner: postgres
--

CREATE INDEX "orders_supplyDate" ON stock.orders USING btree ("supplyDate");


--
-- Name: INDEX "orders_supplyDate"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON INDEX stock."orders_supplyDate" IS 'This index created for optimized product orders search by supply date.';


--
-- Name: productApplying_date; Type: INDEX; Schema: stock; Owner: postgres
--

CREATE INDEX "productApplying_date" ON stock."productApplying" USING btree (date);


--
-- Name: INDEX "productApplying_date"; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON INDEX stock."productApplying_date" IS 'This index created for optimized applying search by date.';


--
-- Name: products_code; Type: INDEX; Schema: stock; Owner: postgres
--

CREATE INDEX products_code ON stock.products USING btree (code);


--
-- Name: INDEX products_code; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON INDEX stock.products_code IS 'This index created for optimized products search by code.';


--
-- Name: products_name; Type: INDEX; Schema: stock; Owner: postgres
--

CREATE INDEX products_name ON stock.products USING btree (name);


--
-- Name: INDEX products_name; Type: COMMENT; Schema: stock; Owner: postgres
--

COMMENT ON INDEX stock.products_name IS 'This index created for optimized products search by name.';


--
-- Name: accounts accounts_bankId_fkey; Type: FK CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.accounts
    ADD CONSTRAINT "accounts_bankId_fkey" FOREIGN KEY ("bankId") REFERENCES bookkeeping.banks(id);


--
-- Name: incomes incomes_incomeType_fkey; Type: FK CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.incomes
    ADD CONSTRAINT "incomes_incomeType_fkey" FOREIGN KEY ("incomeType") REFERENCES bookkeeping."transactionTypes"(id);


--
-- Name: outcomes outcomes_accountId_fkey; Type: FK CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.outcomes
    ADD CONSTRAINT "outcomes_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES bookkeeping.accounts(id);


--
-- Name: outcomes outcomes_employeeId_fkey; Type: FK CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.outcomes
    ADD CONSTRAINT "outcomes_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES personal.employees(id);


--
-- Name: outcomes outcomes_outcomeType_fkey; Type: FK CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.outcomes
    ADD CONSTRAINT "outcomes_outcomeType_fkey" FOREIGN KEY ("outcomeType") REFERENCES bookkeeping."transactionTypes"(id);


--
-- Name: outcomes outcomes_status_fkey; Type: FK CONSTRAINT; Schema: bookkeeping; Owner: postgres
--

ALTER TABLE ONLY bookkeeping.outcomes
    ADD CONSTRAINT outcomes_status_fkey FOREIGN KEY (status) REFERENCES bookkeeping."transactionStatuses"(id);


--
-- Name: employees employees_accountId_fkey; Type: FK CONSTRAINT; Schema: personal; Owner: postgres
--

ALTER TABLE ONLY personal.employees
    ADD CONSTRAINT "employees_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES bookkeeping.accounts(id);


--
-- Name: employees employees_roleId_fkey; Type: FK CONSTRAINT; Schema: personal; Owner: postgres
--

ALTER TABLE ONLY personal.employees
    ADD CONSTRAINT "employees_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES personal."employeeRoles"(id);


--
-- Name: clientDiscounts clientDiscounts_clientId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."clientDiscounts"
    ADD CONSTRAINT "clientDiscounts_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES service.clients(id);


--
-- Name: clientDiscounts clientDiscounts_discountId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."clientDiscounts"
    ADD CONSTRAINT "clientDiscounts_discountId_fkey" FOREIGN KEY ("discountId") REFERENCES service.discounts(id);


--
-- Name: discounts discounts_groupId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.discounts
    ADD CONSTRAINT "discounts_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES service."discountGroups"(id);


--
-- Name: foodIngredients foodIngredients_foodId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."foodIngredients"
    ADD CONSTRAINT "foodIngredients_foodId_fkey" FOREIGN KEY ("foodId") REFERENCES service.foods(id);


--
-- Name: foodIngredients foodIngredients_ingredientId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."foodIngredients"
    ADD CONSTRAINT "foodIngredients_ingredientId_fkey" FOREIGN KEY ("ingredientId") REFERENCES service.ingredients(id);


--
-- Name: foods foods_groupId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.foods
    ADD CONSTRAINT "foods_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES service."foodGroups"(id);


--
-- Name: orderFoods orderFoods_foodId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."orderFoods"
    ADD CONSTRAINT "orderFoods_foodId_fkey" FOREIGN KEY ("foodId") REFERENCES service.foods(id);


--
-- Name: orderFoods orderFoods_orderId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service."orderFoods"
    ADD CONSTRAINT "orderFoods_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES service.orders(id);


--
-- Name: orders orders_clientId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.orders
    ADD CONSTRAINT "orders_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES service.clients(id);


--
-- Name: orders orders_discountId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.orders
    ADD CONSTRAINT "orders_discountId_fkey" FOREIGN KEY ("discountId") REFERENCES service.discounts(id);


--
-- Name: orders orders_employeeId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.orders
    ADD CONSTRAINT "orders_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES personal.employees(id);


--
-- Name: orders orders_tableId_fkey; Type: FK CONSTRAINT; Schema: service; Owner: postgres
--

ALTER TABLE ONLY service.orders
    ADD CONSTRAINT "orders_tableId_fkey" FOREIGN KEY ("tableId") REFERENCES service.tables(id);


--
-- Name: catererProducts catererProducts_catererId_fkey; Type: FK CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock."catererProducts"
    ADD CONSTRAINT "catererProducts_catererId_fkey" FOREIGN KEY ("catererId") REFERENCES stock.caterers(id);


--
-- Name: catererProducts catererProducts_productId_fkey; Type: FK CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock."catererProducts"
    ADD CONSTRAINT "catererProducts_productId_fkey" FOREIGN KEY ("productId") REFERENCES stock.products(id);


--
-- Name: caterers caterers_accountId_fkey; Type: FK CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.caterers
    ADD CONSTRAINT "caterers_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES bookkeeping.accounts(id);


--
-- Name: orders orders_catererId_fkey; Type: FK CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.orders
    ADD CONSTRAINT "orders_catererId_fkey" FOREIGN KEY ("catererId") REFERENCES stock.caterers(id);


--
-- Name: orders orders_employeeId_fkey; Type: FK CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.orders
    ADD CONSTRAINT "orders_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES personal.employees(id);


--
-- Name: orders orders_productId_fkey; Type: FK CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.orders
    ADD CONSTRAINT "orders_productId_fkey" FOREIGN KEY ("productId") REFERENCES stock.products(id);


--
-- Name: orders orders_statusId_fkey; Type: FK CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.orders
    ADD CONSTRAINT "orders_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES stock."productOrderStatus"(id);


--
-- Name: productApplying productApplying_productId_fkey; Type: FK CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock."productApplying"
    ADD CONSTRAINT "productApplying_productId_fkey" FOREIGN KEY ("productId") REFERENCES stock.products(id);


--
-- Name: products products_groupId_fkey; Type: FK CONSTRAINT; Schema: stock; Owner: postgres
--

ALTER TABLE ONLY stock.products
    ADD CONSTRAINT "products_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES stock."productGroups"(id);


--
-- Name: SCHEMA bookkeeping; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA bookkeeping TO accountant;


--
-- Name: SCHEMA personal; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA personal TO manager;


--
-- Name: SCHEMA service; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA service TO manager;


--
-- Name: TABLE accounts; Type: ACL; Schema: bookkeeping; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE bookkeeping.accounts TO accountant;


--
-- Name: TABLE banks; Type: ACL; Schema: bookkeeping; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE bookkeeping.banks TO accountant;


--
-- Name: TABLE incomes; Type: ACL; Schema: bookkeeping; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE bookkeeping.incomes TO accountant;


--
-- Name: TABLE outcomes; Type: ACL; Schema: bookkeeping; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE bookkeeping.outcomes TO accountant;


--
-- Name: TABLE "transactionStatuses"; Type: ACL; Schema: bookkeeping; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE bookkeeping."transactionStatuses" TO accountant;


--
-- Name: TABLE "transactionTypes"; Type: ACL; Schema: bookkeeping; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE bookkeeping."transactionTypes" TO accountant;


--
-- Name: TABLE "employeeRoles"; Type: ACL; Schema: personal; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE personal."employeeRoles" TO manager;


--
-- Name: TABLE employees; Type: ACL; Schema: personal; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE personal.employees TO manager;


--
-- Name: TABLE "clientDiscounts"; Type: ACL; Schema: service; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE service."clientDiscounts" TO manager;


--
-- Name: TABLE clients; Type: ACL; Schema: service; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE service.clients TO manager;


--
-- Name: TABLE "discountGroups"; Type: ACL; Schema: service; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE service."discountGroups" TO manager;


--
-- Name: TABLE discounts; Type: ACL; Schema: service; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE service.discounts TO manager;


--
-- Name: TABLE "foodGroups"; Type: ACL; Schema: service; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE service."foodGroups" TO manager;


--
-- Name: TABLE "foodIngredients"; Type: ACL; Schema: service; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE service."foodIngredients" TO manager;


--
-- Name: TABLE foods; Type: ACL; Schema: service; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE service.foods TO manager;


--
-- Name: TABLE ingredients; Type: ACL; Schema: service; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE service.ingredients TO manager;


--
-- Name: TABLE "orderFoods"; Type: ACL; Schema: service; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE service."orderFoods" TO manager;


--
-- Name: TABLE orders; Type: ACL; Schema: service; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE service.orders TO manager;


--
-- Name: TABLE tables; Type: ACL; Schema: service; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE service.tables TO manager;


--
-- Name: TABLE "catererProducts"; Type: ACL; Schema: stock; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE stock."catererProducts" TO manager;


--
-- Name: TABLE caterers; Type: ACL; Schema: stock; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE stock.caterers TO manager;


--
-- Name: TABLE orders; Type: ACL; Schema: stock; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE stock.orders TO manager;


--
-- Name: TABLE "productApplying"; Type: ACL; Schema: stock; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE stock."productApplying" TO manager;


--
-- Name: TABLE "productGroups"; Type: ACL; Schema: stock; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE stock."productGroups" TO manager;


--
-- Name: TABLE "productOrderStatus"; Type: ACL; Schema: stock; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE stock."productOrderStatus" TO manager;


--
-- Name: TABLE products; Type: ACL; Schema: stock; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE stock.products TO manager;


--
-- PostgreSQL database dump complete
--

