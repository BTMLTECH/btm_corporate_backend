--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: btm_corporate_db_f537_user
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO btm_corporate_db_f537_user;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: btm_corporate_db_f537_user
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: payment_status_type_enum; Type: TYPE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TYPE public.payment_status_type_enum AS ENUM (
    'FLUTTERWAVE',
    'STRIPE'
);


ALTER TYPE public.payment_status_type_enum OWNER TO btm_corporate_db_f537_user;

--
-- Name: tour_package_payment_status_type_enum; Type: TYPE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TYPE public.tour_package_payment_status_type_enum AS ENUM (
    'PENDING',
    'SUCCESS',
    'FAILED'
);


ALTER TYPE public.tour_package_payment_status_type_enum OWNER TO btm_corporate_db_f537_user;

--
-- Name: tour_package_price_type_enum; Type: TYPE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TYPE public.tour_package_price_type_enum AS ENUM (
    'PER_PERSON',
    'PER_FAMILY'
);


ALTER TYPE public.tour_package_price_type_enum OWNER TO btm_corporate_db_f537_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accommodations; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.accommodations (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying(255) NOT NULL,
    type character varying(2000),
    price double precision NOT NULL
);


ALTER TABLE public.accommodations OWNER TO btm_corporate_db_f537_user;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.activities (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying(255) NOT NULL,
    description character varying(2000),
    price double precision NOT NULL,
    tour_sites_region_id uuid
);


ALTER TABLE public.activities OWNER TO btm_corporate_db_f537_user;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO btm_corporate_db_f537_user;

--
-- Name: destination_regions; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.destination_regions (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    region_id uuid,
    destination_id uuid
);


ALTER TABLE public.destination_regions OWNER TO btm_corporate_db_f537_user;

--
-- Name: destination_tour_packages; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.destination_tour_packages (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    tour_package_id uuid,
    destination_id uuid
);


ALTER TABLE public.destination_tour_packages OWNER TO btm_corporate_db_f537_user;

--
-- Name: destinations; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.destinations (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying(255) NOT NULL
);


ALTER TABLE public.destinations OWNER TO btm_corporate_db_f537_user;

--
-- Name: exclusion; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.exclusion (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    description character varying(2048) NOT NULL,
    tour_package_id uuid
);


ALTER TABLE public.exclusion OWNER TO btm_corporate_db_f537_user;

--
-- Name: google_verification; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.google_verification (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    state character varying(255) NOT NULL,
    auth_type character varying(255) NOT NULL
);


ALTER TABLE public.google_verification OWNER TO btm_corporate_db_f537_user;

--
-- Name: inclusion; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.inclusion (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    description character varying(2048) NOT NULL,
    tour_package_id uuid
);


ALTER TABLE public.inclusion OWNER TO btm_corporate_db_f537_user;

