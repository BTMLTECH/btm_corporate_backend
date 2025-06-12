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
f900bf9c-443c-4386-835c-05ecb38bf4ad	2024-12-15 09:15:26.138641	2024-12-15 09:15:26.138653	\N	Budget hotel/guest house	\N	50000
756f44ad-6b54-4659-9066-40e66ab14950	2024-12-15 09:16:01.391273	2024-12-15 09:16:01.391298	\N	Economy	\N	120000
f660a3ea-2f94-4822-8aa0-dce6d5583be1	2024-12-15 09:16:16.727975	2024-12-15 09:16:16.727991	\N	Luxury	\N	300000
035d23ae-ec99-4153-b985-5c33f59da224	2024-12-15 09:16:28.076601	2024-12-15 09:16:28.076618	\N	Mid-range Hotel	\N	200000
\.


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activities (id, created_at, updated_at, deleted_at, name, description, price, tour_sites_region_id) FROM stdin;
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
5044d5e9-fd83-4b16-bc5b-62c55777a034	2025-06-12 18:02:51.78531	2025-06-12 18:02:51.785331	\N	41a30ee3-867c-43ab-8eb4-ecc18896c65c	081bb96c-6133-4527-9b10-a160f7cc73c6
039dc9c5-bd13-4ab8-84b4-460ea82204ff	2025-06-12 18:02:51.78534	2025-06-12 18:02:51.785341	\N	41a30ee3-867c-43ab-8eb4-ecc18896c65c	3c76cf7b-84bb-43d5-8cd1-1464e0c3274b
\.


--
-- Data for Name: destinations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.destinations (id, created_at, updated_at, deleted_at, name) FROM stdin;
2726bfc5-5fc1-4ff4-a107-c3fcbcc4db20	2025-04-29 01:09:28.784107	2025-04-29 01:09:28.78413	\N	Ghana
c21e1e16-8154-4587-9d79-0521febbc846	2025-04-29 22:52:58.94227	2025-04-29 22:52:58.942908	\N	Kenya
fac9b1a9-2c4b-4566-b3df-33cd889c2206	2025-05-05 12:38:11.050917	2025-05-05 12:38:11.051882	\N	Qatar
76cdd493-bab3-4364-979c-b880790aa4f3	2025-05-05 13:23:39.764318	2025-05-05 13:23:39.765724	\N	Dubai
081bb96c-6133-4527-9b10-a160f7cc73c6	2025-06-12 16:58:18.732483	2025-06-12 16:58:18.732881	\N	Nairobi
3c76cf7b-84bb-43d5-8cd1-1464e0c3274b	2025-06-12 16:58:18.783587	2025-06-12 16:58:18.783596	\N	Mombasa
\.


--
-- Data for Name: exclusion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exclusion (id, created_at, updated_at, deleted_at, description, tour_package_id) FROM stdin;
90f7cccd-c34d-4e9b-8ec9-6a557d55b325	2025-06-12 18:02:51.792166	2025-06-12 18:02:51.792174	\N	Personal expenses such as shopping, phone calls, or room service	41a30ee3-867c-43ab-8eb4-ecc18896c65c
ad75545a-4478-48ac-ade0-14ce785d2815	2025-06-12 18:02:51.792178	2025-06-12 18:02:51.792179	\N	Travel insurance	41a30ee3-867c-43ab-8eb4-ecc18896c65c
dc8a0980-820c-4cce-873f-070801574d27	2025-06-12 18:02:51.792182	2025-06-12 18:02:51.792183	\N	Additional excursions or activities not included in the itinerary	41a30ee3-867c-43ab-8eb4-ecc18896c65c
c6e26127-b569-4001-9d46-db73a3a8d904	2025-06-12 18:02:51.792185	2025-06-12 18:02:51.792186	\N	Tips and gratuities	41a30ee3-867c-43ab-8eb4-ecc18896c65c
\.


