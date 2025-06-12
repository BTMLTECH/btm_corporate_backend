--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)
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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accommodations; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.accommodations OWNER TO postgres;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.activities OWNER TO postgres;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: destination_regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.destination_regions (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    region_id uuid,
    destination_id uuid
);


ALTER TABLE public.destination_regions OWNER TO postgres;

--
-- Name: destination_tour_packages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.destination_tour_packages (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    tour_package_id uuid,
    destination_id uuid
);


ALTER TABLE public.destination_tour_packages OWNER TO postgres;

--
-- Name: destinations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.destinations (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying(255) NOT NULL
);


ALTER TABLE public.destinations OWNER TO postgres;

--
-- Name: exclusion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exclusion (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    description character varying(2048) NOT NULL,
    tour_package_id uuid
);


ALTER TABLE public.exclusion OWNER TO postgres;

--
-- Name: google_verification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.google_verification (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    state character varying(255) NOT NULL,
    auth_type character varying(255) NOT NULL
);


ALTER TABLE public.google_verification OWNER TO postgres;

--
-- Name: inclusion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inclusion (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    description character varying(2048) NOT NULL,
    tour_package_id uuid
);


ALTER TABLE public.inclusion OWNER TO postgres;

--
-- Name: itineraries; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.itineraries OWNER TO postgres;

--
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying(255) NOT NULL,
    destination_id uuid
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- Name: termsconditions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.termsconditions (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    title character varying(50) NOT NULL,
    description character varying(2048) NOT NULL,
    tour_package_id uuid
);


ALTER TABLE public.termsconditions OWNER TO postgres;

--
-- Name: tour_package_transportations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tour_package_transportations (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    user_tour_package_id uuid,
    transportation_id uuid
);


ALTER TABLE public.tour_package_transportations OWNER TO postgres;

--
-- Name: tour_packages; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.tour_packages OWNER TO postgres;

--
-- Name: tour_sites_region; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.tour_sites_region OWNER TO postgres;

--
-- Name: transportation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transportation (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying(255) NOT NULL,
    price double precision NOT NULL
);


ALTER TABLE public.transportation OWNER TO postgres;

--
-- Name: user_payment; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_payment OWNER TO postgres;

--
-- Name: user_tour_package_accommodations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_tour_package_accommodations (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    user_tour_package_id uuid,
    accommodation_id uuid
);


ALTER TABLE public.user_tour_package_accommodations OWNER TO postgres;

--
-- Name: user_tour_package_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_tour_package_activities (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    user_tour_package_id uuid,
    activity_id uuid
);


ALTER TABLE public.user_tour_package_activities OWNER TO postgres;

--
-- Name: user_tour_package_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_tour_package_payments (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    user_tour_package_id uuid,
    payment_id uuid
);


ALTER TABLE public.user_tour_package_payments OWNER TO postgres;

--
-- Name: user_tour_package_tour_sites_region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_tour_package_tour_sites_region (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    user_tour_package_id uuid,
    tour_sites_region_id uuid
);


ALTER TABLE public.user_tour_package_tour_sites_region OWNER TO postgres;

--
-- Name: user_tour_packages; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_tour_packages OWNER TO postgres;

--
-- Name: user_verification; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_verification OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: accommodations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accommodations (id, created_at, updated_at, deleted_at, name, type, price) FROM stdin;
\.


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activities (id, created_at, updated_at, deleted_at, name, description, price, tour_sites_region_id) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
28d0f1ca248f
\.


--
-- Data for Name: destination_regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.destination_regions (id, created_at, updated_at, deleted_at, region_id, destination_id) FROM stdin;
\.


--
-- Data for Name: destination_tour_packages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.destination_tour_packages (id, created_at, updated_at, deleted_at, tour_package_id, destination_id) FROM stdin;
92b986a5-25e8-4d08-8b7a-58e72ebad8f7	2025-06-12 19:10:09.183637	2025-06-12 19:10:09.183646	\N	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4	59892785-ceb0-4e33-bec8-b42cfd679e02
dd7168db-5cee-4c0c-bede-2fd46aa3438d	2025-06-12 19:10:09.18365	2025-06-12 19:10:09.183651	\N	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4	85d62f39-be03-4055-aa41-51a68fcd79cf
\.