--
-- Name: itineraries; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.itineraries (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    tour_package_id uuid,
    title character varying(255),
    day_number integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.itineraries OWNER TO btm_corporate_db_f537_user;

--
-- Name: regions; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.regions (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying(255) NOT NULL,
    destination_id uuid
);


ALTER TABLE public.regions OWNER TO btm_corporate_db_f537_user;

--
-- Name: terms_conditions; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.terms_conditions (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    title character varying(50) NOT NULL,
    description character varying(2048) NOT NULL,
    tour_package_id uuid
);


ALTER TABLE public.terms_conditions OWNER TO btm_corporate_db_f537_user;

--
-- Name: tour_package_transportations; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.tour_package_transportations (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    user_tour_package_id uuid,
    transportation_id uuid
);


ALTER TABLE public.tour_package_transportations OWNER TO btm_corporate_db_f537_user;

--
-- Name: tour_packages; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.tour_packages (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text,
    duration_days integer NOT NULL,
    duration_nights integer NOT NULL,
    currency character varying(10),
    price_per_family_usd numeric(10,2),
    price_per_person_usd numeric(10,2),
    number_of_travelers integer NOT NULL,
    traveler_adults integer NOT NULL,
    traveler_children integer,
    is_group_pricing boolean,
    accommodation_details text,
    meals_included text,
    transport_info text,
    price_type public.tour_package_price_type_enum,
    package_type character varying(50) NOT NULL,
    thumbnail_url character varying(255) NOT NULL,
    images_url text
);


ALTER TABLE public.tour_packages OWNER TO btm_corporate_db_f537_user;

--
-- Name: tour_sites_region; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.tour_sites_region (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying(255) NOT NULL,
    description character varying(2000),
    price double precision NOT NULL,
    region_id uuid
);


ALTER TABLE public.tour_sites_region OWNER TO btm_corporate_db_f537_user;

--
-- Name: transportation; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.transportation (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying(255) NOT NULL,
    price double precision NOT NULL
);


ALTER TABLE public.transportation OWNER TO btm_corporate_db_f537_user;

--
-- Name: user_payment; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.user_payment (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    payment_date timestamp without time zone NOT NULL,
    currency character varying(3),
    amount integer NOT NULL,
    email_address character varying(255),
    user_id uuid,
    tx_ref character varying(255) NOT NULL
);


ALTER TABLE public.user_payment OWNER TO btm_corporate_db_f537_user;

--
-- Name: user_tour_package_accommodations; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.user_tour_package_accommodations (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    user_tour_package_id uuid,
    accommodation_id uuid
);


ALTER TABLE public.user_tour_package_accommodations OWNER TO btm_corporate_db_f537_user;

--
-- Name: user_tour_package_activities; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.user_tour_package_activities (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    user_tour_package_id uuid,
    activity_id uuid
);


ALTER TABLE public.user_tour_package_activities OWNER TO btm_corporate_db_f537_user;

--
-- Name: user_tour_package_payments; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.user_tour_package_payments (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    user_tour_package_id uuid,
    payment_id uuid
);


ALTER TABLE public.user_tour_package_payments OWNER TO btm_corporate_db_f537_user;

--
-- Name: user_tour_package_tour_sites_region; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.user_tour_package_tour_sites_region (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    user_tour_package_id uuid,
    tour_sites_region_id uuid
);


ALTER TABLE public.user_tour_package_tour_sites_region OWNER TO btm_corporate_db_f537_user;

--
-- Name: user_tour_packages; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.user_tour_packages (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    active boolean,
    user_id uuid,
    tx_ref character varying(255),
    region_id uuid,
    accommodation_id uuid,
    no_of_people_attending integer NOT NULL,
    start_date date DEFAULT CURRENT_DATE,
    end_date date DEFAULT (CURRENT_DATE + '3 days'::interval)
);


ALTER TABLE public.user_tour_packages OWNER TO btm_corporate_db_f537_user;

--
-- Name: user_verification; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.user_verification (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    session_id uuid NOT NULL,
    email character varying(255) NOT NULL,
    token character varying(350) NOT NULL,
    expires_at timestamp with time zone DEFAULT ((now() AT TIME ZONE 'UTC'::text) + '00:10:00'::interval) NOT NULL
);


ALTER TABLE public.user_verification OWNER TO btm_corporate_db_f537_user;

--
-- Name: users; Type: TABLE; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255),
    phone character varying(24),
    provider character varying(24),
    email_verified boolean,
    address character varying(255),
    is_admin boolean,
    is_active boolean,
    last_login_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO btm_corporate_db_f537_user;

--
-- Data for Name: accommodations; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.accommodations (id, created_at, updated_at, deleted_at, name, type, price) FROM stdin;
\.


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.activities (id, created_at, updated_at, deleted_at, name, description, price, tour_sites_region_id) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.alembic_version (version_num) FROM stdin;
8e73a4877550
\.


--
-- Data for Name: destination_regions; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.destination_regions (id, created_at, updated_at, deleted_at, region_id, destination_id) FROM stdin;
\.


--
-- Data for Name: destination_tour_packages; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.destination_tour_packages (id, created_at, updated_at, deleted_at, tour_package_id, destination_id) FROM stdin;
\.