--
-- Data for Name: google_verification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.google_verification (id, created_at, updated_at, deleted_at, state, auth_type) FROM stdin;
f62b96b6-0faf-4c34-8b14-f4a04e2cd490	2025-05-13 14:13:16.184717	2025-05-13 14:13:16.185276	\N	XG770dCQn67bST0G1QwR85NR7gTF58	Login
313c930c-85c7-4e43-b666-332bf43c1f26	2025-05-13 14:31:21.736888	2025-05-13 14:31:21.737097	\N	yJ3lYlvFWEY92ubC1mdM9iVy0ssAcN	Login
c8fa6dde-96c0-4030-8f72-9f8190e2baff	2025-05-13 14:34:03.375958	2025-05-13 14:34:03.376043	\N	J0a3IW4kHJ2vOPWquXFPmhW2RkQsea	Login
0169fb8d-fd63-458b-aa1b-9046a98afa4b	2025-05-13 14:52:19.856934	2025-05-13 14:52:19.857458	\N	FTxBTERIYfYIXMAqNaVeYhGJFjx0zT	Login
8127563b-00bd-4cb9-8e1d-077aba8ef9e1	2025-05-13 15:03:20.235775	2025-05-13 15:03:20.236873	\N	0IGKDycYa1HJ52IgN4rfCHex1xqGtp	Login
3cd8e678-f9b5-4ac1-9322-905e9f1416e2	2025-05-13 15:16:55.205158	2025-05-13 15:16:55.206119	\N	9HXfprygU1Dzg57IzuenPcKauiRBoE	Login
1dbe3f7f-6f49-4322-a9d7-a076dd5c866a	2025-05-13 15:19:40.548436	2025-05-13 15:19:40.548837	\N	TxX8dlKmrowGlo5XoXyJ2iGJWGjhKL	Login
2156ec40-d7f9-47e8-93c8-fcb990004fa6	2025-05-13 15:36:25.44597	2025-05-13 15:36:25.446045	\N	fVSEpAB348vNwcSGeF1CiBgHnR5mGC	Login
74774479-e141-444d-87b2-94d93e72c4af	2025-05-13 15:36:34.704325	2025-05-13 15:36:34.704343	\N	RdlfHohIRo628A5T8opBtTelcte3pw	Login
93f73f07-9698-4b11-970d-322ef0a3f448	2025-05-13 15:36:51.466789	2025-05-13 15:36:51.466797	\N	NyYN0NytpZIziYssk9V98q9pIsr0tt	Login
6aeac818-ef65-40e2-a55a-4e1577182c07	2025-05-13 15:37:16.725413	2025-05-13 15:37:16.725423	\N	i63vR0GGatymxwGbVp7R4W6un7kIa1	Login
011b215c-8f63-4be6-94cb-4962f080360b	2025-05-14 10:28:14.992186	2025-05-14 10:28:14.992261	\N	8GZA3EAp5mvtUDtUrinIHCQX5WQWCl	Login
e7c4ddd0-5137-4b6d-ab01-dd44770ba59f	2025-05-14 10:33:00.324753	2025-05-14 10:33:00.324766	\N	H3MVUCzEfkinSVBRPY59sU0yex8cts	Login
12426f5a-b4da-4d0d-a2c6-e39d706f170d	2025-05-14 10:33:24.3084	2025-05-14 10:33:24.30841	\N	EVBNnUxQ8k8bqH4cNeCj0vAxoJU2nL	Login
c225d8e2-e41e-476b-aa8d-34960be34b7d	2025-05-14 10:33:46.074361	2025-05-14 10:33:46.07437	\N	jwBEwYtovmpXM8Yflz8tJcIpj9RKmw	Register
76d99a71-8df4-4337-817d-d82b303da869	2025-05-14 10:34:26.531493	2025-05-14 10:34:26.531501	\N	2JEQUG7jFt2jK3xqoBSuZKpg1Cl209	Login
3ad36f65-81c2-4dc3-bd0b-ac36342275f6	2025-05-14 10:35:58.827022	2025-05-14 10:35:58.82703	\N	X2CcHukyeEmLnOflT7Pr8TlX4Yyfbk	Login
6434c24c-2b65-4cca-980f-783039d60715	2025-05-14 10:36:16.27426	2025-05-14 10:36:16.274271	\N	7Xj55WgspjOm6s4qCiSYtdhJDcm2vs	Login
5941ff60-aea2-4b6b-a226-afac4967ce52	2025-05-14 10:36:46.931109	2025-05-14 10:36:46.931117	\N	PxrOKQ65rCrDNjee8lrzGBoDfugL0q	Login
a2430e0e-d499-4ec5-a735-c632dab975c0	2025-05-14 10:38:21.528021	2025-05-14 10:38:21.528111	\N	rgeWenEVonenncHRsYKfSXCu1qpAeH	Login
c95221de-858d-433a-8a30-4c12f7a6022a	2025-05-14 10:40:06.493465	2025-05-14 10:40:06.493559	\N	qGX4xW6L85Hxe1lqkuBdrrKOzruBLj	Login
e58c1a93-bb90-48be-b823-5a597ca9fe9a	2025-05-14 10:45:16.129977	2025-05-14 10:45:16.129985	\N	NcFbQCb6688JDyQDphIwPe1f1zYMvF	Login
5b425fdb-7f76-4f3c-b933-af83a01bcf53	2025-05-14 10:45:40.018888	2025-05-14 10:45:40.018896	\N	B6QlukDu8fdoZ8JkYCly8OTXsVYg51	Login
b6a26bb7-07a7-47b9-b5a9-3dbf7aceb3e2	2025-05-14 10:47:35.089856	2025-05-14 10:47:35.08987	\N	6bevrBdKLmnRg6nXhOtOfmFjdv8gTN	Login
f5bea6ad-fec1-440d-b4b3-69911d99e94b	2025-05-14 10:48:02.327828	2025-05-14 10:48:02.327837	\N	4mALOklwXPnCJ9OHXRCxlUCkBW9CgV	Login
d9de578d-ec49-4c5d-9df0-baeb52689498	2025-05-14 10:53:51.328143	2025-05-14 10:53:51.328151	\N	tB4r6id9aQYb5I6hokUbmCw5WByRz7	Login
a47bbd44-949d-47d8-9801-a8a040333103	2025-05-14 10:55:17.707631	2025-05-14 10:55:17.707641	\N	reLinCcFm3MA2HhM6ltdWTf6DlWq1O	Login
ce332756-db96-4c56-afe7-762740ebccdf	2025-05-14 10:56:17.047253	2025-05-14 10:56:17.047265	\N	0yXFVdDMLyTi0p9W8X91aUSf2pr9bg	Login
e4fd8a84-7273-4100-b9c8-7e45d532a0b1	2025-05-14 10:58:54.101252	2025-05-14 10:58:54.101319	\N	4FejQV94AjSWAh0NixmJFCHymMflJy	Login
aa972931-e761-4a1e-81e8-3fb7e4bb2374	2025-05-14 11:04:32.439704	2025-05-14 11:04:32.439713	\N	FVOW6b7sSbnCrQR0n0DZTEqihQDgmr	Login
faeccd9e-2b27-4569-9c4a-11acf3c2b325	2025-05-14 11:07:41.570572	2025-05-14 11:07:41.570581	\N	BSrqzCcTFDxKiSN9mBkhppDtUPHRaD	Login
\.