--
-- Data for Name: destinations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.destinations (id, created_at, updated_at, deleted_at, name) FROM stdin;
85d62f39-be03-4055-aa41-51a68fcd79cf	2025-06-12 19:10:09.130806	2025-06-12 19:10:09.130814	\N	Nairobi
59892785-ceb0-4e33-bec8-b42cfd679e02	2025-06-12 19:10:09.14801	2025-06-12 19:10:09.148017	\N	Mombasa
\.


--
-- Data for Name: exclusion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exclusion (id, created_at, updated_at, deleted_at, description, tour_package_id) FROM stdin;
98e2770c-c3c1-4fff-9d1c-f3118f432809	2025-06-12 19:10:09.189412	2025-06-12 19:10:09.189419	\N	Personal expenses such as shopping, phone calls, or room service	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
43f38f86-386f-43ad-840e-b2d2b799363d	2025-06-12 19:10:09.189423	2025-06-12 19:10:09.189424	\N	Travel insurance	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
f105fe96-50b2-42f4-a827-6da0b12beccd	2025-06-12 19:10:09.189427	2025-06-12 19:10:09.189428	\N	Additional excursions or activities not included in the itinerary	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
e1d4285b-b2fa-4837-b1f9-d81533fe578f	2025-06-12 19:10:09.189431	2025-06-12 19:10:09.189432	\N	Tips and gratuities	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
\.


--
-- Data for Name: google_verification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.google_verification (id, created_at, updated_at, deleted_at, state, auth_type) FROM stdin;
\.


--
-- Data for Name: inclusion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inclusion (id, created_at, updated_at, deleted_at, description, tour_package_id) FROM stdin;
624d4110-edd2-4b6a-959f-1548e0ce1199	2025-06-12 19:10:09.193364	2025-06-12 19:10:09.193372	\N	Return Economy Flight on Kenya Airways from Lagos	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
fe7294cd-1d73-4c9c-8d24-6b3e296d1dbf	2025-06-12 19:10:09.193376	2025-06-12 19:10:09.193377	\N	Kenya ETA	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
d54c9d16-d778-4de9-9e06-64a69e630a4e	2025-06-12 19:10:09.19338	2025-06-12 19:10:09.193381	\N	Protocol Service	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
993f74f6-d527-4616-9c91-40b73c5ff7bc	2025-06-12 19:10:09.193384	2025-06-12 19:10:09.193384	\N	Return Airport Transfer	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
e3bbb913-8f12-4fd7-8303-43deb2f02065	2025-06-12 19:10:09.193387	2025-06-12 19:10:09.193388	\N	3 Nights in 4-star Resort in Mombasa (PrideInn Flamingo) with daily Breakfast, Lunch, and Dinner	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
b672d00b-0d95-4e9d-8327-0ae9352a3613	2025-06-12 19:10:09.193391	2025-06-12 19:10:09.193392	\N	2 Nights in 4-star Hotel in Nairobi (Holiday Inn) with daily Breakfast	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
bc934086-f2fa-411c-a5e8-035257f74dfe	2025-06-12 19:10:09.193395	2025-06-12 19:10:09.193395	\N	Visit to Nairobi National Park	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
1ece5435-f013-4ff0-b152-00c8c0b81e32	2025-06-12 19:10:09.193398	2025-06-12 19:10:09.193399	\N	Visit to Giraffe Center	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
b978098d-8161-4a4d-9f7e-56f3145d363e	2025-06-12 19:10:09.193402	2025-06-12 19:10:09.193402	\N	Lunch at Carnivore Restaurant	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
1c67caf7-0f1e-460c-a90d-65e06bb8c39e	2025-06-12 19:10:09.193406	2025-06-12 19:10:09.193406	\N	Visit to Wild Waters Mombasa	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
eb4ad38d-4d38-4974-905e-60187cf728eb	2025-06-12 19:10:09.193409	2025-06-12 19:10:09.19341	\N	Dolphin Watch at Kisite Marine Park and Wasini Island with Lunch	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
\.


