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
-- Name: terms_conditions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.terms_conditions (
    id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone,
    title character varying(50),
    description character varying(2048) NOT NULL,
    tour_package_id uuid
);


ALTER TABLE public.terms_conditions OWNER TO postgres;

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
e8183e8b-8b72-4ec5-895e-6677dbac5912	2025-02-19 10:11:48.735743	2025-02-19 10:11:48.735751	\N	Boating on the Densu River	Boating on the Densu River	0	c706410c-31f4-4f03-b50c-b5d8d9fdf50f
7129b4b2-5e73-4974-b1da-2d351f370dc9	2025-02-19 10:12:42.785995	2025-02-19 10:12:42.786003	\N	Hiking to explore the coast's flora and fauna	Hiking to explore the coast's flora and fauna	0	c706410c-31f4-4f03-b50c-b5d8d9fdf50f
fe129c3a-aab9-4b9f-8a80-68e4543411f6	2025-02-19 10:13:50.859859	2025-02-19 10:13:50.859938	\N	Fresh seafood and cuisine	Fresh seafood and cuisine	0	c706410c-31f4-4f03-b50c-b5d8d9fdf50f
d9292dca-3129-4647-bbaf-018b9f4b49f1	2025-02-19 10:15:00.600194	2025-02-19 10:15:00.600199	\N	Pictures of great Ghanaians display	Pictures of great Ghanaians display	0	998c6be0-b44f-432b-b5fd-b73aa80ba6f1
e02f016b-6d3a-4217-a391-2ddd5d389e46	2025-02-19 10:15:12.722802	2025-02-19 10:15:12.722814	\N	Guided tour around the castle	Guided tour around the castle	0	998c6be0-b44f-432b-b5fd-b73aa80ba6f1
313138ed-0388-45a5-8e43-559c0e40c599	2025-02-19 10:15:24.06253	2025-02-19 10:15:24.062552	\N	Scenic photographs	Scenic photographs	0	998c6be0-b44f-432b-b5fd-b73aa80ba6f1
b6cd5a42-68b6-40c7-87af-a41cc2784ffa	2025-02-19 10:15:46.10804	2025-02-19 10:15:46.108053	\N	Sightseeing of artifacts	Sightseeing of artifacts	0	998c6be0-b44f-432b-b5fd-b73aa80ba6f1
0bdf0fc4-d04e-4956-97e1-322e8c06e64f	2025-02-19 10:16:18.458637	2025-02-19 10:16:18.458645	\N	Nature walks	Nature walks	0	261e0fc3-30e8-4c22-a11e-dc4a94aa4e94
c4419eb0-2d6e-4312-bdb8-8fd2a674929a	2025-02-19 10:26:36.167251	2025-02-19 10:26:36.167306	\N	Guided tours	Guided tours	0	261e0fc3-30e8-4c22-a11e-dc4a94aa4e94
99108517-5346-460c-8d85-a58369e93bf6	2025-02-19 10:33:44.618529	2025-02-19 10:33:44.618586	\N	Historical guided tours	Historical guided tours	0	f7e0a9d9-752b-472c-bd7a-bb61e6d7e849
22ea9d22-c06f-43fd-9203-1895228ac9a2	2025-02-19 10:34:04.034909	2025-02-19 10:34:04.034919	\N	Panoramic ocean views	Panoramic ocean views	0	f7e0a9d9-752b-472c-bd7a-bb61e6d7e849
e1ad82ab-70d1-4ca9-b04e-ad773ec6f453	2025-02-19 10:34:59.59869	2025-02-19 10:34:59.598697	\N	Community engagement	Community engagement	0	f7e0a9d9-752b-472c-bd7a-bb61e6d7e849
bdb0b163-3f43-4312-ae31-b889bf510738	2025-02-19 10:35:50.541434	2025-02-19 10:35:50.541441	\N	Beach activities	Beach activities	0	9162c459-ac01-4d69-94ae-f8f6d9c91038
d935ec7b-6f94-489b-b4d7-4575016f95f8	2025-02-19 10:36:08.740594	2025-02-19 10:36:08.7406	\N	Cultural music gatherings	Cultural music gatherings	0	9162c459-ac01-4d69-94ae-f8f6d9c91038
bfe037b3-18da-40f2-b95a-3a453bb08657	2025-02-19 10:37:32.249721	2025-02-19 10:37:32.249728	\N	Relaxation	Relaxation	0	9162c459-ac01-4d69-94ae-f8f6d9c91038
31451f06-2824-4682-a1b4-9df98195057c	2025-02-19 10:38:49.593308	2025-02-19 10:38:49.593315	\N	Historical exhibitions	Historical exhibitions	0	e7da5a8f-5bc6-4296-821e-431d79d466ff
b8474245-183f-445c-9612-78a8c445ca37	2025-02-19 10:39:05.989994	2025-02-19 10:39:05.990006	\N	Educational tours	Educational tours	0	e7da5a8f-5bc6-4296-821e-431d79d466ff
f071d828-7adc-4518-a6c6-c51eec393ad2	2025-02-19 10:39:23.728723	2025-02-19 10:39:23.72873	\N	Cultural programs	Cultural programs	0	e7da5a8f-5bc6-4296-821e-431d79d466ff
3fb76e5c-c07e-43c5-aa25-2701cbde716d	2025-02-19 10:40:40.840027	2025-02-19 10:40:40.840047	\N	High Ropes Course	High Ropes Course	0	cb53ca65-e203-4c94-9f02-e55dd5722a9d
f39e9841-b573-4564-9b4b-0a228b2a878a	2025-02-19 10:40:53.432013	2025-02-19 10:40:53.43202	\N	Children's playground	Children's playground	0	cb53ca65-e203-4c94-9f02-e55dd5722a9d
6e21d127-32fa-44a8-a973-31c8239119d2	2025-02-19 10:41:08.442769	2025-02-19 10:41:08.442777	\N	Canoeing	Canoeing	0	cb53ca65-e203-4c94-9f02-e55dd5722a9d
1347d41d-6f2a-4357-a874-73a7acc78158	2025-02-19 10:41:17.099377	2025-02-19 10:41:17.099386	\N	Canopy Walkway	Canopy Walkway	0	cb53ca65-e203-4c94-9f02-e55dd5722a9d
51d93f58-6730-464b-91af-6223ba063a0e	2025-02-19 10:41:37.787021	2025-02-19 10:41:37.787029	\N	Events in the Woodlands	Events in the Woodlands	0	cb53ca65-e203-4c94-9f02-e55dd5722a9d
dea6dd57-530d-4b4a-aa34-169c40efe4b5	2025-02-19 10:41:51.435532	2025-02-19 10:41:51.435539	\N	Fishing	Fishing	0	cb53ca65-e203-4c94-9f02-e55dd5722a9d
c8e6505c-5d9e-4584-bf4a-8d98c7af00a5	2025-02-19 10:41:57.866532	2025-02-19 10:41:57.866538	\N	Bird Watching	Bird Watching	0	cb53ca65-e203-4c94-9f02-e55dd5722a9d
564f53ad-5f88-4436-aaa7-91b77d66bbf3	2025-02-19 10:42:37.722804	2025-02-19 10:42:37.722815	\N	Cycling	Cycling	0	cb53ca65-e203-4c94-9f02-e55dd5722a9d
35853652-fcf7-416e-bb70-d24442c39ef9	2025-02-19 10:44:49.083816	2025-02-19 10:44:49.083823	\N	Shopping experience	Shopping experience	0	7aa5c922-7213-4e96-80a8-ff3068a11b86
2d7959c4-6085-4b4f-9d14-f2b2ab7808f7	2025-02-19 10:44:59.310846	2025-02-19 10:44:59.310855	\N	Local cuisine	Local cuisine	0	7aa5c922-7213-4e96-80a8-ff3068a11b86
93ab6abe-07d6-4966-90a9-35cd7ee44009	2025-02-19 10:45:11.742903	2025-02-19 10:45:11.74291	\N	Cultural engagement	Cultural engagement	0	7aa5c922-7213-4e96-80a8-ff3068a11b86
458ff8cd-6911-4b19-be7d-e3f16b3ab505	2025-02-19 10:45:24.482582	2025-02-19 10:45:24.482591	\N	Nightlife activities	Nightlife activities	0	7aa5c922-7213-4e96-80a8-ff3068a11b86
7b41db56-7785-427b-9b69-cc8f691089e9	2025-02-19 10:45:51.78443	2025-02-19 10:45:51.784439	\N	Quad Biking	Quad Biking	0	6dcddc35-dddc-4b4f-b1f9-d8fc9dc7cdf1
c2d1786f-97f2-4849-8608-00eb0c59a985	2025-02-19 10:46:01.203318	2025-02-19 10:46:01.203326	\N	Mountain climbing	Mountain climbing	0	6dcddc35-dddc-4b4f-b1f9-d8fc9dc7cdf1
4c716167-24e2-4003-a3e4-3a7ebe4d799e	2025-02-19 10:46:12.202265	2025-02-19 10:46:12.202272	\N	Bird watching	Bird watching	0	6dcddc35-dddc-4b4f-b1f9-d8fc9dc7cdf1
c6142c8f-59c5-4cde-b923-d6c1f1e01b49	2025-02-19 10:46:22.070887	2025-02-19 10:46:22.0709	\N	Cave exploration	Cave exploration	0	6dcddc35-dddc-4b4f-b1f9-d8fc9dc7cdf1
f43d3ca5-be50-4d83-beab-96fb39bcdd3f	2025-02-19 10:46:35.866267	2025-02-19 10:46:35.866275	\N	Wildlife encounters	Wildlife encounters	0	6dcddc35-dddc-4b4f-b1f9-d8fc9dc7cdf1
9f23341e-fc1c-4d4e-8074-990966ad3c4f	2025-02-19 10:47:43.04896	2025-02-19 10:47:43.048967	\N	Traditional fishing demonstrations	Traditional fishing demonstrations	0	8b26d313-6a13-4f44-b5a7-0c47c8fdd611
4de615d8-1879-42ae-a10a-e1b79169eae4	2025-02-19 10:47:56.84157	2025-02-19 10:47:56.841578	\N	Harbor tours	Harbor tours	0	8b26d313-6a13-4f44-b5a7-0c47c8fdd611
bc81338d-4660-4a6e-b63a-162a1563b86b	2025-02-19 10:48:14.397353	2025-02-19 10:48:14.397377	\N	Cultural experiences	Cultural experiences	0	8b26d313-6a13-4f44-b5a7-0c47c8fdd611
f66f3336-84d1-47a9-a169-54beb7c6a5e9	2025-02-19 10:48:54.991147	2025-02-19 10:48:54.991156	\N	Jet skiing	Jet skiing	0	a842b650-ccf0-4f46-93c0-b8dd18004da4
537d3688-03cd-4651-b977-be54fd17f53d	2025-02-19 10:49:05.426659	2025-02-19 10:49:05.426668	\N	Windsurfing	Windsurfing	0	a842b650-ccf0-4f46-93c0-b8dd18004da4
e1f2843a-65df-471c-a350-eda7c351f3c8	2025-02-19 10:49:22.596132	2025-02-19 10:49:22.596138	\N	Boat tours	Boat tours	0	a842b650-ccf0-4f46-93c0-b8dd18004da4
778a2d38-1e21-469a-a84e-011987923b1f	2025-02-19 10:54:03.482013	2025-02-19 10:54:03.482027	\N	Nature walks	Nature walks	0	a842b650-ccf0-4f46-93c0-b8dd18004da4
39eb5a0d-bccc-489f-9b71-040191f443af	2025-02-19 10:57:24.582427	2025-02-19 10:57:24.582434	\N	Photography	Photography	0	2e97f83f-ca43-4ab4-ac3b-a3958c453153
054e8f52-2f6f-463b-b7e7-8a749578a89b	2025-02-19 10:57:36.761004	2025-02-19 10:57:36.761013	\N	Historical tours	Historical tours	0	2e97f83f-ca43-4ab4-ac3b-a3958c453153
9e369f74-150b-42e9-a905-4ba7be7c74e5	2025-02-19 10:57:51.473695	2025-02-19 10:57:51.473702	\N	Architectural appreciation	Architectural appreciation	0	2e97f83f-ca43-4ab4-ac3b-a3958c453153
55a6e92a-4c9b-404a-a64e-c22c59651002	2025-02-19 10:58:48.716796	2025-02-19 10:58:48.716806	\N	Guided tours	Guided tours	0	7ac03042-f320-4865-bf48-8dbffcbcaf9e
a9ad75af-69b0-4a5e-afcc-cef895a72ed1	2025-02-19 10:58:58.438365	2025-02-19 10:58:58.438379	\N	Photography	Photography	0	7ac03042-f320-4865-bf48-8dbffcbcaf9e
996bdacb-45a8-47a1-961e-929de1e5c4fc	2025-02-19 10:59:17.163856	2025-02-19 10:59:17.163864	\N	Garden visits	Garden visits	0	7ac03042-f320-4865-bf48-8dbffcbcaf9e
e9ae89de-0816-4705-903a-29bd97a43226	2025-02-19 11:00:04.340379	2025-02-19 11:00:04.34039	\N	Art exhibitions	Art exhibitions	0	42ccfa4b-583c-45d9-9f6c-d0f00ef20736
6bf85a67-799e-45d7-ae01-4fa0a1ef9871	2025-02-19 11:00:15.052973	2025-02-19 11:00:15.052984	\N	Historical displays	Historical displays	0	42ccfa4b-583c-45d9-9f6c-d0f00ef20736
4b3d6877-52d0-4b80-867b-ea8239034460	2025-02-19 11:00:32.748644	2025-02-19 11:00:32.748652	\N	Cultural education	Cultural education	0	42ccfa4b-583c-45d9-9f6c-d0f00ef20736
5a337f83-9ff0-4bfd-92ef-5e5d482cae9a	2025-02-19 11:01:18.509524	2025-02-19 11:01:18.509535	\N	Nature walks	Nature walks	0	eabe309c-5ebe-4e68-9717-a0d455f0fff4
76355149-9b10-4ec5-9782-940aa5b0140c	2025-02-19 11:01:33.928511	2025-02-19 11:01:33.928518	\N	Waterfall viewing	Waterfall viewing	0	eabe309c-5ebe-4e68-9717-a0d455f0fff4
d09e4295-8fa1-4e24-a119-82a04f4c24bb	2025-02-19 11:01:48.13664	2025-02-19 11:01:48.136646	\N	Local cultural experiences	Local cultural experiences	0	eabe309c-5ebe-4e68-9717-a0d455f0fff4
24d0d860-57d5-45b5-a995-6200d48fdda7	2025-02-19 11:02:01.964618	2025-02-19 11:02:01.964634	\N	Swimming	Swimming	0	eabe309c-5ebe-4e68-9717-a0d455f0fff4
b7587a76-b4d9-46f3-9821-0e75c110167e	2025-02-19 11:02:34.465121	2025-02-19 11:02:34.465132	\N	Historical tours	Historical tours	0	3bd98a10-3f65-49ce-a7b2-703fefd7ff13
c4b2b61a-1719-484e-84c5-787da701466c	2025-02-19 11:03:49.893848	2025-02-19 11:03:49.893857	\N	Cultural programs	Cultural programs	0	3bd98a10-3f65-49ce-a7b2-703fefd7ff13
ffaa7c06-7f94-44ef-ad0f-44bc276c0ad9	2025-02-19 11:04:18.67151	2025-02-19 11:04:18.671517	\N	Swimming	Swimming	0	18cdbcf3-4d9d-4d35-bf2e-6fc310982287
08717348-0013-4ce7-93f4-182ab94dfbda	2025-02-19 11:04:31.890549	2025-02-19 11:04:31.89056	\N	Hiking	Hiking	0	18cdbcf3-4d9d-4d35-bf2e-6fc310982287
bc6b4272-8b4b-4df7-8eda-e40d3125f3b4	2025-02-19 11:06:30.465562	2025-02-19 11:06:30.465579	\N	Bird watching	Bird watching	0	984186b4-4fa2-4961-a7d0-b983fc0590bc
5bfca334-530e-4c0e-bee0-6c290ed5c91d	2025-02-19 11:06:39.591763	2025-02-19 11:06:39.591772	\N	Educational tours	Educational tours	0	984186b4-4fa2-4961-a7d0-b983fc0590bc
6152dc49-7dd0-4008-a967-001bf1073b3d	2025-02-19 11:06:50.077067	2025-02-19 11:06:50.077073	\N	Nature walks	Nature walks	0	984186b4-4fa2-4961-a7d0-b983fc0590bc
31cb989d-f4f0-438e-89f6-5b3e3c690f4b	2025-02-19 11:07:18.208329	2025-02-19 11:07:18.208343	\N	Cave exploration	Cave exploration	0	125e6279-c84c-41ef-a877-78f902633d1d
06a247e4-eff6-4325-a2d4-7e0fd078dd5a	2025-02-19 11:07:30.418884	2025-02-19 11:07:30.418891	\N	Bat watching	Bat watching	0	125e6279-c84c-41ef-a877-78f902633d1d
b0ad333b-6a8f-420c-8a43-25f89b529cd7	2025-02-19 11:07:47.450168	2025-02-19 11:07:47.450181	\N	Guided tours	Guided tours	0	125e6279-c84c-41ef-a877-78f902633d1d
dfbe3431-b6c5-4c39-b11f-9d6102860c60	2025-02-19 11:12:39.857725	2025-02-19 11:12:39.857733	\N	Guided nature tours	Guided nature tours	0	0d58662f-7b01-44ca-80ae-661a6f0f9caa
f3eb7703-5416-415c-a226-3455d8a6a006	2025-02-19 11:12:54.165414	2025-02-19 11:12:54.165422	\N	Butterfly watching	Butterfly watching	0	0d58662f-7b01-44ca-80ae-661a6f0f9caa
60b53773-2cb8-4e08-a751-8169e8a51a00	2025-02-19 11:13:06.670068	2025-02-19 11:13:06.670077	\N	Educational programs	Educational programs	0	0d58662f-7b01-44ca-80ae-661a6f0f9caa
a19879db-71e6-499a-823c-ccbbe150170f	2025-02-19 11:13:35.029048	2025-02-19 11:13:35.029054	\N	Kente weaving demonstrations	Kente weaving demonstrations	0	80553df3-bb9a-467b-881e-7f9ddad6ca99
6ba61974-892a-4134-a0ba-e47cb9357220	2025-02-19 11:13:48.936554	2025-02-19 11:13:48.936563	\N	Cultural tours	Cultural tours	0	80553df3-bb9a-467b-881e-7f9ddad6ca99
ed6dcb36-219b-4c77-a60b-73807a9293d5	2025-02-19 11:14:04.112706	2025-02-19 11:14:04.112718	\N	Shopping	Shopping	0	80553df3-bb9a-467b-881e-7f9ddad6ca99
606d5e15-dd54-4d38-b1f8-e2a8a2bfad58	2025-02-19 11:18:42.691191	2025-02-19 11:18:42.691267	\N	Boat rides	Boat rides	0	22314108-4e0d-4fab-bdc8-f2a40f6c2f9d
1432bbfe-7102-47e9-8bd3-546cfc675c7e	2025-02-19 11:18:52.719081	2025-02-19 11:18:52.719089	\N	Canoeing	Canoeing	0	22314108-4e0d-4fab-bdc8-f2a40f6c2f9d
29bc04fe-9ee1-4b01-a6d3-e01af3c0ccb2	2025-02-19 11:19:01.670833	2025-02-19 11:19:01.67084	\N	Hiking	Hiking	0	22314108-4e0d-4fab-bdc8-f2a40f6c2f9d
411e7327-56fa-4064-a106-124f6907db87	2025-02-19 11:19:27.675297	2025-02-19 11:19:27.675303	\N	Fishing	Fishing	0	22314108-4e0d-4fab-bdc8-f2a40f6c2f9d
5873a747-9d56-49a8-bbbd-6bc91826c65f	2025-02-21 14:33:44.201824	2025-02-21 14:33:44.201835	\N	Birdwatching	Birdwatching	0	261e0fc3-30e8-4c22-a11e-dc4a94aa4e94
41fdca37-c0c9-4143-b810-7912159cdc2d	2025-02-21 14:34:13.2068	2025-02-21 14:34:13.206806	\N	Waterfall sightseeing	Waterfall sightseeing	0	261e0fc3-30e8-4c22-a11e-dc4a94aa4e94
8414a9e7-1d96-4bb6-b717-681fd4923408	2025-02-21 14:40:08.638796	2025-02-21 14:40:08.638862	\N	Educational exhibits	Educational exhibits	0	3bd98a10-3f65-49ce-a7b2-703fefd7ff13
0eac907a-22b6-4472-a9fa-c932ad60c0d0	2025-02-21 21:14:08.864147	2025-02-21 21:14:08.864167	\N	Biking	Biking	0	22314108-4e0d-4fab-bdc8-f2a40f6c2f9d
0915b13a-622a-41b0-a28d-1c3a580efb9c	2025-02-21 21:16:32.062999	2025-02-21 21:16:32.063026	\N	Guided tours	Guided tours	0	8486eec5-ecf6-4070-ad6c-9bf397406fe6
afae3933-2244-4d8f-a496-b2c0e959df16	2025-02-21 21:16:49.852587	2025-02-21 21:16:49.852608	\N	Historical exhibits	Historical exhibits	0	8486eec5-ecf6-4070-ad6c-9bf397406fe6
435ff54b-fd02-4d0f-8e04-704a1aefc3e3	2025-02-21 21:17:12.979361	2025-02-21 21:17:12.979379	\N	Cultural experiences	Cultural experiences	0	8486eec5-ecf6-4070-ad6c-9bf397406fe6
ec7bb110-1be9-4871-87ac-8b4c5b09b7c8	2025-02-21 21:50:31.102481	2025-02-21 21:50:31.102492	\N	Wildlife viewing	Wildlife viewing	0	d38b9529-6cf7-4ff3-95d7-6a026c335440
5a1b88ad-5f26-4c6d-91d3-d0c475abd26d	2025-02-21 21:50:58.278277	2025-02-21 21:50:58.278294	\N	Bird watching	Bird watching	0	d38b9529-6cf7-4ff3-95d7-6a026c335440
ab8db37a-1347-400a-aebe-36367f671024	2025-02-21 21:51:19.345229	2025-02-21 21:51:19.345247	\N	Nature walks	Nature walks	0	d38b9529-6cf7-4ff3-95d7-6a026c335440
c163869b-62c4-4808-b3e3-65e94b4e9186	2025-02-21 21:51:35.841965	2025-02-21 21:51:35.84199	\N	Canoe rides	Canoe rides	0	d38b9529-6cf7-4ff3-95d7-6a026c335440
f613a1e0-44e3-49a3-b308-59d0e0a811f6	2025-02-21 21:53:06.881373	2025-02-21 21:53:06.881524	\N	Cloth printing demonstrations	Cloth printing demonstrations	0	3434bf8e-72c1-4ef6-8c1e-4b7f2747432a
af197a73-fcd3-4cd9-a53c-828325c4f093	2025-02-21 21:53:29.164242	2025-02-21 21:53:29.164257	\N	Cultural tours	Cultural tours	0	3434bf8e-72c1-4ef6-8c1e-4b7f2747432a
b7b6f95c-a1fb-4cd0-9ba7-371f4cffcbeb	2025-02-21 21:53:41.237809	2025-02-21 21:53:41.237826	\N	Shopping	Shopping	0	3434bf8e-72c1-4ef6-8c1e-4b7f2747432a
e04a85da-931e-4cdb-8edd-8b160476cdea	2025-02-21 21:54:53.044575	2025-02-21 21:54:53.044593	\N	Monkey watching	Monkey watching	0	3e92442e-1432-4ca4-8cd1-d90ab8ccfb7a
7f355073-4e32-47d9-acf9-f4e1f7833d51	2025-02-21 21:55:37.100636	2025-02-21 21:55:37.100653	\N	Guided tours	Guided tours	0	3e92442e-1432-4ca4-8cd1-d90ab8ccfb7a
e3e8cc54-8ca3-4e71-bcc1-4e39c9f93461	2025-02-21 21:55:57.969598	2025-02-21 21:55:57.969622	\N	Nature walks	Nature walks	0	3e92442e-1432-4ca4-8cd1-d90ab8ccfb7a
caa8af6c-a6fe-4c9f-8535-dafc59eba0e3	2025-02-22 22:22:57.863167	2025-02-22 22:22:57.863268	\N	Waterfall viewing	Waterfall viewing	0	146c53f0-561b-43ad-a485-c2d966b5e84d
f943def0-a43c-4d8f-855a-f70c9de9ca30	2025-02-22 22:23:25.201454	2025-02-22 22:23:25.201463	\N	Hiking	Hiking	0	146c53f0-561b-43ad-a485-c2d966b5e84d
26ac6d02-4d53-405b-94a0-a5b01d82941c	2025-02-22 22:23:41.913059	2025-02-22 22:23:41.913078	\N	Swimming	Swimming	0	146c53f0-561b-43ad-a485-c2d966b5e84d
1664f1ee-2e95-4aa8-8229-34d5acc26c40	2025-02-22 22:24:06.236314	2025-02-22 22:24:06.236328	\N	Nature walks	Nature walks	0	146c53f0-561b-43ad-a485-c2d966b5e84d
b1014458-3453-4e63-b843-b1e183202d4a	2025-02-22 22:25:42.979088	2025-02-22 22:25:42.979112	\N	Cave exploration	Cave exploration	0	63c7b994-e040-42fc-a63b-53db487f31f9
61628b06-6a55-414b-8873-1ad45c7a07d6	2025-02-22 22:26:29.790077	2025-02-22 22:26:29.790091	\N	Cultural tours	Cultural tours	0	63c7b994-e040-42fc-a63b-53db487f31f9
253972cf-19be-4865-b40e-81dac22bc5ee	2025-02-22 22:26:44.543441	2025-02-22 22:26:44.543457	\N	Hiking	Hiking	0	63c7b994-e040-42fc-a63b-53db487f31f9
c15be002-1116-4b78-a37b-55beb5ba4351	2025-02-24 15:41:16.770512	2025-02-24 15:41:16.770528	\N	Ocean views	Ocean views	0	d53993b0-cb52-434f-93fc-bc490e1a9271
1288b27e-a6eb-4843-a64d-728e821ef388	2025-02-23 17:06:02.351767	2025-02-23 17:06:02.351788	\N	Wildlife viewing	Wildlife viewing	0	be8e3704-0989-4410-be7c-8e735b29da2c
27607360-40b4-48ac-841f-43ac29dc0ab4	2025-02-23 17:06:02.372159	2025-02-23 17:06:02.372167	\N	River safaris	River safaris	0	be8e3704-0989-4410-be7c-8e735b29da2c
c1e9ba99-49ab-4de3-a506-5ebdc8f5a5fb	2025-02-23 17:06:02.389799	2025-02-23 17:06:02.389806	\N	Nature walks	Nature walks	0	be8e3704-0989-4410-be7c-8e735b29da2c
ac94d734-089a-49fa-bcb1-b805e943da7a	2025-02-24 15:41:16.639361	2025-02-24 15:41:16.63937	\N	Historical tours	Historical tours	0	e25683e1-5400-4103-a74e-5e2162834b1d
09ca70bd-3f96-4329-8036-605ae02ea3d3	2025-02-24 15:41:16.691882	2025-02-24 15:41:16.691889	\N	Educational programs	Educational programs	0	e25683e1-5400-4103-a74e-5e2162834b1d
4dae83a2-4750-4b22-8227-726314e46333	2025-02-24 15:41:16.70697	2025-02-24 15:41:16.706979	\N	Cultural experiences	Cultural experiences	0	e25683e1-5400-4103-a74e-5e2162834b1d
6df90ecd-3445-423e-90ec-95bc4bb90905	2025-02-24 15:41:16.753143	2025-02-24 15:41:16.753151	\N	Historical tours	Historical tours	0	d53993b0-cb52-434f-93fc-bc490e1a9271
9e9e41a2-09ec-4c06-bef1-c19d550a82b1	2025-02-24 15:41:16.787902	2025-02-24 15:41:16.78791	\N	Cultural experiences	Cultural experiences	0	d53993b0-cb52-434f-93fc-bc490e1a9271
1c407622-509d-49fb-8e18-b82e7bed1b9d	2025-02-24 15:41:16.827197	2025-02-24 15:41:16.827209	\N	Canopy walkway	Canopy walkway	0	ed1de216-962f-43d5-bf5d-9adfdaa2e5b4
d454b780-6fee-4d9b-a58c-fedd0717c676	2025-02-24 15:41:16.860885	2025-02-24 15:41:16.860898	\N	Nature walks	Nature walks	0	ed1de216-962f-43d5-bf5d-9adfdaa2e5b4
661910a1-1d66-4ce7-907a-120af8bc4acf	2025-02-24 15:41:16.877562	2025-02-24 15:41:16.87757	\N	Cultural programs	Cultural programs	0	ed1de216-962f-43d5-bf5d-9adfdaa2e5b4
75a6bbd8-f039-4b50-9757-166b81749cd0	2025-02-24 15:41:16.911878	2025-02-24 15:41:16.911884	\N	Historical tours	Historical tours	0	e33e7368-7779-4c15-adf8-06cc356226aa
ccef9596-2604-4701-9569-f66dc22fd1bf	2025-02-24 15:41:16.92551	2025-02-24 15:41:16.925518	\N	Museum visits	Museum visits	0	e33e7368-7779-4c15-adf8-06cc356226aa
f8f38b0e-4606-4bfe-86be-878e69008af1	2025-02-24 15:41:16.939981	2025-02-24 15:41:16.93999	\N	Cultural experiences	Cultural experiences	0	e33e7368-7779-4c15-adf8-06cc356226aa
17d7e6c2-3978-4bed-9a9e-de23c2254b60	2025-02-24 15:41:16.956014	2025-02-24 15:41:16.956027	\N	Guided tours	Guided tours	0	f8ef837e-f850-4202-95c8-8546312ce134
3ad68c20-ebd1-4ff8-b0cc-cbc02475523b	2025-02-24 15:41:17.009358	2025-02-24 15:41:17.009368	\N	Historical exhibits	Historical exhibits	0	f8ef837e-f850-4202-95c8-8546312ce134
022337eb-c605-41fb-b284-028884e53833	2025-02-24 15:41:17.025379	2025-02-24 15:41:17.025385	\N	Cultural experiences	Cultural experiences	0	f8ef837e-f850-4202-95c8-8546312ce134
836dce39-9f7c-4122-8d5c-c3abcfa0f6ee	2025-02-24 15:41:17.040571	2025-02-24 15:41:17.04058	\N	Archaeological tours	Archaeological tours	0	59114f5c-4b8d-44fd-9b6c-e04f355650b7
19dac2d3-d5a6-4245-9e2a-7924ddad5a12	2025-02-24 15:41:17.055291	2025-02-24 15:41:17.055302	\N	Educational programs	Educational programs	0	59114f5c-4b8d-44fd-9b6c-e04f355650b7
d507e3f3-0ce0-4e98-8943-4821b64fa183	2025-02-24 15:41:17.069158	2025-02-24 15:41:17.069167	\N	Scenic views	Scenic views	0	59114f5c-4b8d-44fd-9b6c-e04f355650b7
654962da-cead-40ad-ae2b-a30dfa7ba3c3	2025-02-24 15:41:17.086439	2025-02-24 15:41:17.086452	\N	Guided garden tours	Guided garden tours	0	5fbc3d82-9469-418a-bdb6-c21f3f0696c5
23b9dac1-85c0-4643-99d1-3324f86fb889	2025-02-24 15:41:17.102906	2025-02-24 15:41:17.102919	\N	Plant education	Plant education	0	5fbc3d82-9469-418a-bdb6-c21f3f0696c5
2baf4695-ff55-4d0e-b266-a936082c3933	2025-02-24 15:41:17.118036	2025-02-24 15:41:17.118044	\N	Nature walks	Nature walks	0	5fbc3d82-9469-418a-bdb6-c21f3f0696c5
48c80c79-4b26-4498-b4c0-cef239b84b47	2025-02-24 15:41:17.136377	2025-02-24 15:41:17.136388	\N	Waterfall viewing	Waterfall viewing	0	2b056cb2-1cef-4e98-a482-8b3123477ea0
a30ca749-f7a3-4eba-8534-74cc3f8b4e45	2025-02-24 15:41:17.153912	2025-02-24 15:41:17.15392	\N	Hiking	Hiking	0	2b056cb2-1cef-4e98-a482-8b3123477ea0
1203a4c6-72a7-426c-9873-b62de69c884e	2025-02-24 15:41:17.167972	2025-02-24 15:41:17.167983	\N	Nature experiences	Nature experiences	0	2b056cb2-1cef-4e98-a482-8b3123477ea0
d62ed3e1-27bc-4740-a095-2df3621b60de	2025-02-24 15:41:17.226162	2025-02-24 15:41:17.22617	\N	Waterfall viewing	Waterfall viewing	0	9f4b4f99-2998-4113-b764-b70cba0a5fa3
a24c1e8d-1453-4ff4-9e12-71933c6422f1	2025-02-24 15:41:17.240812	2025-02-24 15:41:17.240824	\N	Hiking	Hiking	0	9f4b4f99-2998-4113-b764-b70cba0a5fa3
979376ce-250b-476a-a7a2-86d04219004d	2025-02-24 15:41:17.254008	2025-02-24 15:41:17.254021	\N	Nature walks	Nature walks	0	9f4b4f99-2998-4113-b764-b70cba0a5fa3
f1165abb-f1d7-4404-8be5-a30712148264	2025-02-24 15:41:17.267725	2025-02-24 15:41:17.267732	\N	Guided tours	Guided tours	0	4bc11e94-5750-4acd-aed3-33687f131376
603de8ac-05f9-41c1-ae7f-7974c20134a3	2025-02-24 15:41:17.282065	2025-02-24 15:41:17.282074	\N	Zip lining	Zip lining	0	4bc11e94-5750-4acd-aed3-33687f131376
7d9d89d9-fb0e-4fa1-a834-ae65b20b61e1	2025-02-24 15:41:17.315294	2025-02-24 15:41:17.315304	\N	Horse riding	Horse riding	0	4bc11e94-5750-4acd-aed3-33687f131376
0df9b759-f0ec-49a8-8a7e-e1921cb34b81	2025-02-24 15:41:17.334186	2025-02-24 15:41:17.334199	\N	Rock viewing	Rock viewing	0	4220006f-99c2-4abc-8399-3d41de94da0a
f2ac0905-ee47-4d67-b465-a23fc617a4cf	2025-02-24 15:41:17.351615	2025-02-24 15:41:17.351623	\N	Hiking	Hiking	0	4220006f-99c2-4abc-8399-3d41de94da0a
b9bbb8c2-45c0-4758-8efb-63c85a52fcf0	2025-02-24 15:41:17.366395	2025-02-24 15:41:17.366402	\N	Photography	Photography	0	4220006f-99c2-4abc-8399-3d41de94da0a
5394fb44-1e7e-44fd-a690-67482f8b6ae4	2025-02-24 15:41:17.380289	2025-02-24 15:41:17.380296	\N	Bead making demonstrations	Bead making demonstrations	0	6f22b5e3-926a-4e81-943d-56a549cb864d
466fce20-e276-4c02-8303-565efa6a2db8	2025-02-24 15:41:17.394977	2025-02-24 15:41:17.394984	\N	Shopping	Shopping	0	6f22b5e3-926a-4e81-943d-56a549cb864d
11cefdcf-cc6d-4ef5-9d7f-e45ecf90fd54	2025-02-24 15:41:17.409803	2025-02-24 15:41:17.409814	\N	Cultural experiences	Cultural experiences	0	6f22b5e3-926a-4e81-943d-56a549cb864d
72330a6d-d917-46e1-bdec-7b464755d2a4	2025-02-24 15:41:17.426191	2025-02-24 15:41:17.426199	\N	Rock viewing	Rock viewing	0	d2af43a3-3d9e-4075-b78b-aa31df28b8c8
ab0fa418-96c2-4349-b6a6-624dc1c403b3	2025-02-24 15:41:17.442523	2025-02-24 15:41:17.44254	\N	Hiking	Hiking	0	d2af43a3-3d9e-4075-b78b-aa31df28b8c8
087887c5-d76b-4ce4-b739-12cfba8d1f51	2025-02-24 15:41:17.460108	2025-02-24 15:41:17.460147	\N	Cultural tours	Cultural tours	0	d2af43a3-3d9e-4075-b78b-aa31df28b8c8
96b8be29-74ef-455a-9dcd-f29a8dcf12be	2025-02-24 15:41:17.56453	2025-02-24 15:41:17.564538	\N	Weaving demonstrations	Weaving demonstrations	0	1b738a6f-b61f-497e-bdfb-dd0ee772fd21
f0ba758e-5064-4111-8652-4f26a8b1dc05	2025-02-24 15:41:17.578738	2025-02-24 15:41:17.578744	\N	Cultural tours	Cultural tours	0	1b738a6f-b61f-497e-bdfb-dd0ee772fd21
e13b3463-667f-4ca9-a245-5186640ae186	2025-02-24 15:41:17.593551	2025-02-24 15:41:17.593564	\N	River cruises	River cruises	0	1b738a6f-b61f-497e-bdfb-dd0ee772fd21
4763af2e-becd-4fa4-ac69-b3b45929e8dc	2025-02-24 15:41:17.656225	2025-02-24 15:41:17.656233	\N	Architectural tours	Architectural tours	0	532bf1eb-e4c9-4aaf-8c53-0f896b032d39
912e97eb-244f-473a-be08-9014f1be7216	2025-02-24 15:41:17.670665	2025-02-24 15:41:17.670672	\N	Cultural experiences	Cultural experiences	0	532bf1eb-e4c9-4aaf-8c53-0f896b032d39
17823271-6145-494b-a089-06273b64b0ba	2025-02-24 15:41:17.685835	2025-02-24 15:41:17.685845	\N	Photography	Photography	0	532bf1eb-e4c9-4aaf-8c53-0f896b032d39
99109d90-7ab2-498e-828e-5d304edff225	2025-02-24 15:41:17.700722	2025-02-24 15:41:17.700732	\N	Canoe safaris	Canoe safaris	0	1849e83e-e691-41b8-938e-3abdcf453669
ebacc6bf-d499-46e7-86dd-aa6e7d85f145	2025-02-24 15:41:17.714951	2025-02-24 15:41:17.714961	\N	Cultural tours	Cultural tours	0	1849e83e-e691-41b8-938e-3abdcf453669
5b6b4cc4-c8e5-4013-b6fb-587b75f4ffdf	2025-02-24 15:41:17.730801	2025-02-24 15:41:17.730809	\N	Craft demonstrations	Craft demonstrations	0	1849e83e-e691-41b8-938e-3abdcf453669
72905d3a-1670-4d8d-a150-32ba6960a17f	2025-02-24 15:41:17.743743	2025-02-24 15:41:17.743756	\N	Wildlife safaris	Wildlife safaris	0	4426c562-85c9-4f16-bdfd-d9eff596a6b2
05e5a0e2-92b8-4094-8d1a-48962208a15c	2025-02-24 15:41:17.759815	2025-02-24 15:41:17.759822	\N	Walking tours	Walking tours	0	4426c562-85c9-4f16-bdfd-d9eff596a6b2
b5bce2d3-5aed-4746-85ac-c2570ee8de13	2025-02-24 15:41:17.776265	2025-02-24 15:41:17.776274	\N	Cultural experiences	Cultural experiences	0	4426c562-85c9-4f16-bdfd-d9eff596a6b2
063a7596-2322-4c05-a844-7a564e5bad8e	2025-02-24 15:41:17.476989	2025-02-24 15:41:17.477	\N	Waterfall viewing	Waterfall viewing	0	b9f067c7-4bb5-4ce6-9662-390149ff4c5c
ba40cd15-4c2e-45ec-a359-f3be86ea8e7e	2025-02-24 15:41:17.520447	2025-02-24 15:41:17.520457	\N	Swimming	Swimming	0	b9f067c7-4bb5-4ce6-9662-390149ff4c5c
92685c57-dfcf-4ac3-acc4-a05ea45cd9a1	2025-02-24 15:41:17.609023	2025-02-24 15:41:17.609037	\N	Mountain hiking	Mountain hiking	0	2d27af1e-f695-4acd-91fd-df3ebfa97568
8e0e67bd-9acf-45ae-bd82-7b96a8aff26a	2025-02-24 15:41:17.623849	2025-02-24 15:41:17.623859	\N	Wildlife viewing	Wildlife viewing	0	2d27af1e-f695-4acd-91fd-df3ebfa97568
4bea6785-5bfb-42a7-b14f-d58cceccd7bb	2025-02-24 15:41:17.63988	2025-02-24 15:41:17.639888	\N	Waterfall visits	Waterfall visits	0	2d27af1e-f695-4acd-91fd-df3ebfa97568
b0712c3a-c934-429d-9364-83f3dc9c9ab2	2025-02-24 15:41:17.183155	2025-02-24 15:41:17.183161	\N	Dam tours	Dam tours	0	5d85a50b-3454-47fa-a707-2d2f46434d0e
d8531515-9483-4333-9fca-29223df49f1e	2025-02-24 15:41:17.197445	2025-02-24 15:41:17.197453	\N	Lake cruises	Lake cruises	0	5d85a50b-3454-47fa-a707-2d2f46434d0e
b0905e18-06ee-46c3-be1c-04e3acdfc212	2025-02-24 15:41:17.212461	2025-02-24 15:41:17.21247	\N	Educational programs	Educational programs	0	5d85a50b-3454-47fa-a707-2d2f46434d0e
bf0dc890-bba2-4c4d-a1c2-26cb1965b46c	2025-02-24 16:46:05.084957	2025-02-24 16:46:05.084989	\N	Hiking	Hiking	0	b9f067c7-4bb5-4ce6-9662-390149ff4c5c
640b36d6-81ac-4f33-873e-ed6a0e5df6f1	2025-02-24 16:46:05.107531	2025-02-24 16:46:05.107537	\N	Hiking	Hiking	0	e0bb1a90-6ecb-417b-a079-358029708083
c7f810b1-d3dd-4b93-8e34-31c0954475f1	2025-02-24 16:59:53.719659	2025-02-24 16:59:53.719666	\N	Wildlife viewing	Wildlife viewing	0	ed1de216-962f-43d5-bf5d-9adfdaa2e5b4
16810753-8297-4c82-b11a-b899917f353f	2025-02-24 17:04:59.388121	2025-02-24 17:04:59.388129	\N	Historical tours	Historical tours	0	e0bb1a90-6ecb-417b-a079-358029708083
ba14ef2f-82aa-42fe-861e-b1e5dda597b2	2025-02-24 17:04:59.42072	2025-02-24 17:04:59.420731	\N	Cultural experiences	Cultural experiences	0	e0bb1a90-6ecb-417b-a079-358029708083
36b1d9e7-eae6-4882-bdbd-ebdad35b2d75	2025-02-25 15:48:14.387317	2025-02-25 15:48:14.387325	\N	Pottery workshops	Pottery workshops	0	d0199613-aec4-4e52-be95-026b6deaee07
e3428225-2edc-4fc7-87cc-26f3c028d17e	2025-02-25 15:48:14.428477	2025-02-25 15:48:14.42849	\N	Art demonstrations	Art demonstrations	0	d0199613-aec4-4e52-be95-026b6deaee07
1c362496-71d7-4c39-be62-9fd70e4bc5c7	2025-02-25 15:48:14.448385	2025-02-25 15:48:14.448398	\N	Cultural experiences	Cultural experiences	0	d0199613-aec4-4e52-be95-026b6deaee07
a741a50a-2d6d-47fb-9f9b-b6c1c3585a31	2025-02-25 15:48:14.469841	2025-02-25 15:48:14.469858	\N	Spiritual tours	Spiritual tours	0	dc0d3414-3028-425e-b200-6fca15339509
92cf7f90-f679-4191-8271-7c120f2473e5	2025-02-25 15:48:14.495741	2025-02-25 15:48:14.495757	\N	Cultural experiences	Cultural experiences	0	dc0d3414-3028-425e-b200-6fca15339509
2ccfde99-96ca-48b1-95ed-c7ba7acc6660	2025-02-25 15:48:14.517493	2025-02-25 15:48:14.517509	\N	Hiking	Hiking	0	dc0d3414-3028-425e-b200-6fca15339509
60b6988c-cb2a-4ad2-b906-bc64f102ba64	2025-02-25 15:48:14.54	2025-02-25 15:48:14.540014	\N	Historical tours	Historical tours	0	5837a729-1655-460b-afee-b2cd544cc07d
f51d55a8-1bd3-4984-97ec-090b68defc24	2025-02-25 15:48:14.558317	2025-02-25 15:48:14.558331	\N	Cultural experiences	Cultural experiences	0	5837a729-1655-460b-afee-b2cd544cc07d
22e8c553-a2bb-488c-97fc-7ef965dc7b73	2025-02-25 15:48:14.579818	2025-02-25 15:48:14.579831	\N	Educational programs	Educational programs	0	5837a729-1655-460b-afee-b2cd544cc07d
5561acd2-0a2e-4391-9e06-102409899a20	2025-02-25 15:48:14.598444	2025-02-25 15:48:14.598454	\N	Architectural tours	Architectural tours	0	d1b5e442-6695-4ce5-b137-d7fee2255a43
6afe93a3-6381-4765-98a9-7bf6743d24cb	2025-02-25 15:48:14.61645	2025-02-25 15:48:14.616459	\N	Cultural experiences	Cultural experiences	0	d1b5e442-6695-4ce5-b137-d7fee2255a43
2341740b-11d9-456c-b2db-e060fa09e119	2025-02-25 15:48:14.635381	2025-02-25 15:48:14.635394	\N	Historical education	Historical education	0	d1b5e442-6695-4ce5-b137-d7fee2255a43
90b5c1a1-6303-482e-a555-6e75c8e6d780	2025-02-25 15:48:14.654233	2025-02-25 15:48:14.654244	\N	Hippo viewing	Hippo viewing	0	f24bc191-83ba-4eba-b119-b043df621c27
34068fe6-515c-4ba1-8f20-560aea24a7f6	2025-02-25 15:48:14.672289	2025-02-25 15:48:14.672301	\N	River safaris	River safaris	0	f24bc191-83ba-4eba-b119-b043df621c27
05f9dc15-f8d9-4bcb-a620-a955c039692d	2025-02-25 15:48:14.68683	2025-02-25 15:48:14.686837	\N	Bird watching	Bird watching	0	f24bc191-83ba-4eba-b119-b043df621c27
6eed1022-9ad3-4edd-a895-25ac7da0ac1d	2025-02-25 15:48:14.703816	2025-02-25 15:48:14.703825	\N	Cultural tours	Cultural tours	0	f24bc191-83ba-4eba-b119-b043df621c27
7a5761af-fb31-4b3e-a8c4-05ffb537e2ef	2025-02-25 15:48:14.720328	2025-02-25 15:48:14.720336	\N	Canopy walks	Canopy walks	0	86d0d625-3d83-49df-8fa7-f860a1737d60
59e56d4e-ef4b-411f-b92c-680b994e623e	2025-02-25 15:48:14.738092	2025-02-25 15:48:14.738102	\N	Bird watching	Bird watching	0	86d0d625-3d83-49df-8fa7-f860a1737d60
8a18ea13-5907-4e12-aa04-97187042b703	2025-02-25 15:48:14.754136	2025-02-25 15:48:14.75415	\N	Nature experiences	Nature experiences	0	86d0d625-3d83-49df-8fa7-f860a1737d60
cd03e079-b3ba-4b50-bfce-479e27a2c002	2025-02-25 15:48:14.769052	2025-02-25 15:48:14.769061	\N	Water activities	Water activities	0	290e7f29-d55e-422b-ac2f-3d6b70002188
238acf39-a1ff-4937-bd69-e121d7279164	2025-02-25 15:48:14.784632	2025-02-25 15:48:14.784643	\N	Safari tours	Safari tours	0	290e7f29-d55e-422b-ac2f-3d6b70002188
338b4210-2fc9-43d1-a11a-29191d738fc9	2025-02-25 15:48:14.80485	2025-02-25 15:48:14.80486	\N	Cultural experiences	Cultural experiences	0	290e7f29-d55e-422b-ac2f-3d6b70002188
30e58211-3e77-424d-aa7b-5b11279f491e	2025-02-25 15:48:14.825154	2025-02-25 15:48:14.825163	\N	Recreational activities	Recreational activities	0	290e7f29-d55e-422b-ac2f-3d6b70002188
22b58f32-5fc8-456d-8f01-a04dec5071e7	2025-02-25 15:48:14.841969	2025-02-25 15:48:14.841983	\N	Pottery workshops	Pottery workshops	0	15af0ed4-4e3f-448c-b9c0-7aff9aec3664
c3f8ea30-253b-4aad-9503-105b0ef9825b	2025-02-25 15:48:14.859002	2025-02-25 15:48:14.859011	\N	Cultural experiences	Cultural experiences	0	15af0ed4-4e3f-448c-b9c0-7aff9aec3664
8935bb94-38d1-40f5-a059-8465ee244890	2025-02-25 15:48:14.874889	2025-02-25 15:48:14.874897	\N	Art demonstrations	Art demonstrations	0	15af0ed4-4e3f-448c-b9c0-7aff9aec3664
4e54083b-0982-4221-bf17-ed1eb3da6046	2025-02-25 15:48:14.891634	2025-02-25 15:48:14.891647	\N	Mountain hiking	Mountain hiking	0	caeeba76-386f-472c-a647-b75ad2ecf8c1
e3dc9960-e919-4db9-a90c-bed0624b4280	2025-02-25 15:48:14.910932	2025-02-25 15:48:14.910942	\N	Village tours	Village tours	0	caeeba76-386f-472c-a647-b75ad2ecf8c1
30c105fb-b9be-4bde-997c-ccd963743290	2025-02-25 15:48:14.931461	2025-02-25 15:48:14.931474	\N	Cultural experiences	Cultural experiences	0	caeeba76-386f-472c-a647-b75ad2ecf8c1
f658a90f-eb5d-443e-9ff7-cd368420215e	2025-02-25 15:48:14.950678	2025-02-25 15:48:14.950687	\N	Monkey viewing	Monkey viewing	0	32d3d797-f2a6-4c69-bfd7-67457aee7108
c93aeca0-f688-474d-8223-132ef6315037	2025-02-25 15:48:14.969424	2025-02-25 15:48:14.969435	\N	Guided tours	Guided tours	0	32d3d797-f2a6-4c69-bfd7-67457aee7108
621d9f29-17fb-4301-8094-836b6ce62380	2025-02-25 15:48:14.988287	2025-02-25 15:48:14.988296	\N	Cultural experiences	Cultural experiences	0	32d3d797-f2a6-4c69-bfd7-67457aee7108
aedb8997-2ec8-4821-a4be-e6a12bdfbea8	2025-02-25 15:48:15.005903	2025-02-25 15:48:15.005915	\N	Night entertainment	Night entertainment	0	32d3d797-f2a6-4c69-bfd7-67457aee7108
2f0d750c-da77-413d-b169-9de95cfcd850	2025-02-25 15:48:15.020748	2025-02-25 15:48:15.020758	\N	Waterfall viewing	Waterfall viewing	0	85675642-4327-43ab-8b77-804a529cb747
3d781aa3-3f74-4659-bc4f-31e6c05d5ad7	2025-02-25 15:48:15.037333	2025-02-25 15:48:15.037341	\N	Hiking	Hiking	0	85675642-4327-43ab-8b77-804a529cb747
e37f52e3-c1f8-4082-8345-298f40fdecdb	2025-02-25 15:48:15.052877	2025-02-25 15:48:15.052887	\N	Cultural tours	Cultural tours	0	85675642-4327-43ab-8b77-804a529cb747
d0c7b98d-8475-4655-8100-311850435173	2025-02-25 15:48:15.069729	2025-02-25 15:48:15.069741	\N	Nature experiences	Nature experiences	0	85675642-4327-43ab-8b77-804a529cb747
9767edd1-024f-4d2a-b125-bb88c3f0bbfe	2025-02-25 15:48:15.084976	2025-02-25 15:48:15.084986	\N	Wildlife safaris	Wildlife safaris	0	38f712e0-f9e4-45c9-bc9b-4fb5e6e37f50
1ad08d8a-7232-4dcc-99bb-af8ebca3be84	2025-02-25 15:48:15.100322	2025-02-25 15:48:15.100331	\N	Bird watching	Bird watching	0	38f712e0-f9e4-45c9-bc9b-4fb5e6e37f50
e0d36602-ee04-4e40-a8c1-267b8209267d	2025-02-25 15:48:15.116646	2025-02-25 15:48:15.116657	\N	Nature walks	Nature walks	0	38f712e0-f9e4-45c9-bc9b-4fb5e6e37f50
0164cedc-28cc-4b80-a99b-23c090156404	2025-02-25 15:48:15.13182	2025-02-25 15:48:15.131829	\N	Crocodile viewing	Crocodile viewing	0	80e619d3-d5b9-4375-bf3f-46054153612e
3ac55c6d-ab7f-4f85-bed6-606351a35b27	2025-02-25 15:48:15.150772	2025-02-25 15:48:15.150782	\N	Cultural tours	Cultural tours	0	80e619d3-d5b9-4375-bf3f-46054153612e
73346ba5-ad8a-4315-8cd5-2c723a29bf02	2025-02-25 15:48:15.168428	2025-02-25 15:48:15.168438	\N	Nature experiences	Nature experiences	0	80e619d3-d5b9-4375-bf3f-46054153612e
015222f1-8ef4-47dc-b1ac-4ec0c39a3b0b	2025-02-25 15:48:15.187773	2025-02-25 15:48:15.18779	\N	Beach activities	Beach activities	0	8fd62cdf-c67e-4bfd-b468-ba91b67636c9
52396c88-c6ef-4686-a64a-4dc30f9f4570	2025-02-25 15:48:15.208715	2025-02-25 15:48:15.208723	\N	Water sports	Water sports	0	8fd62cdf-c67e-4bfd-b468-ba91b67636c9
a2af089d-3e06-4b43-94a2-b352dedfd6e2	2025-02-25 15:48:15.224384	2025-02-25 15:48:15.224399	\N	Cultural experiences	Cultural experiences	0	8fd62cdf-c67e-4bfd-b468-ba91b67636c9
d80b8052-7b72-45ca-9a47-4f49317afa88	2025-02-25 15:48:15.242841	2025-02-25 15:48:15.242855	\N	Historical tours	Historical tours	0	c9cb3620-e834-4a9c-a0ba-c6553d551a32
6a9ea780-de63-4421-9b35-179f1fefed44	2025-02-25 15:48:15.261014	2025-02-25 15:48:15.261024	\N	Ocean views	Ocean views	0	c9cb3620-e834-4a9c-a0ba-c6553d551a32
77d1af11-5dd1-437d-afeb-c6be04699b02	2025-02-25 15:48:15.276452	2025-02-25 15:48:15.276469	\N	Cultural experiences	Cultural experiences	0	c9cb3620-e834-4a9c-a0ba-c6553d551a32
a26b8569-06d5-41b0-ad56-27ad5ed79a1a	2025-02-25 15:48:15.291024	2025-02-25 15:48:15.291033	\N	Historical tours	Historical tours	0	3ee41010-b3fb-4416-8032-413016274cbf
c9db6de1-42dc-4431-bf41-ca2ffcd447f3	2025-02-25 15:48:15.307182	2025-02-25 15:48:15.307191	\N	Guided visits	Guided visits	0	3ee41010-b3fb-4416-8032-413016274cbf
e9f3a19d-98b6-42cc-be1e-6beab23623eb	2025-02-25 15:48:15.324379	2025-02-25 15:48:15.324395	\N	Coastal views	Coastal views	0	3ee41010-b3fb-4416-8032-413016274cbf
2539a914-b164-44ed-9ed0-d277fbe13fd9	2025-02-25 15:48:15.343706	2025-02-25 15:48:15.343719	\N	Cultural experiences	Cultural experiences	0	3ee41010-b3fb-4416-8032-413016274cbf
38acfcc7-871f-4f66-b28b-a9e345c19357	2025-02-25 15:48:15.361537	2025-02-25 15:48:15.361549	\N	Historical exhibits	Historical exhibits	0	3aca6941-dcd9-45a0-97d0-5416caef51c3
9189e41f-8a3e-427b-890e-b8125bfda7e5	2025-02-25 15:48:15.377609	2025-02-25 15:48:15.377617	\N	Guided tours	Guided tours	0	3aca6941-dcd9-45a0-97d0-5416caef51c3
25075c13-e374-4a0d-986e-5cea20ee5648	2025-02-25 15:48:15.394641	2025-02-25 15:48:15.394655	\N	Cultural education	Cultural education	0	3aca6941-dcd9-45a0-97d0-5416caef51c3
f2220ee6-7c98-4d1b-bc55-166de90c1869	2025-02-25 15:48:15.421251	2025-02-25 15:48:15.421267	\N	Architectural appreciation	Architectural appreciation	0	3aca6941-dcd9-45a0-97d0-5416caef51c3
763a0cc4-3511-4915-a4bd-d89b8dbc798c	2025-02-25 15:48:15.445179	2025-02-25 15:48:15.445192	\N	Bird watching	Bird watching	0	0e3f7162-52ea-4d9a-81ab-031dfa306f16
80c11803-d131-4d2b-b1f9-b8f2ba85fcd1	2025-02-25 15:48:15.463997	2025-02-25 15:48:15.464009	\N	Hiking	Hiking	0	0e3f7162-52ea-4d9a-81ab-031dfa306f16
bffe28aa-ca6a-42b8-b283-e438554ae08e	2025-02-25 15:48:15.485571	2025-02-25 15:48:15.485585	\N	Rock climbing	Rock climbing	0	0e3f7162-52ea-4d9a-81ab-031dfa306f16
4f3d4e14-9db4-4024-8940-d3e5853748f3	2025-02-25 15:48:15.504529	2025-02-25 15:48:15.504555	\N	Nature walks	Nature walks	0	c6af1bce-b837-4984-89c3-8ce00328217c
e72f3149-a6e8-4901-843d-8476ef35ea10	2025-02-25 15:48:15.521113	2025-02-25 15:48:15.521127	\N	Lighthouse visits	Lighthouse visits	0	c6af1bce-b837-4984-89c3-8ce00328217c
9038c10f-3b59-4b9e-8756-03edd9254684	2025-02-25 15:48:15.537758	2025-02-25 15:48:15.537766	\N	Wildlife viewing	Wildlife viewing	0	c6af1bce-b837-4984-89c3-8ce00328217c
613acef6-941a-4a3e-a939-2a3038a4635d	2025-02-25 15:48:15.55256	2025-02-25 15:48:15.552567	\N	Canoe rides	Canoe rides	0	5ab49b29-e024-4f3b-995c-91ff1fed14b1
bf1ffb78-0f20-4549-aa6b-b98efb0833ef	2025-02-25 15:48:15.569438	2025-02-25 15:48:15.56945	\N	Village tours	Village tours	0	5ab49b29-e024-4f3b-995c-91ff1fed14b1
589990c5-4561-4f2f-b48f-827a067d1650	2025-02-25 15:48:15.585808	2025-02-25 15:48:15.585817	\N	Cultural experiences	Cultural experiences	0	5ab49b29-e024-4f3b-995c-91ff1fed14b1
f1e76b88-1f89-492f-997d-b8931af54b53	2025-02-25 15:48:15.601704	2025-02-25 15:48:15.601714	\N	Historical tours	Historical tours	0	5cb884f8-e150-408e-a9e3-ea52774c5c0a
00cd5bdc-f7d4-4d1d-a7e7-7b458b7e7c2c	2025-02-25 15:48:15.619478	2025-02-25 15:48:15.619491	\N	Ocean views	Ocean views	0	5cb884f8-e150-408e-a9e3-ea52774c5c0a
2372c8aa-2fe1-4870-b691-55ce49643299	2025-02-25 15:48:15.635987	2025-02-25 15:48:15.635996	\N	Cultural engagement	Cultural engagement	0	5cb884f8-e150-408e-a9e3-ea52774c5c0a
71a29abd-953f-4ef2-a3b9-06a3bc13ac6c	2025-02-25 15:48:15.65252	2025-02-25 15:48:15.652529	\N	Community interaction	Community interaction	0	5cb884f8-e150-408e-a9e3-ea52774c5c0a
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
976afbf1-f8b0-4bd3-b4dc-7c6c79a960da	2025-05-07 13:22:38.497577	2025-05-07 13:22:38.497587	\N	92aa9711-f14e-4f58-9fa2-839f2c72251a	76cdd493-bab3-4364-979c-b880790aa4f3
49a377cb-6246-411a-bd47-288ee47f68f1	2025-06-12 17:01:38.448235	2025-06-12 17:01:38.448242	\N	17535cca-e75e-425f-b285-ffd233d68757	081bb96c-6133-4527-9b10-a160f7cc73c6
753b7134-5993-4aea-b0a9-d344a078d390	2025-06-12 17:01:38.448246	2025-06-12 17:01:38.448247	\N	17535cca-e75e-425f-b285-ffd233d68757	3c76cf7b-84bb-43d5-8cd1-1464e0c3274b
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
faf7dc42-7ed4-44b0-ac81-91567a3c1030	2025-06-12 17:01:38.450459	2025-06-12 17:01:38.450467	\N	Personal expenses such as shopping, phone calls, or room service	17535cca-e75e-425f-b285-ffd233d68757
bad8a4ce-94b5-4af4-b3e0-e5795f99c6fb	2025-06-12 17:01:38.450471	2025-06-12 17:01:38.450472	\N	Travel insurance	17535cca-e75e-425f-b285-ffd233d68757
b7423913-7cfa-4925-83b3-6911a6b4e7ea	2025-06-12 17:01:38.450475	2025-06-12 17:01:38.450476	\N	Additional excursions or activities not included in the itinerary	17535cca-e75e-425f-b285-ffd233d68757
ee4208f4-22a1-4421-b6ef-03941d50c95f	2025-06-12 17:01:38.45048	2025-06-12 17:01:38.45048	\N	Tips and gratuities	17535cca-e75e-425f-b285-ffd233d68757
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
14b19c1f-27b3-4e2d-95d1-aee0c9db4d39	2025-06-12 17:01:38.452124	2025-06-12 17:01:38.452133	\N	Return Economy Flight on Kenya Airways from Lagos	17535cca-e75e-425f-b285-ffd233d68757
b81f853c-f5d2-4035-aae5-b351c0782189	2025-06-12 17:01:38.452137	2025-06-12 17:01:38.452138	\N	Kenya ETA	17535cca-e75e-425f-b285-ffd233d68757
ee6b84c8-787b-403d-9fc7-5312d67992f0	2025-06-12 17:01:38.452141	2025-06-12 17:01:38.452142	\N	Protocol Service	17535cca-e75e-425f-b285-ffd233d68757
53ed26fe-4edb-41f8-882e-819cd7700b90	2025-06-12 17:01:38.452145	2025-06-12 17:01:38.452146	\N	Return Airport Transfer	17535cca-e75e-425f-b285-ffd233d68757
5f7434a0-b071-47eb-ad10-26286c39a197	2025-06-12 17:01:38.452149	2025-06-12 17:01:38.452149	\N	3 Nights in 4-star Resort in Mombasa (PrideInn Flamingo) with daily Breakfast, Lunch, and Dinner	17535cca-e75e-425f-b285-ffd233d68757
e855a4cc-a77d-4522-9a4f-9d0f97207fd0	2025-06-12 17:01:38.452152	2025-06-12 17:01:38.452153	\N	2 Nights in 4-star Hotel in Nairobi (Holiday Inn) with daily Breakfast	17535cca-e75e-425f-b285-ffd233d68757
fbe6fdd5-faeb-4851-9a21-e266c7dc00e4	2025-06-12 17:01:38.452156	2025-06-12 17:01:38.452157	\N	Visit to Nairobi National Park	17535cca-e75e-425f-b285-ffd233d68757
2b504afc-c6b9-427c-9581-f775df8705f7	2025-06-12 17:01:38.45216	2025-06-12 17:01:38.45216	\N	Visit to Giraffe Center	17535cca-e75e-425f-b285-ffd233d68757
89898ca4-080d-4d13-9f24-ad40cfdaa969	2025-06-12 17:01:38.452163	2025-06-12 17:01:38.452164	\N	Lunch at Carnivore Restaurant	17535cca-e75e-425f-b285-ffd233d68757
ebb08753-95c2-48ee-90e2-494611b2696f	2025-06-12 17:01:38.452167	2025-06-12 17:01:38.452168	\N	Visit to Wild Waters Mombasa	17535cca-e75e-425f-b285-ffd233d68757
28ab1de7-272e-4b7b-91bc-293f87a9b68b	2025-06-12 17:01:38.452171	2025-06-12 17:01:38.452171	\N	Dolphin Watch at Kisite Marine Park and Wasini Island with Lunch	17535cca-e75e-425f-b285-ffd233d68757
170a9a2c-dae5-4867-8aeb-fbfeb0f5bc3c	2025-05-07 13:22:38.499736	2025-05-07 13:22:38.499745	\N	Return Economy Flight on Emirate Airline from Lagos	92aa9711-f14e-4f58-9fa2-839f2c72251a
f41dc168-5ef3-4ac8-bec7-54f716395616	2025-05-07 13:22:38.49975	2025-05-07 13:22:38.499751	\N	Dubai Visa	92aa9711-f14e-4f58-9fa2-839f2c72251a
3d9fbe52-6cf8-4e20-9df6-d57889f6a313	2025-05-07 13:22:38.499754	2025-05-07 13:22:38.499755	\N	Protocol Service	92aa9711-f14e-4f58-9fa2-839f2c72251a
9e88c238-263b-4ddf-948d-b9759addd2df	2025-05-07 13:22:38.499758	2025-05-07 13:22:38.499759	\N	Return Airport Transfer	92aa9711-f14e-4f58-9fa2-839f2c72251a
53739fec-82e6-4b3c-9a55-afcda962dfbb	2025-05-07 13:22:38.499762	2025-05-07 13:22:38.499763	\N	5 nights in 4 star Hotel (Holiday Inn & Suites - Dubai Science Park with daily Breakfast)	92aa9711-f14e-4f58-9fa2-839f2c72251a
2fa9ebac-becf-475e-bc89-4a163ca15e4d	2025-05-07 13:22:38.499766	2025-05-07 13:22:38.499766	\N	Dhow Cruise at the Marina with Dinner	92aa9711-f14e-4f58-9fa2-839f2c72251a
58e5294f-79ef-4146-9c54-c80252c6685b	2025-05-07 13:22:38.499769	2025-05-07 13:22:38.49977	\N	Desert Safari with Dinner	92aa9711-f14e-4f58-9fa2-839f2c72251a
378626df-c37b-4d31-952f-0ea85e988748	2025-05-07 13:22:38.499773	2025-05-07 13:22:38.499774	\N	Dubai Aquarium Under Water Zoo	92aa9711-f14e-4f58-9fa2-839f2c72251a
bca0e849-fd00-422c-b6e6-f9e662d1e855	2025-05-07 13:22:38.499777	2025-05-07 13:22:38.499777	\N	Half Day Dubai City Tour	92aa9711-f14e-4f58-9fa2-839f2c72251a
\.