--
-- Data for Name: inclusion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inclusion (id, created_at, updated_at, deleted_at, description, tour_package_id) FROM stdin;
58dc904b-4029-4f0b-9c96-b6516c7cc275	2025-06-12 18:02:51.798185	2025-06-12 18:02:51.798194	\N	Return Economy Flight on Kenya Airways from Lagos	41a30ee3-867c-43ab-8eb4-ecc18896c65c
e997bdf8-2ded-488a-8f36-a7fc444c81ac	2025-06-12 18:02:51.798199	2025-06-12 18:02:51.7982	\N	Kenya ETA	41a30ee3-867c-43ab-8eb4-ecc18896c65c
2db52612-e184-44d0-97f3-29c6b482c808	2025-06-12 18:02:51.798203	2025-06-12 18:02:51.798204	\N	Protocol Service	41a30ee3-867c-43ab-8eb4-ecc18896c65c
a18cedc3-f057-4153-a0f2-226e7bad1c54	2025-06-12 18:02:51.798208	2025-06-12 18:02:51.798208	\N	Return Airport Transfer	41a30ee3-867c-43ab-8eb4-ecc18896c65c
49e79775-41a6-4649-beda-6787c6bf1f11	2025-06-12 18:02:51.798212	2025-06-12 18:02:51.798212	\N	3 Nights in 4-star Resort in Mombasa (PrideInn Flamingo) with daily Breakfast, Lunch, and Dinner	41a30ee3-867c-43ab-8eb4-ecc18896c65c
7e654691-cc91-4952-9ab3-fcaab34b3701	2025-06-12 18:02:51.798215	2025-06-12 18:02:51.798216	\N	2 Nights in 4-star Hotel in Nairobi (Holiday Inn) with daily Breakfast	41a30ee3-867c-43ab-8eb4-ecc18896c65c
88845374-403b-47f8-854c-5efa5ccb41be	2025-06-12 18:02:51.798219	2025-06-12 18:02:51.79822	\N	Visit to Nairobi National Park	41a30ee3-867c-43ab-8eb4-ecc18896c65c
f54e4143-f7b3-417b-ba30-a110dfbe172d	2025-06-12 18:02:51.798223	2025-06-12 18:02:51.798224	\N	Visit to Giraffe Center	41a30ee3-867c-43ab-8eb4-ecc18896c65c
f42fbb3e-155a-4604-82c8-798c8b62c948	2025-06-12 18:02:51.798227	2025-06-12 18:02:51.798227	\N	Lunch at Carnivore Restaurant	41a30ee3-867c-43ab-8eb4-ecc18896c65c
15940712-ca71-456f-b583-cd387b1d770d	2025-06-12 18:02:51.79823	2025-06-12 18:02:51.798231	\N	Visit to Wild Waters Mombasa	41a30ee3-867c-43ab-8eb4-ecc18896c65c
1817e137-b8d3-4e2b-bdd6-547616ee4785	2025-06-12 18:02:51.798234	2025-06-12 18:02:51.798235	\N	Dolphin Watch at Kisite Marine Park and Wasini Island with Lunch	41a30ee3-867c-43ab-8eb4-ecc18896c65c
\.