--
-- Data for Name: itineraries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itineraries (id, created_at, updated_at, deleted_at, tour_package_id, title, day_number, description) FROM stdin;
3079d560-0ea3-4dc9-81d2-fea48f577aa1	2025-06-12 19:10:09.198417	2025-06-12 19:10:09.198426	\N	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4	Arrival in Nairobi + Check-in at Holiday Inn	1	Arrive in Nairobi via return economy flight on Kenya Airways from Lagos. Enjoy protocol service and airport transfer to the Holiday Inn hotel. Check in and relax at the 4-star hotel with modern amenities. Evening at leisure.
1e042872-41b0-4251-9ead-ba184d7aace0	2025-06-12 19:10:09.19843	2025-06-12 19:10:09.19843	\N	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4	Visit to Nairobi National Park & Giraffe Center	2	After breakfast, embark on an exciting day exploring Nairobi’s rich wildlife. Begin with a safari drive through Nairobi National Park to spot lions, rhinos, giraffes, and more. Later, visit the Giraffe Center for an up-close encounter with endangered Rothschild giraffes. Evening at leisure.
6538b6fb-f402-43ca-91b0-40bd685ba2a3	2025-06-12 19:10:09.198433	2025-06-12 19:10:09.198434	\N	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4	Lunch at Carnivore Restaurant + Transfer to Mombasa	3	Enjoy a unique and hearty lunch at Nairobi’s famous Carnivore Restaurant. Afterward, transfer to the airport for your flight to Mombasa. Upon arrival, you’ll be taken to PrideInn Flamingo Resort for check-in and dinner. Relax and enjoy the coastal vibes.
9b193812-802b-4f58-afca-1b8af1451b9d	2025-06-12 19:10:09.198437	2025-06-12 19:10:09.198438	\N	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4	Dolphin Watching + Kisite Marine Park & Wasini Island Tour	4	After breakfast, head out for a magical day trip to Kisite Marine Park. Spot playful dolphins, snorkel in the clear waters, and enjoy a traditional Swahili seafood lunch on Wasini Island. Return to the resort for dinner and relaxation.
47a6ec2c-0f5b-401f-a26d-039c53cf8591	2025-06-12 19:10:09.198441	2025-06-12 19:10:09.198441	\N	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4	Family Fun at Wild Waters Mombasa	5	Spend a thrilling day at Wild Waters, Mombasa’s largest water park. With rides, slides, and activities for all ages, it's a day of unforgettable fun for the whole family. Return to the resort in the evening for dinner and rest.
5c52e1ce-9608-4299-8a62-d692e1bb0ac5	2025-06-12 19:10:09.198444	2025-06-12 19:10:09.198445	\N	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4	Departure from Mombasa	6	After breakfast, check out from the resort. You’ll be transferred to Mombasa airport for your return Kenya Airways flight to Lagos via Nairobi. End of tour.
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regions (id, created_at, updated_at, deleted_at, name, destination_id) FROM stdin;
\.


--
-- Data for Name: termsconditions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.termsconditions (id, created_at, updated_at, deleted_at, title, description, tour_package_id) FROM stdin;
9f74a289-9508-42bd-acaa-36da09608ad2	2025-06-12 19:10:09.202054	2025-06-12 19:10:09.202062	\N	Booking & Payment	A 50% deposit is required to confirm booking. Full payment must be made at least 14 days before departure.	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
f1117865-3320-443e-88fa-47e0046f75d9	2025-06-12 19:10:09.202066	2025-06-12 19:10:09.202067	\N	Visa Requirements	All travelers must possess a valid Kenya ETA prior to departure. Assistance with application will be provided.	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
6aaf0708-1095-4a25-9256-432b7e161fbf	2025-06-12 19:10:09.20207	2025-06-12 19:10:09.20207	\N	Cancellation Policy	Cancellations made less than 14 days before travel may incur penalties. Refunds are subject to supplier terms.	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
c8801dfa-f453-471f-97be-2fcc51f7e250	2025-06-12 19:10:09.202073	2025-06-12 19:10:09.202074	\N	Child Policy	Children must be accompanied by at least one adult. Age limits may apply for some activities.	366ee4c4-30f1-45b2-9b27-cf5dd0d459a4
\.


