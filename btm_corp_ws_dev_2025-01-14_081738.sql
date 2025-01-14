--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6 (Ubuntu 16.6-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.6 (Ubuntu 16.6-0ubuntu0.24.04.1)

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
-- Name: payment_status_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_status_type_enum AS ENUM (
    'FLUTTERWAVE',
    'STRIPE'
);


ALTER TYPE public.payment_status_type_enum OWNER TO postgres;

--
-- Name: tour_package_payment_status_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tour_package_payment_status_type_enum AS ENUM (
    'PAID',
    'NOT_PAID'
);


ALTER TYPE public.tour_package_payment_status_type_enum OWNER TO postgres;

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
    price double precision NOT NULL
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
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    name character varying(255) NOT NULL
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- Name: tour_package_accommodations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tour_package_accommodations (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    tour_package_id uuid,
    accommodation_id uuid
);


ALTER TABLE public.tour_package_accommodations OWNER TO postgres;

--
-- Name: tour_package_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tour_package_activities (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    tour_package_id uuid,
    activity_id uuid
);


ALTER TABLE public.tour_package_activities OWNER TO postgres;

--
-- Name: tour_package_tour_sites_region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tour_package_tour_sites_region (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    tour_package_id uuid,
    tour_sites_region_id uuid
);


ALTER TABLE public.tour_package_tour_sites_region OWNER TO postgres;

--
-- Name: tour_package_transportations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tour_package_transportations (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    tour_package_id uuid,
    transportation_id uuid
);


ALTER TABLE public.tour_package_transportations OWNER TO postgres;

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
-- Name: user_tour_packages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_tour_packages (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    active boolean,
    user_id uuid,
    payment_status public.tour_package_payment_status_type_enum,
    tx_ref character varying(255),
    payment_gateway character varying(255),
    currency character varying(255),
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

COPY public.activities (id, created_at, updated_at, deleted_at, name, description, price) FROM stdin;
d13bf8e2-4756-4181-a480-c1d058f2507a	2024-12-15 08:55:00.070218	2024-12-15 08:55:00.07023	\N	Boat Tours	\N	25000
b42281e7-183d-46c3-b4f2-d4afe99dec28	2024-12-15 09:00:26.974703	2024-12-15 09:00:26.974718	\N	Hiking	\N	12000
4096f370-a845-4feb-a319-778266c9f713	2024-12-15 09:00:59.459469	2024-12-15 09:00:59.459487	\N	Guided Historical Tours	\N	7000
0d8e26d6-e5b8-4002-8aa8-18e78e917f22	2024-12-15 09:01:18.767182	2024-12-15 09:01:18.767201	\N	Local Market Tours	\N	5000
21200677-7cfa-4cee-87b5-6a74d6b9c5da	2024-12-15 09:03:05.924802	2024-12-15 09:03:05.924825	\N	Photography	\N	8000
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
0a66b5460e32
\.


--
-- Data for Name: google_verification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.google_verification (id, created_at, updated_at, deleted_at, state, auth_type) FROM stdin;
1cb070b2-0774-4788-933c-141dbace6e69	2025-01-13 12:44:03.615288	2025-01-13 12:44:03.615898	\N	nauZkSEZsmkiGuT36xQ98q7UoAoNH2	Register
51e5026d-6736-4c50-bfa0-848cbab1dfc4	2025-01-13 13:05:13.934241	2025-01-13 13:05:13.934292	\N	4uldK0Ms2EBge5R3OVfqq1SQ3o469Y	Register
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regions (id, created_at, updated_at, deleted_at, name) FROM stdin;
770cfc0b-15f1-4cad-b74a-a087ea89d216	2024-12-15 00:19:28.431111	2024-12-15 00:19:28.431135	\N	Ashanti
88aeb123-0ece-4259-bbb2-8d4d8be602a0	2024-12-15 00:19:56.357869	2024-12-15 00:19:56.357882	\N	Central
e945cdcf-0d50-476c-afa0-f26201729560	2024-12-15 00:20:00.514338	2024-12-15 00:20:00.514354	\N	Eastern
d743fecd-1aa7-4ed9-89b9-b32c5590d5e5	2024-12-15 00:20:19.204369	2024-12-15 00:20:19.204388	\N	Greater Accra
623b3604-b735-4fc8-950d-2c8c7448f570	2024-12-15 00:20:30.34808	2024-12-15 00:20:30.348104	\N	Northern
1b562eb8-90d0-4b60-a458-82b320ef68c7	2024-12-15 00:20:36.662622	2024-12-15 00:20:36.662638	\N	Oti
1e4cb921-15bf-4f53-a002-16dafc7a57d6	2024-12-15 00:20:50.581034	2024-12-15 00:20:50.581052	\N	Upper East
b36cc9fc-18e9-404a-b557-d948b8fc8410	2024-12-15 00:20:56.366474	2024-12-15 00:20:56.366499	\N	Upper West
3845d341-59dc-427a-99de-b2f6a5076d6b	2024-12-15 00:21:04.965985	2024-12-15 00:21:04.966002	\N	Volta
631dea86-c927-4e90-ac94-86dcfd806cec	2024-12-15 00:21:17.501978	2024-12-15 00:21:17.502501	\N	Western
2ac36ee6-66f7-400f-baec-f9be9bb3602a	2024-12-15 00:36:12.197323	2024-12-15 00:36:12.197348	\N	Ahafo
efd40c92-d7d0-4caa-b2d4-a5a76be33b5e	2024-12-15 00:19:39.715414	2024-12-19 10:04:09.597215	\N	Bono
\.


--
-- Data for Name: tour_package_accommodations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_package_accommodations (id, created_at, updated_at, deleted_at, tour_package_id, accommodation_id) FROM stdin;
\.


--
-- Data for Name: tour_package_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_package_activities (id, created_at, updated_at, deleted_at, tour_package_id, activity_id) FROM stdin;
\.


--
-- Data for Name: tour_package_tour_sites_region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_package_tour_sites_region (id, created_at, updated_at, deleted_at, tour_package_id, tour_sites_region_id) FROM stdin;
\.


--
-- Data for Name: tour_package_transportations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_package_transportations (id, created_at, updated_at, deleted_at, tour_package_id, transportation_id) FROM stdin;
\.


--
-- Data for Name: tour_sites_region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_sites_region (id, created_at, updated_at, deleted_at, name, description, price, region_id) FROM stdin;
969a2d8d-8c94-4d55-9b88-3cdc5c1aa3ee	2024-12-17 12:20:37.551852	2024-12-17 12:20:37.551863	\N	Ahafo Ano South Forest Reserve	\N	300000	2ac36ee6-66f7-400f-baec-f9be9bb3602a
cea115da-b7fd-4d29-8731-8321f63c0896	2024-12-17 12:21:16.198423	2024-12-17 12:21:16.19845	\N	Hwidiem Grotto	\N	250000	2ac36ee6-66f7-400f-baec-f9be9bb3602a
5cb09cba-388e-48ae-94b8-e26a4dfa4afc	2024-12-17 12:51:28.789538	2024-12-17 12:51:28.79023	\N	Kumasi Central Market	\N	65000	770cfc0b-15f1-4cad-b74a-a087ea89d216
7e34d835-cc5f-4110-b3bc-250a120e2789	2024-12-17 12:52:05.666758	2024-12-17 12:52:05.666768	\N	Lake Bosomtwe	\N	100000	770cfc0b-15f1-4cad-b74a-a087ea89d216
f94040ad-c4e2-484c-8bad-ac4d9f617e9d	2024-12-17 12:53:30.578144	2024-12-17 12:53:30.578215	\N	Boabeng-Fiema Monkey Sanctuary	\N	170000	efd40c92-d7d0-4caa-b2d4-a5a76be33b5e
b05f4e0b-7586-46d0-9dd5-b833119bad97	2024-12-17 12:53:42.521248	2024-12-17 12:53:42.521266	\N	Fuller Falls	\N	150000	efd40c92-d7d0-4caa-b2d4-a5a76be33b5e
a61045ae-3ee0-4ecf-9557-9e280ffe1e45	2024-12-17 12:53:58.640084	2024-12-17 12:53:58.640108	\N	Kintampo Waterfalls	\N	200000	efd40c92-d7d0-4caa-b2d4-a5a76be33b5e
f8ef837e-f850-4202-95c8-8546312ce134	2024-12-17 12:55:31.279695	2024-12-17 12:55:31.279717	\N	Elmina Castle	\N	72000	88aeb123-0ece-4259-bbb2-8d4d8be602a0
ed1de216-962f-43d5-bf5d-9adfdaa2e5b4	2024-12-17 12:55:50.222711	2024-12-17 12:55:50.222723	\N	Kakum National Park	\N	55000	88aeb123-0ece-4259-bbb2-8d4d8be602a0
a1d5f35f-0280-4554-9b79-717979e9d5f8	2024-12-17 13:43:00.06902	2024-12-17 13:43:00.069714	\N	Aburi Botanical Gardens	\N	100000	e945cdcf-0d50-476c-afa0-f26201729560
5d85a50b-3454-47fa-a707-2d2f46434d0e	2024-12-17 21:50:39.310045	2024-12-17 21:50:39.310129	\N	Akosombo Dam	\N	77000	e945cdcf-0d50-476c-afa0-f26201729560
9f4b4f99-2998-4113-b764-b70cba0a5fa3	2024-12-17 21:50:54.360187	2024-12-17 21:50:54.360197	\N	Boti Falls	\N	89000	e945cdcf-0d50-476c-afa0-f26201729560
1bcdf72c-57c9-4322-9cf6-d049a1dc06b1	2024-12-17 21:51:10.362309	2024-12-17 21:51:10.362327	\N	Tetteh Quarshie Cocoa Farm	\N	120000	e945cdcf-0d50-476c-afa0-f26201729560
e1b6ec0e-7395-4369-b04d-6a51784ee36e	2024-12-17 21:52:37.389629	2024-12-17 21:52:37.389644	\N	Jamestown Lighthouse	\N	89000	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
e7da5a8f-5bc6-4296-821e-431d79d466ff	2024-12-17 21:52:59.056248	2024-12-17 21:52:59.056265	\N	Kwame Nkrumah Memorial Park	\N	79000	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
422a8399-bc7c-4df4-8c02-96f14eb76d0c	2024-12-17 21:53:21.223691	2024-12-17 21:53:21.2237	\N	Labadi Beach	\N	80000	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
d1db8603-cf0e-4e48-adcc-7b355044bd1f	2024-12-17 21:53:40.623001	2024-12-17 21:53:40.623017	\N	National Museum of Ghana	\N	65000	d743fecd-1aa7-4ed9-89b9-b32c5590d5e5
1b738a6f-b61f-497e-bdfb-dd0ee772fd21	2024-12-17 21:55:32.522128	2024-12-17 21:55:32.522166	\N	Daboya Smock Village	\N	127000	623b3604-b735-4fc8-950d-2c8c7448f570
12580be3-858b-488f-8868-13a9189290c7	2024-12-17 21:55:51.732258	2024-12-17 21:55:51.732276	\N	Larabanga Mosque	\N	57000	623b3604-b735-4fc8-950d-2c8c7448f570
692d5ba2-e063-4264-9dd3-95ad329c3a0a	2024-12-17 21:56:12.917182	2024-12-17 21:56:12.917193	\N	Mole National Park	\N	101000	623b3604-b735-4fc8-950d-2c8c7448f570
8ab52cc0-e71f-4878-89a4-2097d9104952	2024-12-17 21:56:25.460148	2024-12-17 21:56:25.460156	\N	Salaga Slave Market	\N	97000	623b3604-b735-4fc8-950d-2c8c7448f570
2d27af1e-f695-4acd-91fd-df3ebfa97568	2024-12-17 21:57:34.093162	2024-12-17 21:57:34.093181	\N	Kyabobo National Park	\N	79000	1b562eb8-90d0-4b60-a458-82b320ef68c7
d1fe0b57-4e84-4f54-a63b-55c620517b99	2024-12-17 21:57:49.701308	2024-12-17 21:57:49.701319	\N	Kpassa Waterfall	\N	99000	1b562eb8-90d0-4b60-a458-82b320ef68c7
8f57207f-fd73-443d-8c3e-4744fe52453c	2024-12-17 21:59:19.538208	2024-12-17 21:59:19.538217	\N	Bolgatanga Central Market	\N	97000	1e4cb921-15bf-4f53-a002-16dafc7a57d6
d1eb279a-ccaf-4764-bf2e-b6c3da5677fb	2024-12-17 21:59:26.724475	2024-12-17 21:59:26.724486	\N	Paga Crocodile Pond	\N	77000	1e4cb921-15bf-4f53-a002-16dafc7a57d6
d0199613-aec4-4e52-be95-026b6deaee07	2024-12-17 21:59:42.07832	2024-12-17 21:59:42.078335	\N	Sirigu Pottery Village	\N	67000	1e4cb921-15bf-4f53-a002-16dafc7a57d6
f4c0f5cc-bce8-40b3-83f0-ee9d5aabbaa0	2024-12-17 21:59:54.178201	2024-12-17 21:59:54.17821	\N	Tongo Hills	\N	87000	1e4cb921-15bf-4f53-a002-16dafc7a57d6
5837a729-1655-460b-afee-b2cd544cc07d	2024-12-17 22:00:55.721098	2024-12-17 22:00:55.721156	\N	Gwollu Defense Wall	\N	45000	b36cc9fc-18e9-404a-b557-d948b8fc8410
9286dc45-9e16-453c-9b99-5609540de7fa	2024-12-17 22:01:19.366371	2024-12-17 22:01:19.366387	\N	Sankana Caves	\N	96000	b36cc9fc-18e9-404a-b557-d948b8fc8410
37ab4e79-88ad-4059-b2a2-7944967dadb7	2024-12-17 22:01:35.441495	2024-12-17 22:01:35.441506	\N	Wa Naa's Palace	\N	86000	b36cc9fc-18e9-404a-b557-d948b8fc8410
f24bc191-83ba-4eba-b119-b043df621c27	2024-12-17 22:01:48.298165	2024-12-17 22:01:48.298181	\N	Wechiau Hippo Sanctuary	\N	88000	b36cc9fc-18e9-404a-b557-d948b8fc8410
b8c7bcd4-3b83-415d-a67f-54e3a4f6c029	2024-12-17 22:03:28.58089	2024-12-17 22:03:28.580951	\N	Keta Lagoon	\N	99000	3845d341-59dc-427a-99de-b2f6a5076d6b
730a6e09-2711-48d3-b390-78809d95186e	2024-12-17 22:03:43.64543	2024-12-17 22:03:43.645436	\N	Mount Afadjato	\N	77000	3845d341-59dc-427a-99de-b2f6a5076d6b
32d3d797-f2a6-4c69-bfd7-67457aee7108	2024-12-17 22:03:57.011426	2024-12-17 22:03:57.011437	\N	Tafi Atome Monkey Sanctuary	\N	150000	3845d341-59dc-427a-99de-b2f6a5076d6b
85675642-4327-43ab-8b77-804a529cb747	2024-12-17 22:04:19.721086	2024-12-17 22:04:19.721108	\N	Wli Waterfalls	\N	52000	3845d341-59dc-427a-99de-b2f6a5076d6b
ea7f929d-6059-4845-876b-7b771ddcdaed	2024-12-17 22:05:11.373935	2024-12-17 22:05:11.373951	\N	Ankasa Conservation Area	\N	34500	631dea86-c927-4e90-ac94-86dcfd806cec
92928a38-2680-4760-8b48-2e6df2aa7dd0	2024-12-17 22:05:31.837636	2024-12-17 22:05:31.83765	\N	Cape Three Points	\N	56000	631dea86-c927-4e90-ac94-86dcfd806cec
b372b8fa-4287-471c-9cf2-34a913b4caa3	2024-12-17 22:05:43.622756	2024-12-17 22:05:43.622773	\N	Fort Metal Cross	\N	23000	631dea86-c927-4e90-ac94-86dcfd806cec
1c7f0a8e-d0c6-428a-ac13-38610ae2ab79	2024-12-17 22:06:05.923532	2024-12-17 22:06:05.923543	\N	Nzulezu Stilt Village	\N	45000	631dea86-c927-4e90-ac94-86dcfd806cec
1297afb5-18f8-444a-9bf8-511560f58c3a	2024-12-17 12:51:46.275466	2024-12-17 22:53:22.691982	\N	Okomfo Anokye Sword Site	\N	47000	770cfc0b-15f1-4cad-b74a-a087ea89d216
8486eec5-ecf6-4070-ad6c-9bf397406fe6	2024-12-17 12:52:26.618194	2024-12-17 23:01:15.260824	\N	Manhyia Palace Museum		120000	770cfc0b-15f1-4cad-b74a-a087ea89d216
e33e7368-7779-4c15-adf8-06cc356226aa	2024-12-17 12:55:16.354407	2024-12-17 12:55:16.354419	\N	Cape Coast Castle	\N	63000	88aeb123-0ece-4259-bbb2-8d4d8be602a0
98e5c053-d4f8-4b95-a675-948c70485c5c	2024-12-17 12:54:58.770022	2024-12-19 14:29:48.784361	\N	Assin Manso Slave River	\N	86000	88aeb123-0ece-4259-bbb2-8d4d8be602a0
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
-- Data for Name: user_tour_packages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_tour_packages (id, created_at, updated_at, deleted_at, active, user_id, payment_status, tx_ref, payment_gateway, currency, region_id, accommodation_id, no_of_people_attending, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: user_verification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_verification (id, created_at, updated_at, deleted_at, session_id, email, token, expires_at) FROM stdin;
4c163100-4e2b-4960-b70d-34929142d2de	2025-01-13 11:26:00.639969	2025-01-13 11:26:00.639978	\N	a5adf3db-7b1c-4cea-b4f4-ef7e9945c68c	tomi@xyz.com	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MzY3NjQ4NTYsImlkIjoiNzBlYjE4MGQtYjhmZC00OWI0LTg1M2UtNzcxNjY5MDQ2MjA4IiwiZW1haWwiOiJ0b21pQHh5ei5jb20iLCJuYW1lIjoiT2x1d2F0b2JpbG9iYSBMaWdodCIsImlzX2FkbWluIjpmYWxzZX0.1Hs0nM72tewA9-OLaMFR-VeGDbxgjUCCpXBbb5ui6Ak	2025-01-13 11:36:00.640417+01
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, created_at, updated_at, deleted_at, name, email, password, phone, provider, email_verified, address, is_admin, is_active, last_login_at) FROM stdin;
a4a1c0fd-cb09-4587-b40b-263c9d089117	2024-12-13 12:27:26.513852	2024-12-14 22:56:37.264815	\N	Oluwatobiloba Agunloye	oluwatobilobagunloye@gmail.com	\N	09056347603	google	t	Lagos, Nigeria	t	t	2024-12-13 12:27:26.514206+01
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
-- Name: activities activities_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_name_key UNIQUE (name);


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
-- Name: google_verification google_verification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.google_verification
    ADD CONSTRAINT google_verification_pkey PRIMARY KEY (id);


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
-- Name: tour_package_accommodations tour_package_accommodations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_accommodations
    ADD CONSTRAINT tour_package_accommodations_pkey PRIMARY KEY (id);


--
-- Name: tour_package_activities tour_package_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_activities
    ADD CONSTRAINT tour_package_activities_pkey PRIMARY KEY (id);


--
-- Name: tour_package_tour_sites_region tour_package_tour_sites_region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_tour_sites_region
    ADD CONSTRAINT tour_package_tour_sites_region_pkey PRIMARY KEY (id);


--
-- Name: tour_package_transportations tour_package_transportations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_transportations
    ADD CONSTRAINT tour_package_transportations_pkey PRIMARY KEY (id);


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
-- Name: tour_package_accommodations tour_package_accommodations_accommodation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_accommodations
    ADD CONSTRAINT tour_package_accommodations_accommodation_id_fkey FOREIGN KEY (accommodation_id) REFERENCES public.accommodations(id) ON DELETE CASCADE;


--
-- Name: tour_package_accommodations tour_package_accommodations_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_accommodations
    ADD CONSTRAINT tour_package_accommodations_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: tour_package_activities tour_package_activities_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_activities
    ADD CONSTRAINT tour_package_activities_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id) ON DELETE CASCADE;


--
-- Name: tour_package_activities tour_package_activities_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_activities
    ADD CONSTRAINT tour_package_activities_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: tour_package_tour_sites_region tour_package_tour_sites_region_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_tour_sites_region
    ADD CONSTRAINT tour_package_tour_sites_region_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: tour_package_tour_sites_region tour_package_tour_sites_region_tour_sites_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_tour_sites_region
    ADD CONSTRAINT tour_package_tour_sites_region_tour_sites_region_id_fkey FOREIGN KEY (tour_sites_region_id) REFERENCES public.tour_sites_region(id) ON DELETE CASCADE;


--
-- Name: tour_package_transportations tour_package_transportations_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_transportations
    ADD CONSTRAINT tour_package_transportations_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.user_tour_packages(id) ON DELETE CASCADE;


--
-- Name: tour_package_transportations tour_package_transportations_transportation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_package_transportations
    ADD CONSTRAINT tour_package_transportations_transportation_id_fkey FOREIGN KEY (transportation_id) REFERENCES public.transportation(id) ON DELETE CASCADE;


--
-- Name: tour_sites_region tour_sites_region_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_sites_region
    ADD CONSTRAINT tour_sites_region_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id) ON DELETE CASCADE;


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