--
-- Data for Name: itineraries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itineraries (id, created_at, updated_at, deleted_at, tour_package_id, title, day_number, description) FROM stdin;
c9d94098-e560-4cc2-9635-3e10fc9710eb	2025-05-07 13:22:38.501359	2025-05-07 13:22:38.501367	\N	92aa9711-f14e-4f58-9fa2-839f2c72251a	Arrival in Dubai + Check-in at Holiday Inn & Suites	1	Arrive in Dubai via return economy flight on Emirates Airline from Lagos. Enjoy protocol service and airport transfer to Holiday Inn & Suites - Dubai Science Park. Check in and unwind at the 4-star hotel with modern amenities. Evening at leisure.
e5955479-96bf-40a6-8e41-dae1ba85dbf9	2025-05-07 13:22:38.501371	2025-05-07 13:22:38.501372	\N	92aa9711-f14e-4f58-9fa2-839f2c72251a	Half Day Dubai City Tour	2	After breakfast, embark on a half-day city tour exploring iconic attractions of Dubai such as the Burj Khalifa (external view), Dubai Creek, Jumeirah Mosque, and historical Al Fahidi district. Return to the hotel in the afternoon for rest or self-exploration.
45e32654-54a2-47f2-95c0-a4e089d5fe99	2025-05-07 13:22:38.501375	2025-05-07 13:22:38.501376	\N	92aa9711-f14e-4f58-9fa2-839f2c72251a	Desert Safari with Dinner	3	Enjoy a leisurely breakfast and some downtime. In the afternoon, depart for a thrilling desert safari experience featuring dune bashing, camel rides, sandboarding, and traditional entertainment. Enjoy a BBQ dinner under the stars before returning to the hotel.
561abc56-c85c-44a9-9758-4d870d762029	2025-05-07 13:22:38.501379	2025-05-07 13:22:38.50138	\N	92aa9711-f14e-4f58-9fa2-839f2c72251a	Dubai Aquarium & Underwater Zoo	4	After breakfast, visit the Dubai Aquarium and Underwater Zoo at Dubai Mall. Discover a fascinating array of marine life and interactive exhibits. Use the rest of the day to explore the mall or return to the hotel for relaxation.
bf258aa1-81f8-43d9-96e6-9d171e823785	2025-05-07 13:22:38.501383	2025-05-07 13:22:38.501384	\N	92aa9711-f14e-4f58-9fa2-839f2c72251a	Dhow Cruise at the Marina with Dinner	5	Spend the morning at leisure or shopping. In the evening, enjoy a serene Dhow Cruise at Dubai Marina, including a buffet dinner with stunning waterfront views, live music, and entertainment. Return to the hotel afterward.
e465c0de-e2c5-406c-8734-2f8c7329b8a1	2025-05-07 13:22:38.501387	2025-05-07 13:22:38.501388	\N	92aa9711-f14e-4f58-9fa2-839f2c72251a	Departure from Dubai	6	After breakfast, check out of the hotel. You’ll be transferred to the airport with protocol service for your return Emirates flight to Lagos. End of tour.
44200d18-eb9d-4757-b8d1-55d2e57205fd	2025-06-12 17:01:38.453807	2025-06-12 17:01:38.453814	\N	17535cca-e75e-425f-b285-ffd233d68757	Arrival in Nairobi + Check-in at Holiday Inn	1	Arrive in Nairobi via return economy flight on Kenya Airways from Lagos. Enjoy protocol service and airport transfer to the Holiday Inn hotel. Check in and relax at the 4-star hotel with modern amenities. Evening at leisure.
b79845bd-05ef-44e9-932d-86f6b5f6ea4f	2025-06-12 17:01:38.453817	2025-06-12 17:01:38.453818	\N	17535cca-e75e-425f-b285-ffd233d68757	Visit to Nairobi National Park & Giraffe Center	2	After breakfast, embark on an exciting day exploring Nairobi’s rich wildlife. Begin with a safari drive through Nairobi National Park to spot lions, rhinos, giraffes, and more. Later, visit the Giraffe Center for an up-close encounter with endangered Rothschild giraffes. Evening at leisure.
84dec181-3420-443d-944b-c168c5deb077	2025-06-12 17:01:38.453821	2025-06-12 17:01:38.453822	\N	17535cca-e75e-425f-b285-ffd233d68757	Lunch at Carnivore Restaurant + Transfer to Mombasa	3	Enjoy a unique and hearty lunch at Nairobi’s famous Carnivore Restaurant. Afterward, transfer to the airport for your flight to Mombasa. Upon arrival, you’ll be taken to PrideInn Flamingo Resort for check-in and dinner. Relax and enjoy the coastal vibes.
6f4c7bbc-c357-4edb-b553-c41dd6857da3	2025-06-12 17:01:38.453824	2025-06-12 17:01:38.453825	\N	17535cca-e75e-425f-b285-ffd233d68757	Dolphin Watching + Kisite Marine Park & Wasini Island Tour	4	After breakfast, head out for a magical day trip to Kisite Marine Park. Spot playful dolphins, snorkel in the clear waters, and enjoy a traditional Swahili seafood lunch on Wasini Island. Return to the resort for dinner and relaxation.
fd9e7617-9e3d-47df-a6e6-042eec013e73	2025-06-12 17:01:38.453828	2025-06-12 17:01:38.453829	\N	17535cca-e75e-425f-b285-ffd233d68757	Family Fun at Wild Waters Mombasa	5	Spend a thrilling day at Wild Waters, Mombasa’s largest water park. With rides, slides, and activities for all ages, it's a day of unforgettable fun for the whole family. Return to the resort in the evening for dinner and rest.
0d912985-f8f4-48ce-8afb-f87d5fb83a5a	2025-06-12 17:01:38.453832	2025-06-12 17:01:38.453833	\N	17535cca-e75e-425f-b285-ffd233d68757	Departure from Mombasa	6	After breakfast, check out from the resort. You’ll be transferred to Mombasa airport for your return Kenya Airways flight to Lagos via Nairobi. End of tour.
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
-- Data for Name: terms_conditions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.terms_conditions (id, created_at, updated_at, deleted_at, title, description, tour_package_id) FROM stdin;
b047a47e-7a4a-4320-89aa-b09195b60267	2025-06-12 17:01:38.456902	2025-06-12 17:01:38.456914	\N	Booking & Payment	A 50% deposit is required to confirm booking. Full payment must be made at least 14 days before departure.	17535cca-e75e-425f-b285-ffd233d68757
83fa8f17-090a-487b-8493-2d6ae0d6338a	2025-06-12 17:01:38.456921	2025-06-12 17:01:38.456923	\N	Visa Requirements	All travelers must possess a valid Kenya ETA prior to departure. Assistance with application will be provided.	17535cca-e75e-425f-b285-ffd233d68757
72dfc258-7e21-4def-a6ba-7ee1211544b7	2025-06-12 17:01:38.456929	2025-06-12 17:01:38.45693	\N	Cancellation Policy	Cancellations made less than 14 days before travel may incur penalties. Refunds are subject to supplier terms.	17535cca-e75e-425f-b285-ffd233d68757
2509e132-e7d3-43a5-9278-ec60e73a50c3	2025-06-12 17:01:38.456936	2025-06-12 17:01:38.456937	\N	Child Policy	Children must be accompanied by at least one adult. Age limits may apply for some activities.	17535cca-e75e-425f-b285-ffd233d68757
\.