--
-- Data for Name: itineraries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itineraries (id, created_at, updated_at, deleted_at, tour_package_id, title, day_number, description) FROM stdin;
75e7990e-eff9-48fc-91ff-83471a8e86fe	2025-06-12 18:02:51.802274	2025-06-12 18:02:51.802283	\N	41a30ee3-867c-43ab-8eb4-ecc18896c65c	Arrival in Nairobi + Check-in at Holiday Inn	1	Arrive in Nairobi via return economy flight on Kenya Airways from Lagos. Enjoy protocol service and airport transfer to the Holiday Inn hotel. Check in and relax at the 4-star hotel with modern amenities. Evening at leisure.
274f2a4e-94ad-4929-9273-6e1327806b28	2025-06-12 18:02:51.802289	2025-06-12 18:02:51.80229	\N	41a30ee3-867c-43ab-8eb4-ecc18896c65c	Visit to Nairobi National Park & Giraffe Center	2	After breakfast, embark on an exciting day exploring Nairobi’s rich wildlife. Begin with a safari drive through Nairobi National Park to spot lions, rhinos, giraffes, and more. Later, visit the Giraffe Center for an up-close encounter with endangered Rothschild giraffes. Evening at leisure.
1e66972d-857d-40e9-bd06-08af57fbfb85	2025-06-12 18:02:51.802293	2025-06-12 18:02:51.802294	\N	41a30ee3-867c-43ab-8eb4-ecc18896c65c	Lunch at Carnivore Restaurant + Transfer to Mombasa	3	Enjoy a unique and hearty lunch at Nairobi’s famous Carnivore Restaurant. Afterward, transfer to the airport for your flight to Mombasa. Upon arrival, you’ll be taken to PrideInn Flamingo Resort for check-in and dinner. Relax and enjoy the coastal vibes.
20ee0262-d2a5-43a6-9d15-5030630342a1	2025-06-12 18:02:51.802298	2025-06-12 18:02:51.802298	\N	41a30ee3-867c-43ab-8eb4-ecc18896c65c	Dolphin Watching + Kisite Marine Park & Wasini Island Tour	4	After breakfast, head out for a magical day trip to Kisite Marine Park. Spot playful dolphins, snorkel in the clear waters, and enjoy a traditional Swahili seafood lunch on Wasini Island. Return to the resort for dinner and relaxation.
38ff7fd0-8422-450b-9eeb-c3f1c259c1d8	2025-06-12 18:02:51.802301	2025-06-12 18:02:51.802302	\N	41a30ee3-867c-43ab-8eb4-ecc18896c65c	Family Fun at Wild Waters Mombasa	5	Spend a thrilling day at Wild Waters, Mombasa’s largest water park. With rides, slides, and activities for all ages, it's a day of unforgettable fun for the whole family. Return to the resort in the evening for dinner and rest.
029c4c4e-625b-4a44-84ad-b4fb756e98a4	2025-06-12 18:02:51.802305	2025-06-12 18:02:51.802306	\N	41a30ee3-867c-43ab-8eb4-ecc18896c65c	Departure from Mombasa	6	After breakfast, check out from the resort. You’ll be transferred to Mombasa airport for your return Kenya Airways flight to Lagos via Nairobi. End of tour.
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regions (id, created_at, updated_at, deleted_at, name, destination_id) FROM stdin;
770cfc0b-15f1-4cad-b74a-a087ea89d216	2024-12-15 00:19:28.431111	2024-12-15 00:19:28.431135	\N	Ashanti	\N
88aeb123-0ece-4259-bbb2-8d4d8be602a0	2024-12-15 00:19:56.357869	2024-12-15 00:19:56.357882	\N	Central	\N
e945cdcf-0d50-476c-afa0-f26201729560	2024-12-15 00:20:00.514338	2024-12-15 00:20:00.514354	\N	Eastern	\N
d743fecd-1aa7-4ed9-89b9-b32c5590d5e5	2024-12-15 00:20:19.204369	2024-12-15 00:20:19.204388	\N	Greater Accra	\N
623b3604-b735-4fc8-950d-2c8c7448f570	2024-12-15 00:20:30.34808	2024-12-15 00:20:30.348104	\N	Northern	\N
1b562eb8-90d0-4b60-a458-82b320ef68c7	2024-12-15 00:20:36.662622	2024-12-15 00:20:36.662638	\N	Oti	\N
1e4cb921-15bf-4f53-a002-16dafc7a57d6	2024-12-15 00:20:50.581034	2024-12-15 00:20:50.581052	\N	Upper East	\N
b36cc9fc-18e9-404a-b557-d948b8fc8410	2024-12-15 00:20:56.366474	2024-12-15 00:20:56.366499	\N	Upper West	\N
3845d341-59dc-427a-99de-b2f6a5076d6b	2024-12-15 00:21:04.965985	2024-12-15 00:21:04.966002	\N	Volta	\N
631dea86-c927-4e90-ac94-86dcfd806cec	2024-12-15 00:21:17.501978	2024-12-15 00:21:17.502501	\N	Western	\N
2ac36ee6-66f7-400f-baec-f9be9bb3602a	2024-12-15 00:36:12.197323	2024-12-15 00:36:12.197348	\N	Ahafo	\N
efd40c92-d7d0-4caa-b2d4-a5a76be33b5e	2024-12-15 00:19:39.715414	2024-12-19 10:04:09.597215	\N	Bono	\N
17da1b36-85c9-45be-a1e0-7ff1a62faeba	2025-02-19 08:34:40.976902	2025-02-19 08:34:40.977116	\N	Bono East	\N
73a32b27-99f1-465b-b723-bcbc090edcfc	2025-02-19 09:08:02.276603	2025-02-19 09:08:02.276611	\N	North East	\N
f7ebaf34-52a1-4ca1-8d86-0c15e89c3d76	2025-02-19 09:11:56.590018	2025-02-19 09:11:56.590028	\N	Savannah	\N
d64a7549-8ce9-4296-b4c6-0b2d37d6de77	2025-02-19 09:21:09.954953	2025-02-19 09:21:09.954984	\N	Western North	\N
\.


--
-- Data for Name: termsconditions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.termsconditions (id, created_at, updated_at, deleted_at, title, description, tour_package_id) FROM stdin;
088d2655-653b-481b-ab79-6ac58a2ebbdb	2025-06-12 18:02:51.807326	2025-06-12 18:02:51.807385	\N	Booking & Payment	A 50% deposit is required to confirm booking. Full payment must be made at least 14 days before departure.	41a30ee3-867c-43ab-8eb4-ecc18896c65c
472e9ff4-dbf9-46b0-9473-f12290dfdb6d	2025-06-12 18:02:51.807397	2025-06-12 18:02:51.807398	\N	Visa Requirements	All travelers must possess a valid Kenya ETA prior to departure. Assistance with application will be provided.	41a30ee3-867c-43ab-8eb4-ecc18896c65c
76a416c7-9316-4ac4-bae7-37d70aeaa8a3	2025-06-12 18:02:51.807402	2025-06-12 18:02:51.807402	\N	Cancellation Policy	Cancellations made less than 14 days before travel may incur penalties. Refunds are subject to supplier terms.	41a30ee3-867c-43ab-8eb4-ecc18896c65c
b3b95867-426f-4e41-b1c0-9ab241ceebe4	2025-06-12 18:02:51.807406	2025-06-12 18:02:51.807407	\N	Child Policy	Children must be accompanied by at least one adult. Age limits may apply for some activities.	41a30ee3-867c-43ab-8eb4-ecc18896c65c
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
41a30ee3-867c-43ab-8eb4-ecc18896c65c	2025-06-12 18:02:51.772778	2025-06-12 18:02:51.773203	\N	Kenya Family Package (Mombasa and Nairobi)	kenya-family-package-mombasa-nairobi	Explore wild Nairobi and sunny Mombasa in 6 unforgettable days. Safari at Nairobi National Park, feed giraffes, feast at Carnivore, snorkel with dolphins, and splash around Wild Waters Mombasa. Flights, hotels, meals & transfers—all covered. Just pack your bags and make memories that last a lifetime!	6	5	USD	7100.00	\N	4	2	2	f	\N	\N	\N	PER_FAMILY	Family Package	https://res.cloudinary.com/djjoidnbp/image/upload/v1749743381/mombasa_xtbkoo.jpg	\N
\.