--
-- Data for Name: destinations; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.destinations (id, created_at, updated_at, deleted_at, name) FROM stdin;
\.


--
-- Data for Name: exclusion; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.exclusion (id, created_at, updated_at, deleted_at, description, tour_package_id) FROM stdin;
\.


--
-- Data for Name: google_verification; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.google_verification (id, created_at, updated_at, deleted_at, state, auth_type) FROM stdin;
\.


--
-- Data for Name: inclusion; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.inclusion (id, created_at, updated_at, deleted_at, description, tour_package_id) FROM stdin;
\.


--
-- Data for Name: itineraries; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.itineraries (id, created_at, updated_at, deleted_at, tour_package_id, title, day_number, description) FROM stdin;
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.regions (id, created_at, updated_at, deleted_at, name, destination_id) FROM stdin;
\.


--
-- Data for Name: terms_conditions; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.terms_conditions (id, created_at, updated_at, deleted_at, title, description, tour_package_id) FROM stdin;
\.


--
-- Data for Name: tour_package_transportations; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.tour_package_transportations (id, created_at, updated_at, deleted_at, user_tour_package_id, transportation_id) FROM stdin;
\.


--
-- Data for Name: tour_packages; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.tour_packages (id, created_at, updated_at, deleted_at, title, slug, description, duration_days, duration_nights, currency, price_per_family_usd, price_per_person_usd, number_of_travelers, traveler_adults, traveler_children, is_group_pricing, accommodation_details, meals_included, transport_info, price_type, package_type, thumbnail_url, images_url) FROM stdin;
\.


--
-- Data for Name: tour_sites_region; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.tour_sites_region (id, created_at, updated_at, deleted_at, name, description, price, region_id) FROM stdin;
\.


--
-- Data for Name: transportation; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.transportation (id, created_at, updated_at, deleted_at, name, price) FROM stdin;
\.


--
-- Data for Name: user_payment; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.user_payment (id, created_at, updated_at, deleted_at, payment_date, currency, amount, email_address, user_id, tx_ref) FROM stdin;
\.


--
-- Data for Name: user_tour_package_accommodations; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.user_tour_package_accommodations (id, created_at, updated_at, deleted_at, user_tour_package_id, accommodation_id) FROM stdin;
\.


--
-- Data for Name: user_tour_package_activities; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.user_tour_package_activities (id, created_at, updated_at, deleted_at, user_tour_package_id, activity_id) FROM stdin;
\.


--
-- Data for Name: user_tour_package_payments; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.user_tour_package_payments (id, created_at, updated_at, deleted_at, user_tour_package_id, payment_id) FROM stdin;
\.


--
-- Data for Name: user_tour_package_tour_sites_region; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.user_tour_package_tour_sites_region (id, created_at, updated_at, deleted_at, user_tour_package_id, tour_sites_region_id) FROM stdin;
\.