--
-- Data for Name: tour_package_transportations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_package_transportations (id, created_at, updated_at, deleted_at, user_tour_package_id, transportation_id) FROM stdin;
5e0d7fb9-f531-4759-9b39-6ba9056b0430	2025-04-30 09:13:43.554155	2025-04-30 09:13:43.554172	\N	501a3291-2842-4d5b-8cc5-205e1ff494e3	85afb053-9985-4a6b-aca0-549a79e361d0
bdd0799b-ab7c-420f-b5ec-269ecdd39005	2025-04-30 09:15:19.336942	2025-04-30 09:15:19.336953	\N	602b5c11-e81e-45e7-8db6-d619405388d1	85afb053-9985-4a6b-aca0-549a79e361d0
bc769321-06b5-47aa-aacb-d2cec807203d	2025-04-30 09:16:24.313226	2025-04-30 09:16:24.313268	\N	bc66c964-a642-4b49-b1e6-7f9a6642c19d	85afb053-9985-4a6b-aca0-549a79e361d0
cd714e8f-da4b-48ce-a890-88d62a0bf2f5	2025-04-30 09:42:25.958087	2025-04-30 09:42:25.958096	\N	3fabb416-c340-4894-8ffa-3781cf6b6ba0	85afb053-9985-4a6b-aca0-549a79e361d0
d53272b5-dd69-4acd-93cb-1a77f4d4ac98	2025-05-05 11:16:58.455289	2025-05-05 11:16:58.455296	\N	ef5ecb0c-6ae0-4005-98db-3082b7d106dc	85afb053-9985-4a6b-aca0-549a79e361d0
63dcff27-c896-4630-b496-dea0afae80c9	2025-05-16 10:54:47.199022	2025-05-16 10:54:47.19903	\N	6fd2fddc-9945-4d61-b84a-f70cf654ebaa	85afb053-9985-4a6b-aca0-549a79e361d0
ba886473-bcda-4e2e-8578-184e417b97a8	2025-05-16 15:10:28.330963	2025-05-16 15:10:28.330973	\N	78370b53-4f74-47a7-a6a9-3216484db47e	85afb053-9985-4a6b-aca0-549a79e361d0
\.