--
-- Data for Name: tour_package_transportations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_package_transportations (id, created_at, updated_at, deleted_at, user_tour_package_id, transportation_id) FROM stdin;
\.


--
-- Data for Name: tour_packages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_packages (id, created_at, updated_at, deleted_at, title, slug, description, duration_days, duration_nights, currency, price_per_family_usd, price_per_person_usd, number_of_travelers, traveler_adults, traveler_children, is_group_pricing, accommodation_details, meals_included, transport_info, price_type, package_type, thumbnail_url, images_url) FROM stdin;
366ee4c4-30f1-45b2-9b27-cf5dd0d459a4	2025-06-12 19:10:09.161554	2025-06-12 19:10:09.161563	\N	Kenya Family Package (Mombasa and Nairobi)	kenya-family-package-mombasa-nairobi	Explore wild Nairobi and sunny Mombasa in 6 unforgettable days. Safari at Nairobi National Park, feed giraffes, feast at Carnivore, snorkel with dolphins, and splash around Wild Waters Mombasa. Flights, hotels, meals & transfers—all covered. Just pack your bags and make memories that last a lifetime!	6	5	USD	7100.00	\N	4	2	2	f	\N	\N	\N	PER_FAMILY	Family Package	https://res.cloudinary.com/djjoidnbp/image/upload/v1749743381/mombasa_xtbkoo.jpg	\N
\.


--
-- Data for Name: tour_sites_region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_sites_region (id, created_at, updated_at, deleted_at, name, description, price, region_id) FROM stdin;
\.


--
-- Data for Name: transportation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transportation (id, created_at, updated_at, deleted_at, name, price) FROM stdin;
\.


--
-- Data for Name: user_payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_payment (id, created_at, updated_at, deleted_at, payment_date, currency, amount, email_address, user_id, tx_ref) FROM stdin;
\.


--
-- Data for Name: user_tour_package_accommodations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_tour_package_accommodations (id, created_at, updated_at, deleted_at, user_tour_package_id, accommodation_id) FROM stdin;
\.


--
-- Data for Name: user_tour_package_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_tour_package_activities (id, created_at, updated_at, deleted_at, user_tour_package_id, activity_id) FROM stdin;
\.


--
-- Data for Name: user_tour_package_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_tour_package_payments (id, created_at, updated_at, deleted_at, user_tour_package_id, payment_id) FROM stdin;
\.


--
-- Data for Name: user_tour_package_tour_sites_region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_tour_package_tour_sites_region (id, created_at, updated_at, deleted_at, user_tour_package_id, tour_sites_region_id) FROM stdin;
\.