--
-- Data for Name: tour_sites_region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_sites_region (id, created_at, updated_at, deleted_at, name, description, price, region_id) FROM stdin;
f8ef837e-f850-4202-95c8-8546312ce134	2024-12-17 12:55:31.279695	2024-12-17 12:55:31.279717	\N	Elmina Castle	\N	72000	88aeb123-0ece-4259-bbb2-8d4d8be602a0
ed1de216-962f-43d5-bf5d-9adfdaa2e5b4	2024-12-17 12:55:50.222711	2024-12-17 12:55:50.222723	\N	Kakum National Park	\N	55000	88aeb123-0ece-4259-bbb2-8d4d8be602a0
5d85a50b-3454-47fa-a707-2d2f46434d0e	2024-12-17 21:50:39.310045	2024-12-17 21:50:39.310129	\N	Akosombo Dam	\N	77000	e945cdcf-0d50-476c-afa0-f26201729560
9f4b4f99-2998-4113-b764-b70cba0a5fa3	2024-12-17 21:50:54.360187	2024-12-17 21:50:54.360197	\N	Boti Falls	\N	89000	e945cdcf-0d50-476c-afa0-f26201729560
e7da5a8f-5bc6-4296-821e-431d79d466ff	2024-12-17 21:52:59.056248	2024-12-17 21:52:59.056265	\N	Kwame Nkrumah Memorial Park	\N	79000	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
2d27af1e-f695-4acd-91fd-df3ebfa97568	2024-12-17 21:57:34.093162	2024-12-17 21:57:34.093181	\N	Kyabobo National Park	\N	79000	1b562eb8-90d0-4b60-a458-82b320ef68c7
5837a729-1655-460b-afee-b2cd544cc07d	2024-12-17 22:00:55.721098	2024-12-17 22:00:55.721156	\N	Gwollu Defense Wall	\N	45000	b36cc9fc-18e9-404a-b557-d948b8fc8410
f24bc191-83ba-4eba-b119-b043df621c27	2024-12-17 22:01:48.298165	2024-12-17 22:01:48.298181	\N	Wechiau Hippo Sanctuary	\N	88000	b36cc9fc-18e9-404a-b557-d948b8fc8410
32d3d797-f2a6-4c69-bfd7-67457aee7108	2024-12-17 22:03:57.011426	2024-12-17 22:03:57.011437	\N	Tafi Atome Monkey Sanctuary	\N	150000	3845d341-59dc-427a-99de-b2f6a5076d6b
7aa5c922-7213-4e96-80a8-ff3068a11b86	2025-02-19 08:03:41.799725	2025-02-19 08:03:41.799734	\N	Oxford Street	Oxford Street	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
6dcddc35-dddc-4b4f-b1f9-d8fc9dc7cdf1	2025-02-19 08:04:05.738792	2025-02-19 08:04:05.738803	\N	Shai Hills Resource Reserve	Shai Hills Resource Reserve	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
8b26d313-6a13-4f44-b5a7-0c47c8fdd611	2025-02-19 08:04:21.532425	2025-02-19 08:04:21.532432	\N	Tema Fishing Harbour	Tema Fishing Harbour	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
a842b650-ccf0-4f46-93c0-b8dd18004da4	2025-02-19 08:04:47.811164	2025-02-19 08:04:47.811204	\N	The Cocoloko Beach	The Cocoloko Beach	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
8486eec5-ecf6-4070-ad6c-9bf397406fe6	2024-12-17 12:52:26.618194	2024-12-17 23:01:15.260824	\N	Manhyia Palace Museum		120000	770cfc0b-15f1-4cad-b74a-a087ea89d216
2e97f83f-ca43-4ab4-ac3b-a3958c453153	2025-02-19 08:05:04.874673	2025-02-19 08:05:04.874681	\N	The Independence Square and Arch	The Independence Square and Arch	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
7ac03042-f320-4865-bf48-8dbffcbcaf9e	2025-02-19 08:05:22.415073	2025-02-19 08:05:22.41508	\N	The National Mosque of Ghana	The National Mosque of Ghana	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
e33e7368-7779-4c15-adf8-06cc356226aa	2024-12-17 12:55:16.354407	2024-12-17 12:55:16.354419	\N	The Cape Coast Castle	\N	63000	88aeb123-0ece-4259-bbb2-8d4d8be602a0
b394e64c-31c1-4a5d-b821-389bc8dad86d	2025-02-19 07:59:55.728804	2025-02-19 07:59:55.72891	\N	Bliss Family Entertainment	Bliss Family Entertainment	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
c706410c-31f4-4f03-b50c-b5d8d9fdf50f	2025-02-19 08:00:42.747939	2025-02-19 08:00:42.747948	\N	Bojo Beach	Bojo Beach	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
998c6be0-b44f-432b-b5fd-b73aa80ba6f1	2025-02-19 08:01:04.619696	2025-02-19 08:01:04.619704	\N	Christianborg Castle	Christianborg Castle	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
261e0fc3-30e8-4c22-a11e-dc4a94aa4e94	2025-02-19 08:01:52.608838	2025-02-19 08:01:52.608845	\N	Dodowa Forest	Dodowa Forest	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
f7e0a9d9-752b-472c-bd7a-bb61e6d7e849	2025-02-19 08:02:18.421887	2025-02-19 08:02:18.421894	\N	Jamestown Lighthouse Community	Jamestown Lighthouse Community	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
9162c459-ac01-4d69-94ae-f8f6d9c91038	2025-02-19 08:02:33.619418	2025-02-19 08:02:33.619426	\N	Kokrobite Beach	Kokrobite Beach	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
cb53ca65-e203-4c94-9f02-e55dd5722a9d	2025-02-19 08:03:15.425706	2025-02-19 08:03:15.425714	\N	Legon Botanical Garden	Legon Botanical Garden	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
42ccfa4b-583c-45d9-9f6c-d0f00ef20736	2025-02-19 08:05:36.453233	2025-02-19 08:05:36.453241	\N	The National Museum	The National Museum	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
eabe309c-5ebe-4e68-9717-a0d455f0fff4	2025-02-19 08:05:54.918778	2025-02-19 08:05:54.918786	\N	Tsenku Waterfall	Tsenku Waterfall	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
3bd98a10-3f65-49ce-a7b2-703fefd7ff13	2025-02-19 08:06:09.27449	2025-02-19 08:06:09.274499	\N	W.E.B Du Bois Center	W.E.B Du Bois Center	0	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
18cdbcf3-4d9d-4d35-bf2e-6fc310982287	2025-02-19 08:07:23.800193	2025-02-19 08:07:23.800201	\N	Bibiri Waterfall	Bibiri Waterfall	0	2ac36ee6-66f7-400f-baec-f9be9bb3602a
984186b4-4fa2-4961-a7d0-b983fc0590bc	2025-02-19 08:07:29.387481	2025-02-19 08:07:29.387494	\N	Asumura White Necked Rock Fowl Conservation	Asumura White Necked Rock Fowl Conservation	0	2ac36ee6-66f7-400f-baec-f9be9bb3602a
125e6279-c84c-41ef-a877-78f902633d1d	2025-02-19 08:07:51.534623	2025-02-19 08:07:51.534633	\N	Mim Buobuoyem Caves and Bat Colony	Mim Buobuoyem Caves and Bat Colony	0	2ac36ee6-66f7-400f-baec-f9be9bb3602a
0d58662f-7b01-44ca-80ae-661a6f0f9caa	2025-02-19 08:08:28.543515	2025-02-19 08:08:28.543523	\N	Bobiri Forest and Butterfly Sanctuary	Bobiri Forest and Butterfly Sanctuary	0	770cfc0b-15f1-4cad-b74a-a087ea89d216
80553df3-bb9a-467b-881e-7f9ddad6ca99	2025-02-19 08:08:49.683683	2025-02-19 08:08:49.683691	\N	Bonwire (Kente Weaving Village)	Bonwire (Kente Weaving Village)	0	770cfc0b-15f1-4cad-b74a-a087ea89d216
22314108-4e0d-4fab-bdc8-f2a40f6c2f9d	2025-02-19 08:09:06.071691	2025-02-19 08:09:06.071699	\N	Lake Bosomtwi	Lake Bosomtwi	0	770cfc0b-15f1-4cad-b74a-a087ea89d216
1b738a6f-b61f-497e-bdfb-dd0ee772fd21	2024-12-17 21:55:32.522128	2024-12-17 21:55:32.522166	\N	Daboya Fugu Weaving Village	\N	127000	623b3604-b735-4fc8-950d-2c8c7448f570
d1eb279a-ccaf-4764-bf2e-b6c3da5677fb	2024-12-17 21:59:26.724475	2024-12-17 21:59:26.724486	\N	Paga Crocodile Park	\N	77000	1e4cb921-15bf-4f53-a002-16dafc7a57d6
d0199613-aec4-4e52-be95-026b6deaee07	2024-12-17 21:59:42.07832	2024-12-17 21:59:42.078335	\N	Sirigu Pottery and Art	\N	67000	1e4cb921-15bf-4f53-a002-16dafc7a57d6
85675642-4327-43ab-8b77-804a529cb747	2024-12-17 22:04:19.721086	2024-12-17 22:04:19.721108	\N	Wli Waterfall	\N	52000	3845d341-59dc-427a-99de-b2f6a5076d6b
d38b9529-6cf7-4ff3-95d7-6a026c335440	2025-02-19 08:16:16.170017	2025-02-19 08:16:16.170025	\N	Owabi Wildlife Sanctuary	Owabi Wildlife Sanctuary	0	770cfc0b-15f1-4cad-b74a-a087ea89d216
3434bf8e-72c1-4ef6-8c1e-4b7f2747432a	2025-02-19 08:16:37.11539	2025-02-19 08:16:37.115401	\N	Ntonso Adinkra Cloth Village	Ntonso Adinkra Cloth Village	0	770cfc0b-15f1-4cad-b74a-a087ea89d216
146c53f0-561b-43ad-a485-c2d966b5e84d	2025-02-19 08:37:09.811254	2025-02-19 08:37:09.811262	\N	Kintampo Waterfall	Kintampo Waterfall	0	17da1b36-85c9-45be-a1e0-7ff1a62faeba
63c7b994-e040-42fc-a63b-53db487f31f9	2025-02-19 08:37:39.27396	2025-02-19 08:37:39.27397	\N	Tano-Boase Sacred Grove	Tano-Boase Sacred Grove	0	17da1b36-85c9-45be-a1e0-7ff1a62faeba
3e92442e-1432-4ca4-8cd1-d90ab8ccfb7a	2025-02-19 08:40:59.879441	2025-02-19 08:40:59.879453	\N	Buabeng-Fiema Monkey Sanctuary	Buabeng-Fiema Monkey Sanctuary	0	17da1b36-85c9-45be-a1e0-7ff1a62faeba
be8e3704-0989-4410-be7c-8e735b29da2c	2025-02-19 08:45:04.269801	2025-02-19 08:45:04.269913	\N	Bui National Park	Bui National Park	0	efd40c92-d7d0-4caa-b2d4-a5a76be33b5e
e25683e1-5400-4103-a74e-5e2162834b1d	2025-02-19 08:46:29.148194	2025-02-19 08:46:29.148212	\N	Assin-Manso Ancestral Slave Park	Assin-Manso Ancestral Slave Park	0	88aeb123-0ece-4259-bbb2-8d4d8be602a0
d53993b0-cb52-434f-93fc-bc490e1a9271	2025-02-19 08:50:15.401724	2025-02-19 08:50:15.401736	\N	Fort Amsterdam	Fort Amsterdam	0	88aeb123-0ece-4259-bbb2-8d4d8be602a0
59114f5c-4b8d-44fd-9b6c-e04f355650b7	2025-02-19 08:58:20.483738	2025-02-19 08:58:20.48385	\N	Abetifi Stone Age Park	Abetifi Stone Age Park	0	e945cdcf-0d50-476c-afa0-f26201729560
5fbc3d82-9469-418a-bdb6-c21f3f0696c5	2025-02-19 08:58:50.300636	2025-02-19 08:58:50.300643	\N	Aburi Botanical Garden	Aburi Botanical Garden	0	e945cdcf-0d50-476c-afa0-f26201729560
2b056cb2-1cef-4e98-a482-8b3123477ea0	2025-02-19 09:00:40.656392	2025-02-19 09:00:40.656437	\N	Akaa Waterfall	Akaa Waterfall	0	e945cdcf-0d50-476c-afa0-f26201729560
4bc11e94-5750-4acd-aed3-33687f131376	2025-02-19 09:05:32.476115	2025-02-19 09:05:32.476142	\N	Bunso Eco Park	Bunso Eco Park	0	e945cdcf-0d50-476c-afa0-f26201729560
4220006f-99c2-4abc-8399-3d41de94da0a	2025-02-19 09:05:46.42469	2025-02-19 09:05:46.424698	\N	The Umbrella Rock	The Umbrella Rock	0	e945cdcf-0d50-476c-afa0-f26201729560
6f22b5e3-926a-4e81-943d-56a549cb864d	2025-02-19 09:06:03.932202	2025-02-19 09:06:03.932214	\N	The Bead Factory	The Bead Factory	0	e945cdcf-0d50-476c-afa0-f26201729560
d2af43a3-3d9e-4075-b78b-aa31df28b8c8	2025-02-19 09:08:37.598891	2025-02-19 09:08:37.598898	\N	Bukpunrugu Africa Map Shaped Rock	Bukpunrugu Africa Map Shaped Rock	0	73a32b27-99f1-465b-b723-bcbc090edcfc
b9f067c7-4bb5-4ce6-9662-390149ff4c5c	2025-02-19 09:08:56.846285	2025-02-19 09:08:56.846292	\N	Nakpanduri Waterfall	Nakpanduri Waterfall	0	73a32b27-99f1-465b-b723-bcbc090edcfc
e0bb1a90-6ecb-417b-a079-358029708083	2025-02-19 09:09:22.26623	2025-02-19 09:09:22.266237	\N	Nalerigu Defence Wall	Nalerigu Defence Wall	0	73a32b27-99f1-465b-b723-bcbc090edcfc
532bf1eb-e4c9-4aaf-8c53-0f896b032d39	2025-02-19 09:12:37.771986	2025-02-19 09:12:37.771994	\N	Larabanga Mosque	Larabanga Mosque	0	f7ebaf34-52a1-4ca1-8d86-0c15e89c3d76
1849e83e-e691-41b8-938e-3abdcf453669	2025-02-19 09:12:55.765651	2025-02-19 09:12:55.765658	\N	Mognori Eco-Village	Mognori Eco-Village	0	f7ebaf34-52a1-4ca1-8d86-0c15e89c3d76
4426c562-85c9-4f16-bdfd-d9eff596a6b2	2025-02-19 09:13:05.715246	2025-02-19 09:13:05.715255	\N	Mole National Park	Mole National Park	0	f7ebaf34-52a1-4ca1-8d86-0c15e89c3d76
dc0d3414-3028-425e-b200-6fca15339509	2025-02-19 09:15:26.407517	2025-02-19 09:15:26.407526	\N	Tengzug Shrine	Tengzug Shrine	0	1e4cb921-15bf-4f53-a002-16dafc7a57d6
d1b5e442-6695-4ce5-b137-d7fee2255a43	2025-02-19 09:17:14.689431	2025-02-19 09:17:14.689439	\N	Nakore Mosque	Nakore Mosque	0	b36cc9fc-18e9-404a-b557-d948b8fc8410
86d0d625-3d83-49df-8fa7-f860a1737d60	2025-02-19 09:18:25.730586	2025-02-19 09:18:25.730609	\N	Amedzofe Canopy Walk	Amedzofe Canopy Walk	0	3845d341-59dc-427a-99de-b2f6a5076d6b
290e7f29-d55e-422b-ac2f-3d6b70002188	2025-02-19 09:18:46.888937	2025-02-19 09:18:46.888953	\N	Aqua Safari	Aqua Safari	0	3845d341-59dc-427a-99de-b2f6a5076d6b
15af0ed4-4e3f-448c-b9c0-7aff9aec3664	2025-02-19 09:19:05.996175	2025-02-19 09:19:05.996182	\N	Kpando Pottery	Kpando Pottery	0	3845d341-59dc-427a-99de-b2f6a5076d6b
caeeba76-386f-472c-a647-b75ad2ecf8c1	2025-02-19 09:19:19.329325	2025-02-19 09:19:19.329334	\N	Mountain Afadja	Mountain Afadja	0	3845d341-59dc-427a-99de-b2f6a5076d6b
38f712e0-f9e4-45c9-bc9b-4fb5e6e37f50	2025-02-19 09:21:29.266176	2025-02-19 09:21:29.266247	\N	Bia National Park	Bia National Park	0	d64a7549-8ce9-4296-b4c6-0b2d37d6de77
80e619d3-d5b9-4375-bf3f-46054153612e	2025-02-19 09:22:12.459617	2025-02-19 09:22:12.459623	\N	Akatekyi Crocodile Pond	Akatekyi Crocodile Pond	0	631dea86-c927-4e90-ac94-86dcfd806cec
8fd62cdf-c67e-4bfd-b468-ba91b67636c9	2025-02-19 09:22:31.245333	2025-02-19 09:22:31.245341	\N	Busua Beach	Busua Beach	0	631dea86-c927-4e90-ac94-86dcfd806cec
c9cb3620-e834-4a9c-a0ba-c6553d551a32	2025-02-19 09:22:42.452165	2025-02-19 09:22:42.452181	\N	Fort Batenstein	Fort Batenstein	0	631dea86-c927-4e90-ac94-86dcfd806cec
3ee41010-b3fb-4416-8032-413016274cbf	2025-02-19 09:23:03.508145	2025-02-19 09:23:03.508162	\N	Fort Orange	Fort Orange	0	631dea86-c927-4e90-ac94-86dcfd806cec
3aca6941-dcd9-45a0-97d0-5416caef51c3	2025-02-19 09:23:32.58017	2025-02-19 09:23:32.580178	\N	Bisa Aberwa Museum	Bisa Aberwa Museum	0	631dea86-c927-4e90-ac94-86dcfd806cec
0e3f7162-52ea-4d9a-81ab-031dfa306f16	2025-02-19 09:23:55.471137	2025-02-19 09:23:55.471148	\N	Ankasa Conservative Area	Ankasa Conservative Area	0	631dea86-c927-4e90-ac94-86dcfd806cec
c6af1bce-b837-4984-89c3-8ce00328217c	2025-02-19 09:24:11.115574	2025-02-19 09:24:11.115582	\N	Cape Three Point Forest Reserve	Cape Three Point Forest Reserve	0	631dea86-c927-4e90-ac94-86dcfd806cec
5ab49b29-e024-4f3b-995c-91ff1fed14b1	2025-02-19 09:24:22.575251	2025-02-19 09:24:22.575264	\N	Nzulezu	Nzulezu	0	631dea86-c927-4e90-ac94-86dcfd806cec
5cb884f8-e150-408e-a9e3-ea52774c5c0a	2025-02-19 09:24:31.217927	2025-02-19 09:24:31.217935	\N	The Fort Metal Cross	The Fort Metal Cross	0	631dea86-c927-4e90-ac94-86dcfd806cec
\.


--
-- Data for Name: transportation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transportation (id, created_at, updated_at, deleted_at, name, price) FROM stdin;
58706fa6-b998-4022-a82b-e5a1ac65667d	2024-12-16 12:20:09.53813	2024-12-16 12:20:09.538138	\N	Bus	120000
0d8b713c-0e3d-4fbd-907b-323a9e7bc4ae	2024-12-16 12:21:28.321756	2024-12-16 12:21:28.321762	\N	Airplane	400000
85afb053-9985-4a6b-aca0-549a79e361d0	2024-12-16 12:21:36.631778	2024-12-16 12:21:36.631784	\N	Car	250000
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
2c3ecbcf-f27d-44d9-85cf-c2f549cc76ca	2025-04-20 03:16:33.8955	2025-04-20 03:16:33.895512	\N	Oluwatobiloba Agunloye	oluwatobilobagunloye@gmail.com	\N	\N	google	t	\N	f	t	2025-04-20 03:16:33.896755+01
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