--
-- Data for Name: tour_packages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_packages (id, created_at, updated_at, deleted_at, title, slug, description, duration_days, duration_nights, currency, price_per_family_usd, price_per_person_usd, number_of_travelers, traveler_adults, traveler_children, is_group_pricing, accommodation_details, meals_included, transport_info, price_type, package_type, thumbnail_url, images_url) FROM stdin;
92aa9711-f14e-4f58-9fa2-839f2c72251a	2025-05-07 13:22:38.496188	2025-05-07 13:22:38.4962	\N	Dubai Family Package	dubai-family-package	\N	6	5	USD	7500.00	\N	4	2	4	f	\N	\N	\N	PER_FAMILY	Family Package	https://res.cloudinary.com/djjoidnbp/image/upload/v1746444989/popup-agency-jJtqDVzozQY-unsplash_nyvcs9.jpg	\N
17535cca-e75e-425f-b285-ffd233d68757	2025-06-12 17:01:38.446402	2025-06-12 17:01:38.44641	\N	Kenya Family Package (Mombasa and Nairobi)	kenya-family-package-mombasa-nairobi	Explore wild Nairobi and sunny Mombasa in 6 unforgettable days. Safari at Nairobi National Park, feed giraffes, feast at Carnivore, snorkel with dolphins, and splash around Wild Waters Mombasa. Flights, hotels, meals & transfers—all covered. Just pack your bags and make memories that last a lifetime!	6	5	USD	7100.00	\N	4	2	2	f	\N	\N	\N	PER_FAMILY	Family Package	https://res.cloudinary.com/djjoidnbp/image/upload/v1749743381/mombasa_xtbkoo.jpg	\N
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
b1992454-1436-4b47-965f-37c3760f9c88	2025-04-30 09:13:43.527593	2025-04-30 09:13:43.527605	\N	501a3291-2842-4d5b-8cc5-205e1ff494e3	f660a3ea-2f94-4822-8aa0-dce6d5583be1
b089ca71-b8c9-4609-af06-f1ed699fe11b	2025-04-30 09:15:19.324695	2025-04-30 09:15:19.324704	\N	602b5c11-e81e-45e7-8db6-d619405388d1	f660a3ea-2f94-4822-8aa0-dce6d5583be1
55ec1884-f9a3-488e-97b0-44c3dd714c77	2025-04-30 09:16:24.28763	2025-04-30 09:16:24.287654	\N	bc66c964-a642-4b49-b1e6-7f9a6642c19d	f660a3ea-2f94-4822-8aa0-dce6d5583be1
c1cce68e-26fb-4616-a1aa-28cd777b426d	2025-04-30 09:42:25.930336	2025-04-30 09:42:25.930347	\N	3fabb416-c340-4894-8ffa-3781cf6b6ba0	f900bf9c-443c-4386-835c-05ecb38bf4ad
a9307eeb-d625-4143-b73d-f627c6b4bc74	2025-05-05 11:16:58.435699	2025-05-05 11:16:58.435707	\N	ef5ecb0c-6ae0-4005-98db-3082b7d106dc	f900bf9c-443c-4386-835c-05ecb38bf4ad
73245450-b3c4-436e-91dd-9e2050088183	2025-05-16 10:54:47.178002	2025-05-16 10:54:47.178012	\N	6fd2fddc-9945-4d61-b84a-f70cf654ebaa	f660a3ea-2f94-4822-8aa0-dce6d5583be1
4b30556c-1149-4cd1-959a-c72f97e4cc33	2025-05-16 15:10:28.307101	2025-05-16 15:10:28.307115	\N	78370b53-4f74-47a7-a6a9-3216484db47e	f900bf9c-443c-4386-835c-05ecb38bf4ad
\.