--
-- Data for Name: user_tour_packages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_tour_packages (id, created_at, updated_at, deleted_at, active, user_id, tx_ref, region_id, accommodation_id, no_of_people_attending, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: user_verification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_verification (id, created_at, updated_at, deleted_at, session_id, email, token, expires_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, created_at, updated_at, deleted_at, name, email, password, phone, provider, email_verified, address, is_admin, is_active, last_login_at) FROM stdin;
\.


--
-- Name: accommodations accommodations_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accommodations
    ADD CONSTRAINT accommodations_name_key UNIQUE (name);


--
-- Name: accommodations accommodations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accommodations
    ADD CONSTRAINT accommodations_pkey PRIMARY KEY (id);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: destination_regions destination_regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destination_regions
    ADD CONSTRAINT destination_regions_pkey PRIMARY KEY (id);


--
-- Name: destination_tour_packages destination_tour_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destination_tour_packages
    ADD CONSTRAINT destination_tour_packages_pkey PRIMARY KEY (id);


--
-- Name: destinations destinations_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destinations
    ADD CONSTRAINT destinations_name_key UNIQUE (name);


--
-- Name: destinations destinations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destinations
    ADD CONSTRAINT destinations_pkey PRIMARY KEY (id);


--
-- Name: exclusion exclusion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exclusion
    ADD CONSTRAINT exclusion_pkey PRIMARY KEY (id);


--
-- Name: google_verification google_verification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.google_verification
    ADD CONSTRAINT google_verification_pkey PRIMARY KEY (id);


--
-- Name: inclusion inclusion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inclusion
    ADD CONSTRAINT inclusion_pkey PRIMARY KEY (id);


--
-- Name: itineraries itineraries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itineraries
    ADD CONSTRAINT itineraries_pkey PRIMARY KEY (id);


--
-- Name: regions regions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_name_key UNIQUE (name);


--
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: termsconditions termsconditions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.termsconditions
    ADD CONSTRAINT termsconditions_pkey PRIMARY KEY (id);


--
-- Name: tour_package_transportations tour_package_transportations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_transportations
    ADD CONSTRAINT tour_package_transportations_pkey PRIMARY KEY (id);


--
-- Name: tour_packages tour_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_packages
    ADD CONSTRAINT tour_packages_pkey PRIMARY KEY (id);


--
-- Name: tour_packages tour_packages_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_packages
    ADD CONSTRAINT tour_packages_slug_key UNIQUE (slug);


--
-- Name: tour_sites_region tour_sites_region_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_sites_region
    ADD CONSTRAINT tour_sites_region_name_key UNIQUE (name);


--
-- Name: tour_sites_region tour_sites_region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_sites_region
    ADD CONSTRAINT tour_sites_region_pkey PRIMARY KEY (id);


--
-- Name: transportation transportation_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transportation
    ADD CONSTRAINT transportation_name_key UNIQUE (name);


--
-- Name: transportation transportation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transportation
    ADD CONSTRAINT transportation_pkey PRIMARY KEY (id);


--
-- Name: activities uq_name_region; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT uq_name_region UNIQUE (name, tour_sites_region_id);


--
-- Name: user_payment user_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_payment
    ADD CONSTRAINT user_payment_pkey PRIMARY KEY (id);


--
-- Name: user_tour_package_accommodations user_tour_package_accommodations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_accommodations
    ADD CONSTRAINT user_tour_package_accommodations_pkey PRIMARY KEY (id);


--
-- Name: user_tour_package_activities user_tour_package_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_activities
    ADD CONSTRAINT user_tour_package_activities_pkey PRIMARY KEY (id);


--
-- Name: user_tour_package_payments user_tour_package_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_payments
    ADD CONSTRAINT user_tour_package_payments_pkey PRIMARY KEY (id);


--
-- Name: user_tour_package_tour_sites_region user_tour_package_tour_sites_region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_tour_sites_region
    ADD CONSTRAINT user_tour_package_tour_sites_region_pkey PRIMARY KEY (id);


--
-- Name: user_tour_packages user_tour_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_packages
    ADD CONSTRAINT user_tour_packages_pkey PRIMARY KEY (id);


--
-- Name: user_verification user_verification_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_verification
    ADD CONSTRAINT user_verification_email_key UNIQUE (email);


--
-- Name: user_verification user_verification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_verification
    ADD CONSTRAINT user_verification_pkey PRIMARY KEY (id, session_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_activities_tour_sites_region_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_activities_tour_sites_region_id ON public.activities USING btree (tour_sites_region_id);


--
-- Name: activities activities_tour_sites_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_tour_sites_region_id_fkey FOREIGN KEY (tour_sites_region_id) REFERENCES public.tour_sites_region(id) ON DELETE CASCADE;


--
-- Name: destination_regions destination_regions_destination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destination_regions
    ADD CONSTRAINT destination_regions_destination_id_fkey FOREIGN KEY (destination_id) REFERENCES public.destinations(id) ON DELETE CASCADE;


--
-- Name: destination_regions destination_regions_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destination_regions
    ADD CONSTRAINT destination_regions_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id) ON DELETE CASCADE;


--
-- Name: destination_tour_packages destination_tour_packages_destination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destination_tour_packages
    ADD CONSTRAINT destination_tour_packages_destination_id_fkey FOREIGN KEY (destination_id) REFERENCES public.destinations(id) ON DELETE CASCADE;


--
-- Name: destination_tour_packages destination_tour_packages_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.destination_tour_packages
    ADD CONSTRAINT destination_tour_packages_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


--
-- Name: exclusion exclusion_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exclusion
    ADD CONSTRAINT exclusion_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


--
-- Name: inclusion inclusion_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inclusion
    ADD CONSTRAINT inclusion_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


--
-- Name: itineraries itineraries_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itineraries
    ADD CONSTRAINT itineraries_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


--
-- Name: regions regions_destination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_destination_id_fkey FOREIGN KEY (destination_id) REFERENCES public.destinations(id);


--
-- Name: termsconditions termsconditions_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.termsconditions
    ADD CONSTRAINT termsconditions_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


--
-- Name: tour_package_transportations tour_package_transportations_transportation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_transportations
    ADD CONSTRAINT tour_package_transportations_transportation_id_fkey FOREIGN KEY (transportation_id) REFERENCES public.transportation(id) ON DELETE CASCADE;


--
-- Name: tour_package_transportations tour_package_transportations_user_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_transportations
    ADD CONSTRAINT tour_package_transportations_user_tour_package_id_fkey FOREIGN KEY (user_tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: tour_sites_region tour_sites_region_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_sites_region
    ADD CONSTRAINT tour_sites_region_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id) ON DELETE CASCADE;


--
-- Name: user_payment user_payment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_payment
    ADD CONSTRAINT user_payment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_accommodations user_tour_package_accommodations_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_accommodations
    ADD CONSTRAINT user_tour_package_accommodations_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.accommodations(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_accommodations user_tour_package_accommodations_user_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_accommodations
    ADD CONSTRAINT user_tour_package_accommodations_user_tour_package_id_fkey FOREIGN KEY (user_tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_activities user_tour_package_activities_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_activities
    ADD CONSTRAINT user_tour_package_activities_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_activities user_tour_package_activities_user_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_activities
    ADD CONSTRAINT user_tour_package_activities_user_tour_package_id_fkey FOREIGN KEY (user_tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_payments user_tour_package_payments_payment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_payments
    ADD CONSTRAINT user_tour_package_payments_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES public.user_payment(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_payments user_tour_package_payments_user_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_payments
    ADD CONSTRAINT user_tour_package_payments_user_tour_package_id_fkey FOREIGN KEY (user_tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_tour_sites_region user_tour_package_tour_sites_region_tour_sites_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_tour_sites_region
    ADD CONSTRAINT user_tour_package_tour_sites_region_tour_sites_region_id_fkey FOREIGN KEY (tour_sites_region_id) REFERENCES public.tour_sites_region(id) ON DELETE CASCADE;


--
-- Name: user_tour_package_tour_sites_region user_tour_package_tour_sites_region_user_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_package_tour_sites_region
    ADD CONSTRAINT user_tour_package_tour_sites_region_user_tour_package_id_fkey FOREIGN KEY (user_tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: user_tour_packages user_tour_packages_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_packages
    ADD CONSTRAINT user_tour_packages_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.accommodations(id);


--
-- Name: user_tour_packages user_tour_packages_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_packages
    ADD CONSTRAINT user_tour_packages_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id) ON DELETE CASCADE;


--
-- Name: user_tour_packages user_tour_packages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tour_packages
    ADD CONSTRAINT user_tour_packages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