--
-- Data for Name: user_tour_packages; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.user_tour_packages (id, created_at, updated_at, deleted_at, active, user_id, tx_ref, region_id, accommodation_id, no_of_people_attending, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: user_verification; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.user_verification (id, created_at, updated_at, deleted_at, session_id, email, token, expires_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: btm_corporate_db_f537_user
--

COPY public.users (id, created_at, updated_at, deleted_at, name, email, password, phone, provider, email_verified, address, is_admin, is_active, last_login_at) FROM stdin;
\.


--
-- Name: accommodations accommodations_name_key; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.accommodations
    ADD CONSTRAINT accommodations_name_key UNIQUE (name);


--
-- Name: accommodations accommodations_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.accommodations
    ADD CONSTRAINT accommodations_pkey PRIMARY KEY (id);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: destination_regions destination_regions_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.destination_regions
    ADD CONSTRAINT destination_regions_pkey PRIMARY KEY (id);


--
-- Name: destination_tour_packages destination_tour_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.destination_tour_packages
    ADD CONSTRAINT destination_tour_packages_pkey PRIMARY KEY (id);


--
-- Name: destinations destinations_name_key; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.destinations
    ADD CONSTRAINT destinations_name_key UNIQUE (name);


--
-- Name: destinations destinations_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (id);


--
-- Name: exclusion exclusion_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.exclusion
    ADD CONSTRAINT exclusion_pkey PRIMARY KEY (id);


--
-- Name: google_verification google_verification_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.google_verification
    ADD CONSTRAINT google_verification_pkey PRIMARY KEY (id);


--
-- Name: inclusion inclusion_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.inclusion
    ADD CONSTRAINT inclusion_pkey PRIMARY KEY (id);


--
-- Name: itineraries itineraries_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.itineraries
    ADD CONSTRAINT itineraries_pkey PRIMARY KEY (id);


--
-- Name: regions regions_name_key; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_name_key UNIQUE (name);


--
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: terms_conditions terms_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.terms_conditions
    ADD CONSTRAINT terms_conditions_pkey PRIMARY KEY (id);


--
-- Name: tour_package_transportations tour_package_transportations_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.tour_package_transportations
    ADD CONSTRAINT tour_package_transportations_pkey PRIMARY KEY (id);


--
-- Name: tour_packages tour_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.tour_packages
    ADD CONSTRAINT tour_packages_pkey PRIMARY KEY (id);


--
-- Name: tour_packages tour_packages_slug_key; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.tour_packages
    ADD CONSTRAINT tour_packages_slug_key UNIQUE (slug);


--
-- Name: tour_sites_region tour_sites_region_name_key; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.tour_sites_region
    ADD CONSTRAINT tour_sites_region_name_key UNIQUE (name);


--
-- Name: tour_sites_region tour_sites_region_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.tour_sites_region
    ADD CONSTRAINT tour_sites_region_pkey PRIMARY KEY (id);


--
-- Name: transportation transportation_name_key; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.transportation
    ADD CONSTRAINT transportation_name_key UNIQUE (name);


--
-- Name: transportation transportation_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.transportation
    ADD CONSTRAINT transportation_pkey PRIMARY KEY (id);


--
-- Name: activities uq_name_region; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT uq_name_region UNIQUE (name, tour_sites_region_id);


--
-- Name: user_payment user_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_payment
    ADD CONSTRAINT user_payment_pkey PRIMARY KEY (id);


--
-- Name: user_tour_package_accommodations user_tour_package_accommodations_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_accommodations
    ADD CONSTRAINT user_tour_package_accommodations_pkey PRIMARY KEY (id);


--
-- Name: user_tour_package_activities user_tour_package_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_activities
    ADD CONSTRAINT user_tour_package_activities_pkey PRIMARY KEY (id);


--
-- Name: user_tour_package_payments user_tour_package_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_payments
    ADD CONSTRAINT user_tour_package_payments_pkey PRIMARY KEY (id);


--
-- Name: user_tour_package_tour_sites_region user_tour_package_tour_sites_region_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_tour_sites_region
    ADD CONSTRAINT user_tour_package_tour_sites_region_pkey PRIMARY KEY (id);


--
-- Name: user_tour_packages user_tour_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_packages
    ADD CONSTRAINT user_tour_packages_pkey PRIMARY KEY (id);


--
-- Name: user_verification user_verification_email_key; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_verification
    ADD CONSTRAINT user_verification_email_key UNIQUE (email);


--
-- Name: user_verification user_verification_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_verification
    ADD CONSTRAINT user_verification_pkey PRIMARY KEY (id, session_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_activities_tour_sites_region_id; Type: INDEX; Schema: public; Owner: btm_corporate_db_f537_user
--

CREATE INDEX ix_activities_tour_sites_region_id ON public.activities USING btree (tour_sites_region_id);


--
-- Name: activities activities_tour_sites_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_tour_sites_region_id_fkey FOREIGN KEY (tour_sites_region_id) REFERENCES public.tour_sites_region(id) ON DELETE CASCADE;


--
-- Name: destination_regions destination_regions_destination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.destination_regions
    ADD CONSTRAINT destination_regions_destination_id_fkey FOREIGN KEY (destination_id) REFERENCES public.destinations(id) ON DELETE CASCADE;


--
-- Name: destination_regions destination_regions_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.destination_regions
    ADD CONSTRAINT destination_regions_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id) ON DELETE CASCADE;


--
-- Name: destination_tour_packages destination_tour_packages_destination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.destination_tour_packages
    ADD CONSTRAINT destination_tour_packages_destination_id_fkey FOREIGN KEY (destination_id) REFERENCES public.destinations(id) ON DELETE CASCADE;


--
-- Name: destination_tour_packages destination_tour_packages_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.destination_tour_packages
    ADD CONSTRAINT destination_tour_packages_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


--
-- Name: exclusion exclusion_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.exclusion
    ADD CONSTRAINT exclusion_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


--
-- Name: inclusion inclusion_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.inclusion
    ADD CONSTRAINT inclusion_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


--
-- Name: itineraries itineraries_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.itineraries
    ADD CONSTRAINT itineraries_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


--
-- Name: regions regions_destination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_destination_id_fkey FOREIGN KEY (destination_id) REFERENCES public.destinations(id);


--
-- Name: terms_conditions terms_conditions_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.terms_conditions
    ADD CONSTRAINT terms_conditions_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


--
-- Name: tour_package_transportations tour_package_transportations_transportation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.tour_package_transportations
    ADD CONSTRAINT tour_package_transportations_transportation_id_fkey FOREIGN KEY (transportation_id) REFERENCES public.transportation(id) ON DELETE CASCADE;


--
-- Name: tour_package_transportations tour_package_transportations_user_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.tour_package_transportations
    ADD CONSTRAINT tour_package_transportations_user_tour_package_id_fkey FOREIGN KEY (user_tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: tour_sites_region tour_sites_region_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.tour_sites_region
    ADD CONSTRAINT tour_sites_region_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id) ON DELETE CASCADE;


--
-- Name: user_payment user_payment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_payment
    ADD CONSTRAINT user_payment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_accommodations user_tour_package_accommodations_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_accommodations
    ADD CONSTRAINT user_tour_package_accommodations_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.accommodations(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_accommodations user_tour_package_accommodations_user_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_accommodations
    ADD CONSTRAINT user_tour_package_accommodations_user_tour_package_id_fkey FOREIGN KEY (user_tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_activities user_tour_package_activities_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_activities
    ADD CONSTRAINT user_tour_package_activities_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_activities user_tour_package_activities_user_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_activities
    ADD CONSTRAINT user_tour_package_activities_user_tour_package_id_fkey FOREIGN KEY (user_tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_payments user_tour_package_payments_payment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_payments
    ADD CONSTRAINT user_tour_package_payments_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES public.user_payment(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_payments user_tour_package_payments_user_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_payments
    ADD CONSTRAINT user_tour_package_payments_user_tour_package_id_fkey FOREIGN KEY (user_tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_tour_sites_region user_tour_package_tour_sites_region_tour_sites_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_tour_sites_region
    ADD CONSTRAINT user_tour_package_tour_sites_region_tour_sites_region_id_fkey FOREIGN KEY (tour_sites_region_id) REFERENCES public.tour_sites_region(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_tour_sites_region user_tour_package_tour_sites_region_user_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_package_tour_sites_region
    ADD CONSTRAINT user_tour_package_tour_sites_region_user_tour_package_id_fkey FOREIGN KEY (user_tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: user_tour_packages user_tour_packages_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_packages
    ADD CONSTRAINT user_tour_packages_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.accommodations(id);


--
-- Name: user_tour_packages user_tour_packages_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_packages
    ADD CONSTRAINT user_tour_packages_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id) ON DELETE CASCADE;


--
-- Name: user_tour_packages user_tour_packages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: btm_corporate_db_f537_user
--

ALTER TABLE ONLY public.user_tour_packages
    ADD CONSTRAINT user_tour_packages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