--
-- Data for Name: user_tour_package_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_tour_package_activities (id, created_at, updated_at, deleted_at, user_tour_package_id, activity_id) FROM stdin;
73e1cefb-a292-4bb7-b68e-e65d7f390e52	2025-04-30 09:13:43.535762	2025-04-30 09:13:43.535774	\N	501a3291-2842-4d5b-8cc5-205e1ff494e3	f8f38b0e-4606-4bfe-86be-878e69008af1
3e79b468-9df0-4e7d-9ec7-4ae749273e57	2025-04-30 09:15:19.326679	2025-04-30 09:15:19.326685	\N	602b5c11-e81e-45e7-8db6-d619405388d1	f8f38b0e-4606-4bfe-86be-878e69008af1
4164bf27-8b66-4c85-9848-f7b41c703ce5	2025-04-30 09:16:24.29586	2025-04-30 09:16:24.295881	\N	bc66c964-a642-4b49-b1e6-7f9a6642c19d	f8f38b0e-4606-4bfe-86be-878e69008af1
097ec46f-558e-4fc2-8c5d-25f5d41eb054	2025-04-30 09:42:25.939927	2025-04-30 09:42:25.939937	\N	3fabb416-c340-4894-8ffa-3781cf6b6ba0	4dae83a2-4750-4b22-8227-726314e46333
88bea7d7-c97c-4e24-902a-200e059eb1af	2025-05-05 11:16:58.444713	2025-05-05 11:16:58.444722	\N	ef5ecb0c-6ae0-4005-98db-3082b7d106dc	087887c5-d76b-4ce4-b739-12cfba8d1f51
773c4412-9ece-4b84-8f26-16e59f55330b	2025-05-16 10:54:47.185607	2025-05-16 10:54:47.185615	\N	6fd2fddc-9945-4d61-b84a-f70cf654ebaa	6152dc49-7dd0-4008-a967-001bf1073b3d
d3e7f248-8c27-46c5-95d4-e1d238227bc7	2025-05-16 15:10:28.315364	2025-05-16 15:10:28.315382	\N	78370b53-4f74-47a7-a6a9-3216484db47e	3ad68c20-ebd1-4ff8-b0cc-cbc02475523b
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
72011e73-2ece-46ae-8dd9-3bae5bc96c5d	2025-04-30 09:13:43.544946	2025-04-30 09:13:43.544958	\N	501a3291-2842-4d5b-8cc5-205e1ff494e3	e33e7368-7779-4c15-adf8-06cc356226aa
0c12a746-961f-42ec-809f-07b11f63cf7c	2025-04-30 09:15:19.332787	2025-04-30 09:15:19.332808	\N	602b5c11-e81e-45e7-8db6-d619405388d1	e33e7368-7779-4c15-adf8-06cc356226aa
2a701d46-7607-49a9-9866-e5044361dc88	2025-04-30 09:16:24.305261	2025-04-30 09:16:24.305287	\N	bc66c964-a642-4b49-b1e6-7f9a6642c19d	e33e7368-7779-4c15-adf8-06cc356226aa
683875c5-8096-4ba2-a440-58dd43fb406e	2025-04-30 09:42:25.950357	2025-04-30 09:42:25.950368	\N	3fabb416-c340-4894-8ffa-3781cf6b6ba0	e25683e1-5400-4103-a74e-5e2162834b1d
7008fc4c-361e-4131-a07a-c8238ae7d09a	2025-05-05 11:16:58.451531	2025-05-05 11:16:58.45154	\N	ef5ecb0c-6ae0-4005-98db-3082b7d106dc	d2af43a3-3d9e-4075-b78b-aa31df28b8c8
2708985c-de2b-4037-b091-e06d57d16bc7	2025-05-16 10:54:47.192681	2025-05-16 10:54:47.192689	\N	6fd2fddc-9945-4d61-b84a-f70cf654ebaa	984186b4-4fa2-4961-a7d0-b983fc0590bc
ecc94cc0-06a3-42f2-9d16-a9cce9a2833d	2025-05-16 15:10:28.323539	2025-05-16 15:10:28.32355	\N	78370b53-4f74-47a7-a6a9-3216484db47e	f8ef837e-f850-4202-95c8-8546312ce134
\.


