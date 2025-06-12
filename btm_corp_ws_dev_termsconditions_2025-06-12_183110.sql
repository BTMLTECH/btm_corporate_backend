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
-- Data for Name: termsconditions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.termsconditions (id, created_at, updated_at, deleted_at, title, description, tour_package_id) FROM stdin;
088d2655-653b-481b-ab79-6ac58a2ebbdb	2025-06-12 18:02:51.807326	2025-06-12 18:02:51.807385	\N	Booking & Payment	A 50% deposit is required to confirm booking. Full payment must be made at least 14 days before departure.	41a30ee3-867c-43ab-8eb4-ecc18896c65c
472e9ff4-dbf9-46b0-9473-f12290dfdb6d	2025-06-12 18:02:51.807397	2025-06-12 18:02:51.807398	\N	Visa Requirements	All travelers must possess a valid Kenya ETA prior to departure. Assistance with application will be provided.	41a30ee3-867c-43ab-8eb4-ecc18896c65c
76a416c7-9316-4ac4-bae7-37d70aeaa8a3	2025-06-12 18:02:51.807402	2025-06-12 18:02:51.807402	\N	Cancellation Policy	Cancellations made less than 14 days before travel may incur penalties. Refunds are subject to supplier terms.	41a30ee3-867c-43ab-8eb4-ecc18896c65c
b3b95867-426f-4e41-b1c0-9ab241ceebe4	2025-06-12 18:02:51.807406	2025-06-12 18:02:51.807407	\N	Child Policy	Children must be accompanied by at least one adult. Age limits may apply for some activities.	41a30ee3-867c-43ab-8eb4-ecc18896c65c
\.


--
-- Name: termsconditions termsconditions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.termsconditions
    ADD CONSTRAINT termsconditions_pkey PRIMARY KEY (id);


--
-- Name: termsconditions termsconditions_tour_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.termsconditions
    ADD CONSTRAINT termsconditions_tour_package_id_fkey FOREIGN KEY (tour_package_id) REFERENCES public.tour_packages(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