--
-- Data for Name: user_tour_packages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_tour_packages (id, created_at, updated_at, deleted_at, active, user_id, tx_ref, region_id, accommodation_id, no_of_people_attending, start_date, end_date) FROM stdin;
501a3291-2842-4d5b-8cc5-205e1ff494e3	2025-04-30 09:13:43.468362	2025-04-30 09:13:43.46838	\N	f	2c3ecbcf-f27d-44d9-85cf-c2f549cc76ca	\N	88aeb123-0ece-4259-bbb2-8d4d8be602a0	f660a3ea-2f94-4822-8aa0-dce6d5583be1	1	2025-05-04	2025-05-10
602b5c11-e81e-45e7-8db6-d619405388d1	2025-04-30 09:15:19.317994	2025-04-30 09:15:19.318006	\N	f	2c3ecbcf-f27d-44d9-85cf-c2f549cc76ca	\N	88aeb123-0ece-4259-bbb2-8d4d8be602a0	f660a3ea-2f94-4822-8aa0-dce6d5583be1	1	2025-05-04	2025-05-10
bc66c964-a642-4b49-b1e6-7f9a6642c19d	2025-04-30 09:16:24.273566	2025-04-30 09:16:24.273596	\N	f	2c3ecbcf-f27d-44d9-85cf-c2f549cc76ca	\N	88aeb123-0ece-4259-bbb2-8d4d8be602a0	f660a3ea-2f94-4822-8aa0-dce6d5583be1	1	2025-05-04	2025-05-10
3fabb416-c340-4894-8ffa-3781cf6b6ba0	2025-04-30 09:42:25.87999	2025-04-30 09:42:25.880705	\N	f	2c3ecbcf-f27d-44d9-85cf-c2f549cc76ca	\N	88aeb123-0ece-4259-bbb2-8d4d8be602a0	f900bf9c-443c-4386-835c-05ecb38bf4ad	1	2025-05-05	2025-05-10
ef5ecb0c-6ae0-4005-98db-3082b7d106dc	2025-05-05 11:16:58.416763	2025-05-05 11:16:58.41679	\N	f	2c3ecbcf-f27d-44d9-85cf-c2f549cc76ca	\N	73a32b27-99f1-465b-b723-bcbc090edcfc	f900bf9c-443c-4386-835c-05ecb38bf4ad	1	2025-05-14	2025-05-28
6fd2fddc-9945-4d61-b84a-f70cf654ebaa	2025-05-16 10:54:47.154479	2025-05-16 10:54:47.154501	\N	f	2c3ecbcf-f27d-44d9-85cf-c2f549cc76ca	\N	2ac36ee6-66f7-400f-baec-f9be9bb3602a	f660a3ea-2f94-4822-8aa0-dce6d5583be1	1	2025-05-18	2025-05-30
78370b53-4f74-47a7-a6a9-3216484db47e	2025-05-16 15:10:28.273676	2025-05-16 15:10:28.273687	\N	f	2c3ecbcf-f27d-44d9-85cf-c2f549cc76ca	\N	88aeb123-0ece-4259-bbb2-8d4d8be602a0	f900bf9c-443c-4386-835c-05ecb38bf4ad	1	2025-05-19	2025-05-30
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
-- Name: terms_conditions terms_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terms_conditions
    ADD CONSTRAINT terms_conditions_pkey PRIMARY KEY (id);


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
-- Name: terms_conditions terms_conditions_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terms_conditions
    ADD CONSTRAINT terms_conditions_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


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

