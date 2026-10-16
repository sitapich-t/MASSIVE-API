--
-- PostgreSQL database dump
--

\restrict 5CU8iZylRgiFSZQvibClw9PztGqhvyRFaXfzbOfFUQHePL5LdDlnr7wBat5iJqJ

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: comparison_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comparison_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comparison_history_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: comparison_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comparison_history (
    id integer DEFAULT nextval('public.comparison_history_id_seq'::regclass) NOT NULL,
    stock1 character varying NOT NULL,
    stock2 character varying NOT NULL,
    timeframe character varying NOT NULL,
    "correlationCoefficient" double precision,
    "comparedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comparison_history OWNER TO postgres;

--
-- Name: economic_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.economic_event (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    event_name character varying NOT NULL,
    country character varying NOT NULL,
    impact character varying NOT NULL,
    actual character varying NOT NULL,
    forecast character varying NOT NULL,
    previous character varying NOT NULL,
    date_time character varying NOT NULL,
    sentiment character varying
);


ALTER TABLE public.economic_event OWNER TO postgres;

--
-- Name: eod_data_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eod_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.eod_data_id_seq OWNER TO postgres;

--
-- Name: eod_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eod_data (
    id integer DEFAULT nextval('public.eod_data_id_seq'::regclass) NOT NULL,
    symbol character varying NOT NULL,
    date character varying NOT NULL,
    "closePrice" double precision NOT NULL,
    volume bigint NOT NULL,
    "historicalAvgVolume" bigint DEFAULT '0'::bigint NOT NULL,
    "putVolume" bigint DEFAULT '0'::bigint NOT NULL,
    "callVolume" bigint DEFAULT '0'::bigint NOT NULL,
    "shortVolume" bigint DEFAULT '0'::bigint NOT NULL,
    "isLatest" boolean DEFAULT true NOT NULL
);


ALTER TABLE public.eod_data OWNER TO postgres;

--
-- Name: market_close_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.market_close_reports (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id character varying NOT NULL,
    watchlist_id character varying NOT NULL,
    data jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.market_close_reports OWNER TO postgres;

--
-- Name: mover_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mover_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mover_results_id_seq OWNER TO postgres;

--
-- Name: mover_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mover_results (
    id integer DEFAULT nextval('public.mover_results_id_seq'::regclass) NOT NULL,
    period character varying(4) NOT NULL,
    symbol character varying(10) NOT NULL,
    current_price numeric(12,4) NOT NULL,
    previous_close_price numeric(12,4) NOT NULL,
    change_amount numeric(12,4) NOT NULL,
    change_percent numeric(8,4) NOT NULL,
    volatility numeric(8,4) NOT NULL,
    calculated_at timestamp with time zone NOT NULL,
    type character varying(20) NOT NULL
);


ALTER TABLE public.mover_results OWNER TO postgres;

--
-- Name: price_alert_stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.price_alert_stocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.price_alert_stocks_id_seq OWNER TO postgres;

--
-- Name: price_alert_stocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_alert_stocks (
    id integer DEFAULT nextval('public.price_alert_stocks_id_seq'::regclass) NOT NULL,
    symbol character varying NOT NULL,
    name character varying NOT NULL,
    industry character varying NOT NULL,
    eod_price numeric(10,2),
    price_date date,
    market_cap numeric(20,2),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    open numeric(12,4),
    high numeric(12,4),
    low numeric(12,4),
    volume bigint
);


ALTER TABLE public.price_alert_stocks OWNER TO postgres;

--
-- Name: price_alert_stocks_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.price_alert_stocks_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.price_alert_stocks_id_seq1 OWNER TO postgres;

--
-- Name: price_alert_stocks_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.price_alert_stocks_id_seq1 OWNED BY public.price_alert_stocks.id;


--
-- Name: price_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.price_histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.price_histories_id_seq OWNER TO postgres;

--
-- Name: price_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_histories (
    id integer DEFAULT nextval('public.price_histories_id_seq'::regclass) NOT NULL,
    symbol character varying(20) NOT NULL,
    "closePrice" numeric(10,2) NOT NULL,
    date date NOT NULL
);


ALTER TABLE public.price_histories OWNER TO postgres;

--
-- Name: recovery_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recovery_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recovery_results_id_seq OWNER TO postgres;

--
-- Name: recovery_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recovery_results (
    id integer DEFAULT nextval('public.recovery_results_id_seq'::regclass) NOT NULL,
    symbol character varying NOT NULL,
    "analysisDate" date NOT NULL,
    "currentPrice" double precision NOT NULL,
    "highestPrice" double precision,
    "lowestPrice" double precision,
    "avgVolume20" double precision,
    sma50 double precision NOT NULL,
    volume double precision NOT NULL,
    "periodMonths" integer,
    "isPassed" boolean NOT NULL,
    reason text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.recovery_results OWNER TO postgres;

--
-- Name: sma_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sma_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sma_records_id_seq OWNER TO postgres;

--
-- Name: sma_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sma_records (
    id integer DEFAULT nextval('public.sma_records_id_seq'::regclass) NOT NULL,
    symbol character varying(20) NOT NULL,
    period integer NOT NULL,
    "smaValue" numeric(10,2) NOT NULL,
    "dataPointsUsed" integer NOT NULL,
    "calculatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "latestDate" date
);


ALTER TABLE public.sma_records OWNER TO postgres;

--
-- Name: stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock (
    symbol character varying(10) NOT NULL,
    company_name character varying(255) NOT NULL
);


ALTER TABLE public.stock OWNER TO postgres;

--
-- Name: stock_analysis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_analysis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_analysis_id_seq OWNER TO postgres;

--
-- Name: stock_analysis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_analysis (
    id integer DEFAULT nextval('public.stock_analysis_id_seq'::regclass) NOT NULL,
    symbol character varying NOT NULL,
    date character varying NOT NULL,
    "volumeSurgeRatio" double precision NOT NULL,
    "crowdedScore" double precision NOT NULL,
    "reversalSignal" character varying NOT NULL,
    "riskRewardRatio" double precision NOT NULL,
    "closePrice" double precision NOT NULL,
    "percentileRank" character varying NOT NULL,
    "colorZone" character varying NOT NULL,
    status character varying NOT NULL,
    volume double precision NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.stock_analysis OWNER TO postgres;

--
-- Name: stock_price_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_price_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_price_id_seq OWNER TO postgres;

--
-- Name: stock_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_price (
    id integer DEFAULT nextval('public.stock_price_id_seq'::regclass) NOT NULL,
    symbol character varying NOT NULL,
    industry character varying,
    date character varying NOT NULL,
    open double precision,
    high double precision,
    low double precision,
    close double precision,
    volume bigint
);


ALTER TABLE public.stock_price OWNER TO postgres;

--
-- Name: stock_prices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_prices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_prices_id_seq OWNER TO postgres;

--
-- Name: stock_prices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_prices (
    id integer DEFAULT nextval('public.stock_prices_id_seq'::regclass) NOT NULL,
    symbol character varying(10) NOT NULL,
    price_date date NOT NULL,
    close_price numeric(12,4) NOT NULL
);


ALTER TABLE public.stock_prices OWNER TO postgres;

--
-- Name: stocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stocks (
    id integer NOT NULL,
    eod_price numeric(10,2),
    price_date date,
    company_name character varying(255) NOT NULL,
    symbol character varying(10) NOT NULL
);


ALTER TABLE public.stocks OWNER TO postgres;

--
-- Name: stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stocks_id_seq OWNER TO postgres;

--
-- Name: stocks_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stocks_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stocks_id_seq1 OWNER TO postgres;

--
-- Name: stocks_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stocks_id_seq1 OWNED BY public.stocks.id;


--
-- Name: trade_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trade_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trade_records_id_seq OWNER TO postgres;

--
-- Name: trade_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trade_records (
    id integer DEFAULT nextval('public.trade_records_id_seq'::regclass) NOT NULL,
    symbol character varying NOT NULL,
    timeframe character varying(20) NOT NULL,
    "initialCapital" double precision NOT NULL,
    "finalBalance" double precision NOT NULL,
    profit double precision NOT NULL,
    "winRate" double precision NOT NULL,
    status character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.trade_records OWNER TO postgres;

--
-- Name: user_price_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_price_alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_price_alerts_id_seq OWNER TO postgres;

--
-- Name: user_price_alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_price_alerts (
    id integer DEFAULT nextval('public.user_price_alerts_id_seq'::regclass) NOT NULL,
    user_id character varying NOT NULL,
    symbol character varying NOT NULL,
    target_price numeric(10,2) NOT NULL,
    is_triggered boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_price_alerts OWNER TO postgres;

--
-- Name: watchlists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.watchlists (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id character varying NOT NULL,
    symbols text NOT NULL,
    comparison_period character varying(10) NOT NULL,
    report_fields text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.watchlists OWNER TO postgres;

--
-- Name: stocks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks ALTER COLUMN id SET DEFAULT nextval('public.stocks_id_seq1'::regclass);


--
-- Data for Name: comparison_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comparison_history (id, stock1, stock2, timeframe, "correlationCoefficient", "comparedAt") FROM stdin;
\.


--
-- Data for Name: economic_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.economic_event (id, event_name, country, impact, actual, forecast, previous, date_time, sentiment) FROM stdin;
21510bec-f99c-4314-8aa0-0a752f1fe82f	Federal Reserve Interest Rate Decision	USD	HIGH	5.25%	5.25%	5.50%	2026-09-09T16:38:24.263Z	\N
fb16171c-bc78-49a0-a8b1-49a5d907b4de	US Consumer Price Index (CPI) YoY	USD	HIGH	3.1%	2.9%	3.4%	2026-09-10T16:38:24.263Z	\N
67d417de-451b-4891-aa35-af9ec160ec69	Non-Farm Payrolls	USD	HIGH	180K	170K	216K	2026-09-11T16:38:24.264Z	\N
d8ec6f9a-7611-4091-8bd0-cee6bb6a8ebd	Jim Cramer's top 10 things to watch in the stock market Thursday	US	MEDIUM	CNBC	-	-	2026-09-10T13:26:24.000Z	NEUTRAL
958331dc-707c-4051-abee-a987b6097b99	Oil jumps to $105 a barrel after Middle East tanker attacks escalate - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T13:19:38.000Z	BULLISH
346dafd3-a3d7-4f41-8550-0f89cc3949d2	Algeria cuts diplomatic ties with the UAE - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T13:18:07.000Z	BEARISH
b28cf2d2-5331-49e3-bf4f-a2b6774cc5f7	VIEW ECB hikes rates as Iran war adds to inflation angst - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T12:53:54.000Z	BEARISH
2fe96142-18ac-4085-a8af-bd9f18bda866	Oracle options are doing something curious heading into earnings	US	MEDIUM	CNBC	-	-	2026-09-10T12:20:51.000Z	NEUTRAL
3be76fcb-af15-43bd-80ce-2462eebc1651	Trump touts $5,000 payout if Republicans win as Vance waits in wings - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T12:19:45.000Z	NEUTRAL
34df0827-b5b0-4a8d-9303-c08a34d44357	India hosts BRICS summit as Iran war tests bloc unity - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T11:44:53.000Z	BEARISH
f0dbc24a-1c39-41a1-b3fb-6447206606a2	A year after Charlie Kirk's death, Turning Point USA grows but Trump slips with young voters - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T11:41:54.000Z	NEUTRAL
402a4783-a685-4e3a-b3ee-4a0a9c5fb2c6	NFL's Roger Goodell is playing the international long game ahead of league's Australia debut	US	MEDIUM	CNBC	-	-	2026-09-10T11:39:21.000Z	NEUTRAL
4f788124-8835-4682-81e4-75f2f399bd1c	Iran suspends freight charge on foreign vessels carrying energy products to or from Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T11:18:49.000Z	NEUTRAL
261920f6-9b6f-4aef-a740-4b3b74bd3bd9	COMMENTARY: Asia's oil industry wants Trump to leave the Gulf, but expects he won't - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T11:09:20.000Z	NEUTRAL
cab0fc3b-5cb8-4512-b5bc-b2e288a614ba	Macy's posts strong results, raises guidance as turnaround begins to take hold	US	MEDIUM	CNBC	-	-	2026-09-10T10:56:08.000Z	NEUTRAL
ddbb0664-e368-4839-9d0c-6915f960d014	COMMENTARY: Morning Bid: Forever war? - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T10:46:08.000Z	BEARISH
0d99731f-e4a7-4bb8-87c8-fe06a9ba9662	Treasury yields move higher as investors await key wholesale inflation data	US	MEDIUM	CNBC	-	-	2026-09-10T10:44:07.000Z	BULLISH
30649597-5c11-46d7-9af7-c5114e4dd93a	OPEC oil output falls in August, Reuters survey shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T10:35:42.000Z	BEARISH
815ca95e-0625-462e-841e-2460da6ba231	Kimmel says interview with Senate candidate Talarico won't air on ABC amid FCC threats	US	MEDIUM	CNBC	-	-	2026-09-10T14:55:39.000Z	NEUTRAL
3438756a-9d0b-40ad-bd73-afae9c95a53d	Yemen's Houthis close in on Bab el-Mandeb Strait in new threat to shipping - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T14:10:30.000Z	NEUTRAL
a655418e-b04e-490c-8e72-8639efcc6b9c	Two arrested by UK police over suspected National Security Act offences relating to Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-10T13:30:31.000Z	NEUTRAL
c0bfa30d-f98e-4fd6-bfaf-8fd60db45e1d	Trump signs Russia sanctions bill into law - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T22:20:53.000Z	NEUTRAL
8e7c9fe0-31b8-42fb-87ed-d56326fcc6be	US troop deaths during Iran war exceed Pentagon count by at least four, Washington Post reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T22:08:49.000Z	BEARISH
51179362-3762-41a3-ba40-2e508a8dd313	Saudi Civil Defense lifts warnings of potential danger in several areas - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T20:48:09.000Z	BEARISH
dd604c4a-facc-4304-ab33-f55ce9ee1aa7	Republican China committee chair urges tough Trump line with Xi - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T19:34:31.000Z	NEUTRAL
7b686199-aa59-4ef2-90ae-fa0d73da4036	What it will take for us to buy the dip in DuPont. Plus, profit-taking hits cyber stocks	US	MEDIUM	CNBC	-	-	2026-09-18T18:32:55.000Z	NEUTRAL
9c8a3ab6-bdd6-4c62-ab46-8d272955d9c6	McDonald's is the new 'Value Meal,' says trader Mike Khouw	US	MEDIUM	CNBC	-	-	2026-09-18T18:11:47.000Z	NEUTRAL
3bde9359-687c-4ecc-a0fd-1f68cc735a78	Caviar and champagne: Air France's luxury shift helps ride out Iran war impact - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T17:55:36.000Z	BEARISH
373ed343-cbf6-4b14-b835-96ada8b1dcec	Nike parts ways with Kylian Mbappé, soccer superstar signs with On	US	MEDIUM	CNBC	-	-	2026-09-18T16:42:14.000Z	NEUTRAL
bd21424e-9986-4937-8995-62ecc9256bc4	We're buying more of this defensive stock ahead of an upcoming long-term catalyst	US	MEDIUM	CNBC	-	-	2026-09-18T16:14:27.000Z	NEUTRAL
9fc8168d-922c-4a22-b6c5-cf7fe368516e	Disney names CTO for the first time as media giant expands tech push	US	MEDIUM	CNBC	-	-	2026-09-18T16:14:26.000Z	NEUTRAL
9a78276d-2e1d-4dbc-a985-60ed98e0cf12	What Jim Cramer learned at NYC's flagship Apple Store for the iPhone 18 launch	US	MEDIUM	CNBC	-	-	2026-09-18T15:53:36.000Z	NEUTRAL
c2039938-ef20-4b16-8bd1-c1c867a73506	Wendy's franchisee files for Chapter 11 bankruptcy protection as burger chain struggles	US	MEDIUM	CNBC	-	-	2026-09-18T15:41:28.000Z	NEUTRAL
daec339c-97e1-412d-a475-208f140105ec	Ticket prices rise for Macklemore solo concert after Ed Sheeran tour removal	US	MEDIUM	CNBC	-	-	2026-09-18T15:33:54.000Z	BULLISH
95354f81-811f-4500-8bed-1f6f9af65a02	Sportsbooks remain king this football season, but upstarts are making a run for the money	US	MEDIUM	CNBC	-	-	2026-09-18T15:16:44.000Z	NEUTRAL
0264b8a6-5c20-444a-86b5-1bc065e30788	Jim Cramer's top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-18T13:08:59.000Z	NEUTRAL
15f7d9b5-b150-423d-adde-a603732a2f44	Trump signs Russia sanctions bill into law - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T22:20:53.000Z	NEUTRAL
aebe3cbf-0ba8-4d9c-9b2c-1141c48d2f86	US troop deaths during Iran war exceed Pentagon count by at least four, Washington Post reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T22:08:49.000Z	BEARISH
b1b42fdb-40eb-48e3-a3f8-a2807ef12a3b	Saudi Civil Defense lifts warnings of potential danger in several areas - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T20:48:09.000Z	BEARISH
7ac2a03e-2833-448f-b7bd-48e8aa359854	Republican China committee chair urges tough Trump line with Xi - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T19:34:31.000Z	NEUTRAL
75f2b79c-69c0-4b82-bfc4-2c2e5f68735a	What it will take for us to buy the dip in DuPont. Plus, profit-taking hits cyber stocks	US	MEDIUM	CNBC	-	-	2026-09-18T18:32:55.000Z	NEUTRAL
453b0507-8413-4670-b779-96010e0fb4a1	McDonald's is the new 'Value Meal,' says trader Mike Khouw	US	MEDIUM	CNBC	-	-	2026-09-18T18:11:47.000Z	NEUTRAL
d0cf5e8c-27fc-4205-84c1-56e16666a71d	Caviar and champagne: Air France's luxury shift helps ride out Iran war impact - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T17:55:36.000Z	BEARISH
6d10f74b-8075-4296-b8a6-f3d4440c04fd	Nike parts ways with Kylian Mbappé, soccer superstar signs with On	US	MEDIUM	CNBC	-	-	2026-09-18T16:42:14.000Z	NEUTRAL
14b47344-e6cb-4dd5-a92a-64a75a2aa646	We're buying more of this defensive stock ahead of an upcoming long-term catalyst	US	MEDIUM	CNBC	-	-	2026-09-18T16:14:27.000Z	NEUTRAL
4a9f4833-6bee-458f-a66d-0121142c9b75	Disney names CTO for the first time as media giant expands tech push	US	MEDIUM	CNBC	-	-	2026-09-18T16:14:26.000Z	NEUTRAL
88696264-e957-43ca-a7a9-d0a119d4fded	What Jim Cramer learned at NYC's flagship Apple Store for the iPhone 18 launch	US	MEDIUM	CNBC	-	-	2026-09-18T15:53:36.000Z	NEUTRAL
2da6f8dd-8804-49f3-8f67-051e8fd0cd18	Wendy's franchisee files for Chapter 11 bankruptcy protection as burger chain struggles	US	MEDIUM	CNBC	-	-	2026-09-18T15:41:28.000Z	NEUTRAL
d36ae032-3024-42d1-a408-23cc10b250ce	Ticket prices rise for Macklemore solo concert after Ed Sheeran tour removal	US	MEDIUM	CNBC	-	-	2026-09-18T15:33:54.000Z	BULLISH
491ce887-0122-4d1e-bbd8-eb029257e9f5	Sportsbooks remain king this football season, but upstarts are making a run for the money	US	MEDIUM	CNBC	-	-	2026-09-18T15:16:44.000Z	NEUTRAL
de5a92ee-7275-4dd6-b207-466b5feea3b5	Jim Cramer's top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-18T13:08:59.000Z	NEUTRAL
9f4569eb-b78a-4f79-995a-2b8e4b1b5e93	Trump signs Russia sanctions bill into law - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T22:20:53.000Z	NEUTRAL
7a3799f0-e30f-450b-a585-90a05701948a	US troop deaths during Iran war exceed Pentagon count by at least four, Washington Post reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T22:08:49.000Z	BEARISH
bf1f021b-a3ae-41f2-aa4f-2eebeaa8af6b	Saudi Civil Defense lifts warnings of potential danger in several areas - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T20:48:09.000Z	BEARISH
7241d52e-dd88-4e89-bdf8-c24522583fc4	Republican China committee chair urges tough Trump line with Xi - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T19:34:31.000Z	NEUTRAL
d930af47-9ae7-4bd2-a759-ed0d84d36cc2	What it will take for us to buy the dip in DuPont. Plus, profit-taking hits cyber stocks	US	MEDIUM	CNBC	-	-	2026-09-18T18:32:55.000Z	NEUTRAL
4cf8b2de-702d-4dc2-9ffd-520c0edb4fcd	McDonald's is the new 'Value Meal,' says trader Mike Khouw	US	MEDIUM	CNBC	-	-	2026-09-18T18:11:47.000Z	NEUTRAL
e6ae03f9-bec9-412b-a982-792b4dd596bb	Caviar and champagne: Air France's luxury shift helps ride out Iran war impact - Reuters	US	MEDIUM	Reuters	-	-	2026-09-18T17:55:36.000Z	BEARISH
0b878987-33ff-4ad6-a732-88d38cc4c52f	Nike parts ways with Kylian Mbappé, soccer superstar signs with On	US	MEDIUM	CNBC	-	-	2026-09-18T16:42:14.000Z	NEUTRAL
f6bbcb40-d570-4e6c-b749-5ac64ae07902	We're buying more of this defensive stock ahead of an upcoming long-term catalyst	US	MEDIUM	CNBC	-	-	2026-09-18T16:14:27.000Z	NEUTRAL
90b72841-f4a0-4a40-9a6c-c11030aad74b	Disney names CTO for the first time as media giant expands tech push	US	MEDIUM	CNBC	-	-	2026-09-18T16:14:26.000Z	NEUTRAL
d8461880-1281-4878-a257-e0e18175af27	What Jim Cramer learned at NYC's flagship Apple Store for the iPhone 18 launch	US	MEDIUM	CNBC	-	-	2026-09-18T15:53:36.000Z	NEUTRAL
c670c1f3-b584-44a6-8114-040e19027d76	Wendy's franchisee files for Chapter 11 bankruptcy protection as burger chain struggles	US	MEDIUM	CNBC	-	-	2026-09-18T15:41:28.000Z	NEUTRAL
91be3daa-3997-4f29-8218-495e5cd2b957	Ticket prices rise for Macklemore solo concert after Ed Sheeran tour removal	US	MEDIUM	CNBC	-	-	2026-09-18T15:33:54.000Z	BULLISH
3f0689a5-ce09-45a6-8e2e-85f8f440ec0f	Sportsbooks remain king this football season, but upstarts are making a run for the money	US	MEDIUM	CNBC	-	-	2026-09-18T15:16:44.000Z	NEUTRAL
cdb20c93-3485-4e06-8776-31ca66526b54	Jim Cramer's top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-18T13:08:59.000Z	NEUTRAL
6c1edf09-a4a7-41e5-8873-1977faef64e3	Jim Cramer's top 10 things to watch in the stock market Tuesday	US	MEDIUM	CNBC	-	-	2026-09-22T12:58:59.000Z	NEUTRAL
8d36b9f0-d7bb-44ed-aeb0-73e937bf621a	Flight disruptions ease at Newark, Philadelphia following equipment outage	US	MEDIUM	CNBC	-	-	2026-09-22T11:40:23.000Z	BEARISH
dd349998-5d0e-4863-8e19-c3457e511c3d	Trump set for whirlwind UN meetings with wars in Iran, Ukraine on agenda - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T11:27:07.000Z	BEARISH
0af7c364-d013-4f8a-8ccf-bcfe7acd43b1	Iran ready to reopen Strait of Hormuz if US eases military pressure and lifts blockade - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T10:29:43.000Z	NEUTRAL
8e4e7de9-b08c-4734-816e-b83f4add28c6	ECB, EU central banks oppose stablecoin bank deposit rule - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T10:20:53.000Z	NEUTRAL
f8d907c1-fdaa-4e8a-84e2-5bcb04fafea4	Saudi defence fund speeds up maritime sector push following Houthi advance - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T09:59:45.000Z	NEUTRAL
d565ecf2-84fd-4439-b630-a9f95a529fcb	Hormuz vessel traffic falls to two, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T09:05:43.000Z	BEARISH
17f8bb4c-2c88-4d37-8bc1-dec65988a36e	Russia says Ukrainian drone attack kills one in its Samara region - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T08:55:43.000Z	NEUTRAL
3388f0e4-52dd-4bcb-afbb-692e6ebb3e78	China names Hu Changsheng as new Tibet party chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T07:31:46.000Z	NEUTRAL
fcad4efb-4f6c-46ad-bc22-5dbeae5d9e7d	South African rand subdued as investors eye US-Iran talks, domestic events - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T07:24:09.000Z	NEUTRAL
a9becaec-a129-4b6e-a501-414c78046565	India's PhonePe gets initial UAE central bank nod for payment licences - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T06:49:00.000Z	NEUTRAL
4f8448dd-5c48-4d9e-bc27-5bdc0ce703f9	No bitterness over World Cup omission, Azmoun says after Iran recall - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T06:11:00.000Z	NEUTRAL
1928931e-798a-4b03-8a52-af6396c5541c	Oil rises amid worries of growing Iran-U.S. tensions after Bessent issues Iranian airline shutdown warning	US	MEDIUM	CNBC	-	-	2026-09-22T04:22:20.000Z	BULLISH
eb71e0e8-836f-4612-b500-cd3ff953c688	Rupee sways with oil and intervention cues, keeping traders light-footed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T02:58:00.000Z	NEUTRAL
5eb40edf-0771-4159-8400-d34f39168c9a	Alibaba deepens AI push with new chip, bigger model; shares jump 5% - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T02:50:00.000Z	BULLISH
3d8984e3-26f9-4b20-a6a9-2f11aa7ea3d8	Jim Cramer's top 10 things to watch in the stock market Tuesday	US	MEDIUM	CNBC	-	-	2026-09-22T12:58:59.000Z	NEUTRAL
2e9b218b-811a-44b7-8f17-9ee7c948c0e5	Flight disruptions ease at Newark, Philadelphia following equipment outage	US	MEDIUM	CNBC	-	-	2026-09-22T11:40:23.000Z	BEARISH
19cf3c4d-e3a4-4934-a9ef-e99f2b58a4ad	Trump set for whirlwind UN meetings with wars in Iran, Ukraine on agenda - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T11:27:07.000Z	BEARISH
93c01aec-8c7c-41d9-b9fa-915df2dd213f	Iran ready to reopen Strait of Hormuz if US eases military pressure and lifts blockade - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T10:29:43.000Z	NEUTRAL
e43d3049-5574-43ae-9124-357b57c3ccab	ECB, EU central banks oppose stablecoin bank deposit rule - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T10:20:53.000Z	NEUTRAL
c4486595-32de-4eef-9637-30c4f30dd80f	Saudi defence fund speeds up maritime sector push following Houthi advance - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T09:59:45.000Z	NEUTRAL
3cffc26c-65cc-48c8-85b7-065691bfdffb	Hormuz vessel traffic falls to two, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T09:05:43.000Z	BEARISH
f372d7ca-5083-4580-8475-415f570f5210	Russia says Ukrainian drone attack kills one in its Samara region - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T08:55:43.000Z	NEUTRAL
7b2052d6-e840-4c7d-9303-e65b4ab8505f	China names Hu Changsheng as new Tibet party chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T07:31:46.000Z	NEUTRAL
c5b26886-eeb3-4b3b-a342-f12ba4728c76	South African rand subdued as investors eye US-Iran talks, domestic events - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T07:24:09.000Z	NEUTRAL
e056fbb9-af28-4692-8841-1532ee889963	India's PhonePe gets initial UAE central bank nod for payment licences - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T06:49:00.000Z	NEUTRAL
d21c554b-7934-4289-b39c-b8abaa13e624	No bitterness over World Cup omission, Azmoun says after Iran recall - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T06:11:00.000Z	NEUTRAL
3abe468d-3489-4f23-ba4f-2c1240e92e02	Oil rises amid worries of growing Iran-U.S. tensions after Bessent issues Iranian airline shutdown warning	US	MEDIUM	CNBC	-	-	2026-09-22T04:22:20.000Z	BULLISH
5f6382e7-a0a4-45e7-895f-652203d400be	Rupee sways with oil and intervention cues, keeping traders light-footed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T02:58:00.000Z	NEUTRAL
a7260bba-cdf5-48d0-a488-fa7b80145897	Alibaba deepens AI push with new chip, bigger model; shares jump 5% - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T02:50:00.000Z	BULLISH
1994c375-d068-4466-9b83-cf4343075561	South Korea pushes for Trump summit with renegade North Korea, seeing opportunity for peace	US	MEDIUM	CNBC	-	-	2026-09-23T09:22:51.000Z	NEUTRAL
e00a873b-bd36-4097-8f54-f70a05132fc8	The craziest, most ridiculous faces at the World Gurning Championships - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T08:53:21.000Z	NEUTRAL
d77746bc-98e3-4624-baf6-a8ad43b295c3	Gold retreats as hawkish Fed comments reinforce policy tightening bets - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T04:53:00.000Z	NEUTRAL
2520b132-9e61-41d1-9ecd-f8061b78505e	Rupee slips as dollar gets Fed hike expectations tailwind - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:46:00.000Z	NEUTRAL
be1fc37c-f33a-46f9-9964-4fcdc309f7b6	Shipping traffic via Strait of Hormuz stays below 10-day average, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:39:00.000Z	NEUTRAL
50545dd3-ffa4-4a49-aa80-961bd77517d0	European stocks gain as oil slides, AI buzz lifts tech - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:51:00.000Z	BULLISH
b469b837-7409-4c1c-befb-f13c5dfadef1	Oil holds near two-week lows while diesel cracks hit record peak - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:44:00.000Z	NEUTRAL
c40cb014-9813-42fd-8ea7-f9e25678e045	Dollar at 2-month highs as Fed outlook 'dominant' - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:43:00.000Z	BULLISH
daf2710c-a4ec-45b0-b18e-657848085cc9	South Korea plans to cut its reliance on Middle East crude oil imports to 50% by 2035 - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T00:42:00.000Z	BEARISH
01f516c7-a34d-423a-aa00-b3523a0f6c4c	Trump supports diesel export ban as fuel prices hit records - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T23:22:15.000Z	NEUTRAL
f9b2c9b4-0e0f-426d-a3ab-8aaa27bc7281	Qantas to start selling tickets next year for its New York to Sydney nonstop flight	US	MEDIUM	CNBC	-	-	2026-09-22T23:00:01.000Z	NEUTRAL
c74f6eb1-5e1e-4a61-80fb-adfb99bf7584	Trump warns in UN speech he could 'annihilate' Iran without peace deal - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T21:07:29.000Z	BEARISH
b9771b89-b65c-4f69-b18c-e202bcc7d1b6	A top chip stock analyst sees big things for Nvidia, Broadcom. How his case aligns with ours	US	MEDIUM	CNBC	-	-	2026-09-22T20:43:48.000Z	NEUTRAL
02b10989-78e6-41d4-bc85-9ee4885c1ce1	PODCAST: Trump's UN speech, ICC sanctions and Turkey's LGBTQ+ crackdown (Updated) - Reuters	US	MEDIUM	Reuters	-	-	2026-09-22T20:31:42.000Z	NEUTRAL
f65893b2-ca23-4618-8d1b-04952e0f2485	Canada is giving C$100 million in international aid for Palestine, says Carney - reuters.com	US	MEDIUM	Reuters	-	-	2026-09-22T20:25:06.000Z	NEUTRAL
c1048ffe-3d4e-4ad9-ac56-3de2785b7aa7	First US-Iran talks in months raise hopes for progress despite no concessions - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:35:54.000Z	NEUTRAL
520cb586-66eb-4460-a1f5-93bcd305252e	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:15:11.000Z	NEUTRAL
d40d1a7f-2b54-4e00-a8c7-79e822d0b38f	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
6be110a1-95e7-4a0c-beeb-2b5d3db4b9b2	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
ab1086e5-7129-4588-a252-4a9dc2125cc3	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
95d513c6-93a3-451c-840d-c0f27f234b1a	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
36537e25-e3b2-4edb-9542-c4212fea5231	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
2d0dd526-815e-4b46-967e-02dc4660081a	PODCAST: Crude hopes - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:36:18.000Z	NEUTRAL
7fd5e4ab-3d86-438e-a527-aaddac3082e7	South Korea pushes for Trump summit with renegade North Korea, seeing opportunity for peace	US	MEDIUM	CNBC	-	-	2026-09-23T09:22:51.000Z	NEUTRAL
658677ea-6d6f-4a0e-9f21-f7ec753076d3	Gold loses shine as rate hike bets foster a stronger dollar - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T04:53:00.000Z	NEUTRAL
7aab9aa5-041b-449d-89d5-9b86f67cd6a1	Rupee slips as dollar gets Fed hike expectations tailwind - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:46:00.000Z	NEUTRAL
38900271-5cdf-4292-9bf6-d909db7c044d	Shipping traffic via Strait of Hormuz stays below 10-day average, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:39:00.000Z	NEUTRAL
2a89fb55-a1c9-40a4-90cb-8a8c6bf77d43	Global stocks stall, oil ticks up as investors await Mideast peace signals - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:51:00.000Z	NEUTRAL
94f921df-d72f-4139-865a-5c9100cabb31	Oil holds near two-week lows while diesel cracks hit record peak - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:44:00.000Z	NEUTRAL
5a7cc24d-4908-415b-80d4-3ece449034d0	Dollar hits near two-month high on Fed rate hike prospects - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:43:00.000Z	BULLISH
ca3eef52-9608-46e1-8e53-dda2355c9ede	First US-Iran talks in months raise hopes for progress despite no concessions - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:35:54.000Z	NEUTRAL
51deffed-56da-4f29-b3d8-e9b0979cd860	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:15:11.000Z	NEUTRAL
2fa7ad42-00cd-4f20-9e5d-615477870812	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
23c0f83c-1ff2-420f-bd4a-e8eb650a4ee8	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
efaefa3f-3e5b-4531-8169-18648bc870af	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
526869dd-1485-4eb2-a05b-1052f3263ac8	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
fc18a9f4-d059-4d2e-b0c8-f39752719f97	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
ceddb2cb-62a4-4f96-915e-895a2f328731	PODCAST: Crude hopes - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:36:18.000Z	NEUTRAL
79b1317f-d821-4ebb-b85d-f22e01f7ef0b	South Korea pushes for Trump summit with renegade North Korea, seeing opportunity for peace	US	MEDIUM	CNBC	-	-	2026-09-23T09:22:51.000Z	NEUTRAL
82668033-db02-4529-91ef-2a2dde689278	Gold loses shine as rate hike bets foster a stronger dollar - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T04:53:00.000Z	NEUTRAL
d44d187e-05de-487b-b7bd-7051b9a25003	Rupee slips as dollar gets Fed hike expectations tailwind - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:46:00.000Z	NEUTRAL
2e401eec-0136-459d-a570-4a6c339c7136	Shipping traffic via Strait of Hormuz stays below 10-day average, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:39:00.000Z	NEUTRAL
013d9048-8e6c-4a77-bc61-3dc14bef7583	Global stocks stall, oil ticks up as investors await Mideast peace signals - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:51:00.000Z	NEUTRAL
beda2c46-262a-4ec5-abe1-e1e9dd66850e	Oil holds near two-week lows while diesel cracks hit record peak - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:44:00.000Z	NEUTRAL
d28aee6b-d944-4cc7-a375-5976632d9a48	Dollar hits near two-month high on Fed rate hike prospects - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:43:00.000Z	BULLISH
4d5233d4-feef-452b-8788-437399bfd230	First US-Iran talks in months raise hopes for progress despite no concessions - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:35:54.000Z	NEUTRAL
a29e9e8e-da92-4cd6-87c2-deb5069d2d18	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:15:11.000Z	NEUTRAL
63a5cd74-f516-4888-b2fa-1c6ddaae469f	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
5e3f1f45-25ed-4183-b14f-db6a503688f4	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
0dd9b10a-ff19-49be-8435-9e1b6f46746e	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
cbcbcf5a-2ddc-446a-8f0c-5547ab773ec3	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
58586cea-4deb-48a0-b50b-2c186edbbda1	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
e2bc60f9-e62a-40c7-b7b1-bb5f203a2bc5	PODCAST: Crude hopes - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:36:18.000Z	NEUTRAL
1af14339-fd00-4d70-bb45-7b5f716ef829	South Korea pushes for Trump summit with renegade North Korea, seeing opportunity for peace	US	MEDIUM	CNBC	-	-	2026-09-23T09:22:51.000Z	NEUTRAL
32ec92de-7b54-49e1-a9bb-0a3a93aadfe1	Gold loses shine as rate hike bets foster a stronger dollar - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T04:53:00.000Z	NEUTRAL
5672e280-d5e0-418e-ad2d-d354c2077ba4	Rupee slips as dollar gets Fed hike expectations tailwind - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:46:00.000Z	NEUTRAL
42e36c73-688a-4b23-9eee-0f7b710307f4	Shipping traffic via Strait of Hormuz stays below 10-day average, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:39:00.000Z	NEUTRAL
b8fa95b5-a441-489e-9d7a-39dd824ff019	Global stocks stall, oil ticks up as investors await Mideast peace signals - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:51:00.000Z	NEUTRAL
b5537300-7774-410b-bb9b-3ad00c39ec02	Oil holds near two-week lows while diesel cracks hit record peak - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:44:00.000Z	NEUTRAL
dc2d2826-d366-4ff3-95ab-94527494df94	Dollar hits near two-month high on Fed rate hike prospects - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:43:00.000Z	BULLISH
c19eb77c-6709-4bb6-839c-2fe5cb3d1dad	First US-Iran talks in months raise hopes for progress despite no concessions - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:35:54.000Z	NEUTRAL
76e2744f-6a6c-4a9f-8d53-b949dc31e338	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:15:11.000Z	NEUTRAL
d3ab6380-8572-4a70-ad7d-4f479bbe4773	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
1256a910-f1d5-444a-b46a-33c699d615c0	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
6dd65a30-6c64-4ef5-a481-3abab84ee0f8	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
061b6d88-905f-4a0f-922a-7045c41283a7	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
54e84a3e-3170-4265-a209-a5aef8fedce5	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
e6e81776-e5ac-42f7-bcb9-1f51943fdad1	PODCAST: Crude hopes - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:36:18.000Z	NEUTRAL
06b7284f-f605-456b-888b-0637c3cd72d7	South Korea pushes for Trump summit with renegade North Korea, seeing opportunity for peace	US	MEDIUM	CNBC	-	-	2026-09-23T09:22:51.000Z	NEUTRAL
e45dedac-d7ff-429e-9259-426ba87d3cdb	Gold loses shine as rate hike bets foster a stronger dollar - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T04:53:00.000Z	NEUTRAL
14337927-65be-4dd5-b256-e5458266d46b	Rupee slips as dollar gets Fed hike expectations tailwind - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:46:00.000Z	NEUTRAL
533d29e2-24aa-4039-9439-78b3ff33abb6	Shipping traffic via Strait of Hormuz stays below 10-day average, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:39:00.000Z	NEUTRAL
c52d80f5-5dbc-46a9-b44b-9d7579d7ed85	Global stocks stall, oil ticks up as investors await Mideast peace signals - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:51:00.000Z	NEUTRAL
6654ad94-b870-47e4-815e-233585206ec2	Oil holds near two-week lows while diesel cracks hit record peak - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:44:00.000Z	NEUTRAL
b0a87098-7692-43fb-b296-0aad2dbfce24	Dollar hits near two-month high on Fed rate hike prospects - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:43:00.000Z	BULLISH
a17eaeec-26e3-4d89-89cb-8fd5240685f1	First US-Iran talks in months raise hopes for progress despite no concessions - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:35:54.000Z	NEUTRAL
47c03843-79b3-4296-9773-ecfeb75d4136	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:15:11.000Z	NEUTRAL
c20f827e-6691-4617-85b4-d3e044428a3b	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
80e72200-0cd8-4a35-a69c-114a665dfc31	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
2dd3c5dd-aad6-49cb-b28a-f6652d939dc2	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
adaa9cdc-39ec-4bc3-9bc6-aae3074681d8	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
32c56f2f-e7a8-4e40-b1eb-e4413d21ba86	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
9fe6a258-b700-4693-ac9d-92a4278abbb6	PODCAST: Crude hopes - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:36:18.000Z	NEUTRAL
d66225b3-a89b-4940-870b-e02a2932086d	South Korea pushes for Trump summit with renegade North Korea, seeing opportunity for peace	US	MEDIUM	CNBC	-	-	2026-09-23T09:22:51.000Z	NEUTRAL
5a04ffb8-356b-4c51-8b48-b529744fd483	Gold loses shine as rate hike bets foster a stronger dollar - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T04:53:00.000Z	NEUTRAL
c0b83967-6ee4-4cbd-a9ec-60dc1d319a02	Rupee slips as dollar gets Fed hike expectations tailwind - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:46:00.000Z	NEUTRAL
ecdc92cd-68ed-49b8-a150-a5846970dc48	Shipping traffic via Strait of Hormuz stays below 10-day average, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:39:00.000Z	NEUTRAL
634494d8-f879-42ee-884f-aafe6c2f6a39	Global stocks stall, oil ticks up as investors await Mideast peace signals - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:51:00.000Z	NEUTRAL
9515fa47-d271-46d9-a733-f160ecdb74f5	Oil holds near two-week lows while diesel cracks hit record peak - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:44:00.000Z	NEUTRAL
41191844-604e-4c3c-83e3-4c9b336b298a	Dollar hits near two-month high on Fed rate hike prospects - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:43:00.000Z	BULLISH
78dce987-0394-4aa4-bc17-a0284acb9c16	First US-Iran talks in months raise hopes for progress despite no concessions - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:35:54.000Z	NEUTRAL
11afe6e5-5da3-4074-9958-de3db4fc6dcd	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:15:11.000Z	NEUTRAL
a906aece-4823-4056-9a72-abe287a471f8	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
8f8f63e9-705f-4915-99f6-6cec70e6ee40	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
2d34e102-dbb1-4b05-a47f-cb1b437d6ad0	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
4a65596b-7f66-4c60-8d22-52b92127c536	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
73a7b7ea-10ed-4801-b0b8-bf62631023f7	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
ccfdff01-8dd7-4e3e-96fc-4a1a3c13b8d9	PODCAST: Crude hopes - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:36:18.000Z	NEUTRAL
62aac648-c51a-4b93-90d5-47173c1387ce	South Korea pushes for Trump summit with renegade North Korea, seeing opportunity for peace	US	MEDIUM	CNBC	-	-	2026-09-23T09:22:51.000Z	NEUTRAL
6dc68f07-5d86-4603-8c92-7d43382e9700	Gold loses shine as rate hike bets foster a stronger dollar - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T04:53:00.000Z	NEUTRAL
0f01274a-7bfd-47e1-94c2-f593949af3bc	Rupee slips as dollar gets Fed hike expectations tailwind - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:46:00.000Z	NEUTRAL
edc92baa-fa92-4b16-a4b6-ee4bbee65d8c	Shipping traffic via Strait of Hormuz stays below 10-day average, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:39:00.000Z	NEUTRAL
2e5951d3-30ce-4c50-9628-5688faf86599	Global stocks stall, oil ticks up as investors await Mideast peace signals - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:51:00.000Z	NEUTRAL
9d7a3ba0-e183-4920-a0a9-c4e3e1bdda1d	Oil holds near two-week lows while diesel cracks hit record peak - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:44:00.000Z	NEUTRAL
429101ba-ef9f-4c29-809b-7dc847eef66c	Dollar hits near two-month high on Fed rate hike prospects - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:43:00.000Z	BULLISH
c79e23e9-a4bd-40ea-9707-7f8b3da915b8	First US-Iran talks in months raise hopes for progress despite no concessions - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:35:54.000Z	NEUTRAL
7b2e5954-bb7e-4c58-973d-77a0ad9b2d07	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:15:11.000Z	NEUTRAL
236004d4-bc4d-44e5-bbdf-909ce905b069	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
0517f900-accf-45f9-8bb8-32cb087dae08	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
ffadc778-0f28-414d-bc38-5c9881661642	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
ff04344a-bbf0-4661-8554-426071fc4612	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
0f927b2a-7d9c-44dd-b698-8e0b7e77a660	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
70581d7c-7029-4d44-9429-fdc2d15dfc2b	PODCAST: Crude hopes - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:36:18.000Z	NEUTRAL
4cab8ddf-f682-4f73-b594-5f7f552947c4	South Korea pushes for Trump summit with renegade North Korea, seeing opportunity for peace	US	MEDIUM	CNBC	-	-	2026-09-23T09:22:51.000Z	NEUTRAL
4b5713a1-f169-4637-88f1-95228086e765	Gold loses shine as rate hike bets foster a stronger dollar - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T04:53:00.000Z	NEUTRAL
676c3436-6c08-4184-924e-e753269ba71b	Rupee slips as dollar gets Fed hike expectations tailwind - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:46:00.000Z	NEUTRAL
57598c9b-e9ba-4615-9883-11734e38c69a	Shipping traffic via Strait of Hormuz stays below 10-day average, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T02:39:00.000Z	NEUTRAL
fed2bff6-c5f5-4f6c-90c6-ad80acbb3669	Global stocks stall, oil ticks up as investors await Mideast peace signals - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:51:00.000Z	NEUTRAL
8ca77637-e2f7-4388-a8d1-fe06a1f26830	Oil holds near two-week lows while diesel cracks hit record peak - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:44:00.000Z	NEUTRAL
e34dd500-afe2-4622-b1f6-ede2be481c7d	Dollar hits near two-month high on Fed rate hike prospects - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T01:43:00.000Z	BULLISH
aedfb722-1e6a-4838-83e5-92598ed0294b	History rhymes for Meta, and our plan for Micron ahead of earnings	US	MEDIUM	CNBC	-	-	2026-09-23T15:25:04.000Z	NEUTRAL
d75ca345-52fc-4e6a-a410-b3baf27fa9fc	Pezeshkian says Iran won't surrender, after Trump's annihilation threat - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T15:00:05.000Z	NEUTRAL
cbbcf692-850a-4dfe-8c5a-1e2f56c140a0	72% of Americans would slow financial progress to enjoy life now, SoFi survey finds	US	MEDIUM	CNBC	-	-	2026-09-23T13:19:37.000Z	NEUTRAL
d30ebe35-9ad9-4835-8021-1b7de5ec5d66	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:15:11.000Z	NEUTRAL
34016b9a-90b7-4f39-a0ea-e3a62aeaa315	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
0349af4c-8446-423f-99ea-ee9c0c1284f0	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
3d8938f3-b04b-4f05-9f72-d27fdc56234e	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
fd73d369-faea-4d15-815f-55eaf8b8f288	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
a1218298-8567-46f5-aae0-d711cce11662	Global gas market pricing prolonged tightness due to Iran war, IGU executive says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T11:47:45.000Z	BEARISH
a1768be3-b9d6-40f6-ab96-41a6a5170f82	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
5979cf8c-33fa-4b89-8115-4a1528cde615	UK's FTSE 100 up as banks gain, oil prices steady - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:53:43.000Z	BULLISH
d6deeaae-182a-4abd-abe4-7e4bed6b15f9	PODCAST: Crude hopes - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:36:18.000Z	NEUTRAL
ad2d10ff-b319-4690-8633-b29a4c897532	South Korea pushes for Trump summit with renegade North Korea, seeing opportunity for peace	US	MEDIUM	CNBC	-	-	2026-09-23T09:22:51.000Z	NEUTRAL
37eba761-506a-45b8-a113-3b0409d463e1	OECD raises Turkey inflation forecast, trims growth outlook - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T08:03:44.000Z	BULLISH
f1ed8066-ee6f-46bc-bc88-39cee0dfeab9	Gold loses shine as rate hike bets foster a stronger dollar - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T04:53:00.000Z	NEUTRAL
c14b24c4-9275-4f5e-a317-f682ff4a6193	History rhymes for Meta, and our plan for Micron ahead of earnings	US	MEDIUM	CNBC	-	-	2026-09-23T15:25:04.000Z	NEUTRAL
90965068-d128-44e9-b7b4-ce755d708b18	Pezeshkian says Iran won't surrender, after Trump's annihilation threat - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T15:00:05.000Z	NEUTRAL
509b9617-2619-4849-a5d9-19f43c4ccf4f	72% of Americans would slow financial progress to enjoy life now, SoFi survey finds	US	MEDIUM	CNBC	-	-	2026-09-23T13:19:37.000Z	NEUTRAL
06261cb8-b826-44a4-94c2-8cc33e2ad91a	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:15:11.000Z	NEUTRAL
100523aa-da0c-4bb1-96af-59c888f637ef	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
be7a8e52-03c9-4484-b903-2476b129b8ed	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
3b0ec4ad-424f-4738-a09d-09f9cc251e84	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
19c7dd6c-b78e-4e82-ba7d-0b68505b317a	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
79daf823-f6f9-44d1-8bda-bb1feb817950	Global gas market pricing prolonged tightness due to Iran war, IGU executive says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T11:47:45.000Z	BEARISH
41031083-679a-410b-8b48-4910485f27fb	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
347947d1-20c9-46b5-a3b8-d72fef4499f0	UK's FTSE 100 up as banks gain, oil prices steady - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:53:43.000Z	BULLISH
1d72a17a-3de1-4afe-a7a0-3d0e91ae87ca	PODCAST: Crude hopes - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:36:18.000Z	NEUTRAL
f43bcea1-91bb-4a7d-a3ff-f6fdb51afcc0	South Korea pushes for Trump summit with renegade North Korea, seeing opportunity for peace	US	MEDIUM	CNBC	-	-	2026-09-23T09:22:51.000Z	NEUTRAL
f953c01a-74a1-4278-9c8e-b3891a94afcf	OECD raises Turkey inflation forecast, trims growth outlook - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T08:03:44.000Z	BULLISH
a8aa96f1-6982-4d92-9491-1a7662e6c87d	Gold loses shine as rate hike bets foster a stronger dollar - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T04:53:00.000Z	NEUTRAL
0ef75c1b-6624-418e-a91c-3a72e65afed8	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T16:34:44.000Z	NEUTRAL
14260bd4-0e51-460d-b0fd-988b2d970130	Meta is having a ChatGPT moment with Muse. What is it and what makes it so special	US	MEDIUM	CNBC	-	-	2026-09-23T16:22:24.000Z	NEUTRAL
ad2e6801-cc59-4777-906f-3f6d5bfa5e78	Iran's Pezeshkian accuses Trump of 'bullying mentality,' vows no surrender - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T15:52:40.000Z	NEUTRAL
625fbddf-ac22-45dc-ba2c-a0fce6e17bb4	History rhymes for Meta, and our plan for Micron ahead of earnings	US	MEDIUM	CNBC	-	-	2026-09-23T15:25:04.000Z	NEUTRAL
d5b8357b-4998-4b96-acc1-007ac2c15327	Pezeshkian says Iran won't surrender, after Trump's annihilation threat - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T15:00:05.000Z	NEUTRAL
a9ec974d-7040-4c5f-bfcf-19073f567ae4	Gold loses shine as rate hike bets foster a stronger dollar - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T13:32:07.000Z	NEUTRAL
4c0648dd-86c2-49d8-a6c8-ec996567432c	72% of Americans would slow financial progress to enjoy life now, SoFi survey finds	US	MEDIUM	CNBC	-	-	2026-09-23T13:19:37.000Z	NEUTRAL
d1c7769b-85a8-4ee2-8662-11fe16eae4ba	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
4b4574b3-4fa4-475b-b496-bc005d818020	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
85ac52a1-b0d4-4a14-92f6-b4601ab03ecf	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
9399663c-e03b-411e-bbdb-1ea94bb24243	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
ccef92d8-9da2-4d53-b210-af841236b37a	Global gas market pricing prolonged tightness due to Iran war, IGU executive says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T11:47:45.000Z	BEARISH
c712815e-117c-4c01-87fd-a9a007f1ad07	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
f5d56e4a-b5e7-4b5a-b5a2-82e8053d92e4	UK's FTSE 100 up as banks gain, oil prices steady - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:53:43.000Z	BULLISH
4fc30fca-4832-4dc2-8997-d8078f1a5454	PODCAST: Crude hopes - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T09:36:18.000Z	NEUTRAL
88e3b0f5-5f88-46af-91c9-83c152958986	FTSE 100 muted as energy gains offset broader drag; Iran, Xi visit watched - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T16:49:31.000Z	BULLISH
74c73207-6437-4b63-b943-83a523b48803	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T16:34:44.000Z	NEUTRAL
a591b42e-f9be-4973-a8c3-8e95b0e2aa10	Meta is having a ChatGPT moment with Muse. What is it and what makes it so special	US	MEDIUM	CNBC	-	-	2026-09-23T16:22:24.000Z	NEUTRAL
8beeedd5-a35e-49b7-aca3-509732dd9f61	Iran's Pezeshkian accuses Trump of 'bullying mentality,' vows no surrender - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T15:52:40.000Z	NEUTRAL
2df12593-b5dd-4446-b9c4-54158272c5eb	History rhymes for Meta, and our plan for Micron ahead of earnings	US	MEDIUM	CNBC	-	-	2026-09-23T15:25:04.000Z	NEUTRAL
5cbe225c-f6b2-48d7-99a7-34f26b0f2ad0	Pezeshkian says Iran won't surrender, after Trump's annihilation threat - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T15:00:05.000Z	NEUTRAL
6adc078c-00d4-429a-9496-a17f316b7742	Florida fund sues New York Times for records concerning editorial standards - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T14:45:19.000Z	NEUTRAL
a81d3a9b-289a-4a41-a6fb-db135fa1d94b	Iran threatens to paralyse airports in neighbouring countries if they stop Iranian flights - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T14:11:36.000Z	NEUTRAL
c0b640d4-f2df-4894-9ec8-30b2767ddf7b	72% of Americans would slow financial progress to enjoy life now, SoFi survey finds	US	MEDIUM	CNBC	-	-	2026-09-23T13:19:37.000Z	NEUTRAL
31d3cc7b-a088-48bd-9743-3bc536bca354	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
e141d896-e9a2-4f50-a55a-f8340241dc66	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
82525f4d-8a51-4cce-b781-021827f3f136	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
f774a765-64eb-4792-a3aa-1dce6a7e9431	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
965d0e97-a389-4cb5-838f-f66600e44685	Global gas market pricing prolonged tightness due to Iran war, IGU executive says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T11:47:45.000Z	BEARISH
1978d0fb-a615-46ec-bb58-4761e7e2321b	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
1aa7b8bd-e3cd-4f18-8846-a832ca487434	FTSE 100 muted as energy gains offset broader drag; Iran, Xi visit watched - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T16:49:31.000Z	BULLISH
9e413929-d95f-4e7e-8641-aff0e5266146	Trump plans grand spectacle for potentially tense Xi talks - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T16:34:44.000Z	NEUTRAL
95641e3a-d8f5-4a4b-a6df-568f86f6142c	Meta is having a ChatGPT moment with Muse. What is it and what makes it so special	US	MEDIUM	CNBC	-	-	2026-09-23T16:22:24.000Z	NEUTRAL
4c9e9de4-5dc0-4edf-9d84-b6750f3ad19b	Iran's Pezeshkian accuses Trump of 'bullying mentality,' vows no surrender - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T15:52:40.000Z	NEUTRAL
67c3e1c1-a793-4d95-af47-c8efcc7d32ff	History rhymes for Meta, and our plan for Micron ahead of earnings	US	MEDIUM	CNBC	-	-	2026-09-23T15:25:04.000Z	NEUTRAL
6216d945-f621-4451-ba40-598efa6e8987	Pezeshkian says Iran won't surrender, after Trump's annihilation threat - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T15:00:05.000Z	NEUTRAL
0be25f7f-11e9-4b61-aeba-3650cfd50b5f	Florida fund sues New York Times for records concerning editorial standards - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T14:45:19.000Z	NEUTRAL
288f8a88-7822-4af2-b44b-6cf06cddcfc8	Iran threatens to paralyse airports in neighbouring countries if they stop Iranian flights - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T14:11:36.000Z	NEUTRAL
23951fca-bf77-41d8-a194-2b3337a29494	72% of Americans would slow financial progress to enjoy life now, SoFi survey finds	US	MEDIUM	CNBC	-	-	2026-09-23T13:19:37.000Z	NEUTRAL
c184f891-9a56-4842-bb49-ae91d4e5e473	Typical job search advice isn't working in today's market. Experts' new rules for landing a role right now	US	MEDIUM	CNBC	-	-	2026-09-23T13:15:01.000Z	NEUTRAL
3ae990c5-fb06-4454-8f97-fa9d55b87913	Our top 10 things to watch in the stock market Wednesday	US	MEDIUM	CNBC	-	-	2026-09-23T13:08:43.000Z	NEUTRAL
a94883f3-be33-4fe8-bdaa-c20056c02331	IonQ shares rally after company says it made a major quantum computing breakthrough	US	MEDIUM	CNBC	-	-	2026-09-23T12:35:15.000Z	NEUTRAL
8f539042-1f78-4094-9566-ce480e577d4b	Four killed in Gaza in strikes, Israel says it killed a Hamas finance chief - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T12:15:59.000Z	BEARISH
e7134f1a-25fb-4373-9e3f-87e3beed6ba9	Global gas market pricing prolonged tightness due to Iran war, IGU executive says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T11:47:45.000Z	BEARISH
d985bd50-89da-456d-a4f6-c6db6bfe09cd	Trump's Board of Peace to unveil $2.45 billion Gaza recovery plan, Axios reports - Reuters	US	MEDIUM	Reuters	-	-	2026-09-23T10:12:00.000Z	NEUTRAL
d6bf433a-5173-4b31-bf41-0d405498364b	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
44c21d50-93d7-4f7c-b61e-9b355a5136fa	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
1f3923bc-6a4e-4f98-8798-234afa5615b6	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
3402bab9-cb93-4357-8626-7d3283965777	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
21755c56-73e4-447f-8147-222207b41822	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
d941fbc7-a0e4-49f9-a7b1-fc137a7492fa	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
fbcfcbd5-2ddb-4d08-9cca-94ad7516b1ed	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
cdd47e31-18b3-432f-8ab7-996a203468b7	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
45a23c57-fdc8-4c9d-97a9-7f52faece126	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
9a115b9d-6420-47b3-aa1f-8a276577c020	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
00416a92-9e3b-4a0a-ad39-5145ba8891bf	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:54:00.000Z	NEUTRAL
e10bd1f6-edf7-4214-9c31-52bc1224389a	Oil slides as US-Iran truce hopes outweigh Houthi attacks on Saudi Arabia - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:11:00.000Z	NEUTRAL
9b895c02-9b94-4397-9560-ba5faf17f520	Russian, Iranian foreign ministers say only diplomatic solution to conflict around Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:58:00.000Z	NEUTRAL
a8030304-bbe4-4191-b17d-e9d8d0e1fe30	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:17:00.000Z	NEUTRAL
a682cb01-75c3-4836-a3b4-f654728b678f	Iran's president says it is up to US to choose if it wants to end Iran war - Reuters	US	MEDIUM	Reuters	-	-	2026-09-24T23:42:35.000Z	BEARISH
989fdb68-8f72-4bba-bbe4-b2877f0e54f6	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
e7e3098e-a322-4394-9980-738fbed8b135	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
b7cab294-c8c2-4055-9e4a-00496cc7b05d	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
ae57d08c-50ad-4114-83e0-115b4eb82b9c	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
57557dc0-203b-454b-8d42-95fec896c9b5	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
ee21910f-3879-4568-9fd0-3a18f23e615e	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
5e77ae3c-8436-47ef-8326-9e6ce7e91912	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
c0a274d4-7d39-4e6d-b994-b482534073d2	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
5478a1d9-d9e4-4953-991f-909e458b089f	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
fdf2cb39-66eb-42da-a0ba-8d80ac8bea1e	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
59b2d99b-d4c3-4e52-8c73-9ae72b39fc27	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:54:00.000Z	NEUTRAL
37dbba45-f8c9-470b-81a5-d855dc8c3609	Oil slides as US-Iran truce hopes outweigh Houthi attacks on Saudi Arabia - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:11:00.000Z	NEUTRAL
530fbc19-63ea-490a-a252-13b7a008b65c	Russian, Iranian foreign ministers say only diplomatic solution to conflict around Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:58:00.000Z	NEUTRAL
c918dcac-2058-468e-b076-294163667341	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:17:00.000Z	NEUTRAL
b2b3b10f-cfbd-41d8-ae4a-5afbfb430981	Iran's president says it is up to US to choose if it wants to end Iran war - Reuters	US	MEDIUM	Reuters	-	-	2026-09-24T23:42:35.000Z	BEARISH
bad96d15-47d2-4971-8e93-2f12d1a600fc	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
29429f47-1549-4187-a6f5-947121802cd5	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
71122517-b5d1-4fff-a113-f0edad639c41	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
10365786-356b-4d09-a596-a96c02817410	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
e753ca5f-cbc6-4b85-83dc-224e41fba014	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
f8a69f4d-8f2c-451c-bac0-ca0d03bc302b	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
ca116809-6f3e-4511-bcd6-e2071790d174	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
e469ac86-72c4-4bd7-9f22-50e9e66f5bf8	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
94589a52-ce40-4826-b935-475650bc675e	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
5aa866c0-2435-4db4-8d7c-5c94a6a327b7	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
03fab59a-16a5-4d08-b7b1-b0f500590090	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:54:00.000Z	NEUTRAL
8ce2a91c-84b4-4a2e-8711-19d2a3af840f	Oil slides as US-Iran truce hopes outweigh Houthi attacks on Saudi Arabia - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:11:00.000Z	NEUTRAL
aa2567fa-065d-4f5c-89dc-dec24c462ad1	Russian, Iranian foreign ministers say only diplomatic solution to conflict around Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:58:00.000Z	NEUTRAL
54935be0-80f7-4d81-a10f-d0e7ec842fee	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:17:00.000Z	NEUTRAL
680b29ad-fa86-4857-b353-f8c3de3b3369	Iran's president says it is up to US to choose if it wants to end Iran war - Reuters	US	MEDIUM	Reuters	-	-	2026-09-24T23:42:35.000Z	BEARISH
0bb4edc6-d99a-4b5c-b10d-1f04b4df882a	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
345f9026-4c4e-44cf-855d-5e31eea87360	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
a016bf25-c5f2-41c7-8f47-e9a89eb71011	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
6035b6cf-ec59-4a92-867e-60896af4488f	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
830e58d0-6db3-4975-b6e8-d44b69a3a965	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
d5e6f39e-a433-438b-8596-a56017cd1b63	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
1cc19ed1-2910-497c-806d-2fade59aa9c3	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
8428e847-8651-4cea-beec-4f02bb5d3a23	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
f56c20fa-200c-411b-9ad7-96e33937f7d2	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
da764a90-eca7-4e95-b236-b1ed4b5c4261	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
277f4b01-8e56-40b8-94cf-d7f155add47e	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:54:00.000Z	NEUTRAL
595c9706-836e-4391-b94f-9ae8b538992d	Oil slides as US-Iran truce hopes outweigh Houthi attacks on Saudi Arabia - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:11:00.000Z	NEUTRAL
60e8d20c-da61-4b68-8d09-f8137a6c20de	Russian, Iranian foreign ministers say only diplomatic solution to conflict around Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:58:00.000Z	NEUTRAL
196e62c9-4397-411d-bf76-a61dfbfa4f2c	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:17:00.000Z	NEUTRAL
a8c78bb9-2c80-4e54-8e9a-003a053bb48f	Iran's president says it is up to US to choose if it wants to end Iran war - Reuters	US	MEDIUM	Reuters	-	-	2026-09-24T23:42:35.000Z	BEARISH
e0cc9d92-529d-4cce-959a-1f45d19f8f0e	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
85de6f3a-2a72-44f7-9821-62524f5474be	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
356fe12e-d991-4603-8fe7-2057667c9a4d	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
91f53959-3d21-40b6-a24c-8e1faaf021c6	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
98ab6425-bf92-400d-bf6a-24c1aa5e41a6	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
74f3a6b5-ed0f-421d-8dd5-2b6f707b5382	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
1f7479e6-7135-4c80-b657-f256bfd59c46	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:59:07.000Z	NEUTRAL
75caf33a-c6ae-4c87-a559-b34a35d6d114	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
8bf6e3a1-315e-4419-b931-819b106dd414	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
cb23fbbe-545e-42ee-a5bc-9aa51343c1ec	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
3464208a-cfb0-4d8d-9893-362012da0d75	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
e2d942ca-70b8-493d-b5a4-57eb00243e64	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
3df650e7-d5b9-4b03-abc7-e3f18ade615c	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:54:00.000Z	NEUTRAL
9d2b5195-0d9e-4d10-88cb-adb0696d5deb	Oil slides as US-Iran truce hopes outweigh Houthi attacks on Saudi Arabia - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:11:00.000Z	NEUTRAL
5cbfa4cd-e526-473a-aa62-1329767249e4	Russian, Iranian foreign ministers say only diplomatic solution to conflict around Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:58:00.000Z	NEUTRAL
cf248fd6-35d0-4927-8b6e-b582967592c1	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
3f04500b-c557-4ae9-97e1-81bc2bf35286	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
1848c9c2-c80b-421c-b473-540935d8756b	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
c0d0b366-695f-4354-8ccb-1ac928c98c32	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
73098dcb-64dc-4b41-9eb5-87f8ab04e25d	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
844a0b7a-e146-4dcb-9f95-b65280f948cf	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
988057bc-0c2c-4750-9b58-da57a8a2ec31	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:59:07.000Z	NEUTRAL
c444033a-4909-417a-b4d2-81d3b4af4265	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
e229ec5f-3e46-4ff8-a8e7-db6ce924a468	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
b9cbbc94-6425-4d70-8304-da3dbcbfd510	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
ed36ed46-522c-481a-8faa-55a84c3360ab	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
2be60892-44f3-44a5-a69b-5491781719b9	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
0d829a05-2b6f-449f-a284-097994c4ffbd	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:54:00.000Z	NEUTRAL
8eb3cf2f-8ec4-432b-a445-2ac3c4255224	Oil slides as US-Iran truce hopes outweigh Houthi attacks on Saudi Arabia - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:11:00.000Z	NEUTRAL
54a88c99-6317-46fe-baad-a5dad15107b0	Russian, Iranian foreign ministers say only diplomatic solution to conflict around Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:58:00.000Z	NEUTRAL
9b42afb6-eb54-4bb2-816b-270ba4a9b546	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
da06dacd-6e06-497e-8e6f-943e9d974c3d	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
cd36deae-9f48-4dbf-b617-508bfbfb8cfc	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
1d574b7b-953c-486c-82ac-e32e23db7ca2	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
063693e2-bb52-40ec-ba07-8bdae6c9af88	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
357a13e8-2d07-4816-9a2b-1543e5528621	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
03999c6f-0218-435b-9e17-f40e5ff43239	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:59:07.000Z	NEUTRAL
9bd058a6-0b00-4f1d-a982-d0a39ff57f9f	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
fd1914a9-709e-4ea7-9434-6998965a9f6f	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
28564f76-a49d-4750-afc9-66216c2e06bd	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
ac4c6320-dfaa-4d8d-8586-86758c3a7bfd	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
a9bd6499-98c2-4978-92fe-27ebed5db26d	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
37920cca-475b-4cc2-9276-5a5536d84813	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:54:00.000Z	NEUTRAL
b47f3cb6-ad99-44cc-8722-51bf2958b2e3	Oil slides as US-Iran truce hopes outweigh Houthi attacks on Saudi Arabia - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:11:00.000Z	NEUTRAL
d7ada441-dcfe-4252-a1ff-b18e74a4fc22	Russian, Iranian foreign ministers say only diplomatic solution to conflict around Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:58:00.000Z	NEUTRAL
3670cf7a-8570-47f9-9c5c-863fe8948ba1	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
9b8c0677-d46f-4903-b28a-002b11e8fceb	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
9c965c84-c488-4e07-b3d9-c1e3859ad837	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
afe8e1b1-414d-45f1-a242-7cc0161d6b37	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
c67a01ca-f2f5-44a4-b42e-71db251da908	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
f7c74514-921b-4d83-91ee-c7e0b806021a	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
eb0aa273-1198-460c-8589-52b4e7873dd8	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:59:07.000Z	NEUTRAL
8bb3ddb1-b7d1-4612-b08d-556b710c795c	Jim Cramer's top 10 things to watch in the stock market Thursday	US	MEDIUM	CNBC	-	-	2026-10-01T13:00:03.000Z	NEUTRAL
8b3cde94-2db4-4603-b3e4-678278bc5c60	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
10a20ad2-5367-4663-ad5b-18cd8e80a1c1	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
557ea0dc-f7ef-4378-914d-133578796233	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
1650412a-f26e-45fd-9607-583833eeecc7	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
4df10e80-a212-4210-afef-5eaf84fce22c	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
9fc49286-25a5-4c1f-a99f-b599cca2b235	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:54:00.000Z	NEUTRAL
0e28de8e-5c4e-4249-b0c5-2e06d61da4de	Oil slides as US-Iran truce hopes outweigh Houthi attacks on Saudi Arabia - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:11:00.000Z	NEUTRAL
b0a1d847-702f-48d7-8f43-5b8b2d4bf67e	Russian, Iranian foreign ministers say only diplomatic solution to conflict around Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:58:00.000Z	NEUTRAL
94f2a663-bdea-41f1-9a3a-45699761f2f8	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
8fb71fb8-cb46-475e-8b7f-25caa205bac5	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
cc692966-56dc-44a5-84ba-a8107085d2f3	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
10c75949-6c88-4fb1-9d9a-5788f8f0bf99	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
ff0a2a95-9399-4fdd-a765-8208bb16ce9a	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
fb0bf8da-a8f6-4714-8fca-6cc275fa77a1	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
874982e1-ab82-4552-b804-19ab24da4392	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:59:07.000Z	NEUTRAL
146f59dd-2dc1-4116-a29a-9f93418dd684	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
8297d9a7-b444-4026-a957-593613aad812	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
6cb88e14-eb61-43b4-8cf3-d8b8126b56c3	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
e24ba491-0e5c-4688-bc93-c8a8de99f66e	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
9614e19f-858c-40e2-bef5-44006cc53de3	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
68cb1314-c190-4ab9-9bb4-abb3f21c376d	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:54:00.000Z	NEUTRAL
4b7da2ca-24f5-48f5-b6ac-4ec919a34176	Oil slides as US-Iran truce hopes outweigh Houthi attacks on Saudi Arabia - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:11:00.000Z	NEUTRAL
b80ed61f-0c49-4fad-85de-9049833b71b0	Russian, Iranian foreign ministers say only diplomatic solution to conflict around Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:58:00.000Z	NEUTRAL
66b4e4f4-2eb8-4a28-a7b3-0d3263bc7e17	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
c8cbae32-f08d-4005-9547-1f5dc3c90190	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
f479da85-08e7-4b9b-8227-8adb2fe6650b	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
c3e1cc7b-b905-4fbc-b006-0a8f70012454	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
baa4835d-a5dd-4814-ba39-379cf93f41f2	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
e0d16b7b-3209-4c14-8780-cf96fdfbf601	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
b75e7c17-d86a-4b16-8f55-72771bc43a62	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:59:07.000Z	NEUTRAL
69a1608d-3864-4e66-89ae-e8a9db122736	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
f9e0a56f-9ae0-4316-a970-5a55c0bc2a09	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
c0cf77c5-36ec-44cc-a6ba-24d0e5b32de8	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
548a76bb-cb15-4a37-bed7-d25069a2bebd	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
c3605a0b-905a-4a17-af6f-89c785cc0269	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
6e237eef-219b-42bd-9a72-1ed1391caad8	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:54:00.000Z	NEUTRAL
222d3242-8f5a-48b5-94f2-e7876ef2537a	Oil slides as US-Iran truce hopes outweigh Houthi attacks on Saudi Arabia - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:11:00.000Z	NEUTRAL
901d361e-4783-4ecc-b156-7d7e7c176d4b	Russian, Iranian foreign ministers say only diplomatic solution to conflict around Iran - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T00:58:00.000Z	NEUTRAL
3bbcaf81-d37c-4076-9ff7-73eacafb5dce	Trump told Xi that China helping Iran is unacceptable, US ambassador says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T16:03:29.000Z	NEUTRAL
ebbcd029-53ef-4d19-9113-40143863245f	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
223abc34-69c8-4ce9-8d18-d9b4bf32fee6	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
b8a2f7e5-a38a-430c-8c41-1f89dd97b024	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
f4707210-f3f8-48b8-9534-1246f48d7e08	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
1c453d5e-97d0-49ab-aa0f-a25acd191c3e	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T12:13:07.000Z	NEUTRAL
ac718184-09f2-4644-a257-a1cde82c885a	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
2473a340-1fd2-4655-9009-ec6354450dce	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
dc53a4a6-9b0f-4d92-83e8-07331262022b	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:59:07.000Z	NEUTRAL
ed760eac-624f-420f-b885-dd17f3a46595	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
1da5b1e6-78d9-4bf7-b498-8bf120c72c4e	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
8aa72c53-6b55-4f64-a862-e796efce231e	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
6ede38ba-2ffa-4f11-9aa3-95dc9ccfbd0d	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
a404c2ca-0fba-41aa-aa73-c3ff3b6eefe1	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
6bb4fcab-d75f-4ada-a613-76226d5fd2c1	Oil slides as US-Iran truce hopes outweigh Houthi attacks on Saudi Arabia - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T01:11:00.000Z	NEUTRAL
95394128-372a-489e-b8e8-cb8d7fc0e7be	10-year Treasury yield hit a 19-year high—and some investors see opportunity to buy bonds	US	MEDIUM	CNBC	-	-	2026-09-25T16:40:09.000Z	BULLISH
3e43936d-470d-40dd-8415-109c75f00dd5	Trump told Xi that China helping Iran is unacceptable, US ambassador says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T16:03:29.000Z	NEUTRAL
70bac389-5934-4d4b-bada-5f9beb1c08e9	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
bd777db7-6e0c-4e80-81a9-647f5ee9e2e7	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
f7a0008b-a475-4429-b228-1c10daaa666a	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
95295351-dc61-45b1-ac85-47ecf05deae0	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
5f2ecc1d-6560-4079-b42a-d9b4a2ffccf2	Allies unite behind Saudi Arabia as more Iranian flights curtailed - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T12:13:07.000Z	NEUTRAL
0bc61b22-7fad-470f-b928-540365f50171	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
e017ff51-d04b-40fc-afeb-24f0d2dc7db2	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
542d8d45-81d0-4b77-af11-6e69a704bb77	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:59:07.000Z	NEUTRAL
bdb3caca-da6d-49f1-9ff3-319a98af5aee	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
ddc99318-2005-4dd6-a021-c5d174556ad0	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
338ca92b-b0ba-42d5-bb3c-3410b766c9d0	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
e81e8c2e-2944-4d86-b87f-44fc6fb600d8	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
571f2422-7a0e-4d5a-9c8a-98a1b74412fc	Gold rises, but on track for weekly loss as Fed rate hike expectations build - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:23:00.000Z	BULLISH
6ae9d472-8693-47ec-881f-118467bb8f8b	10-year Treasury yield hit a 19-year high—and some investors see opportunity to buy bonds	US	MEDIUM	CNBC	-	-	2026-09-25T16:40:09.000Z	BULLISH
c8efbd5c-88c2-45e6-855d-6eb31857a1d9	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T16:26:30.000Z	NEUTRAL
fa4a118c-516b-4f08-8a62-250b3991063e	Trump told Xi that China helping Iran is unacceptable, US ambassador says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T16:03:29.000Z	NEUTRAL
8da68e69-3b6b-44c2-ace4-d638c4c686b2	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
04560bef-938d-4238-8cf8-a5db3dccfc32	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
b443069b-7263-4b4e-ba99-eceb1a749265	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
7c2dc041-7dfd-45eb-a6eb-1d5b1cdba56b	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
8c8b995e-62f1-494d-b3ae-70c0010c6b54	UAE markets decline after warning on regional air travel - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T12:17:43.000Z	BEARISH
49e16903-9b9a-4314-bf78-40f0263cd15e	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
f4de17be-e274-4cc4-ba85-3a5aa94c1c8e	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
094410bf-0a21-444e-8ab9-d33d93ec4cb3	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
9d1a9697-5a4a-4331-82f7-3b3f8b4a248d	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
80d48dec-3682-4cb5-adac-50a712481b1b	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
5a9c5101-f678-4cbf-9f6b-ecb328de1fcf	Crude oil exports via Hormuz at 33.7 million barrels this week, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T03:49:00.000Z	NEUTRAL
3b4bf131-2e81-45f3-8a5c-f19c96041a0c	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
9e8ea122-f136-4fcc-af03-ae4e1dff5a38	10-year Treasury yield hit a 19-year high—and some investors see opportunity to buy bonds	US	MEDIUM	CNBC	-	-	2026-09-25T16:40:09.000Z	BULLISH
1eaaf1f2-0481-4452-b7ef-a3f307a71a54	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T16:26:30.000Z	NEUTRAL
fa332f83-b2c1-4750-94d5-6574ad822067	Trump told Xi that China helping Iran is unacceptable, US ambassador says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T16:03:29.000Z	NEUTRAL
8fa7b5b9-0728-4a13-ae6f-715528461b6c	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
cd6ce911-8556-4c09-9e3b-09a156bcea33	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
7e82a7a8-dd78-4474-bbb8-07cc876fd5a5	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
5f61ed47-c317-4170-a8a7-5fec2a0deda5	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
d55b2616-6a41-4bef-8e50-25349667063f	UAE markets decline after warning on regional air travel - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T12:17:43.000Z	BEARISH
d55f23b6-bce7-43ab-a8b2-491c59526930	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
4a581b60-3a6e-429c-acb6-3e2daba49f61	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
7b79fe4e-9693-42d1-96ee-a0ca986cb3ad	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
143a58dc-c4e0-4c7b-9855-43aff90df4e7	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
04695a2f-3a9a-45fa-ab92-77ed6b6b7aa5	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
66fd1f9b-564d-448d-8256-4bf309cfe834	Crude oil exports via Hormuz at 33.7 million barrels this week, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T03:49:00.000Z	NEUTRAL
a3e24569-ef4d-4763-be9f-98da21494754	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
f7d8c09a-d42a-4747-8746-9214ad85b127	10-year Treasury yield hit a 19-year high—and some investors see opportunity to buy bonds	US	MEDIUM	CNBC	-	-	2026-09-25T16:40:09.000Z	BULLISH
1c5d2cf4-2a27-474c-b8a0-e7a38148b3cb	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T16:26:30.000Z	NEUTRAL
1b4150bd-4ed7-441e-bf41-8f5f5ea90cce	Trump told Xi that China helping Iran is unacceptable, US ambassador says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T16:03:29.000Z	NEUTRAL
cb0953c2-077e-4452-b592-b70cdec2082b	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
71f218cb-b03c-4251-b75b-855b34519550	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
14f29109-0180-4d43-85e2-832a65142ae7	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
22e4a2ab-e043-4989-8a4e-f9bddba8e74c	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
8823f9d0-59f9-4167-82da-b966b1acd7cb	UAE markets decline after warning on regional air travel - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T12:17:43.000Z	BEARISH
4261850c-4c4a-4e0e-8899-4563a61419c3	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
1aaf2dbd-8c25-4e95-92bd-d7179017b408	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
d67c9b3d-181d-472e-96b1-d902679f6fbe	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
777a248e-f0ad-4cd9-b3f9-438ba35d4474	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
b112ce45-d586-4832-9027-3ac3e7af8c33	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
e3981d18-8b99-42c6-baef-bb6ba537be13	Crude oil exports via Hormuz at 33.7 million barrels this week, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T03:49:00.000Z	NEUTRAL
2ff74653-e11b-4597-9584-c12e0dcf5b93	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
b48a512a-48ec-4946-a096-ca79d469ded6	10-year Treasury yield hit a 19-year high—and some investors see opportunity to buy bonds	US	MEDIUM	CNBC	-	-	2026-09-25T16:40:09.000Z	BULLISH
c5d8f49f-9859-4b75-9c40-83d6b3aeebc6	Hurt by Trump, Senate Republicans plan to bolster affordability credentials before midterms - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T16:26:30.000Z	NEUTRAL
3baa4117-e855-4f0a-bc7a-b4d903a2c889	Trump told Xi that China helping Iran is unacceptable, US ambassador says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T16:03:29.000Z	NEUTRAL
0f78d3b4-2e40-45b6-bcae-4ca290d8d95c	Saudi Grand Mufti tells troops to be ready to sacrifice their lives fighting Houthis - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T14:49:05.000Z	NEUTRAL
c6d600db-f7e9-4856-886e-62f2fd6538dc	EXCLUSIVE: Qatar Airways retires idle A330s and sends pilots to RwandAir as Iran war drags - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T13:33:43.000Z	BEARISH
20a9d726-a4e0-48cf-ab7d-2433d27c4d20	Top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-09-25T13:09:58.000Z	NEUTRAL
b5c63849-86a7-4e9d-86ce-eef5c0ed697a	Airlines waive flight-change fees ahead of nor'easter	US	MEDIUM	CNBC	-	-	2026-09-25T12:52:24.000Z	NEUTRAL
8d40f5d5-2f7e-48f9-b3c6-eafb2a157de6	UAE markets decline after warning on regional air travel - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T12:17:43.000Z	BEARISH
512a24af-faf4-499a-98de-c9b2b0815e2c	New study reveals the estate-planning choices that are likely to pit heirs against each other	US	MEDIUM	CNBC	-	-	2026-09-25T12:00:02.000Z	BULLISH
87e3b643-0efb-4034-8184-00cf13730e14	Three Iraqi airports suspend Iranian flights starting Friday, sources and state media say - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T11:24:28.000Z	NEUTRAL
2b42380f-696d-40b0-a05c-ee9ef327891e	Pact with Saudi and Pakistan could expand to Muslim world, Iran, Turkish speaker says - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T10:01:36.000Z	NEUTRAL
7ae6fe56-760e-4861-b38c-2b60aec4c68b	Pharma stock soars 150% on injectables deal with Wegovy maker Novo	US	MEDIUM	CNBC	-	-	2026-09-25T09:58:27.000Z	NEUTRAL
8093c360-1542-4efd-9af1-279bc71850e8	How Trump's diplomatic week exposed the limits of his power - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T05:03:00.000Z	NEUTRAL
916b4a35-57fd-4dfe-a6e7-af93d98bad2b	Crude oil exports via Hormuz at 33.7 million barrels this week, data shows - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T03:49:00.000Z	NEUTRAL
e3b253b8-19c9-4de8-8008-488c459e88c0	Rupee soothed by intervention, surge in forward premiums tipped to cool - Reuters	US	MEDIUM	Reuters	-	-	2026-09-25T02:33:00.000Z	BEARISH
af05c8a0-40d4-4b35-897d-23b1dcc324c8	Israel's Netanyahu: Co-pilot of flydubai plane underwent radical Islamist indoctrination - reuters.com	US	MEDIUM	Reuters	-	-	2026-10-01T13:34:52.000Z	NEUTRAL
507de98d-c3f5-4e77-b889-05a31a5f8ec4	Racehorse market breaks records riding high on tax breaks, stock market gains	US	MEDIUM	CNBC	-	-	2026-10-01T13:19:21.000Z	BULLISH
de7f8e83-86ff-4e0e-97c3-a5e9dfa50787	Most Gulf bourses edge lower on mixed US-Iran cues - reuters.com	US	MEDIUM	Reuters	-	-	2026-10-01T13:10:57.000Z	NEUTRAL
18a4cdab-2b80-457a-b531-8845f4eb8af4	Netanyahu says flydubai co-pilot underwent Islamist radical indoctrination - reuters.com	US	MEDIUM	Reuters	-	-	2026-10-01T12:46:38.000Z	NEUTRAL
b81863bc-cd80-4fa3-9c54-110e947abd9d	EXCLUSIVE: Syrian government officials and Hezbollah held secret talks in Turkey, sources say - reuters.com	US	MEDIUM	Reuters	-	-	2026-10-01T11:27:25.000Z	NEUTRAL
7d2b8340-fb0c-4851-a01b-969d35d34565	UK 30-year gilt yields top 6% for the first time since 1998 - reuters.com	US	MEDIUM	Reuters	-	-	2026-10-01T11:23:12.000Z	NEUTRAL
627fb5d1-5644-4bb5-bcf8-f3c2a87ca2b6	Iran readies harder retaliation if attacked as diplomacy faces long odds - reuters.com	US	MEDIUM	Reuters	-	-	2026-10-01T11:22:08.000Z	NEUTRAL
1267ec01-b5aa-4891-acf2-ec3a47655028	SpaceX set to launch Google AI chips into orbit in push toward space-based data centers	US	MEDIUM	CNBC	-	-	2026-10-01T11:20:15.000Z	BEARISH
ee8851ce-c545-4180-9299-78ade1732314	Japan's prime minister says her policies will boost confidence in the yen after U.S. intervention falls short	US	MEDIUM	CNBC	-	-	2026-10-01T11:13:25.000Z	BEARISH
2a44e8fe-ab0c-4952-9616-14612c872203	Trump will not win this year's Nobel Peace Prize, but he may influence who does, say experts - reuters.com	US	MEDIUM	Reuters	-	-	2026-10-01T06:24:01.000Z	NEUTRAL
907508a0-102e-4c2a-be6d-004c892e36dc	Three oil tankers hit by projectiles in Hormuz strait on Tuesday, Marisks says - reuters.com	US	MEDIUM	Reuters	-	-	2026-10-01T06:17:00.000Z	NEUTRAL
5170840e-525c-4019-8251-29582ae49ea2	Norway ready for high winter gas demand from Europe, pipeline operator says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T06:15:00.000Z	BULLISH
3d86c06d-f818-4aec-a8b7-cdb534517683	Netanyahu says Israel will get to the 'root' of co-pilot in foiled bid to crash flydubai flight - reuters.com	US	MEDIUM	Reuters	-	-	2026-10-01T02:57:00.000Z	NEUTRAL
4353b79e-0e9b-4f24-807c-c15e0707e529	Indian benchmark shares post longest weekly losing run in 25 years - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T02:25:00.000Z	NEUTRAL
71741667-b22c-4144-bfaa-3241ec3e9108	Israel's Netanyahu: Co-pilot of flydubai plane underwent radical Islamist indoctrination - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T13:34:52.000Z	NEUTRAL
ee7ec8c7-c9e5-4201-a15e-28b7004ff240	Racehorse market breaks records riding high on tax breaks, stock market gains	US	MEDIUM	CNBC	-	-	2026-10-01T13:19:21.000Z	BULLISH
42e698a9-6392-4e13-b134-a6b2e49aab15	Most Gulf bourses edge lower on mixed US-Iran cues - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T13:10:57.000Z	NEUTRAL
ef279c37-28d1-4029-a5ac-9b9f55a5f6e2	Jim Cramer's top 10 things to watch in the stock market Thursday	US	MEDIUM	CNBC	-	-	2026-10-01T13:00:03.000Z	NEUTRAL
d28358c1-4095-452e-9a60-f3a54bc56c64	Netanyahu says flydubai co-pilot underwent Islamist radical indoctrination - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T12:46:38.000Z	NEUTRAL
828344b7-b3ea-4e3b-99b6-b913835c2479	EXCLUSIVE: Syrian government officials and Hezbollah held secret talks in Turkey, sources say - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T11:27:25.000Z	NEUTRAL
e3e51e1d-a63e-444f-bd86-577ecf025658	UK 30-year gilt yields top 6% for the first time since 1998 - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T11:23:12.000Z	NEUTRAL
934d6107-571a-4f2a-9024-e0f716fdaa28	Iran readies harder retaliation if attacked as diplomacy faces long odds - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T11:22:08.000Z	NEUTRAL
7ac018c6-f3ce-4ed2-b2fd-f77c702427cc	SpaceX set to launch Google AI chips into orbit in push toward space-based data centers	US	MEDIUM	CNBC	-	-	2026-10-01T11:20:15.000Z	BEARISH
93bbdb48-1d0d-4d32-93fa-dd52ac82cc2e	Japan's prime minister says her policies will boost confidence in the yen after U.S. intervention falls short	US	MEDIUM	CNBC	-	-	2026-10-01T11:13:25.000Z	BEARISH
68c60ea2-0825-42b8-9527-10a385612b78	Trump will not win this year's Nobel Peace Prize, but he may influence who does, say experts - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T06:24:01.000Z	NEUTRAL
0dba18ab-c32d-44ec-86a0-3feac73e290f	Three oil tankers hit by projectiles in Hormuz strait on Tuesday, Marisks says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T06:17:00.000Z	NEUTRAL
7126d093-39bf-46b5-b828-6052c6e9b710	Norway ready for high winter gas demand from Europe, pipeline operator says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T06:15:00.000Z	BULLISH
30cec967-5507-474f-99b2-e0d64f75bdc6	Netanyahu says Israel will get to the 'root' of co-pilot in foiled bid to crash flydubai flight - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T02:57:00.000Z	NEUTRAL
2347d7a0-17f3-419a-8d09-c217e16a9ad6	Indian benchmark shares post longest weekly losing run in 25 years - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T02:25:00.000Z	NEUTRAL
436eb2d5-6c2a-4427-b475-2f9503391296	Israel's Netanyahu: Co-pilot of flydubai plane underwent radical Islamist indoctrination - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T13:34:52.000Z	NEUTRAL
20bf34ac-395f-475d-a35b-bbddf757c807	Racehorse market breaks records riding high on tax breaks, stock market gains	US	MEDIUM	CNBC	-	-	2026-10-01T13:19:21.000Z	BULLISH
649734b7-ef7b-45ee-bd55-6b03d8797bee	Most Gulf bourses edge lower on mixed US-Iran cues - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T13:10:57.000Z	NEUTRAL
8e6a9c9c-e62a-48e5-a5a9-6b9a12f8a73b	Jim Cramer's top 10 things to watch in the stock market Thursday	US	MEDIUM	CNBC	-	-	2026-10-01T13:00:03.000Z	NEUTRAL
700273b2-4782-47db-8527-fa17cbe16427	Netanyahu says flydubai co-pilot underwent Islamist radical indoctrination - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T12:46:38.000Z	NEUTRAL
d4b6f079-2c3d-450d-aa3b-97b5800f781f	EXCLUSIVE: Syrian government officials and Hezbollah held secret talks in Turkey, sources say - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T11:27:25.000Z	NEUTRAL
47ed5f9c-e79f-49b8-be19-2a7e51565409	UK 30-year gilt yields top 6% for the first time since 1998 - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T11:23:12.000Z	NEUTRAL
616f8f06-5ddc-4296-b3a1-c419244c62ee	Iran readies harder retaliation if attacked as diplomacy faces long odds - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T11:22:08.000Z	NEUTRAL
07b81186-eb5e-43bd-8d97-2aaf0e695198	SpaceX set to launch Google AI chips into orbit in push toward space-based data centers	US	MEDIUM	CNBC	-	-	2026-10-01T11:20:15.000Z	BEARISH
063371ef-3aa4-456a-8b63-8568ce8ce94c	Japan's prime minister says her policies will boost confidence in the yen after U.S. intervention falls short	US	MEDIUM	CNBC	-	-	2026-10-01T11:13:25.000Z	BEARISH
698b1157-53f7-4ca7-964e-ab29a70ded28	Trump will not win this year's Nobel Peace Prize, but he may influence who does, say experts - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T06:24:01.000Z	NEUTRAL
8f77c6db-f76a-4ae2-b0dc-b7643052a09c	Three oil tankers hit by projectiles in Hormuz strait on Tuesday, Marisks says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T06:17:00.000Z	NEUTRAL
7dbe06bc-662c-4e78-a97b-dd3ecbdf7024	Norway ready for high winter gas demand from Europe, pipeline operator says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T06:15:00.000Z	BULLISH
2d33ca4f-1b0b-4fa4-8cec-9838def3dd2c	Netanyahu says Israel will get to the 'root' of co-pilot in foiled bid to crash flydubai flight - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T02:57:00.000Z	NEUTRAL
95d9492d-fb9c-4ead-8ac4-82924edaf59c	Indian benchmark shares post longest weekly losing run in 25 years - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T02:25:00.000Z	NEUTRAL
b932dc35-cd75-46dc-9221-cfa0446105fd	Jim Cramer's top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-10-02T13:13:28.000Z	NEUTRAL
fd8dbc7d-a646-46b1-89a9-02a78244c488	American starts letting customers mix cash and miles for tickets	US	MEDIUM	CNBC	-	-	2026-10-02T15:00:01.000Z	NEUTRAL
054bfaff-b6bb-43fa-ae8f-a024a884b27f	EXCLUSIVE: Europe weighs new diesel stocks release after US pressure, sources say - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T12:14:40.000Z	NEUTRAL
b0a340be-6ccf-4de7-bffc-7bd01e4b9554	EXCLUSIVE: OPEC+ delays oil capacity review after Iran war disrupts expansion plans, sources say - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T11:58:10.000Z	BEARISH
d1383a27-8819-41f8-8deb-a50fbcf0696f	The secret signs the bond sell-off might be ending	US	MEDIUM	CNBC	-	-	2026-10-02T10:37:26.000Z	NEUTRAL
f85a8005-a814-47e6-8521-f0aefb3208f3	September LNG shipments through Hormuz hit highest since start of US-Iran war - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T07:47:58.000Z	BULLISH
d40b80e5-9df7-4ea2-babd-db0ef42e0954	Treasury yields inch higher as investors await key jobs report	US	MEDIUM	CNBC	-	-	2026-10-02T07:47:49.000Z	BULLISH
d5116cfb-b0af-4135-945c-7d4d43c5a28f	Yemen carried out 20 strikes on Houthi targets in Taiz province, spokesperson says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T06:21:00.000Z	BEARISH
fb2fac2f-fb6c-4628-bae6-4c24809d6569	Foiled flydubai attack clouds regional airline revival - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T05:23:12.000Z	NEUTRAL
7124b0b3-610f-401e-82d9-db1374f6ba8a	Vietnam's Nghi Son refinery secures crude supplies through November, mostly from Kuwait - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T01:37:00.000Z	NEUTRAL
798c151a-6f18-4093-8d73-f304821ef043	Oil price drops more than 2% on talks over diesel, crude stock releases - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T01:10:00.000Z	BEARISH
7e14d9c4-de71-46a2-8103-ca79d03afa50	US sanctions target Iran's auto, rail sectors as blockade chokes ship lanes - Reuters	US	MEDIUM	Reuters	-	-	2026-10-01T20:52:13.000Z	NEUTRAL
a5383c20-544d-414e-9980-63fe7d4d2ec1	Boeing engineers and technical workers approve new contract, avoiding strike	US	MEDIUM	CNBC	-	-	2026-10-01T19:36:58.000Z	BEARISH
da363150-8170-4b34-b8f3-4c9845f3efd2	Jim Cramer sees a huge catalyst on the horizon for Apple. How to play the stock	US	MEDIUM	CNBC	-	-	2026-10-01T19:23:49.000Z	NEUTRAL
9b3b3e5c-7fb9-4425-ae03-35161dfe9a08	The September jobs report will be released Friday. Here's what to expect	US	MEDIUM	CNBC	-	-	2026-10-01T18:55:02.000Z	NEUTRAL
50770255-b4ab-4289-bcaf-28b2601a5da6	United Airlines goes after top frequent flyers at Delta, American with status match	US	MEDIUM	CNBC	-	-	2026-10-01T18:52:08.000Z	NEUTRAL
b9ac5542-bbac-466b-b6ed-5b7f0b099d31	EXCLUSIVE: Europe agrees to release diesel stocks, Trump says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:34:28.000Z	NEUTRAL
456cfee6-f72b-42b7-9173-7a8f28602745	Iran readies harder retaliation if attacked as diplomacy faces long odds - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:32:10.000Z	NEUTRAL
191a53b5-df20-4dca-aab4-bc28f0220fac	Facebook whistleblower Frances Haugen questions whether AI companies can police themselves	US	MEDIUM	CNBC	-	-	2026-10-02T14:22:39.000Z	NEUTRAL
cde99e90-02d2-458b-bfa6-10c002bb028a	Jim Cramer's top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-10-02T13:13:28.000Z	NEUTRAL
ea82779d-0e2f-4aa8-9d02-7cb10ad23ef3	Italy says EU naval mission in Red Sea still insufficient - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T13:07:43.000Z	NEUTRAL
5895b4f7-c4dc-45a8-96f5-0601a9592846	EXCLUSIVE: OPEC+ delays oil capacity review after Iran war disrupts expansion plans, sources say - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T12:54:06.000Z	BEARISH
8cb215c9-6371-4955-8784-691a0bcd4111	UK new car sales rise 12% in September as EVs and Chinese brands gain ground - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T12:22:01.000Z	BULLISH
6f728f34-dacf-46d9-9878-c8c5acaae869	Photos of the week - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T11:54:50.000Z	NEUTRAL
9c8e1210-f62e-44ff-80ac-ea5b5c2d61f8	The secret signs the bond sell-off might be ending	US	MEDIUM	CNBC	-	-	2026-10-02T10:37:26.000Z	NEUTRAL
6cfd9c7c-85e3-41b1-bf76-80306ad4fcc3	September LNG shipments through Hormuz hit highest since start of US-Iran war - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T07:47:58.000Z	BULLISH
a718cc44-7816-495c-8dbb-82c4ef36e692	Treasury yields inch higher as investors await key jobs report	US	MEDIUM	CNBC	-	-	2026-10-02T07:47:49.000Z	BULLISH
98f05ee9-bd90-4ab6-a3c9-120d7612b030	Yemen carried out 20 strikes on Houthi targets in Taiz province, spokesperson says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T06:21:00.000Z	BEARISH
6172aa08-8dbe-4968-a965-63d2f804dc56	Foiled flydubai attack clouds regional airline revival - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T05:01:00.000Z	NEUTRAL
f84d0734-0941-4e2c-96ae-bbcdac91af58	Vietnam's Nghi Son refinery secures crude supplies through November, mostly from Kuwait - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T01:37:00.000Z	NEUTRAL
f7263e23-37f7-42bd-8a12-356f050dca64	EU aviation body widens Saudi airspace warning after Houthi strikes - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T16:25:01.000Z	BEARISH
92ba6e3a-fa61-47d2-be9f-60e525163952	US diesel prices remain high despite Trump's moves to boost supplies - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T16:18:51.000Z	BULLISH
e4d74ae4-b7f2-42eb-903d-4c73077bf9c2	Kremlin says Putin in phone call with Trump downplays immediate Ukraine talks resumption - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T22:04:42.000Z	NEUTRAL
e590f4c2-325d-41f5-9b85-b0481cec5fc1	Photos of the week - Reuters	US	MEDIUM	Reuters	-	-	2026-10-03T00:05:20.000Z	NEUTRAL
2f1a38e6-355d-4d82-ade7-a18ec24dd7f0	G7 countries agree on release of diesel and oil stocks after US pressure - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T22:20:30.000Z	NEUTRAL
70a1f879-7bac-4f9c-852c-8caf69fcde49	Two Iranians charged in UK over alleged terrorism plot targeting Jewish community - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T21:11:46.000Z	NEUTRAL
179ed094-0bab-4dac-8a7f-16f0e24583cd	What do we know about flydubai flight 1073? - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T20:53:24.000Z	NEUTRAL
f5e09f4a-f3cb-4bc6-aaa3-5fe11f44c1a8	Israeli officials to question co-pilot of flydubai flight, source says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T20:20:50.000Z	NEUTRAL
6c9be38d-259b-48aa-a5e2-7e5046002757	Saudis plan assault on Houthis to break Red Sea chokehold - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T18:13:41.000Z	NEUTRAL
9dcc6c59-c4b0-47ac-9ba5-54abfd0f6564	Friday's rally in the S&P 500 might not be enough, but Linde is out of this world	US	MEDIUM	CNBC	-	-	2026-10-02T18:03:35.000Z	NEUTRAL
c6d75c9b-e8e4-455e-a805-8daa82f79c95	Iraq says 40 daily Iranian flights cleared to fly to and from Najaf - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T16:37:43.000Z	NEUTRAL
ae7c3f3f-73c4-435b-9dbe-4787d7b5aa7c	1.7 million skilled trade jobs will open annually through 2035, report says—experts don't know who will fill them	US	MEDIUM	CNBC	-	-	2026-10-02T16:15:01.000Z	NEUTRAL
1c7e48bb-309b-4ac5-9b48-f5635b222c17	UK new car sales rise 12% in September as EVs and Chinese brands gain ground - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T16:01:03.000Z	BULLISH
61bcce7c-e557-4ff1-a8eb-bd83c2d06ee0	The sector in the cross hairs of the bond sell-off looks poised for a bounce, says Mike Khouw	US	MEDIUM	CNBC	-	-	2026-10-02T15:34:28.000Z	NEUTRAL
fbf39550-1a38-42f9-aab4-bfadb5de582d	Nvidia breaks through to new record highs. Plus, more good news for Boeing	US	MEDIUM	CNBC	-	-	2026-10-02T15:31:51.000Z	BULLISH
f24a8235-dac8-4adc-a168-0c78ff313a55	American starts letting customers mix cash and miles for tickets	US	MEDIUM	CNBC	-	-	2026-10-02T15:00:01.000Z	NEUTRAL
6a84329e-11ec-471a-96d3-42f56cf6732d	US issues sanctions against Hamas financing network, Treasury says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:33:45.000Z	BULLISH
2abfb428-6884-4997-b25c-475dfd8ef35d	Iran readies harder retaliation if attacked as diplomacy faces long odds - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:32:10.000Z	NEUTRAL
1472dda9-e54e-49c3-bccf-b1b9d25fa543	Photos of the week - Reuters	US	MEDIUM	Reuters	-	-	2026-10-03T00:05:20.000Z	NEUTRAL
6080b80f-0897-4b35-b739-f538c68facbc	G7 countries agree on release of diesel and oil stocks after US pressure - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T22:20:30.000Z	NEUTRAL
8f24fa21-bf70-41fc-9651-67c17a66f56c	Two Iranians charged in UK over alleged terrorism plot targeting Jewish community - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T21:11:46.000Z	NEUTRAL
e1f4c533-be0f-4e5e-b156-4e29932e0b28	What do we know about flydubai flight 1073? - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T20:53:24.000Z	NEUTRAL
0c3a41fa-02ce-4ed2-b4a0-9acc18580eb7	Israeli officials to question co-pilot of flydubai flight, source says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T20:20:50.000Z	NEUTRAL
2593a8eb-e986-4dcf-9395-4b708d258ae6	Saudis plan assault on Houthis to break Red Sea chokehold - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T18:13:41.000Z	NEUTRAL
4a6dbd18-8072-4d03-a951-5b2946d56088	Friday's rally in the S&P 500 might not be enough, but Linde is out of this world	US	MEDIUM	CNBC	-	-	2026-10-02T18:03:35.000Z	NEUTRAL
92ea2459-5acf-455a-8779-387cf18b53ee	Iraq says 40 daily Iranian flights cleared to fly to and from Najaf - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T16:37:43.000Z	NEUTRAL
9a7876e8-c4a0-4c2d-9fb6-adf742693d4e	1.7 million skilled trade jobs will open annually through 2035, report says—experts don't know who will fill them	US	MEDIUM	CNBC	-	-	2026-10-02T16:15:01.000Z	NEUTRAL
c47cc302-e359-4e04-b031-247d378dcba7	UK new car sales rise 12% in September as EVs and Chinese brands gain ground - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T16:01:03.000Z	BULLISH
d8d458a4-03d6-4996-97bd-864d7344f489	The sector in the cross hairs of the bond sell-off looks poised for a bounce, says Mike Khouw	US	MEDIUM	CNBC	-	-	2026-10-02T15:34:28.000Z	NEUTRAL
c6b910ad-d443-4f67-b23e-e7cdd10861e7	Nvidia breaks through to new record highs. Plus, more good news for Boeing	US	MEDIUM	CNBC	-	-	2026-10-02T15:31:51.000Z	BULLISH
5e807e67-38b9-4b4d-af79-f85fcf8b79ed	American starts letting customers mix cash and miles for tickets	US	MEDIUM	CNBC	-	-	2026-10-02T15:00:01.000Z	NEUTRAL
a897dc03-5452-42d7-a682-f8f062bb90d7	US issues sanctions against Hamas financing network, Treasury says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:33:45.000Z	BULLISH
78cb3fe9-b8ad-4585-8c23-25dd304d72dd	Iran readies harder retaliation if attacked as diplomacy faces long odds - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:32:10.000Z	NEUTRAL
2d7e2750-aff0-4bc9-845c-73e1c5f38b53	Photos of the week - Reuters	US	MEDIUM	Reuters	-	-	2026-10-03T00:05:20.000Z	NEUTRAL
bd070648-0200-4770-85ce-53523b013847	G7 countries agree on release of diesel and oil stocks after US pressure - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T22:20:30.000Z	NEUTRAL
f0477c02-aa35-41c7-829a-523c1f977277	Two Iranians charged in UK over alleged terrorism plot targeting Jewish community - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T21:11:46.000Z	NEUTRAL
b930491b-8d3d-4803-912e-234260c58af2	What do we know about flydubai flight 1073? - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T20:53:24.000Z	NEUTRAL
a290aac2-e9e5-43b0-a28a-ab9005ca32cc	Israeli officials to question co-pilot of flydubai flight, source says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T20:20:50.000Z	NEUTRAL
55bb9430-f6ec-4c03-8066-8d838902716c	Saudis plan assault on Houthis to break Red Sea chokehold - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T18:13:41.000Z	NEUTRAL
64c5db7e-acf3-4803-9238-bb2d8308b37c	Friday's rally in the S&P 500 might not be enough, but Linde is out of this world	US	MEDIUM	CNBC	-	-	2026-10-02T18:03:35.000Z	NEUTRAL
8f699b70-e2ed-49bf-8d72-f6d9add0586a	Iraq says 40 daily Iranian flights cleared to fly to and from Najaf - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T16:37:43.000Z	NEUTRAL
8da11162-b0eb-4e4e-a585-8b6d58d8fe9c	1.7 million skilled trade jobs will open annually through 2035, report says—experts don't know who will fill them	US	MEDIUM	CNBC	-	-	2026-10-02T16:15:01.000Z	NEUTRAL
7debac0b-8faa-450f-9207-ecfd940014e2	UK new car sales rise 12% in September as EVs and Chinese brands gain ground - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T16:01:03.000Z	BULLISH
06b73a30-db2e-4740-9a64-adaa03395943	The sector in the cross hairs of the bond sell-off looks poised for a bounce, says Mike Khouw	US	MEDIUM	CNBC	-	-	2026-10-02T15:34:28.000Z	NEUTRAL
275020df-17fc-4bcf-b66d-654bfccd6be8	Nvidia breaks through to new record highs. Plus, more good news for Boeing	US	MEDIUM	CNBC	-	-	2026-10-02T15:31:51.000Z	BULLISH
fa144672-2c0a-47f6-bc78-20742b5b98cf	American starts letting customers mix cash and miles for tickets	US	MEDIUM	CNBC	-	-	2026-10-02T15:00:01.000Z	NEUTRAL
255a0cdb-d470-4303-9926-e159942c5539	US issues sanctions against Hamas financing network, Treasury says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:33:45.000Z	BULLISH
c13572c0-cf61-4a0a-99ec-5179a5ad6958	Iran readies harder retaliation if attacked as diplomacy faces long odds - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:32:10.000Z	NEUTRAL
f07fd979-5b46-4810-84ef-2bf77cc85abf	Photos of the week - Reuters	US	MEDIUM	Reuters	-	-	2026-10-03T00:05:20.000Z	NEUTRAL
e09b2b7b-331e-4d1e-bd75-82d61df45ed6	G7 countries agree on release of diesel and oil stocks after US pressure - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T22:20:30.000Z	NEUTRAL
009bd4e5-5132-4e9d-a956-91b35455bf1b	Two Iranians charged in UK over alleged terrorism plot targeting Jewish community - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T21:11:46.000Z	NEUTRAL
eb677158-9c19-490a-b0f0-52d9b67e957d	What do we know about flydubai flight 1073? - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T20:53:24.000Z	NEUTRAL
78bd32a7-1438-4d0c-9649-dc365db12883	Israeli officials to question co-pilot of flydubai flight, source says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T20:20:50.000Z	NEUTRAL
cdfd22ed-bfad-4cc7-9192-c5c2426944f5	Saudis plan assault on Houthis to break Red Sea chokehold - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T18:13:41.000Z	NEUTRAL
c68236ed-a9af-4570-9dab-490263092f36	Friday's rally in the S&P 500 might not be enough, but Linde is out of this world	US	MEDIUM	CNBC	-	-	2026-10-02T18:03:35.000Z	NEUTRAL
35fd1767-482a-47c3-94d9-568cd6eae4a0	Iraq says 40 daily Iranian flights cleared to fly to and from Najaf - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T16:37:43.000Z	NEUTRAL
e76a3d36-c81b-417a-9672-996b430d61a8	1.7 million skilled trade jobs will open annually through 2035, report says—experts don't know who will fill them	US	MEDIUM	CNBC	-	-	2026-10-02T16:15:01.000Z	NEUTRAL
195fe6c2-1028-4647-93e0-f9f34c361b70	UK new car sales rise 12% in September as EVs and Chinese brands gain ground - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T16:01:03.000Z	BULLISH
41dabad6-476d-41d4-b1c1-eada2d7452f1	The sector in the cross hairs of the bond sell-off looks poised for a bounce, says Mike Khouw	US	MEDIUM	CNBC	-	-	2026-10-02T15:34:28.000Z	NEUTRAL
946fcb8a-1bcd-433a-8412-c4a1d47ab4ea	Nvidia breaks through to new record highs. Plus, more good news for Boeing	US	MEDIUM	CNBC	-	-	2026-10-02T15:31:51.000Z	BULLISH
0e4b8993-211a-47d9-a615-cefc420ddd5a	American starts letting customers mix cash and miles for tickets	US	MEDIUM	CNBC	-	-	2026-10-02T15:00:01.000Z	NEUTRAL
57fd12fb-c508-4149-91ca-140f1c162485	US issues sanctions against Hamas financing network, Treasury says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:33:45.000Z	BULLISH
4b7d4d7e-d172-4030-9ef5-dd40f3dd854c	Iran readies harder retaliation if attacked as diplomacy faces long odds - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:32:10.000Z	NEUTRAL
5c3ffc4e-6fc4-4266-8045-18a3a1172e38	Photos of the week - Reuters	US	MEDIUM	Reuters	-	-	2026-10-03T00:05:20.000Z	NEUTRAL
a93c337e-6b7a-4c47-9931-d236bb7ee63b	G7 countries agree on release of diesel and oil stocks after US pressure - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T22:20:30.000Z	NEUTRAL
79f7b362-b14d-4577-a487-72bdea5e6cbb	Two Iranians charged in UK over alleged terrorism plot targeting Jewish community - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T21:11:46.000Z	NEUTRAL
5a186880-2d2b-4f23-90ce-9ac75d5d3049	What do we know about flydubai flight 1073? - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T20:53:24.000Z	NEUTRAL
41444545-b2a0-4999-92cd-cd17a2aeb2c9	Israeli officials to question co-pilot of flydubai flight, source says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T20:20:50.000Z	NEUTRAL
36152b23-5ca9-4a1d-b4b7-183728af7c0d	Saudis plan assault on Houthis to break Red Sea chokehold - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T18:13:41.000Z	NEUTRAL
b429e793-0409-402c-87c0-74414b5b7e56	Friday's rally in the S&P 500 might not be enough, but Linde is out of this world	US	MEDIUM	CNBC	-	-	2026-10-02T18:03:35.000Z	NEUTRAL
71e2c26e-7207-4889-8a9b-53cdea59180b	Iraq says 40 daily Iranian flights cleared to fly to and from Najaf - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T16:37:43.000Z	NEUTRAL
47cd3595-bcb9-48ac-9364-5a7786144f76	1.7 million skilled trade jobs will open annually through 2035, report says—experts don't know who will fill them	US	MEDIUM	CNBC	-	-	2026-10-02T16:15:01.000Z	NEUTRAL
ebe164c4-2775-4b87-9903-afc6dc005fbf	UK new car sales rise 12% in September as EVs and Chinese brands gain ground - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T16:01:03.000Z	BULLISH
ba4c2ba5-f63a-4857-b7ef-39b01042e1d6	The sector in the cross hairs of the bond sell-off looks poised for a bounce, says Mike Khouw	US	MEDIUM	CNBC	-	-	2026-10-02T15:34:28.000Z	NEUTRAL
529ebb04-c7f5-4f1a-a94f-013b496c91d9	Nvidia breaks through to new record highs. Plus, more good news for Boeing	US	MEDIUM	CNBC	-	-	2026-10-02T15:31:51.000Z	BULLISH
76233691-9258-4984-b447-4d909a3c52c2	American starts letting customers mix cash and miles for tickets	US	MEDIUM	CNBC	-	-	2026-10-02T15:00:01.000Z	NEUTRAL
1db2e4a5-6bca-43c2-b786-83aea2ee317c	US issues sanctions against Hamas financing network, Treasury says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:33:45.000Z	BULLISH
95eb7360-e321-4563-9ff6-d905e470cc21	Iran readies harder retaliation if attacked as diplomacy faces long odds - Reuters	US	MEDIUM	Reuters	-	-	2026-10-02T14:32:10.000Z	NEUTRAL
4a48c324-c659-479e-810e-14aa1bff53e4	I’m a psychologist who studies couples: The No. 1 way to end a fight before it escalates—it works ‘almost immediately’	US	MEDIUM	CNBC	-	-	2026-10-11T12:48:01.000Z	NEUTRAL
733406a1-a83e-4b15-9888-06b6461fd6ec	NBA commissioner Adam Silver says league could introduce ‘smart ball’ technology as soon as next year	US	MEDIUM	CNBC	-	-	2026-10-11T12:00:01.000Z	NEUTRAL
b8cc1ff2-0f0b-4789-9014-f2275b632e7a	Yemen's Houthis renew warning over Saudi airports after deadly Riyadh attack - Reuters	US	MEDIUM	Reuters	-	-	2026-10-11T10:48:38.000Z	BEARISH
3422420b-4c8a-47e8-9904-a66ec09a1cf7	Saudi stocks slide after attack on Riyadh airport - Reuters	US	MEDIUM	Reuters	-	-	2026-10-11T07:51:43.000Z	NEUTRAL
7b87d824-0cbf-4ca3-8910-bd041c336fa9	Yemen's Houthis renew warning to airlines, travellers against using Saudi airports - Reuters	US	MEDIUM	Reuters	-	-	2026-10-11T07:34:22.000Z	BULLISH
94d6f323-9ab7-40cc-a3f5-42028e724daf	US military says it disabled cargo vessel trying to run Iran blockade - Reuters	US	MEDIUM	Reuters	-	-	2026-10-11T01:35:00.000Z	NEUTRAL
40872976-2939-45db-88d7-fb944d7547c9	Stocks saw new highs and big declines: How the volatile AI trade moved last week's market	US	MEDIUM	CNBC	-	-	2026-10-10T15:28:16.000Z	BULLISH
7ffebe09-d376-4c91-8b2a-86eca1536270	Israeli strikes kill five people in Gaza, medics say - Reuters	US	MEDIUM	Reuters	-	-	2026-10-10T15:24:12.000Z	BEARISH
eb0d461a-d166-40e1-8b0a-728670ee5aca	Houthi strike on Saudi airport kills 12, worst attack on kingdom in a decade - Reuters	US	MEDIUM	Reuters	-	-	2026-10-10T14:13:00.000Z	BEARISH
eefdbf93-6133-4adb-b3dd-21d8acc671a8	Pokémon card values are soaring. What collectors should know before buying or selling	US	MEDIUM	CNBC	-	-	2026-10-10T13:30:02.000Z	NEUTRAL
b3a091b2-3955-46f5-b1fa-8780b19b7975	I work hard to stay close to my friends. A researcher says it’s good for my well-being—and these 3 habits can help	US	MEDIUM	CNBC	-	-	2026-10-10T13:05:01.000Z	NEUTRAL
b938da90-f2a1-4ed3-8059-2538db6a81b7	How Supreme Court justices are leaning in major 401(k) case over private funds and underperformance	US	MEDIUM	CNBC	-	-	2026-10-10T13:00:01.000Z	NEUTRAL
45fea3c7-2a30-488f-85dd-48021f2aa0b4	Major Saudi conferences to proceed, organisers say, despite deadly airport attack - Reuters	US	MEDIUM	Reuters	-	-	2026-10-10T11:32:00.000Z	NEUTRAL
470c55f4-1e37-43c2-95f5-c08fdb9f7053	Wall Street posts weekly gains with earnings, inflation data on tap - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T23:33:00.000Z	BULLISH
1bebcb95-5edb-4f0b-9ed6-52e238e7ce4b	Options traders start calling bottom on bond rout after 'bullet bid' 10-year auction	US	MEDIUM	CNBC	-	-	2026-10-08T13:29:52.000Z	NEUTRAL
48578bc4-5fe5-4bd9-862a-ab0f0137aa52	Jim Cramer's top 10 things to watch in the stock market Thursday	US	MEDIUM	CNBC	-	-	2026-10-08T13:04:30.000Z	NEUTRAL
7cb016c4-850e-404b-b54e-16d515f0d2c6	Trump's former defense secretary sees no end in sight for Iran war — to the benefit of America's 'greatest adversary'	US	MEDIUM	CNBC	-	-	2026-10-08T12:50:51.000Z	BEARISH
daa10116-45da-4003-9b92-c3577deafd76	Airline chiefs say can't fully guard against rogue pilots after flydubai attack - Reuters	US	MEDIUM	Reuters	-	-	2026-10-08T12:39:40.000Z	BULLISH
5b15f6d6-c244-4b03-a6a0-660151020030	Skydance co-CEOs Ellison and Kreiz speak with CNBC days after finalizing WBD acquisition	US	MEDIUM	CNBC	-	-	2026-10-08T12:25:10.000Z	NEUTRAL
7f6ab5bd-c4b1-4fb4-83f5-3111d7c32b7a	Booms and flight disruptions in Riyadh as Saudi-Houthi war escalates - Reuters	US	MEDIUM	Reuters	-	-	2026-10-08T12:22:37.000Z	BEARISH
8bf9eda4-9a47-46c2-a10c-bc7d30ce3734	Ryanair's O'Leary says 'insanely higher' jet fuel cost could remain into 2028 - Reuters	US	MEDIUM	Reuters	-	-	2026-10-08T11:53:24.000Z	BULLISH
575cf4e7-439a-46d5-8475-c68272477a1d	As Munir's military takes on Gulf role, Pakistan's parliament is not involved - Reuters	US	MEDIUM	Reuters	-	-	2026-10-08T11:28:20.000Z	NEUTRAL
4c70e061-850c-4459-bba1-7d425c941e7e	Russia, China hypersonic missile threats fuel need for space defense, satellite CEO says	US	MEDIUM	CNBC	-	-	2026-10-08T11:04:39.000Z	NEUTRAL
f4ddda94-bdc2-4778-85c5-5f41b908302b	Iran’s wartime hunt for protesters at home and abroad ushers in a new era of repression - Reuters	US	MEDIUM	Reuters	-	-	2026-10-08T11:00:00.000Z	BEARISH
f626210f-8887-46bb-9cdc-3bfc587a2c25	Latest suspect in RAF Fairford airbase plot released on bail - Reuters	US	MEDIUM	Reuters	-	-	2026-10-08T10:24:27.000Z	NEUTRAL
2f1b08b9-79c8-456c-aed1-4fb7b8cf86fd	NFL tells Supreme Court prediction markets are gambling and should be regulated by the states	US	MEDIUM	CNBC	-	-	2026-10-08T10:00:02.000Z	NEUTRAL
91da1fc7-e0f7-4381-9e23-6a8ce69f41c3	Gulf stocks retreat as Hormuz tanker attacks hit wartime high - Reuters	US	MEDIUM	Reuters	-	-	2026-10-08T08:11:45.000Z	BULLISH
4c5a8c39-2189-47c2-8b68-4ae1c4cd4da4	COMMENTARY: Battle for Mideast oil market share has already begun - Reuters	US	MEDIUM	Reuters	-	-	2026-10-08T06:00:00.000Z	NEUTRAL
1488704b-f291-41ac-adfc-919c4e7c571e	British diplomats to remain at scaled-down mission in Jerusalem - Reuters	US	MEDIUM	Reuters	-	-	2026-10-08T04:13:00.000Z	NEUTRAL
792020ef-2d81-4df0-9e2c-cc394c098270	Tech stocks' resilience has puzzled investors. The options market could hold some clues	US	MEDIUM	CNBC	-	-	2026-10-09T13:07:30.000Z	NEUTRAL
21a2cc07-fec8-441c-98f2-21e87383d7c2	Jim Cramer's top 10 things to watch in the stock market Friday	US	MEDIUM	CNBC	-	-	2026-10-09T13:01:32.000Z	NEUTRAL
39a4a581-1a8d-44a5-9819-d20eac392959	Houthi strikes on Riyadh airport killed three Saudis as war escalates - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T11:57:24.000Z	BEARISH
ffa1263b-fd35-4e34-a404-5856a6fd7cea	Ferrari’s chairman is bullish on AI. He’s less certain how businesses will cash in	US	MEDIUM	CNBC	-	-	2026-10-09T11:54:21.000Z	NEUTRAL
15e7524c-9910-4374-92c6-9df0819f6e10	Kalshi traders see high odds that more than 5,100 data centers will be planned or operating before 2027	US	MEDIUM	CNBC	-	-	2026-10-09T11:54:04.000Z	BULLISH
4b76c136-b852-4226-af9f-ea566c7a5da2	EU aviation agency widens Saudi airspace alert, citing growing risk from Houthi strikes - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T11:30:33.000Z	BEARISH
2063a5a1-0011-4361-97b9-ec132798d2fd	Delta CEO: 'Safety is going to make the call' on launching Saudi Arabia flight	US	MEDIUM	CNBC	-	-	2026-10-09T11:12:02.000Z	NEUTRAL
a100802c-5c40-4386-9b7e-ea669bbc0922	Bipartisan majority of Americans blame Trump policies for rising costs, Reuters/Ipsos poll finds - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T11:01:29.000Z	NEUTRAL
4da0bed2-8246-4446-bf7d-98fe4addd316	Trump's moves to boost diesel supplies have not yet lowered prices - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T10:19:51.000Z	NEUTRAL
27a8e4f8-c99c-48d1-8e7a-5b63a767db5d	Three Saudi nationals killed in attacks on Riyadh airport, aviation authority says - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T08:39:54.000Z	NEUTRAL
94658c40-463c-4d87-898f-28f0ead2d96b	Treasury yields steady as Trump strikes diplomatic tone on Iran ahead of midterms	US	MEDIUM	CNBC	-	-	2026-10-09T08:24:50.000Z	BEARISH
35d0bd0c-1c19-4dcb-96b2-ef78c846599b	Scenes from across France as student protests spread - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T07:07:35.000Z	NEUTRAL
14c92630-3582-4287-add2-4c4189ffb528	China to resume October fuel exports after a brief halt, four trade sources say - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T03:28:00.000Z	NEUTRAL
944129d9-1826-43ae-b1ed-81463a3e2e25	Oil falls as Trump comments on Iran talks ease supply concerns - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T02:28:00.000Z	BEARISH
dd70dcd3-4957-46b6-b20b-8f46c0ca81a4	Gold adds over 1% on easing oil prices, softer dollar - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T01:58:00.000Z	NEUTRAL
c493ccf8-3d4e-4ff1-b953-c8c26bbc8e4e	Pokémon card values are soaring. What collectors should know before buying or selling	US	MEDIUM	CNBC	-	-	2026-10-10T13:30:02.000Z	NEUTRAL
5f1be1da-4d57-450b-8cf8-e5cb200efca5	I work hard to stay close to my friends. A researcher says it’s good for my well-being—and these 3 habits can help	US	MEDIUM	CNBC	-	-	2026-10-10T13:05:01.000Z	NEUTRAL
6bdee818-4b7d-429f-8ad0-fa2e837f87d9	How Supreme Court justices are leaning in major 401(k) case over private funds and underperformance	US	MEDIUM	CNBC	-	-	2026-10-10T13:00:01.000Z	NEUTRAL
b62d80a6-7d10-4a13-adb9-819c2f0a0f72	Wall Street posts weekly gains with earnings, inflation data on tap - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T23:33:00.000Z	BULLISH
fcd2a104-ae32-401e-bd86-e18f49a567cc	Kremlin says Putin in phone call with Trump downplays immediate Ukraine talks resumption - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T22:04:42.000Z	NEUTRAL
e7759eab-f99f-45e3-94cb-142743888852	What's behind the recovery rally in tech stocks — plus, Elon Musk's very good week	US	MEDIUM	CNBC	-	-	2026-10-09T19:02:29.000Z	NEUTRAL
fce48507-a27c-42b4-ad1d-ec494ba481eb	Two massive trades just happened in Micron and Nvidia. What they could mean for chips	US	MEDIUM	CNBC	-	-	2026-10-09T18:50:21.000Z	NEUTRAL
18626336-a20f-4592-aa76-d7b4ef7b903b	Trump created a committee to dig into the Fed's Lisa Cook. What is it and what comes next?	US	MEDIUM	CNBC	-	-	2026-10-09T18:20:57.000Z	NEUTRAL
ae03a750-dd59-451a-82ee-69725455c162	The used car market is stagnant. Here's how to profit anyway	US	MEDIUM	CNBC	-	-	2026-10-09T17:37:31.000Z	NEUTRAL
24326e7e-f261-4d92-881d-096a5e237c19	Tesla drops 'Full Self-Driving' brand name in Europe after regulator pushback	US	MEDIUM	CNBC	-	-	2026-10-09T17:12:32.000Z	BEARISH
16b23045-8338-4520-afc6-12dd85cb7ab0	Cramer: Investors selling Apple on latest iPhone 18 report are 'stupid as plywood'	US	MEDIUM	CNBC	-	-	2026-10-09T16:43:00.000Z	NEUTRAL
c1bb435e-9d50-4209-88b2-51693bef69c3	London stocks post weekly gains as gilt yields retreat; telecom stocks fall - Reuters	US	MEDIUM	Reuters	-	-	2026-10-09T16:35:20.000Z	BULLISH
2ff9a6bb-a4cd-4f00-8e10-9c5fd8a75d09	Verizon stock heads for worst day since 2002 as SpaceX U.S. network plans whack telcos	US	MEDIUM	CNBC	-	-	2026-10-09T16:26:44.000Z	NEUTRAL
\.


--
-- Data for Name: eod_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eod_data (id, symbol, date, "closePrice", volume, "historicalAvgVolume", "putVolume", "callVolume", "shortVolume", "isLatest") FROM stdin;
\.


--
-- Data for Name: market_close_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.market_close_reports (id, user_id, watchlist_id, data, created_at) FROM stdin;
a7c42832-dab8-484e-9e47-ae9a973b8449	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 46.15, "price": 0, "symbol": "MSFT", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-20.79%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}, {"RSI": 46.18, "price": 0, "symbol": "NVDA", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-19.85%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}]	2026-09-19 11:07:32.928176
7011ccb5-691a-4095-9c54-b149f9f4118f	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 46.15, "price": 0, "symbol": "MSFT", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-20.79%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}, {"RSI": 46.18, "price": 0, "symbol": "NVDA", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-19.85%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}]	2026-09-19 11:07:58.468563
bc3d6d16-8217-4bc9-affa-d180dc98f63e	user2	62c63a21-87aa-472a-b1ad-fef23a5ccf25	[{"RSI": 46.15, "price": 0, "symbol": "MSFT", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-20.79%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}, {"RSI": 46.18, "price": 0, "symbol": "NVDA", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-19.85%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}]	2026-09-19 11:10:37.203168
5a9556dc-5e9a-4a5e-8f13-3fdd5b3d7c76	user2	62c63a21-87aa-472a-b1ad-fef23a5ccf25	[{"RSI": 46.15, "price": 0, "symbol": "MSFT", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-20.79%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}, {"RSI": 46.18, "price": 0, "symbol": "NVDA", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-19.85%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}]	2026-09-19 12:39:50.429991
74f7d273-a38a-4470-9e20-d6906af20b95	user2	62c63a21-87aa-472a-b1ad-fef23a5ccf25	[{"RSI": 46.15, "price": 0, "symbol": "MSFT", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-20.79%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}, {"RSI": 46.18, "price": 0, "symbol": "NVDA", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-19.85%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}]	2026-09-19 12:40:54.182171
30b22cfc-a38b-4ba0-8e29-f664e7cb5550	user3	9a0e01ec-58fc-4d68-b0d2-532d40d56cda	[{"RSI": 46.15, "price": 0, "symbol": "MSFT", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-20.79%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}, {"RSI": 46.18, "price": 0, "symbol": "NVDA", "volume": 0, "comparison_period": "3DAY", "RSI_change_percent": "-19.85%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}]	2026-09-19 12:42:40.771351
b68c5453-324b-48d6-8ad3-bf74eb0213a9	user4	47a34add-d0ab-46d3-af6f-b77498b3d40e	[{"RSI": 40.53, "price": 0, "symbol": "MSFT", "volume": 0, "comparison_period": "1DAY", "RSI_change_percent": "-21.16%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}, {"RSI": 40.68, "price": 0, "symbol": "NVDA", "volume": 0, "comparison_period": "1DAY", "RSI_change_percent": "-20.89%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}]	2026-09-19 12:44:28.153122
5fa6416b-e2f8-4d39-8bff-612ff624c346	user5	4c5fcd1e-a55f-4576-977a-896091b05eb9	[{"RSI": 41.91, "price": 0, "symbol": "MSFT", "volume": 0, "comparison_period": "7DAY", "RSI_change_percent": "-19.85%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}, {"RSI": 41.84, "price": 0, "symbol": "NVDA", "volume": 0, "comparison_period": "7DAY", "RSI_change_percent": "-19.63%", "price_change_percent": "-100.00%", "volume_change_percent": "-100.00%"}]	2026-09-19 12:45:06.705408
02523e15-2bd8-49d5-b028-eb6c10c16eae	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 56.91, "price": 501.61, "symbol": "MSFT", "volume": 27959945, "comparison_period": "7DAY", "RSI_change_percent": "+2.67%", "price_change_percent": "+1.21%", "volume_change_percent": "+92.69%"}, {"RSI": 63.77, "price": 227.38, "symbol": "NVDA", "volume": 109806068, "comparison_period": "7DAY", "RSI_change_percent": "+11.53%", "price_change_percent": "+4.16%", "volume_change_percent": "+23.29%"}]	2026-09-22 20:10:50.636768
ffb932ef-0698-4080-94db-bc73e9b2c4f3	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 54.04, "price": 498, "symbol": "MSFT", "volume": 21652838, "comparison_period": "7DAY", "RSI_change_percent": "-2.51%", "price_change_percent": "+0.48%", "volume_change_percent": "+49.14%"}, {"RSI": 64.47, "price": 228.87, "symbol": "NVDA", "volume": 95746745, "comparison_period": "7DAY", "RSI_change_percent": "+12.75%", "price_change_percent": "+4.85%", "volume_change_percent": "+7.51%"}]	2026-09-23 22:08:19.451251
c6f4c057-aa73-4120-af9e-0f96828a9b07	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 54.04, "price": 498, "symbol": "MSFT", "volume": 21652838, "comparison_period": "7DAY", "RSI_change_percent": "-2.51%", "price_change_percent": "+0.48%", "volume_change_percent": "+49.14%"}, {"RSI": 64.47, "price": 228.87, "symbol": "NVDA", "volume": 95746745, "comparison_period": "7DAY", "RSI_change_percent": "+12.75%", "price_change_percent": "+4.85%", "volume_change_percent": "+7.51%"}]	2026-09-23 23:30:43.838176
599745e5-6274-4ec8-b625-67c3f5b9160b	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 52.2, "price": 497.93, "symbol": "MSFT", "volume": 16657643, "comparison_period": "7DAY", "RSI_change_percent": "+8.82%", "price_change_percent": "+1.56%", "volume_change_percent": "-0.08%"}, {"RSI": 56.93, "price": 224.58, "symbol": "NVDA", "volume": 77469856, "comparison_period": "7DAY", "RSI_change_percent": "+13.00%", "price_change_percent": "+4.99%", "volume_change_percent": "-19.77%"}]	2026-09-26 00:59:31.03825
a61e5a5a-9e09-4916-8827-a18b4862ce3b	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 52.2, "price": 497.93, "symbol": "MSFT", "volume": 16657643, "comparison_period": "7DAY", "RSI_change_percent": "+8.82%", "price_change_percent": "+1.56%", "volume_change_percent": "-0.08%"}, {"RSI": 56.93, "price": 224.58, "symbol": "NVDA", "volume": 77469856, "comparison_period": "7DAY", "RSI_change_percent": "+13.00%", "price_change_percent": "+4.99%", "volume_change_percent": "-19.77%"}]	2026-09-26 01:04:42.599263
40365dcd-9889-456c-8a52-cc91fb14d4bf	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 55.08, "price": 512.9, "symbol": "MSFT", "volume": 27223265, "comparison_period": "7DAY", "RSI_change_percent": "+21.21%", "price_change_percent": "+2.99%", "volume_change_percent": "+25.73%"}, {"RSI": 57.33, "price": 228.38, "symbol": "NVDA", "volume": 121732189, "comparison_period": "7DAY", "RSI_change_percent": "-2.98%", "price_change_percent": "-0.21%", "volume_change_percent": "+27.14%"}]	2026-10-01 21:52:54.47874
3c206107-5225-4d5a-b717-41bb55575e80	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 60.74, "price": 512.8, "symbol": "MSFT", "volume": 19731883, "comparison_period": "3DAY", "RSI_change_percent": "+4.19%", "price_change_percent": "+0.75%", "volume_change_percent": "-7.54%"}, {"RSI": 57.45, "price": 230.86, "symbol": "NVDA", "volume": 98591412, "comparison_period": "3DAY", "RSI_change_percent": "+10.21%", "price_change_percent": "+1.61%", "volume_change_percent": "-2.86%"}]	2026-10-02 20:51:42.594664
8f6ffed9-7b89-4b4e-bf08-106cb19e397f	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 60.74, "price": 512.8, "symbol": "MSFT", "volume": 19731883, "comparison_period": "3DAY", "RSI_change_percent": "+4.19%", "price_change_percent": "+0.75%", "volume_change_percent": "-7.54%"}, {"RSI": 57.45, "price": 230.86, "symbol": "NVDA", "volume": 98591412, "comparison_period": "3DAY", "RSI_change_percent": "+10.21%", "price_change_percent": "+1.61%", "volume_change_percent": "-2.86%"}]	2026-10-02 20:52:20.933001
6f4f60a4-7093-4fed-a346-ca5b69ee0473	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 63.46, "price": 517.53, "symbol": "MSFT", "volume": 17822339, "comparison_period": "3DAY", "RSI_change_percent": "+7.85%", "price_change_percent": "+1.68%", "volume_change_percent": "-16.49%"}, {"RSI": 59.65, "price": 233.95, "symbol": "NVDA", "volume": 135167817, "comparison_period": "3DAY", "RSI_change_percent": "+15.67%", "price_change_percent": "+2.97%", "volume_change_percent": "+33.18%"}]	2026-10-03 03:32:14.194679
f1ae7818-9cdc-4f45-bd61-5830ace50987	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 59.98, "price": 517.53, "symbol": "MSFT", "volume": 17822339, "comparison_period": "7DAY", "RSI_change_percent": "+14.93%", "price_change_percent": "+3.38%", "volume_change_percent": "-8.35%"}, {"RSI": 60.57, "price": 233.95, "symbol": "NVDA", "volume": 135167817, "comparison_period": "7DAY", "RSI_change_percent": "+18.35%", "price_change_percent": "+3.74%", "volume_change_percent": "+50.95%"}]	2026-10-03 04:28:31.873209
c721368d-70f6-42ce-b621-f2a293809d8c	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 69.32, "price": 529.76, "symbol": "MSFT", "volume": 16773600, "comparison_period": "7DAY", "RSI_change_percent": "+17.41%", "price_change_percent": "+4.03%", "volume_change_percent": "-14.54%"}, {"RSI": 61.79, "price": 237.47, "symbol": "NVDA", "volume": 81485100, "comparison_period": "7DAY", "RSI_change_percent": "+14.87%", "price_change_percent": "+3.76%", "volume_change_percent": "-42.75%"}]	2026-10-08 14:20:51.314272
3fb149ea-748d-4abb-a23b-58cb97f16208	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 69.02, "price": 535.07, "symbol": "MSFT", "volume": 18500612, "comparison_period": "7DAY", "RSI_change_percent": "+10.56%", "price_change_percent": "+4.32%", "volume_change_percent": "-32.04%"}, {"RSI": 51.38, "price": 229.28, "symbol": "NVDA", "volume": 84645559, "comparison_period": "7DAY", "RSI_change_percent": "-7.76%", "price_change_percent": "+0.39%", "volume_change_percent": "-30.47%"}]	2026-10-10 14:29:31.134982
0fd1823e-88db-46a5-94e9-851e98d7919e	user1	dcf5cef0-861f-4a73-beaf-2c1589a27bd7	[{"RSI": 68.48, "price": 535.07, "symbol": "MSFT", "volume": 18500612, "comparison_period": "7DAY", "RSI_change_percent": "+10.54%", "price_change_percent": "+4.32%", "volume_change_percent": "-32.04%"}, {"RSI": 55.71, "price": 229.28, "symbol": "NVDA", "volume": 84645559, "comparison_period": "7DAY", "RSI_change_percent": "-12.47%", "price_change_percent": "+0.39%", "volume_change_percent": "-30.47%"}]	2026-10-11 13:42:26.985029
\.


--
-- Data for Name: mover_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mover_results (id, period, symbol, current_price, previous_close_price, change_amount, change_percent, volatility, calculated_at, type) FROM stdin;
71	1W	MSFT	512.9000	498.0000	14.9000	2.9900	2.9900	2026-10-11 13:42:50.684+00	most_volatile
72	1W	JPM	330.8300	340.0000	-9.1700	-2.7000	2.7000	2026-10-11 13:42:50.684+00	most_volatile
73	1W	XOM	162.7500	158.7100	4.0400	2.5500	2.5500	2026-10-11 13:42:50.684+00	most_volatile
74	1W	AMZN	249.1500	254.9800	-5.8300	-2.2900	2.2900	2026-10-11 13:42:50.684+00	most_volatile
75	1W	JNJ	264.7400	269.1900	-4.4500	-1.6500	1.6500	2026-10-11 13:42:50.684+00	most_volatile
76	1W	LLY	1157.0800	1170.1400	-13.0600	-1.1200	1.1200	2026-10-11 13:42:50.684+00	most_volatile
77	1W	DIS	104.9000	103.8200	1.0800	1.0400	1.0400	2026-10-11 13:42:50.684+00	most_volatile
78	1W	CVX	204.2100	202.4100	1.8000	0.8900	0.8900	2026-10-11 13:42:50.684+00	most_volatile
79	1W	V	359.3300	362.0400	-2.7100	-0.7500	0.7500	2026-10-11 13:42:50.684+00	most_volatile
80	1W	NVDA	228.3800	228.8700	-0.4900	-0.2100	0.2100	2026-10-11 13:42:50.684+00	most_volatile
\.


--
-- Data for Name: price_alert_stocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_alert_stocks (id, symbol, name, industry, eod_price, price_date, market_cap, created_at, updated_at, open, high, low, volume) FROM stdin;
2752	MSFT	Microsoft Corporation	Technology	\N	2026-01-01	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2753	MSFT	Microsoft Corporation	Technology	472.94	2026-01-02	3511837502642.31	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	484.3900	484.6600	470.1600	25571600
2754	MSFT	Microsoft Corporation	Technology	\N	2026-01-03	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2755	MSFT	Microsoft Corporation	Technology	\N	2026-01-04	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2756	MSFT	Microsoft Corporation	Technology	472.85	2026-01-05	3511169230741.28	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	474.0600	476.0700	469.5000	25250300
2757	MSFT	Microsoft Corporation	Technology	478.51	2026-01-06	3553197845413.50	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	473.8000	478.7400	469.7500	23037700
2758	MSFT	Microsoft Corporation	Technology	483.47	2026-01-07	3590028487598.16	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	479.7600	489.7000	477.9500	25564200
2759	MSFT	Microsoft Corporation	Technology	478.11	2026-01-08	3550227445929.37	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	481.2400	482.6600	475.8600	18162600
2760	MSFT	Microsoft Corporation	Technology	479.28	2026-01-09	3558915433862.09	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	474.0600	479.8200	472.2000	18491000
2761	MSFT	Microsoft Corporation	Technology	\N	2026-01-10	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2762	MSFT	Microsoft Corporation	Technology	\N	2026-01-11	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2763	MSFT	Microsoft Corporation	Technology	477.18	2026-01-12	3543321743009.06	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	476.6700	480.9900	475.6800	23519900
2764	MSFT	Microsoft Corporation	Technology	470.67	2026-01-13	3494981595957.22	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	474.6800	475.7800	465.9500	28545800
2765	MSFT	Microsoft Corporation	Technology	459.38	2026-01-14	3411147123913.13	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	466.4600	468.2000	457.1700	28184300
2766	MSFT	Microsoft Corporation	Technology	456.66	2026-01-15	3390949631113.22	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	464.1200	464.2500	455.9000	23225800
2767	MSFT	Microsoft Corporation	Technology	459.86	2026-01-16	3414711240718.62	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	457.8300	463.1900	456.4800	34246700
2768	MSFT	Microsoft Corporation	Technology	\N	2026-01-17	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2769	MSFT	Microsoft Corporation	Technology	\N	2026-01-18	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2770	MSFT	Microsoft Corporation	Technology	\N	2026-01-19	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2771	MSFT	Microsoft Corporation	Technology	454.52	2026-01-20	3375058854989.84	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	451.2200	456.8000	449.2800	26130000
2772	MSFT	Microsoft Corporation	Technology	444.11	2026-01-21	3297758899235.37	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	452.6000	452.6900	438.6800	37980500
2773	MSFT	Microsoft Corporation	Technology	451.14	2026-01-22	3349960701582.38	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	447.6200	452.8400	444.7000	25349400
2774	MSFT	Microsoft Corporation	Technology	465.95	2026-01-23	3459933012175.32	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	451.8700	471.1000	450.5300	38000200
2775	MSFT	Microsoft Corporation	Technology	\N	2026-01-24	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2776	MSFT	Microsoft Corporation	Technology	\N	2026-01-25	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2777	MSFT	Microsoft Corporation	Technology	470.28	2026-01-26	3492085524443.09	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	465.3100	474.2500	462.0000	29291200
2778	MSFT	Microsoft Corporation	Technology	480.58	2026-01-27	3568568552356.53	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	473.7000	482.8700	473.1600	29213900
2779	MSFT	Microsoft Corporation	Technology	481.63	2026-01-28	3576365511087.88	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	483.2100	483.7400	478.0000	36875400
2780	MSFT	Microsoft Corporation	Technology	433.50	2026-01-29	3218973970348.50	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	439.9900	442.5000	421.0200	128855300
2781	MSFT	Microsoft Corporation	Technology	430.29	2026-01-30	3195138032773.10	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	439.1700	439.6000	426.4500	58566800
2782	MSFT	Microsoft Corporation	Technology	\N	2026-01-31	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2783	MSFT	Microsoft Corporation	Technology	\N	2026-02-01	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2784	MSFT	Microsoft Corporation	Technology	423.37	2026-02-02	3143753158267.12	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	430.2400	430.7400	422.2500	42219900
2785	MSFT	Microsoft Corporation	Technology	411.21	2026-02-03	3053458497903.40	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	422.0100	422.0500	408.5600	61424100
2786	MSFT	Microsoft Corporation	Technology	414.19	2026-02-04	3075586705046.06	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	411.0000	419.8000	409.2400	45012400
2787	MSFT	Microsoft Corporation	Technology	393.67	2026-02-05	2923214593150.22	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	407.4400	408.3000	392.3200	66289200
2788	MSFT	Microsoft Corporation	Technology	401.14	2026-02-06	2978683427032.38	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	399.1700	401.7900	392.9200	53515300
2789	MSFT	Microsoft Corporation	Technology	\N	2026-02-07	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2790	MSFT	Microsoft Corporation	Technology	\N	2026-02-08	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2791	MSFT	Microsoft Corporation	Technology	413.60	2026-02-09	3071205660399.53	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	404.8500	414.8900	400.8700	45480500
2792	MSFT	Microsoft Corporation	Technology	413.27	2026-02-10	3068755103486.09	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	419.6200	423.6800	412.7000	44857900
2793	MSFT	Microsoft Corporation	Technology	404.37	2026-02-11	3002667793938.12	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	416.1800	416.4600	401.0100	42491000
2794	MSFT	Microsoft Corporation	Technology	401.84	2026-02-12	2983881172910.28	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	405.0000	406.2000	398.0100	40802400
2795	MSFT	Microsoft Corporation	Technology	401.32	2026-02-13	2980019970834.44	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	404.4500	405.5400	398.0500	34091600
2796	MSFT	Microsoft Corporation	Technology	\N	2026-02-14	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2797	MSFT	Microsoft Corporation	Technology	\N	2026-02-15	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2798	MSFT	Microsoft Corporation	Technology	\N	2026-02-16	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2799	MSFT	Microsoft Corporation	Technology	396.86	2026-02-17	2946901874785.62	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	399.2200	400.5200	394.5300	32078800
2800	MSFT	Microsoft Corporation	Technology	399.60	2026-02-18	2967248023525.53	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	398.1300	402.5600	396.3200	23223400
2801	MSFT	Microsoft Corporation	Technology	398.46	2026-02-19	2958782792893.15	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	400.6900	404.4300	396.6700	28234000
2802	MSFT	Microsoft Corporation	Technology	397.23	2026-02-20	2949649516969.41	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	396.1100	400.1200	395.1600	34015200
2803	MSFT	Microsoft Corporation	Technology	\N	2026-02-21	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2804	MSFT	Microsoft Corporation	Technology	\N	2026-02-22	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2805	MSFT	Microsoft Corporation	Technology	384.47	2026-02-23	2854899483989.16	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	395.0000	395.3600	383.1000	43238300
2806	MSFT	Microsoft Corporation	Technology	389.00	2026-02-24	2888537195999.00	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	384.1400	389.3600	381.7100	33884700
2807	MSFT	Microsoft Corporation	Technology	400.60	2026-02-25	2974673569016.53	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	390.5300	401.4700	390.1600	43625500
2808	MSFT	Microsoft Corporation	Technology	401.72	2026-02-26	2982990143708.91	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	404.7100	407.4900	398.7400	34405900
2809	MSFT	Microsoft Corporation	Technology	392.74	2026-02-27	2916308663620.25	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	390.8800	396.8200	389.8800	51367200
2810	MSFT	Microsoft Corporation	Technology	\N	2026-02-28	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2811	MSFT	Microsoft Corporation	Technology	\N	2026-03-01	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2812	MSFT	Microsoft Corporation	Technology	398.55	2026-03-02	2959451064794.18	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	392.8600	401.1900	390.6300	35474900
2813	MSFT	Microsoft Corporation	Technology	403.93	2026-03-03	2999400535793.31	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	393.1400	406.7000	392.6700	38199200
2814	MSFT	Microsoft Corporation	Technology	405.20	2026-03-04	3008831123597.07	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	401.2700	411.0300	400.3100	35808000
2815	MSFT	Microsoft Corporation	Technology	410.68	2026-03-05	3049522967857.56	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	404.4200	411.6100	404.4000	39001300
2816	MSFT	Microsoft Corporation	Technology	408.96	2026-03-06	3036751020548.65	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	409.2000	413.0500	408.5100	31123900
2817	MSFT	Microsoft Corporation	Technology	\N	2026-03-07	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2818	MSFT	Microsoft Corporation	Technology	\N	2026-03-08	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2819	MSFT	Microsoft Corporation	Technology	409.41	2026-03-09	3040092606663.47	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	404.9200	410.2100	403.5000	30131900
2820	MSFT	Microsoft Corporation	Technology	405.76	2026-03-10	3012989410943.25	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	410.0300	410.2000	402.9300	31706400
2821	MSFT	Microsoft Corporation	Technology	404.88	2026-03-11	3006454894653.63	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	405.5700	409.0100	401.5900	25512100
2822	MSFT	Microsoft Corporation	Technology	401.86	2026-03-12	2984029602240.62	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	404.6300	406.1200	401.7100	27263900
2823	MSFT	Microsoft Corporation	Technology	395.55	2026-03-13	2937174428321.18	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	401.0000	404.8000	394.2500	26848000
2824	MSFT	Microsoft Corporation	Technology	\N	2026-03-14	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2825	MSFT	Microsoft Corporation	Technology	\N	2026-03-15	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2826	MSFT	Microsoft Corporation	Technology	399.95	2026-03-16	2969847009769.32	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	398.0700	400.6300	394.7900	27733700
2827	MSFT	Microsoft Corporation	Technology	399.41	2026-03-17	2965837151753.47	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	400.2700	404.4000	397.7500	26228300
2828	MSFT	Microsoft Corporation	Technology	391.79	2026-03-18	2909254531369.60	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	397.1300	398.0000	391.0000	25908500
2829	MSFT	Microsoft Corporation	Technology	389.02	2026-03-19	2888685625329.34	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	390.1000	392.4900	387.0600	25138800
2830	MSFT	Microsoft Corporation	Technology	381.87	2026-03-20	2835593020390.62	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	386.7900	387.0000	380.1200	50853200
2831	MSFT	Microsoft Corporation	Technology	\N	2026-03-21	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2832	MSFT	Microsoft Corporation	Technology	\N	2026-03-22	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2833	MSFT	Microsoft Corporation	Technology	383.00	2026-03-23	2843983923053.00	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	383.9000	387.2100	381.6800	29680100
2834	MSFT	Microsoft Corporation	Technology	372.74	2026-03-24	2767797753800.25	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	382.3600	382.4700	371.8500	42733600
2835	MSFT	Microsoft Corporation	Technology	371.04	2026-03-25	2755174462431.35	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	376.9200	377.0600	369.6300	31181200
2836	MSFT	Microsoft Corporation	Technology	365.97	2026-03-26	2717526892405.66	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	370.8200	374.7200	365.1900	36836600
2837	MSFT	Microsoft Corporation	Technology	356.77	2026-03-27	2649211783244.59	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	361.9000	362.4500	356.5100	37883400
2838	MSFT	Microsoft Corporation	Technology	\N	2026-03-28	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2839	MSFT	Microsoft Corporation	Technology	\N	2026-03-29	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2840	MSFT	Microsoft Corporation	Technology	358.96	2026-03-30	2665473745998.65	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	361.9000	365.3600	356.2800	44797000
2841	MSFT	Microsoft Corporation	Technology	370.17	2026-03-31	2748714274111.72	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	364.5500	372.9000	363.0700	45244400
2842	MSFT	Microsoft Corporation	Technology	369.37	2026-04-01	2742773701753.12	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	373.4900	373.9900	368.2000	29417200
2843	MSFT	Microsoft Corporation	Technology	373.46	2026-04-02	2773144155618.15	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	367.2100	373.6400	364.1500	24099100
2844	MSFT	Microsoft Corporation	Technology	\N	2026-04-03	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2845	MSFT	Microsoft Corporation	Technology	\N	2026-04-04	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2846	MSFT	Microsoft Corporation	Technology	\N	2026-04-05	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2847	MSFT	Microsoft Corporation	Technology	372.88	2026-04-06	2768837438941.63	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	373.4900	373.7300	369.5000	16146600
2848	MSFT	Microsoft Corporation	Technology	372.29	2026-04-07	2764456394295.10	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	370.3400	372.4500	366.5600	21443300
2849	MSFT	Microsoft Corporation	Technology	374.33	2026-04-08	2779604343937.78	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	384.9800	385.0000	371.4100	33064800
2850	MSFT	Microsoft Corporation	Technology	373.07	2026-04-09	2770248310713.69	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	372.5000	373.5000	367.0500	30435300
2851	MSFT	Microsoft Corporation	Technology	370.87	2026-04-10	2753912019989.62	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	372.9800	375.6400	370.0300	28111100
2852	MSFT	Microsoft Corporation	Technology	\N	2026-04-11	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2853	MSFT	Microsoft Corporation	Technology	\N	2026-04-12	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2854	MSFT	Microsoft Corporation	Technology	384.37	2026-04-13	2854156884118.12	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	373.6100	384.5400	371.0200	35745800
2855	MSFT	Microsoft Corporation	Technology	393.11	2026-04-14	2919056079194.37	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	387.9200	394.6900	386.5200	37504500
2856	MSFT	Microsoft Corporation	Technology	411.22	2026-04-15	3053532825873.41	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	398.0000	414.3700	396.7300	45063400
2857	MSFT	Microsoft Corporation	Technology	420.26	2026-04-16	3120659820562.75	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	419.8600	420.8200	412.1400	41642400
2858	MSFT	Microsoft Corporation	Technology	422.79	2026-04-17	3139446441590.60	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	424.8200	431.5800	420.6900	48568200
2859	MSFT	Microsoft Corporation	Technology	\N	2026-04-18	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2860	MSFT	Microsoft Corporation	Technology	\N	2026-04-19	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2861	MSFT	Microsoft Corporation	Technology	418.07	2026-04-20	3104397857808.69	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	421.1500	423.3300	416.3000	27582200
2862	MSFT	Microsoft Corporation	Technology	424.16	2026-04-21	3149619402655.72	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	420.2400	427.1800	417.2000	32048500
2863	MSFT	Microsoft Corporation	Technology	432.92	2026-04-22	3214667253671.97	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	426.1900	433.7000	423.6700	29378200
2864	MSFT	Microsoft Corporation	Technology	415.75	2026-04-23	3087170537883.25	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	419.8900	423.6600	411.4100	38308000
2865	MSFT	Microsoft Corporation	Technology	424.62	2026-04-24	3153035090130.87	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	416.9700	424.9500	415.8000	27457400
2866	MSFT	Microsoft Corporation	Technology	\N	2026-04-25	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2867	MSFT	Microsoft Corporation	Technology	\N	2026-04-26	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2868	MSFT	Microsoft Corporation	Technology	424.82	2026-04-27	3154520289872.94	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	422.3800	427.1100	417.0700	30867300
2869	MSFT	Microsoft Corporation	Technology	429.25	2026-04-28	3187415402011.75	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	424.5700	429.9200	421.9000	30438100
2870	MSFT	Microsoft Corporation	Technology	424.46	2026-04-29	3151846975659.15	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	424.5800	426.8200	420.2900	38288300
2871	MSFT	Microsoft Corporation	Technology	407.78	2026-04-30	3027988931255.59	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	410.8100	414.4200	398.0100	70909400
2872	MSFT	Microsoft Corporation	Technology	414.44	2026-05-01	3077443091418.81	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	412.8000	417.1100	410.4400	31372400
2873	MSFT	Microsoft Corporation	Technology	\N	2026-05-02	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2874	MSFT	Microsoft Corporation	Technology	\N	2026-05-03	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2875	MSFT	Microsoft Corporation	Technology	413.62	2026-05-04	3071354089729.87	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	411.5400	420.7800	410.8000	28066500
2876	MSFT	Microsoft Corporation	Technology	411.38	2026-05-05	3054720940345.13	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	415.3200	416.7800	408.8000	25700900
2877	MSFT	Microsoft Corporation	Technology	413.96	2026-05-06	3073878748003.65	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	408.0000	418.4200	405.1100	30285900
2878	MSFT	Microsoft Corporation	Technology	420.77	2026-05-07	3124446694668.59	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	420.1100	427.9800	418.7600	34942400
2879	MSFT	Microsoft Corporation	Technology	415.12	2026-05-08	3082492407966.37	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	417.3900	418.6300	414.0000	33383800
2880	MSFT	Microsoft Corporation	Technology	\N	2026-05-09	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2881	MSFT	Microsoft Corporation	Technology	\N	2026-05-10	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2882	MSFT	Microsoft Corporation	Technology	412.66	2026-05-11	3064225629509.22	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	407.8700	412.6900	405.5000	35657900
2883	MSFT	Microsoft Corporation	Technology	407.77	2026-05-12	3027914603285.59	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	414.4800	415.5000	406.6400	38594200
2884	MSFT	Microsoft Corporation	Technology	405.21	2026-05-13	3008905224957.40	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	403.2000	406.3100	401.0300	29667100
2885	MSFT	Microsoft Corporation	Technology	409.43	2026-05-14	3040241035993.81	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	404.4800	411.8400	400.8800	27077500
2886	MSFT	Microsoft Corporation	Technology	421.92	2026-05-15	3132986253270.97	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	414.2700	428.1700	412.9100	50771200
2887	MSFT	Microsoft Corporation	Technology	\N	2026-05-16	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2888	MSFT	Microsoft Corporation	Technology	\N	2026-05-17	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2889	MSFT	Microsoft Corporation	Technology	423.54	2026-05-18	3145015600708.85	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	416.6200	425.1200	415.6100	32564100
2890	MSFT	Microsoft Corporation	Technology	417.42	2026-05-19	3099571298561.47	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	429.9000	432.7000	416.4900	33018700
2891	MSFT	Microsoft Corporation	Technology	421.06	2026-05-20	3126600166311.69	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	414.1700	422.1000	411.3000	27864000
2892	MSFT	Microsoft Corporation	Technology	419.09	2026-05-21	3111971832630.03	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	424.7500	426.3400	415.7100	31393500
2893	MSFT	Microsoft Corporation	Technology	418.57	2026-05-22	3108110630554.19	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	419.5400	424.4000	416.3300	22390300
2894	MSFT	Microsoft Corporation	Technology	\N	2026-05-23	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2895	MSFT	Microsoft Corporation	Technology	\N	2026-05-24	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2896	MSFT	Microsoft Corporation	Technology	\N	2026-05-25	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2897	MSFT	Microsoft Corporation	Technology	416.03	2026-05-26	3089249681556.34	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	416.4300	419.7700	413.0200	30398000
2898	MSFT	Microsoft Corporation	Technology	412.67	2026-05-27	3064299957479.22	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	411.0100	415.9400	409.5800	28901500
2899	MSFT	Microsoft Corporation	Technology	426.99	2026-05-28	3170633596687.00	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	412.9800	429.4900	412.6700	47250500
2900	MSFT	Microsoft Corporation	Technology	450.24	2026-05-29	3343277529352.75	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	432.5500	450.3300	432.3600	79654400
2901	MSFT	Microsoft Corporation	Technology	\N	2026-05-30	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2902	MSFT	Microsoft Corporation	Technology	\N	2026-05-31	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2903	MSFT	Microsoft Corporation	Technology	460.52	2026-06-01	3419612127935.84	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	464.8400	466.3200	458.2700	53628900
2904	MSFT	Microsoft Corporation	Technology	441.31	2026-06-02	3276967462504.44	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	446.8800	453.5000	440.4300	37036800
2905	MSFT	Microsoft Corporation	Technology	427.34	2026-06-03	3173232582930.78	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	438.4500	440.3900	424.2500	39037000
2906	MSFT	Microsoft Corporation	Technology	428.05	2026-06-04	3178504656778.68	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	435.8100	436.1500	426.4100	26899500
2907	MSFT	Microsoft Corporation	Technology	416.67	2026-06-05	3094002139443.22	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	428.3400	429.4700	414.4000	34782200
2908	MSFT	Microsoft Corporation	Technology	\N	2026-06-06	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2909	MSFT	Microsoft Corporation	Technology	\N	2026-06-07	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2910	MSFT	Microsoft Corporation	Technology	411.74	2026-06-08	3057394027949.25	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	414.1400	417.1600	408.5600	32086700
2911	MSFT	Microsoft Corporation	Technology	403.41	2026-06-09	2995539333717.47	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	409.0300	411.9800	398.4800	35317300
2912	MSFT	Microsoft Corporation	Technology	397.36	2026-06-10	2950614647531.12	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	398.5500	405.0400	397.1600	32576000
2913	MSFT	Microsoft Corporation	Technology	390.34	2026-06-11	2898487399763.78	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	395.2100	396.8500	384.0000	47224100
2914	MSFT	Microsoft Corporation	Technology	390.74	2026-06-12	2901457572638.25	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	391.4300	391.7400	382.2700	34865800
2915	MSFT	Microsoft Corporation	Technology	\N	2026-06-13	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2916	MSFT	Microsoft Corporation	Technology	\N	2026-06-14	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2917	MSFT	Microsoft Corporation	Technology	399.76	2026-06-15	2968436137997.25	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	396.8000	401.7500	392.8500	32266400
2918	MSFT	Microsoft Corporation	Technology	393.83	2026-06-16	2924402481012.28	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	395.7900	396.8400	390.6900	31506800
2919	MSFT	Microsoft Corporation	Technology	378.91	2026-06-17	2813613469187.97	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	390.2500	390.3700	377.3200	41987800
2920	MSFT	Microsoft Corporation	Technology	379.40	2026-06-18	2817251913963.47	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	377.8200	381.3700	373.2800	59714200
2921	MSFT	Microsoft Corporation	Technology	\N	2026-06-19	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2922	MSFT	Microsoft Corporation	Technology	\N	2026-06-20	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2923	MSFT	Microsoft Corporation	Technology	\N	2026-06-21	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2924	MSFT	Microsoft Corporation	Technology	367.34	2026-06-22	2727699853470.78	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	375.7400	381.6300	367.0700	45171100
2925	MSFT	Microsoft Corporation	Technology	373.94	2026-06-23	2776708499033.31	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	372.3800	377.2200	370.6700	40647600
2926	MSFT	Microsoft Corporation	Technology	365.46	2026-06-24	2713739791690.15	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	371.5700	378.8800	364.7800	44509900
2927	MSFT	Microsoft Corporation	Technology	352.83	2026-06-25	2619955115881.28	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	362.7700	364.2300	349.2000	66179000
2928	MSFT	Microsoft Corporation	Technology	372.97	2026-06-26	2769505710842.66	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	357.1500	376.6100	355.4300	186201600
2929	MSFT	Microsoft Corporation	Technology	\N	2026-06-27	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2930	MSFT	Microsoft Corporation	Technology	\N	2026-06-28	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2931	MSFT	Microsoft Corporation	Technology	368.57	2026-06-29	2736833356004.19	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	377.5000	380.5000	359.9000	51229900
2932	MSFT	Microsoft Corporation	Technology	373.02	2026-06-30	2769876897473.34	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	371.0300	374.1500	367.4500	44945700
2933	MSFT	Microsoft Corporation	Technology	384.28	2026-07-01	2853488612217.09	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	380.8300	388.8300	374.8900	48065800
2934	MSFT	Microsoft Corporation	Technology	390.49	2026-07-02	2899601186265.50	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	384.4800	392.2000	383.7000	42128900
2935	MSFT	Microsoft Corporation	Technology	\N	2026-07-03	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2936	MSFT	Microsoft Corporation	Technology	\N	2026-07-04	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2937	MSFT	Microsoft Corporation	Technology	\N	2026-07-05	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2938	MSFT	Microsoft Corporation	Technology	386.74	2026-07-06	2871755390674.25	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	387.0400	389.1500	381.2200	34224500
2939	MSFT	Microsoft Corporation	Technology	388.84	2026-07-07	2887349081527.28	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	392.4900	395.5700	388.2200	29297500
2940	MSFT	Microsoft Corporation	Technology	383.34	2026-07-08	2846508581326.78	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	384.0300	385.3100	381.3300	25908300
2941	MSFT	Microsoft Corporation	Technology	384.36	2026-07-09	2854082556148.12	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	374.4500	384.6500	373.3500	31083200
2942	MSFT	Microsoft Corporation	Technology	385.10	2026-07-10	2859577613906.03	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	387.8000	391.9100	381.5000	24644600
2943	MSFT	Microsoft Corporation	Technology	\N	2026-07-11	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2944	MSFT	Microsoft Corporation	Technology	\N	2026-07-12	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2945	MSFT	Microsoft Corporation	Technology	390.99	2026-07-13	2903313959011.00	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	387.7500	393.6500	384.1500	28914900
2946	MSFT	Microsoft Corporation	Technology	384.93	2026-07-14	2858315171464.31	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	382.8200	388.1900	378.6500	27863900
2947	MSFT	Microsoft Corporation	Technology	395.63	2026-07-15	2937768598861.88	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	387.8000	398.9600	386.4000	36253700
2948	MSFT	Microsoft Corporation	Technology	401.10	2026-07-16	2978386341762.03	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	398.3100	405.9900	392.0500	37047400
2949	MSFT	Microsoft Corporation	Technology	393.82	2026-07-17	2924328379651.94	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	394.8600	398.3900	389.3900	33049800
2950	MSFT	Microsoft Corporation	Technology	\N	2026-07-18	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2951	MSFT	Microsoft Corporation	Technology	\N	2026-07-19	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2952	MSFT	Microsoft Corporation	Technology	402.29	2026-07-20	2987222759025.10	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	391.4100	403.1800	389.6500	27915800
2953	MSFT	Microsoft Corporation	Technology	397.75	2026-07-21	2953510719045.25	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	398.8100	401.4700	396.3200	24126600
2954	MSFT	Microsoft Corporation	Technology	390.34	2026-07-22	2898487399763.78	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	399.5800	401.0000	386.9600	28142500
2955	MSFT	Microsoft Corporation	Technology	381.58	2026-07-23	2833439548747.53	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	389.9700	391.7800	377.3900	30351800
2956	MSFT	Microsoft Corporation	Technology	381.70	2026-07-24	2834330804558.57	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	387.0500	389.0300	380.6500	27659400
2957	MSFT	Microsoft Corporation	Technology	\N	2026-07-25	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2958	MSFT	Microsoft Corporation	Technology	\N	2026-07-26	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2959	MSFT	Microsoft Corporation	Technology	389.10	2026-07-27	2889279795870.03	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	390.0800	394.2000	387.9900	27856200
2960	MSFT	Microsoft Corporation	Technology	393.35	2026-07-28	2920838364206.78	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	393.1600	400.3200	391.3000	32367500
2961	MSFT	Microsoft Corporation	Technology	390.54	2026-07-29	2899972599505.85	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	393.4000	401.2500	388.7400	47209000
2962	MSFT	Microsoft Corporation	Technology	451.10	2026-07-30	3349663616312.03	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	437.9000	458.6900	432.4400	110160700
2963	MSFT	Microsoft Corporation	Technology	464.72	2026-07-31	3450799509641.91	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	450.0000	466.8400	449.3300	60846000
2964	MSFT	Microsoft Corporation	Technology	\N	2026-08-01	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2965	MSFT	Microsoft Corporation	Technology	\N	2026-08-02	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2966	MSFT	Microsoft Corporation	Technology	487.65	2026-08-03	3621067213364.22	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	476.1300	491.6500	475.0000	66762100
2967	MSFT	Microsoft Corporation	Technology	492.81	2026-08-04	3659383055290.94	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	480.9000	499.4400	479.1700	50455500
2968	MSFT	Microsoft Corporation	Technology	487.46	2026-08-05	3619656341592.15	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	496.3600	498.2400	485.6800	33388900
2969	MSFT	Microsoft Corporation	Technology	499.86	2026-08-06	3711733060358.62	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	488.5500	501.5600	488.5200	36441500
2970	MSFT	Microsoft Corporation	Technology	499.99	2026-08-07	3712698417530.00	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	499.2100	505.1800	498.7300	28846200
2971	MSFT	Microsoft Corporation	Technology	\N	2026-08-08	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2972	MSFT	Microsoft Corporation	Technology	\N	2026-08-09	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2973	MSFT	Microsoft Corporation	Technology	506.06	2026-08-10	3757771533046.69	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	503.4400	513.7300	502.2700	31206100
2974	MSFT	Microsoft Corporation	Technology	503.81	2026-08-11	3741064055691.94	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	504.3300	505.3300	499.5500	23049800
2975	MSFT	Microsoft Corporation	Technology	492.43	2026-08-12	3656561311746.81	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	499.9900	501.5000	491.5200	29001500
2976	MSFT	Microsoft Corporation	Technology	496.88	2026-08-13	3689605079825.63	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	493.2700	501.3400	493.0100	23039000
2977	MSFT	Microsoft Corporation	Technology	495.40	2026-08-14	3678615190919.47	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	496.3600	500.0100	493.9200	16217600
2978	MSFT	Microsoft Corporation	Technology	\N	2026-08-15	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2979	MSFT	Microsoft Corporation	Technology	\N	2026-08-16	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2980	MSFT	Microsoft Corporation	Technology	480.35	2026-08-17	3566860821923.78	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	490.1400	492.6600	478.4100	29635800
2981	MSFT	Microsoft Corporation	Technology	481.63	2026-08-18	3576365511087.88	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	481.5400	484.2700	477.1500	24087600
2982	MSFT	Microsoft Corporation	Technology	484.31	2026-08-19	3596265918617.44	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	480.0700	489.3000	479.3600	19961900
2983	MSFT	Microsoft Corporation	Technology	481.15	2026-08-20	3572801167672.72	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	483.3000	484.1600	479.5000	20020800
2984	MSFT	Microsoft Corporation	Technology	483.24	2026-08-21	3588320530555.75	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	479.8800	486.3600	478.5300	22510800
2985	MSFT	Microsoft Corporation	Technology	\N	2026-08-22	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2986	MSFT	Microsoft Corporation	Technology	\N	2026-08-23	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2987	MSFT	Microsoft Corporation	Technology	487.31	2026-08-24	3618542555090.44	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	483.2100	490.6100	481.8600	17230800
2988	MSFT	Microsoft Corporation	Technology	491.71	2026-08-25	3651214909928.90	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	485.4400	492.4400	484.3000	19519000
2989	MSFT	Microsoft Corporation	Technology	496.37	2026-08-26	3685817979110.12	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	487.8500	497.4000	487.3100	20758900
2990	MSFT	Microsoft Corporation	Technology	505.06	2026-08-27	3750345987555.69	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	494.8800	506.4800	490.0800	28688800
2991	MSFT	Microsoft Corporation	Technology	513.53	2026-08-28	3813240593538.51	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	505.3300	517.7800	504.8700	29207300
2992	MSFT	Microsoft Corporation	Technology	\N	2026-08-29	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2993	MSFT	Microsoft Corporation	Technology	\N	2026-08-30	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
2994	MSFT	Microsoft Corporation	Technology	507.29	2026-08-31	3766905035580.10	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	510.3800	512.1900	506.3900	27208900
2995	MSFT	Microsoft Corporation	Technology	501.02	2026-09-01	3720346720321.34	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	497.5200	505.9700	496.7800	21046900
2996	MSFT	Microsoft Corporation	Technology	496.82	2026-09-02	3689159565224.94	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	499.8500	500.2700	493.8100	15336100
2997	MSFT	Microsoft Corporation	Technology	510.12	2026-09-03	3787919229611.37	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	501.6600	515.6500	500.8000	24125900
2998	MSFT	Microsoft Corporation	Technology	499.70	2026-09-04	3710545172496.57	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	510.0000	511.0000	499.3600	18101800
2999	MSFT	Microsoft Corporation	Technology	\N	2026-09-05	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
3000	MSFT	Microsoft Corporation	Technology	\N	2026-09-06	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
3001	MSFT	Microsoft Corporation	Technology	\N	2026-09-07	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
3002	MSFT	Microsoft Corporation	Technology	493.95	2026-09-08	3667848285923.32	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	493.0100	495.1900	490.1500	18882300
3003	MSFT	Microsoft Corporation	Technology	491.65	2026-09-09	3650769395328.22	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	493.0700	494.3900	489.8000	12889600
3004	MSFT	Microsoft Corporation	Technology	492.44	2026-09-10	3656635639716.81	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	488.3200	494.5200	486.0000	16038800
3005	MSFT	Microsoft Corporation	Technology	495.63	2026-09-11	3680323147961.88	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	495.6500	498.9700	492.5800	14510500
3006	MSFT	Microsoft Corporation	Technology	\N	2026-09-12	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
3007	MSFT	Microsoft Corporation	Technology	\N	2026-09-13	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
3008	MSFT	Microsoft Corporation	Technology	505.41	2026-09-14	3752944973799.47	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	497.0600	509.9500	495.3400	23091900
3009	MSFT	Microsoft Corporation	Technology	497.12	2026-09-15	3691387138228.37	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	500.0600	505.9000	495.5400	17794600
3010	MSFT	Microsoft Corporation	Technology	490.30	2026-09-16	3640744863593.43	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	493.0300	495.9700	487.2300	16670300
3011	MSFT	Microsoft Corporation	Technology	497.75	2026-09-17	3696065268145.25	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	497.8000	501.4700	493.1700	17841600
3012	MSFT	Microsoft Corporation	Technology	493.78	2026-09-18	3666585843481.59	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	497.9700	498.6500	491.1000	39622300
3013	MSFT	Microsoft Corporation	Technology	\N	2026-09-19	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
3014	MSFT	Microsoft Corporation	Technology	\N	2026-09-20	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
3015	MSFT	Microsoft Corporation	Technology	501.61	2026-09-21	3724727764967.87	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	494.9500	501.8700	491.3300	27959900
3016	MSFT	Microsoft Corporation	Technology	498.00	2026-09-22	3697921654518.00	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	507.3200	508.5000	493.6500	21652800
3017	MSFT	Microsoft Corporation	Technology	500.59	2026-09-23	3717153790146.53	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	500.7600	509.4400	495.8800	19445600
3018	MSFT	Microsoft Corporation	Technology	497.93	2026-09-24	3697401811947.31	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	495.0700	498.9000	491.2200	16657600
3019	MSFT	Microsoft Corporation	Technology	516.17	2026-09-25	3832843689188.06	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	499.0400	519.4000	497.2500	38193100
3020	MSFT	Microsoft Corporation	Technology	\N	2026-09-26	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
3021	MSFT	Microsoft Corporation	Technology	\N	2026-09-27	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
3022	MSFT	Microsoft Corporation	Technology	509.22	2026-09-28	3781236283991.41	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	505.4700	513.3300	502.2200	19626900
3023	MSFT	Microsoft Corporation	Technology	508.96	2026-09-29	3779305569648.65	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	508.3100	513.6400	502.4000	21341800
3024	MSFT	Microsoft Corporation	Technology	512.90	2026-09-30	3808562463621.63	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	511.6100	519.8300	510.3100	27223300
3025	MSFT	Microsoft Corporation	Technology	512.80	2026-10-01	3807819637140.93	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	519.8800	522.8500	512.1700	19731900
3026	MSFT	Microsoft Corporation	Technology	517.53	2026-10-02	3842942775502.51	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	519.3900	522.5000	513.6600	17822300
3027	MSFT	Microsoft Corporation	Technology	\N	2026-10-03	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
3028	MSFT	Microsoft Corporation	Technology	\N	2026-10-04	\N	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	\N	\N	\N	\N
3029	MSFT	Microsoft Corporation	Technology	525.18	2026-10-05	3899747926577.06	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	521.6200	532.3500	521.4700	26604800
3030	MSFT	Microsoft Corporation	Technology	529.30	2026-10-06	3930341137742.43	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	531.6800	535.6900	528.7800	21107500
3031	MSFT	Microsoft Corporation	Technology	529.76	2026-10-07	3933757051827.25	2026-10-08 20:55:08.923	2026-10-08 20:55:08.923	530.7300	531.7300	524.6900	16773600
3033	NVDA	NVIDIA Corporation	Technology	\N	2026-01-01	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3034	NVDA	NVIDIA Corporation	Technology	188.85	2026-01-02	4560161097381.59	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	189.8400	192.9300	188.2600	148240500
3035	NVDA	NVIDIA Corporation	Technology	\N	2026-01-03	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3036	NVDA	NVIDIA Corporation	Technology	\N	2026-01-04	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3037	NVDA	NVIDIA Corporation	Technology	188.12	2026-01-05	4542533522094.73	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	191.7600	193.6300	186.1500	183529700
3038	NVDA	NVIDIA Corporation	Technology	187.24	2026-01-06	4521284412643.43	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	190.5200	192.1700	186.8200	176862600
3039	NVDA	NVIDIA Corporation	Technology	189.11	2026-01-07	4566439184738.16	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	188.5700	191.3700	186.5600	153543200
3040	NVDA	NVIDIA Corporation	Technology	185.04	2026-01-08	4468160717880.25	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	189.1100	189.5500	183.7100	172457000
3041	NVDA	NVIDIA Corporation	Technology	184.86	2026-01-09	4463814434738.16	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	185.0800	186.3400	183.6700	131327500
3042	NVDA	NVIDIA Corporation	Technology	\N	2026-01-10	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3043	NVDA	NVIDIA Corporation	Technology	\N	2026-01-11	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3044	NVDA	NVIDIA Corporation	Technology	184.94	2026-01-12	4465746238952.64	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	183.2200	187.1200	183.0200	137968500
3045	NVDA	NVIDIA Corporation	Technology	185.81	2026-01-13	4486754011047.36	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	185.0000	188.1100	183.4000	160128900
3046	NVDA	NVIDIA Corporation	Technology	183.14	2026-01-14	4422281565261.84	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	184.3200	184.4600	180.8000	159586100
3047	NVDA	NVIDIA Corporation	Technology	187.05	2026-01-15	4516696423690.80	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	186.5000	189.7000	186.3300	206188600
3048	NVDA	NVIDIA Corporation	Technology	186.23	2026-01-16	4496895706832.89	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	189.0800	190.4400	186.0800	187967200
3049	NVDA	NVIDIA Corporation	Technology	\N	2026-01-17	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3050	NVDA	NVIDIA Corporation	Technology	\N	2026-01-18	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3051	NVDA	NVIDIA Corporation	Technology	\N	2026-01-19	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3052	NVDA	NVIDIA Corporation	Technology	178.07	2026-01-20	4299856466857.91	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	181.9000	182.3800	177.6100	223345300
3053	NVDA	NVIDIA Corporation	Technology	183.32	2026-01-21	4426628216857.91	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	179.0500	185.3800	178.4000	200381000
3054	NVDA	NVIDIA Corporation	Technology	184.84	2026-01-22	4463331391571.05	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	184.7500	186.1700	183.9300	139636600
3055	NVDA	NVIDIA Corporation	Technology	187.67	2026-01-23	4531667445785.52	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	187.5000	189.6000	186.8200	142748100
3056	NVDA	NVIDIA Corporation	Technology	\N	2026-01-24	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3057	NVDA	NVIDIA Corporation	Technology	\N	2026-01-25	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3058	NVDA	NVIDIA Corporation	Technology	186.47	2026-01-26	4502691119476.32	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	187.1600	189.1200	185.9900	124799600
3059	NVDA	NVIDIA Corporation	Technology	188.52	2026-01-27	4552192543167.11	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	187.2400	190.0000	185.7000	143711600
3060	NVDA	NVIDIA Corporation	Technology	191.52	2026-01-28	4624633543167.11	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	191.2700	192.3500	189.8400	148552700
3061	NVDA	NVIDIA Corporation	Technology	192.51	2026-01-29	4648538837356.57	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	191.3400	193.4800	186.0600	171764400
3062	NVDA	NVIDIA Corporation	Technology	191.13	2026-01-30	4615216227905.27	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	191.2100	194.4900	189.4700	179489500
3063	NVDA	NVIDIA Corporation	Technology	\N	2026-01-31	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3064	NVDA	NVIDIA Corporation	Technology	\N	2026-02-01	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3065	NVDA	NVIDIA Corporation	Technology	185.61	2026-02-02	4481924684738.16	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	187.2000	190.3000	184.8800	165794100
3066	NVDA	NVIDIA Corporation	Technology	180.34	2026-02-03	4354669891571.05	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	186.2400	186.2700	176.2300	204019600
3067	NVDA	NVIDIA Corporation	Technology	174.19	2026-02-04	4206165988952.64	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	179.4600	179.5800	171.9100	207014100
3068	NVDA	NVIDIA Corporation	Technology	171.88	2026-02-05	4150386477905.27	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	174.9300	176.8200	171.0300	206312900
3069	NVDA	NVIDIA Corporation	Technology	185.41	2026-02-06	4477095358428.96	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	176.6900	187.0000	174.6000	231346200
3070	NVDA	NVIDIA Corporation	Technology	\N	2026-02-07	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3071	NVDA	NVIDIA Corporation	Technology	\N	2026-02-08	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3072	NVDA	NVIDIA Corporation	Technology	190.04	2026-02-09	4588895717880.25	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	184.2600	193.6600	183.9500	196387400
3073	NVDA	NVIDIA Corporation	Technology	188.54	2026-02-10	4552675217880.25	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	191.3800	192.4800	188.1200	136764800
3074	NVDA	NVIDIA Corporation	Technology	190.05	2026-02-11	4589137423690.80	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	192.4500	193.2600	188.7700	144192700
3075	NVDA	NVIDIA Corporation	Technology	186.94	2026-02-12	4514040238952.64	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	193.0300	193.6100	186.5100	189932500
3076	NVDA	NVIDIA Corporation	Technology	182.81	2026-02-13	4414313011047.36	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	187.4800	187.5000	181.5900	161888000
3077	NVDA	NVIDIA Corporation	Technology	\N	2026-02-14	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3078	NVDA	NVIDIA Corporation	Technology	\N	2026-02-15	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3079	NVDA	NVIDIA Corporation	Technology	\N	2026-02-16	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3080	NVDA	NVIDIA Corporation	Technology	184.97	2026-02-17	4466470619476.32	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	181.7500	187.1500	179.1800	162276900
3081	NVDA	NVIDIA Corporation	Technology	187.98	2026-02-18	4539152956832.89	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	188.7500	190.3700	186.7600	164749100
3082	NVDA	NVIDIA Corporation	Technology	187.90	2026-02-19	4537221152618.41	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	187.0600	188.4300	185.6600	126554500
3083	NVDA	NVIDIA Corporation	Technology	189.82	2026-02-20	4583583716857.91	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	186.5700	190.3300	185.9400	178422300
3084	NVDA	NVIDIA Corporation	Technology	\N	2026-02-21	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3085	NVDA	NVIDIA Corporation	Technology	\N	2026-02-22	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3086	NVDA	NVIDIA Corporation	Technology	191.55	2026-02-23	4625357923690.80	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	191.4000	193.9500	189.5800	171584800
3087	NVDA	NVIDIA Corporation	Technology	192.85	2026-02-24	4656749097381.59	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	191.4900	193.7700	187.4000	175123600
3088	NVDA	NVIDIA Corporation	Technology	195.56	2026-02-25	4722187261047.36	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	194.4500	197.6300	193.7900	250637100
3089	NVDA	NVIDIA Corporation	Technology	184.89	2026-02-26	4464538815261.84	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	194.2700	194.2900	184.3200	360807900
3090	NVDA	NVIDIA Corporation	Technology	177.19	2026-02-27	4278606988952.64	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	181.2500	182.5900	176.3800	311636500
3091	NVDA	NVIDIA Corporation	Technology	\N	2026-02-28	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3092	NVDA	NVIDIA Corporation	Technology	\N	2026-03-01	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3093	NVDA	NVIDIA Corporation	Technology	182.48	2026-03-02	4406344456832.89	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	175.0100	183.4600	174.6400	209095300
3094	NVDA	NVIDIA Corporation	Technology	180.05	2026-03-03	4347667423690.80	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	178.4900	180.9000	176.9200	178099400
3095	NVDA	NVIDIA Corporation	Technology	183.04	2026-03-04	4419866717880.25	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	180.4400	184.7000	180.0600	177731200
3096	NVDA	NVIDIA Corporation	Technology	183.34	2026-03-05	4427110891571.05	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	181.1700	184.0600	177.8800	198779700
3097	NVDA	NVIDIA Corporation	Technology	177.82	2026-03-06	4293819716857.91	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	179.8400	182.7600	176.8200	189021900
3098	NVDA	NVIDIA Corporation	Technology	\N	2026-03-07	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3099	NVDA	NVIDIA Corporation	Technology	\N	2026-03-08	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3100	NVDA	NVIDIA Corporation	Technology	182.65	2026-03-09	4410449402618.41	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	176.8300	182.9100	175.5600	177213600
3101	NVDA	NVIDIA Corporation	Technology	184.77	2026-03-10	4461641293167.11	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	182.4000	186.4400	182.0100	179118500
3102	NVDA	NVIDIA Corporation	Technology	186.03	2026-03-11	4492066380523.68	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	185.9100	187.6200	184.4500	145280400
3103	NVDA	NVIDIA Corporation	Technology	183.14	2026-03-12	4422281565261.84	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	184.0500	184.9400	181.7500	155762700
3104	NVDA	NVIDIA Corporation	Technology	180.25	2026-03-13	4352496750000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	184.9200	186.0900	179.9400	160988400
3105	NVDA	NVIDIA Corporation	Technology	\N	2026-03-14	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3106	NVDA	NVIDIA Corporation	Technology	\N	2026-03-15	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3107	NVDA	NVIDIA Corporation	Technology	183.22	2026-03-16	4424213369476.32	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	182.9700	188.8800	181.4100	217307400
3108	NVDA	NVIDIA Corporation	Technology	181.93	2026-03-17	4393063533142.09	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	185.0600	185.4000	181.6800	182497800
3109	NVDA	NVIDIA Corporation	Technology	180.40	2026-03-18	4356118652618.41	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	182.4800	183.3800	180.3300	156683100
3110	NVDA	NVIDIA Corporation	Technology	178.56	2026-03-19	4311688261047.36	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	178.0100	179.9800	175.7900	170968500
3111	NVDA	NVIDIA Corporation	Technology	172.70	2026-03-20	4170186826309.20	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	178.0000	178.2600	171.7200	241323500
3112	NVDA	NVIDIA Corporation	Technology	\N	2026-03-21	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3113	NVDA	NVIDIA Corporation	Technology	\N	2026-03-22	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3114	NVDA	NVIDIA Corporation	Technology	175.64	2026-03-23	4241179065261.84	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	177.2600	178.3700	174.7600	182836300
3115	NVDA	NVIDIA Corporation	Technology	175.20	2026-03-24	4230554326309.20	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	174.8300	176.2200	173.9800	147667800
3116	NVDA	NVIDIA Corporation	Technology	178.68	2026-03-25	4314585783142.09	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	177.1000	181.2200	176.8500	162602100
3117	NVDA	NVIDIA Corporation	Technology	171.24	2026-03-26	4134932412643.43	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	176.0700	176.5100	171.1400	186152200
3118	NVDA	NVIDIA Corporation	Technology	167.52	2026-03-27	4045105543167.11	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	170.0000	170.9700	167.0100	196212700
3119	NVDA	NVIDIA Corporation	Technology	\N	2026-03-28	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3120	NVDA	NVIDIA Corporation	Technology	\N	2026-03-29	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3121	NVDA	NVIDIA Corporation	Technology	165.17	2026-03-30	3988359945785.52	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	168.7800	169.4500	164.2700	185627000
3122	NVDA	NVIDIA Corporation	Technology	174.40	2026-03-31	4211236652618.41	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	166.9700	174.6200	166.9600	226181300
3123	NVDA	NVIDIA Corporation	Technology	175.75	2026-04-01	4243835250000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	176.0000	177.3700	174.7500	168132000
3124	NVDA	NVIDIA Corporation	Technology	177.39	2026-04-02	4283436315261.84	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	172.1800	177.4900	171.3700	143143200
3125	NVDA	NVIDIA Corporation	Technology	\N	2026-04-03	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3126	NVDA	NVIDIA Corporation	Technology	\N	2026-04-04	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3127	NVDA	NVIDIA Corporation	Technology	\N	2026-04-05	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3128	NVDA	NVIDIA Corporation	Technology	177.64	2026-04-06	4289473065261.84	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	177.1600	177.7900	175.7600	107564300
3129	NVDA	NVIDIA Corporation	Technology	178.10	2026-04-07	4300580847381.59	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	175.7300	178.2300	173.6600	132534900
3130	NVDA	NVIDIA Corporation	Technology	182.08	2026-04-08	4396685804214.48	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	184.5000	185.2600	180.3000	147732700
3131	NVDA	NVIDIA Corporation	Technology	183.91	2026-04-09	4440874858428.96	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	181.8400	184.0800	180.6200	116428500
3132	NVDA	NVIDIA Corporation	Technology	188.63	2026-04-10	4554848727905.27	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	184.3100	190.0000	184.3000	160459500
3133	NVDA	NVIDIA Corporation	Technology	\N	2026-04-11	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3134	NVDA	NVIDIA Corporation	Technology	\N	2026-04-12	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3135	NVDA	NVIDIA Corporation	Technology	189.31	2026-04-13	4571268511047.36	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	186.0300	189.6600	185.7400	133648200
3136	NVDA	NVIDIA Corporation	Technology	196.51	2026-04-14	4745126837356.57	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	190.8400	196.5100	190.7700	161307000
3137	NVDA	NVIDIA Corporation	Technology	198.87	2026-04-15	4802113772094.73	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	196.5400	200.4000	195.7400	185338400
3138	NVDA	NVIDIA Corporation	Technology	198.35	2026-04-16	4789557597381.59	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	197.4300	199.8500	195.8100	134012900
3139	NVDA	NVIDIA Corporation	Technology	201.68	2026-04-17	4869966783142.09	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	199.9000	201.7000	199.2700	160324400
3140	NVDA	NVIDIA Corporation	Technology	\N	2026-04-18	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3141	NVDA	NVIDIA Corporation	Technology	\N	2026-04-19	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3142	NVDA	NVIDIA Corporation	Technology	202.06	2026-04-20	4879142761047.36	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	199.9800	202.1700	197.8400	119381400
3143	NVDA	NVIDIA Corporation	Technology	199.88	2026-04-21	4826502477905.27	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	202.1300	202.7500	199.0000	107945300
3144	NVDA	NVIDIA Corporation	Technology	202.50	2026-04-22	4889767500000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	200.9900	202.5000	199.0000	107501000
3145	NVDA	NVIDIA Corporation	Technology	199.64	2026-04-23	4820707065261.84	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	202.4600	203.8300	197.2200	113561800
3146	NVDA	NVIDIA Corporation	Technology	208.27	2026-04-24	5029095793167.11	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	199.9600	210.9500	199.8100	214134400
3147	NVDA	NVIDIA Corporation	Technology	\N	2026-04-25	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3148	NVDA	NVIDIA Corporation	Technology	\N	2026-04-26	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3149	NVDA	NVIDIA Corporation	Technology	216.61	2026-04-27	5230481684738.16	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	209.6500	216.8300	207.3800	187172400
3150	NVDA	NVIDIA Corporation	Technology	213.17	2026-04-28	5147415945785.52	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	209.4900	214.7300	208.2000	180275400
3151	NVDA	NVIDIA Corporation	Technology	209.25	2026-04-29	5052759750000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	212.7000	212.7200	207.5800	123711800
3152	NVDA	NVIDIA Corporation	Technology	199.57	2026-04-30	4819016966857.91	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	209.9300	210.3000	198.7000	225239200
3153	NVDA	NVIDIA Corporation	Technology	198.45	2026-05-01	4791972076309.20	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	201.2800	203.0000	197.1200	128647000
3154	NVDA	NVIDIA Corporation	Technology	\N	2026-05-02	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3155	NVDA	NVIDIA Corporation	Technology	\N	2026-05-03	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3156	NVDA	NVIDIA Corporation	Technology	198.48	2026-05-04	4792696456832.89	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	199.5000	201.7300	194.7400	125368100
3157	NVDA	NVIDIA Corporation	Technology	196.50	2026-05-05	4744885500000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	199.3000	200.2400	196.0300	113406600
3158	NVDA	NVIDIA Corporation	Technology	207.83	2026-05-06	5018471054214.48	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	199.8900	208.2700	198.6100	188362800
3159	NVDA	NVIDIA Corporation	Technology	211.50	2026-05-07	5107090500000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	208.3400	214.2000	206.5000	168307900
3160	NVDA	NVIDIA Corporation	Technology	215.20	2026-05-08	5196434326309.20	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	213.0300	217.8000	212.8900	136421400
3161	NVDA	NVIDIA Corporation	Technology	\N	2026-05-09	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3162	NVDA	NVIDIA Corporation	Technology	\N	2026-05-10	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3163	NVDA	NVIDIA Corporation	Technology	219.44	2026-05-11	5298817738952.64	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	214.0400	222.3000	213.8900	160685800
3164	NVDA	NVIDIA Corporation	Technology	220.78	2026-05-12	5331174630523.68	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	218.5500	223.7500	214.9200	159176600
3165	NVDA	NVIDIA Corporation	Technology	225.83	2026-05-13	5453117054214.48	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	224.9300	227.8400	221.5700	150405400
3166	NVDA	NVIDIA Corporation	Technology	235.74	2026-05-14	5692413912643.43	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	229.8500	236.5400	229.3000	180782900
3167	NVDA	NVIDIA Corporation	Technology	225.32	2026-05-15	5440802216857.91	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	229.7600	231.5000	224.2400	180977600
3168	NVDA	NVIDIA Corporation	Technology	\N	2026-05-16	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3169	NVDA	NVIDIA Corporation	Technology	\N	2026-05-17	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3170	NVDA	NVIDIA Corporation	Technology	222.32	2026-05-18	5368361216857.91	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	229.8700	230.0000	218.3700	146280900
3171	NVDA	NVIDIA Corporation	Technology	220.61	2026-05-19	5327069684738.16	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	219.6200	224.4800	217.9100	140948200
3172	NVDA	NVIDIA Corporation	Technology	223.47	2026-05-20	5396130119476.32	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	223.1800	226.1300	220.5000	184201600
3173	NVDA	NVIDIA Corporation	Technology	219.51	2026-05-21	5300507837356.57	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	222.2900	227.4000	217.9300	203381800
3174	NVDA	NVIDIA Corporation	Technology	215.33	2026-05-22	5199573554214.48	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	220.9000	221.0100	214.8000	169275700
3175	NVDA	NVIDIA Corporation	Technology	\N	2026-05-23	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3176	NVDA	NVIDIA Corporation	Technology	\N	2026-05-24	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3177	NVDA	NVIDIA Corporation	Technology	\N	2026-05-25	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3178	NVDA	NVIDIA Corporation	Technology	214.86	2026-05-26	5188224434738.16	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	216.5400	218.1800	212.0000	187202600
3179	NVDA	NVIDIA Corporation	Technology	212.60	2026-05-27	5133652347381.59	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	214.1200	214.1500	208.7800	167601200
3180	NVDA	NVIDIA Corporation	Technology	214.25	2026-05-28	5173494750000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	211.2800	215.5200	211.2200	143996000
3807	JNJ	Johnson & Johnson	Healthcare	\N	2026-08-01	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3181	NVDA	NVIDIA Corporation	Technology	211.14	2026-05-29	5098397565261.84	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	214.5800	217.8600	211.1300	289410600
3182	NVDA	NVIDIA Corporation	Technology	\N	2026-05-30	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3183	NVDA	NVIDIA Corporation	Technology	\N	2026-05-31	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3184	NVDA	NVIDIA Corporation	Technology	224.36	2026-06-01	5417620934738.16	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	215.7300	224.8700	215.7000	212850700
3185	NVDA	NVIDIA Corporation	Technology	222.82	2026-06-02	5380434716857.91	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	227.1800	232.2800	221.3500	193362900
3186	NVDA	NVIDIA Corporation	Technology	214.75	2026-06-03	5185568250000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	221.7200	222.8200	214.5100	160907000
3187	NVDA	NVIDIA Corporation	Technology	218.66	2026-06-04	5279983108428.96	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	213.9100	221.6000	210.9700	169022200
3188	NVDA	NVIDIA Corporation	Technology	205.10	2026-06-05	4952549847381.59	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	214.5300	214.8700	204.3300	219655500
3189	NVDA	NVIDIA Corporation	Technology	\N	2026-06-06	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3190	NVDA	NVIDIA Corporation	Technology	\N	2026-06-07	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3191	NVDA	NVIDIA Corporation	Technology	208.64	2026-06-08	5038030065261.84	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	210.1800	210.4700	206.0000	138372800
3192	NVDA	NVIDIA Corporation	Technology	208.19	2026-06-09	5027163988952.64	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	210.6200	211.4000	199.3400	180962500
3193	NVDA	NVIDIA Corporation	Technology	200.42	2026-06-10	4839541695785.52	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	204.4300	207.2200	199.9200	161746600
3194	NVDA	NVIDIA Corporation	Technology	204.87	2026-06-11	4946995772094.73	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	201.4900	205.6600	199.5400	158643200
3195	NVDA	NVIDIA Corporation	Technology	205.19	2026-06-12	4954722988952.64	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	204.8600	207.0700	203.4400	112001800
3196	NVDA	NVIDIA Corporation	Technology	\N	2026-06-13	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3197	NVDA	NVIDIA Corporation	Technology	\N	2026-06-14	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3198	NVDA	NVIDIA Corporation	Technology	212.45	2026-06-15	5130030076309.20	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	208.9200	212.7100	208.3400	149936700
3199	NVDA	NVIDIA Corporation	Technology	207.41	2026-06-16	5008329358428.96	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	211.1800	211.4900	207.2900	125694100
3200	NVDA	NVIDIA Corporation	Technology	204.65	2026-06-17	4941683402618.41	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	208.5300	209.2100	203.0800	128363500
3201	NVDA	NVIDIA Corporation	Technology	210.69	2026-06-18	5087531488952.64	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	207.3300	211.3900	206.5000	241272000
3202	NVDA	NVIDIA Corporation	Technology	\N	2026-06-19	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3203	NVDA	NVIDIA Corporation	Technology	\N	2026-06-20	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3204	NVDA	NVIDIA Corporation	Technology	\N	2026-06-21	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3205	NVDA	NVIDIA Corporation	Technology	208.65	2026-06-22	5038271402618.41	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	211.4400	213.9900	207.7200	122041400
3206	NVDA	NVIDIA Corporation	Technology	200.04	2026-06-23	4830365717880.25	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	202.1700	203.7700	200.0000	153496200
3207	NVDA	NVIDIA Corporation	Technology	199.00	2026-06-24	4805253000000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	200.1200	201.6700	196.5800	151810700
3208	NVDA	NVIDIA Corporation	Technology	195.74	2026-06-25	4726533912643.43	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	200.0800	200.8000	192.1300	149550000
3209	NVDA	NVIDIA Corporation	Technology	192.53	2026-06-26	4649021880523.68	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	193.1200	195.5500	191.2200	179304100
3210	NVDA	NVIDIA Corporation	Technology	\N	2026-06-27	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3211	NVDA	NVIDIA Corporation	Technology	\N	2026-06-28	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3212	NVDA	NVIDIA Corporation	Technology	194.97	2026-06-29	4707940619476.32	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	193.8500	196.1800	189.8000	148835700
3213	NVDA	NVIDIA Corporation	Technology	200.09	2026-06-30	4831573141571.05	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	197.2400	200.6300	195.1100	166476700
3214	NVDA	NVIDIA Corporation	Technology	197.58	2026-07-01	4770964304214.48	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	196.2000	199.8500	193.4500	146147600
3215	NVDA	NVIDIA Corporation	Technology	194.83	2026-07-02	4704560054214.48	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	197.1400	200.0600	192.3500	142068700
3216	NVDA	NVIDIA Corporation	Technology	\N	2026-07-03	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3217	NVDA	NVIDIA Corporation	Technology	\N	2026-07-04	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3218	NVDA	NVIDIA Corporation	Technology	\N	2026-07-05	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3219	NVDA	NVIDIA Corporation	Technology	195.55	2026-07-06	4721945923690.80	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	194.4200	197.5500	193.9900	108999000
3220	NVDA	NVIDIA Corporation	Technology	196.93	2026-07-07	4755268533142.09	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	192.3700	198.4100	191.1400	124154600
3221	NVDA	NVIDIA Corporation	Technology	204.12	2026-07-08	4928885522094.73	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	195.1800	205.1600	195.0600	147419100
3222	NVDA	NVIDIA Corporation	Technology	202.78	2026-07-09	4896528630523.68	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	204.4600	204.5900	198.9600	132037400
3223	NVDA	NVIDIA Corporation	Technology	210.96	2026-07-10	5094051282119.75	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	202.0000	211.0000	201.9200	148421000
3224	NVDA	NVIDIA Corporation	Technology	\N	2026-07-11	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3225	NVDA	NVIDIA Corporation	Technology	\N	2026-07-12	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3226	NVDA	NVIDIA Corporation	Technology	203.53	2026-07-13	4914638880523.68	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	208.5400	210.5700	203.0000	121411000
3227	NVDA	NVIDIA Corporation	Technology	211.80	2026-07-14	5114334673690.80	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	208.2000	212.5500	203.8000	124379600
3228	NVDA	NVIDIA Corporation	Technology	212.50	2026-07-15	5131237500000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	211.9600	213.8100	206.0400	124797200
3229	NVDA	NVIDIA Corporation	Technology	207.40	2026-07-16	5008087652618.41	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	210.1700	211.0800	205.8500	122986100
3230	NVDA	NVIDIA Corporation	Technology	202.81	2026-07-17	4897253011047.36	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	202.6400	206.6500	197.9700	144281900
3231	NVDA	NVIDIA Corporation	Technology	\N	2026-07-18	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3232	NVDA	NVIDIA Corporation	Technology	\N	2026-07-19	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3233	NVDA	NVIDIA Corporation	Technology	203.28	2026-07-20	4908602130523.68	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	205.8700	207.7400	202.2800	88701500
3234	NVDA	NVIDIA Corporation	Technology	207.29	2026-07-21	5005431467880.25	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	207.5400	208.6500	204.0100	108685600
3235	NVDA	NVIDIA Corporation	Technology	212.06	2026-07-22	5120612761047.36	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	205.8100	214.3900	204.9500	137645600
3236	NVDA	NVIDIA Corporation	Technology	208.76	2026-07-23	5040927587356.57	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	209.4600	210.8700	205.9600	110505300
3237	NVDA	NVIDIA Corporation	Technology	206.84	2026-07-24	4994565391571.05	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	207.4500	211.9100	204.8100	114836800
3238	NVDA	NVIDIA Corporation	Technology	\N	2026-07-25	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3239	NVDA	NVIDIA Corporation	Technology	\N	2026-07-26	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3240	NVDA	NVIDIA Corporation	Technology	196.51	2026-07-27	4745126837356.57	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	208.2000	208.7500	195.4400	154353700
3241	NVDA	NVIDIA Corporation	Technology	197.01	2026-07-28	4757200337356.57	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	195.0000	198.7000	192.7400	134111500
3808	JNJ	Johnson & Johnson	Healthcare	\N	2026-08-02	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3242	NVDA	NVIDIA Corporation	Technology	190.01	2026-07-29	4588171337356.57	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	195.8500	197.0700	190.0100	147680800
3243	NVDA	NVIDIA Corporation	Technology	195.04	2026-07-30	4709630717880.25	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	193.4500	197.2500	191.5200	129010200
3244	NVDA	NVIDIA Corporation	Technology	200.75	2026-07-31	4847510250000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	198.4400	202.0000	194.9500	139961200
3245	NVDA	NVIDIA Corporation	Technology	\N	2026-08-01	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3246	NVDA	NVIDIA Corporation	Technology	\N	2026-08-02	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3247	NVDA	NVIDIA Corporation	Technology	206.64	2026-08-03	4989736065261.84	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	197.6900	208.7400	196.8500	128406900
3248	NVDA	NVIDIA Corporation	Technology	211.94	2026-08-04	5117715238952.64	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	211.3000	213.0600	209.0500	134922000
3249	NVDA	NVIDIA Corporation	Technology	219.22	2026-08-05	5293505369476.32	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	216.8600	222.2200	216.4000	158187400
3250	NVDA	NVIDIA Corporation	Technology	218.99	2026-08-06	5287951662643.43	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	221.5300	223.6300	217.0000	113940600
3251	NVDA	NVIDIA Corporation	Technology	223.96	2026-08-07	5407962282119.75	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	221.5400	224.7600	220.6600	105669400
3252	NVDA	NVIDIA Corporation	Technology	\N	2026-08-08	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3253	NVDA	NVIDIA Corporation	Technology	\N	2026-08-09	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3254	NVDA	NVIDIA Corporation	Technology	217.55	2026-08-10	5253179923690.80	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	223.4000	224.1400	216.7700	115846600
3255	NVDA	NVIDIA Corporation	Technology	217.50	2026-08-11	5251972500000.00	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	222.1700	222.2000	216.2000	101273100
3256	NVDA	NVIDIA Corporation	Technology	224.09	2026-08-12	5411101141571.05	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	221.0400	225.1000	220.2000	108783600
3257	NVDA	NVIDIA Corporation	Technology	225.30	2026-08-13	5440319173690.80	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	225.0600	227.2300	223.7100	98867200
3258	NVDA	NVIDIA Corporation	Technology	225.16	2026-08-14	5436938608428.96	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	226.7700	227.4900	224.5000	75680900
3259	NVDA	NVIDIA Corporation	Technology	\N	2026-08-15	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3260	NVDA	NVIDIA Corporation	Technology	\N	2026-08-16	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3261	NVDA	NVIDIA Corporation	Technology	225.01	2026-08-17	5433316337356.57	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	225.9800	227.9200	224.8600	93678700
3262	NVDA	NVIDIA Corporation	Technology	219.74	2026-08-18	5306061912643.43	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	220.4500	221.6400	218.6900	103128200
3263	NVDA	NVIDIA Corporation	Technology	217.56	2026-08-19	5253421261047.36	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	221.6700	222.8700	216.7600	96797300
3264	NVDA	NVIDIA Corporation	Technology	216.85	2026-08-20	5236277097381.59	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	218.3600	219.8600	215.6600	92457000
3265	NVDA	NVIDIA Corporation	Technology	214.72	2026-08-21	5184843869476.32	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	218.4200	218.7400	214.5000	98869300
3266	NVDA	NVIDIA Corporation	Technology	\N	2026-08-22	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3267	NVDA	NVIDIA Corporation	Technology	\N	2026-08-23	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3268	NVDA	NVIDIA Corporation	Technology	208.48	2026-08-24	5034166456832.89	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	215.5300	215.5900	207.2500	135187300
3269	NVDA	NVIDIA Corporation	Technology	213.05	2026-08-25	5144518423690.80	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	211.0300	214.7300	210.1100	122309000
3270	NVDA	NVIDIA Corporation	Technology	209.66	2026-08-26	5062660108428.96	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	212.6400	213.6000	209.2300	179900000
3271	NVDA	NVIDIA Corporation	Technology	227.98	2026-08-27	5505032956832.89	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	222.8600	230.4700	220.9000	298909800
3272	NVDA	NVIDIA Corporation	Technology	217.55	2026-08-28	5253179923690.80	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	227.3600	229.2600	216.8100	195116400
3273	NVDA	NVIDIA Corporation	Technology	\N	2026-08-29	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3274	NVDA	NVIDIA Corporation	Technology	\N	2026-08-30	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3275	NVDA	NVIDIA Corporation	Technology	220.78	2026-08-31	5331174630523.68	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	218.8700	221.3000	216.2100	124702700
3276	NVDA	NVIDIA Corporation	Technology	217.44	2026-09-01	5250523738952.64	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	216.7500	220.4100	215.1000	109756200
3277	NVDA	NVIDIA Corporation	Technology	224.41	2026-09-02	5418828358428.96	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	218.7900	227.9500	218.4800	157104700
3278	NVDA	NVIDIA Corporation	Technology	228.45	2026-09-03	5516382076309.20	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	226.0200	230.4000	224.7500	134681600
3279	NVDA	NVIDIA Corporation	Technology	230.36	2026-09-04	5562502934738.16	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	231.0900	234.7600	229.6300	135352400
3280	NVDA	NVIDIA Corporation	Technology	\N	2026-09-05	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3281	NVDA	NVIDIA Corporation	Technology	\N	2026-09-06	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3282	NVDA	NVIDIA Corporation	Technology	\N	2026-09-07	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3283	NVDA	NVIDIA Corporation	Technology	225.73	2026-09-08	5450702206832.89	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	233.1100	233.7100	224.8500	122965600
3284	NVDA	NVIDIA Corporation	Technology	223.67	2026-09-09	5400959445785.52	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	225.2800	226.1800	223.4600	82955500
3285	NVDA	NVIDIA Corporation	Technology	218.36	2026-09-10	5272738934738.16	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	220.5300	220.9900	217.2000	105768000
3286	NVDA	NVIDIA Corporation	Technology	218.29	2026-09-11	5271048467880.25	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	221.2400	222.0000	218.1500	89060100
3287	NVDA	NVIDIA Corporation	Technology	\N	2026-09-12	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3288	NVDA	NVIDIA Corporation	Technology	\N	2026-09-13	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3289	NVDA	NVIDIA Corporation	Technology	210.96	2026-09-14	5094051282119.75	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	211.2400	212.7700	208.9300	132267200
3290	NVDA	NVIDIA Corporation	Technology	212.17	2026-09-15	5123268945785.52	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	213.3800	213.9400	211.1600	88059700
3291	NVDA	NVIDIA Corporation	Technology	213.90	2026-09-16	5165043152618.41	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	214.1400	216.7600	212.5000	96563600
3292	NVDA	NVIDIA Corporation	Technology	219.34	2026-09-17	5296402891571.05	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	218.3800	219.9100	217.1500	94191300
3293	NVDA	NVIDIA Corporation	Technology	222.27	2026-09-18	5367153793167.11	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	219.3500	222.7300	218.0300	190287400
3294	NVDA	NVIDIA Corporation	Technology	\N	2026-09-19	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3295	NVDA	NVIDIA Corporation	Technology	\N	2026-09-20	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3296	NVDA	NVIDIA Corporation	Technology	227.38	2026-09-21	5490544977905.27	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	222.9400	228.5000	221.5600	109806100
3297	NVDA	NVIDIA Corporation	Technology	228.87	2026-09-22	5526523772094.73	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	226.8500	229.9800	226.5000	95746700
3298	NVDA	NVIDIA Corporation	Technology	225.51	2026-09-23	5445389837356.57	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	228.0300	228.9500	224.0200	89547300
3299	NVDA	NVIDIA Corporation	Technology	224.58	2026-09-24	5422933304214.48	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	222.0800	224.9400	221.0900	77469900
3300	NVDA	NVIDIA Corporation	Technology	225.07	2026-09-25	5434765466857.91	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	225.1300	226.9400	223.1300	89947700
3301	NVDA	NVIDIA Corporation	Technology	\N	2026-09-26	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3302	NVDA	NVIDIA Corporation	Technology	\N	2026-09-27	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3303	NVDA	NVIDIA Corporation	Technology	228.86	2026-09-28	5526282434738.16	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	229.7500	233.2100	228.0400	142344300
3304	NVDA	NVIDIA Corporation	Technology	227.21	2026-09-29	5486440032119.75	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	230.9700	232.8200	227.0300	101494900
3305	NVDA	NVIDIA Corporation	Technology	228.38	2026-09-30	5514691977905.27	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	229.2700	232.3700	228.1700	121732200
3306	NVDA	NVIDIA Corporation	Technology	230.86	2026-10-01	5574576434738.16	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	229.9800	232.2900	228.1600	98591400
3307	NVDA	NVIDIA Corporation	Technology	233.95	2026-10-02	5649190576309.20	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	236.0600	237.8800	233.6000	135167800
3308	NVDA	NVIDIA Corporation	Technology	\N	2026-10-03	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3309	NVDA	NVIDIA Corporation	Technology	\N	2026-10-04	\N	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	\N	\N	\N	\N
3310	NVDA	NVIDIA Corporation	Technology	238.90	2026-10-05	5768718152618.41	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	236.0900	240.1000	235.1500	127171500
3311	NVDA	NVIDIA Corporation	Technology	239.24	2026-10-06	5776928412643.43	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	242.1000	243.3700	238.9300	101701900
3312	NVDA	NVIDIA Corporation	Technology	237.47	2026-10-07	5734188119476.32	2026-10-08 20:55:09.464	2026-10-08 20:55:09.464	237.6900	239.0800	236.3800	81485100
3314	LLY	Eli Lilly and Company	Healthcare	\N	2026-01-01	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3315	LLY	Eli Lilly and Company	Healthcare	1080.36	2026-01-02	963401732323.54	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1076.4000	1080.6600	1052.0800	2469100
3316	LLY	Eli Lilly and Company	Healthcare	\N	2026-01-03	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3317	LLY	Eli Lilly and Company	Healthcare	\N	2026-01-04	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3318	LLY	Eli Lilly and Company	Healthcare	1041.51	2026-01-05	928757600471.47	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1069.2300	1085.3800	1033.3800	4084800
3319	LLY	Eli Lilly and Company	Healthcare	1064.04	2026-01-06	948848560473.89	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1044.1100	1070.8300	1039.9301	2690700
3320	LLY	Eli Lilly and Company	Healthcare	1108.09	2026-01-07	988129704095.10	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1077.0000	1117.6600	1075.9600	4652800
3321	LLY	Eli Lilly and Company	Healthcare	1085.19	2026-01-08	967708804126.67	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1113.6899	1133.9500	1070.1500	3156000
3322	LLY	Eli Lilly and Company	Healthcare	1063.56	2026-01-09	948420542015.83	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1086.8300	1104.5200	1063.0300	2561900
3323	LLY	Eli Lilly and Company	Healthcare	\N	2026-01-10	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3324	LLY	Eli Lilly and Company	Healthcare	\N	2026-01-11	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3325	LLY	Eli Lilly and Company	Healthcare	1081.00	2026-01-12	963972459886.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1058.0000	1083.3600	1058.0000	2380200
3326	LLY	Eli Lilly and Company	Healthcare	1077.19	2026-01-13	960574872878.67	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1083.0000	1090.2200	1069.0900	2194200
3327	LLY	Eli Lilly and Company	Healthcare	1073.29	2026-01-14	957097168479.39	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1081.7500	1084.0000	1061.1200	1912600
3328	LLY	Eli Lilly and Company	Healthcare	1032.97	2026-01-15	921142094030.58	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1062.5601	1067.6500	1012.5700	4183400
3329	LLY	Eli Lilly and Company	Healthcare	1038.40	2026-01-16	925984297761.43	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1024.4301	1049.9399	1018.0000	3829000
3330	LLY	Eli Lilly and Company	Healthcare	\N	2026-01-17	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3331	LLY	Eli Lilly and Company	Healthcare	\N	2026-01-18	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3332	LLY	Eli Lilly and Company	Healthcare	\N	2026-01-19	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3333	LLY	Eli Lilly and Company	Healthcare	1041.29	2026-01-20	928561443487.39	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1028.1500	1045.8500	1015.9600	2484900
3334	LLY	Eli Lilly and Company	Healthcare	1078.52	2026-01-21	961760958615.94	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1043.8600	1081.3300	1042.0200	3685900
3335	LLY	Eli Lilly and Company	Healthcare	1087.38	2026-01-22	969661774410.49	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1078.5200	1095.4800	1071.7400	2478200
3336	LLY	Eli Lilly and Company	Healthcare	1064.29	2026-01-23	949071495825.39	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1083.7300	1084.3199	1063.0200	2592900
3337	LLY	Eli Lilly and Company	Healthcare	\N	2026-01-24	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3338	LLY	Eli Lilly and Company	Healthcare	\N	2026-01-25	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3339	LLY	Eli Lilly and Company	Healthcare	1062.75	2026-01-26	947698179226.50	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1062.2100	1067.0800	1043.3199	2244900
3340	LLY	Eli Lilly and Company	Healthcare	1039.51	2026-01-27	926974117659.47	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1064.1100	1073.3900	1034.8101	2587900
3341	LLY	Eli Lilly and Company	Healthcare	1023.80	2026-01-28	912964840577.28	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1029.1100	1029.6899	1004.1400	3300200
3342	LLY	Eli Lilly and Company	Healthcare	1024.14	2026-01-29	913268056603.46	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1025.3600	1040.0000	1018.0000	2293000
3343	LLY	Eli Lilly and Company	Healthcare	1037.15	2026-01-30	924869621003.93	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1033.3000	1048.5699	1020.0000	3303100
3344	LLY	Eli Lilly and Company	Healthcare	\N	2026-01-31	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3345	LLY	Eli Lilly and Company	Healthcare	\N	2026-02-01	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3346	LLY	Eli Lilly and Company	Healthcare	1044.13	2026-02-02	931093958600.99	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1037.5699	1057.4100	1037.5699	2757100
3347	LLY	Eli Lilly and Company	Healthcare	1003.46	2026-02-03	894826850858.69	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1040.7500	1048.8000	993.5800	5483900
3348	LLY	Eli Lilly and Company	Healthcare	1107.12	2026-02-04	987264741056.51	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1075.1200	1114.0000	1065.0000	7119400
3349	LLY	Eli Lilly and Company	Healthcare	1020.84	2026-02-05	910325320849.17	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1065.5000	1075.0000	1005.8300	7742400
3350	LLY	Eli Lilly and Company	Healthcare	1058.18	2026-02-06	943622968897.35	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1056.0000	1060.0200	1033.2700	4887100
3351	LLY	Eli Lilly and Company	Healthcare	\N	2026-02-07	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3352	LLY	Eli Lilly and Company	Healthcare	\N	2026-02-08	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3353	LLY	Eli Lilly and Company	Healthcare	1044.67	2026-02-09	931575533793.87	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1077.0900	1106.9399	1042.9200	3423800
3354	LLY	Eli Lilly and Company	Healthcare	1025.00	2026-02-10	914034941150.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1050.6600	1055.6500	1023.8800	3539400
3355	LLY	Eli Lilly and Company	Healthcare	1015.21	2026-02-11	905304812379.19	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1026.5000	1030.1000	1012.6200	2599900
3356	LLY	Eli Lilly and Company	Healthcare	1038.27	2026-02-12	925868367024.44	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1024.8700	1059.8400	1012.0000	3592200
3357	LLY	Eli Lilly and Company	Healthcare	1040.00	2026-02-13	927411062240.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1039.9800	1064.3400	1033.6899	2698700
3358	LLY	Eli Lilly and Company	Healthcare	\N	2026-02-14	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3359	LLY	Eli Lilly and Company	Healthcare	\N	2026-02-15	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3360	LLY	Eli Lilly and Company	Healthcare	\N	2026-02-16	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3361	LLY	Eli Lilly and Company	Healthcare	1036.05	2026-02-17	923888727228.36	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1045.6100	1067.0000	1034.8800	2984600
3362	LLY	Eli Lilly and Company	Healthcare	1020.56	2026-02-18	910075607130.26	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1032.3600	1037.5400	1011.3100	3236900
3363	LLY	Eli Lilly and Company	Healthcare	1023.22	2026-02-19	912447615322.08	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1010.8200	1025.2300	1007.0000	2145800
3364	LLY	Eli Lilly and Company	Healthcare	1009.52	2026-02-20	900230801601.94	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1023.8600	1028.6500	1002.4600	3249400
3365	LLY	Eli Lilly and Company	Healthcare	\N	2026-02-21	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3366	LLY	Eli Lilly and Company	Healthcare	\N	2026-02-22	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3367	LLY	Eli Lilly and Company	Healthcare	1058.56	2026-02-23	943961834985.83	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1047.0200	1064.4500	1034.0000	4767600
3368	LLY	Eli Lilly and Company	Healthcare	1042.15	2026-02-24	929328328033.93	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1042.9500	1058.9000	1024.0800	2803100
3369	LLY	Eli Lilly and Company	Healthcare	1028.83	2026-02-25	917450271547.13	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1036.5800	1053.6300	1027.0000	2481900
3370	LLY	Eli Lilly and Company	Healthcare	1022.02	2026-02-26	911377569176.94	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1024.0800	1026.9200	1007.3800	2666400
3371	LLY	Eli Lilly and Company	Healthcare	1051.99	2026-02-27	938103032989.53	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1019.1700	1053.0000	1017.3600	4325900
3372	LLY	Eli Lilly and Company	Healthcare	\N	2026-02-28	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3373	LLY	Eli Lilly and Company	Healthcare	\N	2026-03-01	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3374	LLY	Eli Lilly and Company	Healthcare	1017.97	2026-03-02	907765972940.58	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1044.6200	1056.2000	1013.0000	3094300
3375	LLY	Eli Lilly and Company	Healthcare	1007.73	2026-03-03	898634549651.56	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1015.0000	1020.0100	995.0700	2846000
3376	LLY	Eli Lilly and Company	Healthcare	1003.57	2026-03-04	894924929350.73	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1011.6300	1015.6600	993.6600	1965500
3377	LLY	Eli Lilly and Company	Healthcare	983.26	2026-03-05	876813663571.97	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	990.0000	993.5600	965.6000	3769900
3378	LLY	Eli Lilly and Company	Healthcare	990.33	2026-03-06	883118281843.70	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	975.0000	991.2200	966.0900	2627800
3379	LLY	Eli Lilly and Company	Healthcare	\N	2026-03-07	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3380	LLY	Eli Lilly and Company	Healthcare	\N	2026-03-08	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3381	LLY	Eli Lilly and Company	Healthcare	1008.39	2026-03-09	899223129458.96	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	986.8900	1008.9300	980.5800	2802200
3382	LLY	Eli Lilly and Company	Healthcare	1001.35	2026-03-10	892945235127.07	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1006.0000	1012.0000	994.0000	1663700
3383	LLY	Eli Lilly and Company	Healthcare	999.84	2026-03-11	891598751323.17	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1000.0300	1002.9300	990.3000	1446900
3384	LLY	Eli Lilly and Company	Healthcare	977.25	2026-03-12	871454289013.50	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	993.4500	994.5000	973.1600	2340100
3385	LLY	Eli Lilly and Company	Healthcare	985.08	2026-03-13	878436639462.20	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	980.1300	1003.2200	978.0000	1984400
3386	LLY	Eli Lilly and Company	Healthcare	\N	2026-03-14	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3387	LLY	Eli Lilly and Company	Healthcare	\N	2026-03-15	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3388	LLY	Eli Lilly and Company	Healthcare	989.12	2026-03-16	882039255148.51	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	991.9800	998.1700	975.5100	2289900
3389	LLY	Eli Lilly and Company	Healthcare	930.35	2026-03-17	829631595301.07	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	978.9200	981.1700	925.2500	5637500
3390	LLY	Eli Lilly and Company	Healthcare	918.05	2026-03-18	818663186892.78	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	925.0000	929.0000	905.1100	3443800
3391	LLY	Eli Lilly and Company	Healthcare	917.50	2026-03-19	818172740005.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	914.0000	924.5300	910.8600	2379000
3392	LLY	Eli Lilly and Company	Healthcare	906.70	2026-03-20	808541943705.72	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	910.5500	925.3800	899.2900	4818800
3393	LLY	Eli Lilly and Company	Healthcare	\N	2026-03-21	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3394	LLY	Eli Lilly and Company	Healthcare	\N	2026-03-22	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3395	LLY	Eli Lilly and Company	Healthcare	910.55	2026-03-23	811975126347.78	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	913.4900	926.7800	907.2300	2817500
3396	LLY	Eli Lilly and Company	Healthcare	903.02	2026-03-24	805260341862.94	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	907.0000	908.6700	895.6100	2572700
3397	LLY	Eli Lilly and Company	Healthcare	916.31	2026-03-25	817111565554.76	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	912.4900	922.1500	909.0900	2177700
3398	LLY	Eli Lilly and Company	Healthcare	897.00	2026-03-26	799892041182.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	912.3800	916.3500	896.2900	2163200
3399	LLY	Eli Lilly and Company	Healthcare	878.24	2026-03-27	783162963697.03	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	896.0000	900.8300	877.1100	2740800
3400	LLY	Eli Lilly and Company	Healthcare	\N	2026-03-28	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3401	LLY	Eli Lilly and Company	Healthcare	\N	2026-03-29	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3402	LLY	Eli Lilly and Company	Healthcare	886.63	2026-03-30	790644687155.99	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	888.4800	897.4300	883.1100	3070200
3403	LLY	Eli Lilly and Company	Healthcare	919.77	2026-03-31	820197010413.44	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	893.4900	924.1400	892.1400	3464200
3404	LLY	Eli Lilly and Company	Healthcare	954.52	2026-04-01	851185024271.94	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	926.8800	976.6800	925.9900	6267900
3405	LLY	Eli Lilly and Company	Healthcare	935.58	2026-04-02	834295439865.20	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	945.0000	957.6900	930.0200	2727100
3406	LLY	Eli Lilly and Company	Healthcare	\N	2026-04-03	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3407	LLY	Eli Lilly and Company	Healthcare	\N	2026-04-04	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3408	LLY	Eli Lilly and Company	Healthcare	\N	2026-04-05	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3409	LLY	Eli Lilly and Company	Healthcare	927.06	2026-04-06	826697785669.26	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	932.0400	936.0000	919.7800	1821100
3410	LLY	Eli Lilly and Company	Healthcare	931.09	2026-04-07	830291529660.67	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	924.5000	932.6600	898.4500	2726900
3411	LLY	Eli Lilly and Company	Healthcare	953.30	2026-04-08	850097071454.28	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	941.5200	961.1400	933.1300	2568000
3412	LLY	Eli Lilly and Company	Healthcare	955.19	2026-04-09	851782475774.24	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	948.4700	963.7600	939.2900	1672100
3413	LLY	Eli Lilly and Company	Healthcare	939.47	2026-04-10	837764272569.58	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	963.6900	963.9400	935.5400	1958900
3414	LLY	Eli Lilly and Company	Healthcare	\N	2026-04-11	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3415	LLY	Eli Lilly and Company	Healthcare	\N	2026-04-12	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3416	LLY	Eli Lilly and Company	Healthcare	929.55	2026-04-13	828918213061.78	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	939.9700	945.9000	927.1700	2089600
3417	LLY	Eli Lilly and Company	Healthcare	922.50	2026-04-14	822631447035.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	925.0000	939.9300	915.0400	2360200
3418	LLY	Eli Lilly and Company	Healthcare	905.03	2026-04-15	807052750797.42	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	923.5000	930.0000	888.0300	4233400
3419	LLY	Eli Lilly and Company	Healthcare	903.99	2026-04-16	806125304901.53	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	911.6700	920.0000	898.1500	2836600
3420	LLY	Eli Lilly and Company	Healthcare	927.03	2026-04-17	826671061729.42	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	917.8000	929.9900	917.8000	3266100
3421	LLY	Eli Lilly and Company	Healthcare	\N	2026-04-18	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3422	LLY	Eli Lilly and Company	Healthcare	\N	2026-04-19	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3423	LLY	Eli Lilly and Company	Healthcare	919.90	2026-04-20	820312941150.43	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	926.9000	929.6400	912.5000	1926300
3424	LLY	Eli Lilly and Company	Healthcare	903.02	2026-04-21	805260341862.94	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	910.2000	913.0500	881.1100	4062800
3425	LLY	Eli Lilly and Company	Healthcare	921.48	2026-04-22	821721853384.06	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	906.4000	922.5400	902.2300	2623800
3426	LLY	Eli Lilly and Company	Healthcare	917.65	2026-04-23	818306522986.93	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	929.4900	930.0000	911.8900	2149200
3427	LLY	Eli Lilly and Company	Healthcare	883.96	2026-04-24	788263752841.69	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	900.0100	900.4200	871.7300	4463700
3428	LLY	Eli Lilly and Company	Healthcare	\N	2026-04-25	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3429	LLY	Eli Lilly and Company	Healthcare	\N	2026-04-26	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
5038	XOM	Exxon Mobil Corporation	Energy	\N	2026-02-08	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
3430	LLY	Eli Lilly and Company	Healthcare	868.27	2026-04-27	774272328004.44	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	878.1300	891.2000	868.0400	2700300
3431	LLY	Eli Lilly and Company	Healthcare	874.00	2026-04-28	779381988844.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	871.9000	878.1500	863.3500	2561300
3432	LLY	Eli Lilly and Company	Healthcare	851.21	2026-04-29	759059221795.19	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	866.0400	869.0200	850.5100	3904600
3433	LLY	Eli Lilly and Company	Healthcare	934.60	2026-04-30	833421496276.57	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	898.7800	945.5000	896.8000	8236700
3434	LLY	Eli Lilly and Company	Healthcare	963.33	2026-05-01	859041263881.70	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	948.9500	984.4500	943.8000	4352400
3435	LLY	Eli Lilly and Company	Healthcare	\N	2026-05-02	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3436	LLY	Eli Lilly and Company	Healthcare	\N	2026-05-03	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3437	LLY	Eli Lilly and Company	Healthcare	967.93	2026-05-04	863143252578.27	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	960.0000	974.2200	951.7600	3696900
3438	LLY	Eli Lilly and Company	Healthcare	988.87	2026-05-05	881816319797.01	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	971.8900	992.8000	964.4100	2955500
3439	LLY	Eli Lilly and Company	Healthcare	987.05	2026-05-06	880193343906.78	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	991.3500	996.4900	983.5000	3921200
3440	LLY	Eli Lilly and Company	Healthcare	974.96	2026-05-07	869412220787.69	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	985.3700	989.0000	967.1000	3494900
3441	LLY	Eli Lilly and Company	Healthcare	948.45	2026-05-08	845772147406.22	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	974.0700	980.0000	947.5100	3559200
3442	LLY	Eli Lilly and Company	Healthcare	\N	2026-05-09	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3443	LLY	Eli Lilly and Company	Healthcare	\N	2026-05-10	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3444	LLY	Eli Lilly and Company	Healthcare	966.99	2026-05-11	862305013479.53	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	949.0000	995.0000	943.2600	3517500
3445	LLY	Eli Lilly and Company	Healthcare	989.87	2026-05-12	882708061203.01	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	974.4400	997.5200	971.1800	3037500
3446	LLY	Eli Lilly and Company	Healthcare	1015.75	2026-05-13	905786333144.50	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	994.7500	1022.8200	992.0000	3486400
3447	LLY	Eli Lilly and Company	Healthcare	1006.70	2026-05-14	897716084305.72	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1017.4900	1018.1700	996.0100	1751700
3448	LLY	Eli Lilly and Company	Healthcare	1004.92	2026-05-15	896128758477.80	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1006.9800	1014.3800	997.4100	2820700
3449	LLY	Eli Lilly and Company	Healthcare	\N	2026-05-16	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3450	LLY	Eli Lilly and Company	Healthcare	\N	2026-05-17	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3451	LLY	Eli Lilly and Company	Healthcare	988.09	2026-05-18	881120789802.67	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1000.6100	1003.0000	978.8700	2016000
3452	LLY	Eli Lilly and Company	Healthcare	1021.41	2026-05-19	910833565554.33	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	989.5100	1021.8000	984.6000	3796000
3453	LLY	Eli Lilly and Company	Healthcare	1018.87	2026-05-20	908568561977.01	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1024.9900	1037.8800	1003.6900	2998800
3454	LLY	Eli Lilly and Company	Healthcare	1041.65	2026-05-21	928882457330.93	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1024.3000	1047.3000	1022.0000	2705200
3455	LLY	Eli Lilly and Company	Healthcare	1065.00	2026-05-22	949704597390.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1049.8101	1070.3400	1047.0699	3470600
3456	LLY	Eli Lilly and Company	Healthcare	\N	2026-05-23	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3457	LLY	Eli Lilly and Company	Healthcare	\N	2026-05-24	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3458	LLY	Eli Lilly and Company	Healthcare	\N	2026-05-25	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3459	LLY	Eli Lilly and Company	Healthcare	1064.74	2026-05-26	949472735916.03	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1075.0000	1082.0000	1060.3600	2981000
3460	LLY	Eli Lilly and Company	Healthcare	1082.92	2026-05-27	965684642573.37	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1072.2600	1093.0000	1069.9000	2583000
3461	LLY	Eli Lilly and Company	Healthcare	1126.80	2026-05-28	1004814259822.86	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1096.6400	1149.1000	1092.0100	4600700
3462	LLY	Eli Lilly and Company	Healthcare	1105.00	2026-05-29	985374253630.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1127.0000	1132.6600	1089.0100	4600800
3463	LLY	Eli Lilly and Company	Healthcare	\N	2026-05-30	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3464	LLY	Eli Lilly and Company	Healthcare	\N	2026-05-31	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3465	LLY	Eli Lilly and Company	Healthcare	1082.20	2026-06-01	965042506031.14	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1095.0000	1106.1700	1071.6000	2693400
3466	LLY	Eli Lilly and Company	Healthcare	1064.15	2026-06-02	948946638965.93	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1067.3700	1078.2200	1052.1500	2408500
3467	LLY	Eli Lilly and Company	Healthcare	1078.78	2026-06-03	961992820089.92	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1059.5000	1093.2800	1053.5100	2655600
3468	LLY	Eli Lilly and Company	Healthcare	1125.27	2026-06-04	1003449869346.44	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1108.6000	1140.4600	1101.6200	4046700
3469	LLY	Eli Lilly and Company	Healthcare	1131.42	2026-06-05	1008934100764.37	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1142.9700	1166.2900	1131.0300	4126200
3470	LLY	Eli Lilly and Company	Healthcare	\N	2026-06-06	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3471	LLY	Eli Lilly and Company	Healthcare	\N	2026-06-07	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3472	LLY	Eli Lilly and Company	Healthcare	1149.15	2026-06-08	1024744658475.93	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1159.0000	1182.7300	1143.6000	4504400
3473	LLY	Eli Lilly and Company	Healthcare	1144.68	2026-06-09	1020758600516.35	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1165.0000	1174.6000	1137.7500	3822000
3474	LLY	Eli Lilly and Company	Healthcare	1136.37	2026-06-10	1013348177182.01	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1152.5000	1166.4200	1133.5300	2700600
3475	LLY	Eli Lilly and Company	Healthcare	1160.95	2026-06-11	1035267141753.64	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1139.7100	1170.1200	1125.6400	2764900
3476	LLY	Eli Lilly and Company	Healthcare	1133.00	2026-06-12	1010343012998.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1165.0000	1169.9900	1132.8101	2438400
3477	LLY	Eli Lilly and Company	Healthcare	\N	2026-06-13	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3478	LLY	Eli Lilly and Company	Healthcare	\N	2026-06-14	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3479	LLY	Eli Lilly and Company	Healthcare	1129.35	2026-06-15	1007088135095.07	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1134.0000	1137.4900	1112.0100	3167200
3480	LLY	Eli Lilly and Company	Healthcare	1122.50	2026-06-16	1000979728235.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1138.8199	1146.6899	1115.5000	2260700
3481	LLY	Eli Lilly and Company	Healthcare	1112.00	2026-06-17	991616443472.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1116.7000	1121.4900	1104.9000	2383300
3482	LLY	Eli Lilly and Company	Healthcare	1098.57	2026-06-18	979640308493.15	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1120.4900	1122.3300	1088.6600	4470500
3483	LLY	Eli Lilly and Company	Healthcare	\N	2026-06-19	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3484	LLY	Eli Lilly and Company	Healthcare	\N	2026-06-20	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3485	LLY	Eli Lilly and Company	Healthcare	\N	2026-06-21	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3486	LLY	Eli Lilly and Company	Healthcare	1102.08	2026-06-22	982770329536.63	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1112.2400	1119.4500	1093.1500	3015000
3487	LLY	Eli Lilly and Company	Healthcare	1107.08	2026-06-23	987229036566.63	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1117.0000	1122.0200	1079.2200	3316300
3488	LLY	Eli Lilly and Company	Healthcare	1117.26	2026-06-24	996307011975.97	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1129.4100	1135.1400	1100.9800	2908200
3489	LLY	Eli Lilly and Company	Healthcare	1127.69	2026-06-25	1005607813881.67	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1126.9900	1145.4301	1114.0000	2757200
3490	LLY	Eli Lilly and Company	Healthcare	1208.12	2026-06-26	1077330623062.51	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1128.8000	1215.7600	1128.0000	7725800
3491	LLY	Eli Lilly and Company	Healthcare	\N	2026-06-27	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3492	LLY	Eli Lilly and Company	Healthcare	\N	2026-06-28	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3493	LLY	Eli Lilly and Company	Healthcare	1229.93	2026-06-29	1096779555377.85	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1222.7800	1238.0000	1203.1400	3684700
3494	LLY	Eli Lilly and Company	Healthcare	1199.43	2026-06-30	1069581442494.85	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1228.8800	1230.0500	1190.2000	3723600
3495	LLY	Eli Lilly and Company	Healthcare	1191.74	2026-07-01	1062723894478.03	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1217.5100	1217.5100	1173.9301	2720400
3496	LLY	Eli Lilly and Company	Healthcare	1213.91	2026-07-02	1082493840636.90	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1193.0100	1232.0000	1180.3000	3296100
3497	LLY	Eli Lilly and Company	Healthcare	\N	2026-07-03	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3498	LLY	Eli Lilly and Company	Healthcare	\N	2026-07-04	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3499	LLY	Eli Lilly and Company	Healthcare	\N	2026-07-05	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3500	LLY	Eli Lilly and Company	Healthcare	1200.06	2026-07-06	1070143243934.83	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1208.0000	1213.7900	1183.3400	2348800
3501	LLY	Eli Lilly and Company	Healthcare	1235.56	2026-07-07	1101800063847.83	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1232.8800	1249.4500	1222.7700	2933800
3502	LLY	Eli Lilly and Company	Healthcare	1215.83	2026-07-08	1084205914469.13	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1221.1000	1241.8900	1204.1600	2608600
3503	LLY	Eli Lilly and Company	Healthcare	1216.95	2026-07-09	1085204660489.64	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1211.6400	1230.0000	1200.3700	2088100
3504	LLY	Eli Lilly and Company	Healthcare	1188.58	2026-07-10	1059905961155.63	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1210.3101	1212.9600	1178.3199	2010200
3505	LLY	Eli Lilly and Company	Healthcare	\N	2026-07-11	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3506	LLY	Eli Lilly and Company	Healthcare	\N	2026-07-12	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3507	LLY	Eli Lilly and Company	Healthcare	1181.87	2026-07-13	1053922411155.01	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1180.1100	1196.2900	1166.0100	2072700
3508	LLY	Eli Lilly and Company	Healthcare	1152.54	2026-07-14	1027767674904.89	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1166.0100	1166.0100	1140.7400	2642900
3509	LLY	Eli Lilly and Company	Healthcare	1156.63	2026-07-15	1031414866775.99	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1145.5000	1160.8199	1134.4000	2552200
3510	LLY	Eli Lilly and Company	Healthcare	1169.17	2026-07-16	1042597338840.87	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1162.2700	1189.0699	1141.2000	2791100
3511	LLY	Eli Lilly and Company	Healthcare	1179.11	2026-07-17	1051461196166.04	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1159.4500	1187.9500	1151.0100	2757500
3512	LLY	Eli Lilly and Company	Healthcare	\N	2026-07-18	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3513	LLY	Eli Lilly and Company	Healthcare	\N	2026-07-19	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3514	LLY	Eli Lilly and Company	Healthcare	1146.90	2026-07-20	1022738240312.43	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1179.6500	1187.1200	1144.4301	2644200
3515	LLY	Eli Lilly and Company	Healthcare	1175.41	2026-07-21	1048161796505.90	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1143.0000	1177.5800	1139.0000	2092000
3516	LLY	Eli Lilly and Company	Healthcare	1163.01	2026-07-22	1037104181300.47	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1173.9100	1175.0000	1153.5000	1555800
3517	LLY	Eli Lilly and Company	Healthcare	1185.87	2026-07-23	1057489376779.01	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1146.6200	1189.5900	1141.7800	1909900
3518	LLY	Eli Lilly and Company	Healthcare	1196.03	2026-07-24	1066549499943.42	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1194.3500	1206.9399	1187.5000	1983300
3519	LLY	Eli Lilly and Company	Healthcare	\N	2026-07-25	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3520	LLY	Eli Lilly and Company	Healthcare	\N	2026-07-26	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3521	LLY	Eli Lilly and Company	Healthcare	1197.53	2026-07-27	1067887112052.42	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1201.0000	1205.0500	1183.4500	1592800
3522	LLY	Eli Lilly and Company	Healthcare	1220.66	2026-07-28	1088513095127.40	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1217.6000	1232.0000	1205.0100	2375400
3523	LLY	Eli Lilly and Company	Healthcare	1210.02	2026-07-29	1079024953504.94	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1215.1801	1229.1899	1204.8000	2170900
3524	LLY	Eli Lilly and Company	Healthcare	1154.97	2026-07-30	1029934545562.58	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1174.0300	1186.6500	1153.1400	3027700
3525	LLY	Eli Lilly and Company	Healthcare	1148.84	2026-07-31	1024468166389.60	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1148.5100	1150.6300	1119.0000	2884600
3526	LLY	Eli Lilly and Company	Healthcare	\N	2026-08-01	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3527	LLY	Eli Lilly and Company	Healthcare	\N	2026-08-02	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3528	LLY	Eli Lilly and Company	Healthcare	1121.36	2026-08-03	999963129969.54	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1152.0000	1161.9399	1109.1500	2934000
3529	LLY	Eli Lilly and Company	Healthcare	1115.68	2026-08-04	994898099742.35	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1117.3800	1135.8300	1109.1600	4097200
3530	LLY	Eli Lilly and Company	Healthcare	1169.86	2026-08-05	1043212588160.54	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1174.0000	1216.9399	1138.4301	6445700
3531	LLY	Eli Lilly and Company	Healthcare	1191.94	2026-08-06	1062902199217.17	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1196.5500	1230.8800	1173.5000	3422400
3532	LLY	Eli Lilly and Company	Healthcare	1185.71	2026-08-07	1057346667674.61	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1188.0000	1196.8000	1161.2000	2898500
3533	LLY	Eli Lilly and Company	Healthcare	\N	2026-08-08	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3534	LLY	Eli Lilly and Company	Healthcare	\N	2026-08-09	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3535	LLY	Eli Lilly and Company	Healthcare	1231.94	2026-08-10	1098571855457.17	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1185.0100	1231.9399	1184.4100	3011900
3536	LLY	Eli Lilly and Company	Healthcare	1215.02	2026-08-11	1083483660534.94	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1230.6500	1238.0000	1209.5300	2113200
3537	LLY	Eli Lilly and Company	Healthcare	1220.28	2026-08-12	1088174229038.92	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1201.7300	1226.5000	1191.0800	1941600
3538	LLY	Eli Lilly and Company	Healthcare	1209.00	2026-08-13	1078115359854.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1238.3000	1240.1000	1206.0000	1927300
3539	LLY	Eli Lilly and Company	Healthcare	1180.16	2026-08-14	1052397568184.40	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1194.0100	1199.0000	1171.2000	2274500
3540	LLY	Eli Lilly and Company	Healthcare	\N	2026-08-15	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3541	LLY	Eli Lilly and Company	Healthcare	\N	2026-08-16	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3542	LLY	Eli Lilly and Company	Healthcare	1183.16	2026-08-17	1055072792402.40	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1175.2000	1198.5200	1163.5000	1807000
3543	LLY	Eli Lilly and Company	Healthcare	1225.73	2026-08-18	1093034176159.56	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1200.0000	1228.4700	1194.0100	2509100
3544	LLY	Eli Lilly and Company	Healthcare	1280.34	2026-08-19	1141732161278.60	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1245.8101	1292.6500	1240.5400	4541800
3545	LLY	Eli Lilly and Company	Healthcare	1244.40	2026-08-20	1109683027397.43	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1274.1300	1280.2800	1243.2300	2621400
3546	LLY	Eli Lilly and Company	Healthcare	1255.40	2026-08-21	1119492182863.43	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1232.0000	1271.2200	1230.0000	2497300
3547	LLY	Eli Lilly and Company	Healthcare	\N	2026-08-22	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3548	LLY	Eli Lilly and Company	Healthcare	\N	2026-08-23	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3549	LLY	Eli Lilly and Company	Healthcare	1246.93	2026-08-24	1111939159279.85	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1262.1400	1262.1400	1230.9500	1664600
3550	LLY	Eli Lilly and Company	Healthcare	1233.66	2026-08-25	1100105733405.40	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1249.0000	1264.7300	1229.7900	2141100
3551	LLY	Eli Lilly and Company	Healthcare	1189.41	2026-08-26	1060646176189.90	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1234.0000	1235.7800	1180.0100	3000500
3552	LLY	Eli Lilly and Company	Healthcare	1176.10	2026-08-27	1048777045825.57	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1182.2500	1190.1100	1171.7100	2730600
5424	CVX	Chevron Corporation	Energy	\N	2026-05-24	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
3553	LLY	Eli Lilly and Company	Healthcare	1174.61	2026-08-28	1047448359839.04	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1172.6600	1180.0000	1162.9301	2450800
3554	LLY	Eli Lilly and Company	Healthcare	\N	2026-08-29	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3555	LLY	Eli Lilly and Company	Healthcare	\N	2026-08-30	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3556	LLY	Eli Lilly and Company	Healthcare	1156.73	2026-08-31	1031504019145.56	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1168.4700	1171.4500	1147.0000	3055800
3557	LLY	Eli Lilly and Company	Healthcare	1160.00	2026-09-01	1034420030960.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1188.0000	1188.3300	1156.8500	2520100
3558	LLY	Eli Lilly and Company	Healthcare	1160.08	2026-09-02	1034491331084.63	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1164.1500	1187.8300	1158.0000	2445100
3559	LLY	Eli Lilly and Company	Healthcare	1159.60	2026-09-03	1034063312626.57	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1170.0000	1171.6600	1137.5000	2550500
3560	LLY	Eli Lilly and Company	Healthcare	1149.36	2026-09-04	1024931889337.54	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1150.6100	1158.4399	1138.3101	2218900
3561	LLY	Eli Lilly and Company	Healthcare	\N	2026-09-05	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3562	LLY	Eli Lilly and Company	Healthcare	\N	2026-09-06	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3563	LLY	Eli Lilly and Company	Healthcare	\N	2026-09-07	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3564	LLY	Eli Lilly and Company	Healthcare	1123.91	2026-09-08	1002237114096.90	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1133.0000	1134.5300	1113.5500	2400500
3565	LLY	Eli Lilly and Company	Healthcare	1124.21	2026-09-09	1002504571205.61	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1127.6100	1138.7900	1119.0000	2045000
3566	LLY	Eli Lilly and Company	Healthcare	1123.00	2026-09-10	1001425598938.00	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1126.0800	1133.7900	1120.5200	1995600
3567	LLY	Eli Lilly and Company	Healthcare	1115.70	2026-09-11	994915843132.14	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1129.4100	1131.4399	1113.2900	1837200
3568	LLY	Eli Lilly and Company	Healthcare	\N	2026-09-12	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3569	LLY	Eli Lilly and Company	Healthcare	\N	2026-09-13	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3570	LLY	Eli Lilly and Company	Healthcare	1138.28	2026-09-14	1015051433746.92	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1142.2000	1153.9500	1130.5000	2129600
3571	LLY	Eli Lilly and Company	Healthcare	1136.11	2026-09-15	1013116315708.04	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1156.6300	1161.0000	1131.5900	1885200
3572	LLY	Eli Lilly and Company	Healthcare	1137.82	2026-09-16	1014641158678.65	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1137.3101	1151.2300	1132.6300	1475400
3573	LLY	Eli Lilly and Company	Healthcare	1152.44	2026-09-17	1027678413680.17	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1150.2700	1159.7500	1138.2600	1896400
3574	LLY	Eli Lilly and Company	Healthcare	1152.93	2026-09-18	1028115467115.85	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1150.0000	1157.6000	1140.2700	4542600
3575	LLY	Eli Lilly and Company	Healthcare	\N	2026-09-19	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3576	LLY	Eli Lilly and Company	Healthcare	\N	2026-09-20	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3577	LLY	Eli Lilly and Company	Healthcare	1164.89	2026-09-21	1038780659497.96	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1144.5000	1170.9000	1134.4100	2476600
3578	LLY	Eli Lilly and Company	Healthcare	1170.14	2026-09-22	1043462301879.46	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1146.1500	1180.5300	1139.2600	2453100
3579	LLY	Eli Lilly and Company	Healthcare	1150.99	2026-09-23	1026385432183.53	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1174.7100	1188.8800	1145.9800	2154100
3580	LLY	Eli Lilly and Company	Healthcare	1181.89	2026-09-24	1053940263399.96	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1156.6700	1197.7900	1151.0000	2417700
3581	LLY	Eli Lilly and Company	Healthcare	1183.46	2026-09-25	1055340249511.11	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1185.3199	1190.0000	1160.8400	1923200
3582	LLY	Eli Lilly and Company	Healthcare	\N	2026-09-26	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3583	LLY	Eli Lilly and Company	Healthcare	\N	2026-09-27	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3584	LLY	Eli Lilly and Company	Healthcare	1184.78	2026-09-28	1056517409125.92	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1180.3000	1194.0900	1172.5601	1971200
3585	LLY	Eli Lilly and Company	Healthcare	1184.63	2026-09-29	1056383626143.99	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1186.0500	1192.9399	1168.4700	1658100
3586	LLY	Eli Lilly and Company	Healthcare	1157.08	2026-09-30	1031816106866.63	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1186.4900	1215.0000	1155.2700	3407700
3587	LLY	Eli Lilly and Company	Healthcare	1149.85	2026-10-01	1025368833918.07	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1155.0000	1158.7200	1139.8500	2172500
3588	LLY	Eli Lilly and Company	Healthcare	1142.85	2026-10-02	1019126644076.07	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1153.8199	1164.9200	1136.6600	2052300
3589	LLY	Eli Lilly and Company	Healthcare	\N	2026-10-03	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3590	LLY	Eli Lilly and Company	Healthcare	\N	2026-10-04	\N	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	\N	\N	\N	\N
3591	LLY	Eli Lilly and Company	Healthcare	1143.12	2026-10-05	1019367431672.51	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1150.7600	1165.7300	1139.5000	1976600
3592	LLY	Eli Lilly and Company	Healthcare	1157.49	2026-10-06	1032181751322.53	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1147.1500	1177.0699	1139.9800	2131000
3593	LLY	Eli Lilly and Company	Healthcare	1188.72	2026-10-07	1060030818015.08	2026-10-08 20:55:09.757	2026-10-08 20:55:09.757	1173.6200	1206.6300	1166.0000	2303500
3595	JNJ	Johnson & Johnson	Healthcare	\N	2026-01-01	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3596	JNJ	Johnson & Johnson	Healthcare	207.35	2026-01-02	499692488796.80	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	206.8200	207.3900	203.6800	6325500
3597	JNJ	Johnson & Johnson	Healthcare	\N	2026-01-03	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3598	JNJ	Johnson & Johnson	Healthcare	\N	2026-01-04	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3599	JNJ	Johnson & Johnson	Healthcare	204.31	2026-01-05	492366376469.53	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	205.8700	205.9400	200.9100	9477000
3600	JNJ	Johnson & Johnson	Healthcare	204.79	2026-01-06	493523117499.89	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	204.6000	206.7100	204.1200	8107900
3601	JNJ	Johnson & Johnson	Healthcare	207.49	2026-01-07	500029873129.50	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	205.2600	208.2600	205.0300	7545900
3602	JNJ	Johnson & Johnson	Healthcare	205.75	2026-01-08	495836636332.75	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	206.9300	208.9800	204.9700	6557800
3603	JNJ	Johnson & Johnson	Healthcare	204.39	2026-01-09	492559172769.94	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	205.9100	206.7000	204.0100	6154300
3604	JNJ	Johnson & Johnson	Healthcare	\N	2026-01-10	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3605	JNJ	Johnson & Johnson	Healthcare	\N	2026-01-11	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3606	JNJ	Johnson & Johnson	Healthcare	209.72	2026-01-12	505403936704.61	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	205.5500	209.9000	203.8500	11794300
3607	JNJ	Johnson & Johnson	Healthcare	213.65	2026-01-13	514874820540.20	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	209.9100	214.3900	208.8600	11379600
3608	JNJ	Johnson & Johnson	Healthcare	218.55	2026-01-14	526683345728.78	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	214.7300	218.8600	214.1500	11858800
3609	JNJ	Johnson & Johnson	Healthcare	219.57	2026-01-15	529141452593.91	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	218.2300	219.7500	215.9100	8492100
3610	JNJ	Johnson & Johnson	Healthcare	218.66	2026-01-16	526948436045.33	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	219.0400	220.1100	218.1400	10021500
3611	JNJ	Johnson & Johnson	Healthcare	\N	2026-01-17	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3612	JNJ	Johnson & Johnson	Healthcare	\N	2026-01-18	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3613	JNJ	Johnson & Johnson	Healthcare	\N	2026-01-19	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3614	JNJ	Johnson & Johnson	Healthcare	218.21	2026-01-20	525863989031.11	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	217.0900	218.7300	214.5000	14057100
3615	JNJ	Johnson & Johnson	Healthcare	218.01	2026-01-21	525381979894.00	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	211.0000	218.6800	210.5000	14762900
3616	JNJ	Johnson & Johnson	Healthcare	218.49	2026-01-22	526538757696.50	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	218.7700	222.1700	218.1000	13160000
3617	JNJ	Johnson & Johnson	Healthcare	220.14	2026-01-23	530515075672.69	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	219.8000	221.2100	217.8400	6950600
3618	JNJ	Johnson & Johnson	Healthcare	\N	2026-01-24	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3619	JNJ	Johnson & Johnson	Healthcare	\N	2026-01-25	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3620	JNJ	Johnson & Johnson	Healthcare	221.49	2026-01-26	533768453487.50	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	220.2100	222.0300	220.0000	6856700
3621	JNJ	Johnson & Johnson	Healthcare	224.44	2026-01-27	540877646994.22	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	222.0000	225.5000	220.7000	8154100
3622	JNJ	Johnson & Johnson	Healthcare	227.72	2026-01-28	548782111450.61	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	226.4000	228.5700	226.0800	9026500
3623	JNJ	Johnson & Johnson	Healthcare	227.29	2026-01-29	547745835932.39	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	228.8100	230.0000	227.0800	9645300
3624	JNJ	Johnson & Johnson	Healthcare	227.25	2026-01-30	547649456168.25	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	228.2600	228.5000	225.3300	11045500
3625	JNJ	Johnson & Johnson	Healthcare	\N	2026-01-31	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3626	JNJ	Johnson & Johnson	Healthcare	\N	2026-02-01	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3627	JNJ	Johnson & Johnson	Healthcare	230.75	2026-02-02	556084101257.75	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	228.3200	231.1900	227.2500	8187500
3628	JNJ	Johnson & Johnson	Healthcare	233.10	2026-02-03	561747377669.55	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	231.5000	235.2000	230.4800	9346600
3629	JNJ	Johnson & Johnson	Healthcare	234.47	2026-02-04	565048926980.36	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	235.0000	235.8300	232.9400	8641400
3630	JNJ	Johnson & Johnson	Healthcare	237.79	2026-02-05	573049771200.89	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	235.0000	239.5800	234.9900	10267500
3631	JNJ	Johnson & Johnson	Healthcare	239.99	2026-02-06	578351577532.00	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	238.9600	240.9400	237.9800	8274000
3632	JNJ	Johnson & Johnson	Healthcare	\N	2026-02-07	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3633	JNJ	Johnson & Johnson	Healthcare	\N	2026-02-08	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3634	JNJ	Johnson & Johnson	Healthcare	238.64	2026-02-09	575098199717.19	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	240.2500	240.7400	237.0400	9378500
3635	JNJ	Johnson & Johnson	Healthcare	238.35	2026-02-10	574399345303.80	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	239.9800	240.5000	237.8800	6723300
3636	JNJ	Johnson & Johnson	Healthcare	240.86	2026-02-11	580448177544.31	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	239.3400	241.2600	237.4000	6803900
3637	JNJ	Johnson & Johnson	Healthcare	244.55	2026-02-12	589340709250.78	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	240.4800	246.3500	239.6800	10254300
3638	JNJ	Johnson & Johnson	Healthcare	243.45	2026-02-13	586689806085.22	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	244.5900	244.9500	242.6100	13268500
3639	JNJ	Johnson & Johnson	Healthcare	\N	2026-02-14	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3640	JNJ	Johnson & Johnson	Healthcare	\N	2026-02-15	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3641	JNJ	Johnson & Johnson	Healthcare	\N	2026-02-16	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3642	JNJ	Johnson & Johnson	Healthcare	243.33	2026-02-17	586400630020.67	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	244.1300	244.4900	241.8700	12703000
3643	JNJ	Johnson & Johnson	Healthcare	244.99	2026-02-18	590401070517.00	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	243.2400	245.0700	242.8200	8129700
3644	JNJ	Johnson & Johnson	Healthcare	246.91	2026-02-19	595028071410.58	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	244.6200	246.9600	244.2700	7553900
3645	JNJ	Johnson & Johnson	Healthcare	242.49	2026-02-20	584376324024.50	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	246.4700	246.8800	240.2800	13565800
3646	JNJ	Johnson & Johnson	Healthcare	\N	2026-02-21	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3647	JNJ	Johnson & Johnson	Healthcare	\N	2026-02-22	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3648	JNJ	Johnson & Johnson	Healthcare	245.84	2026-02-23	592449462261.17	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	243.6300	246.8100	242.6000	9622700
3649	JNJ	Johnson & Johnson	Healthcare	246.28	2026-02-24	593509823527.39	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	245.3500	247.2500	244.5400	7246300
3650	JNJ	Johnson & Johnson	Healthcare	245.17	2026-02-25	590834834613.83	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	244.8600	247.2500	243.7200	7698200
3651	JNJ	Johnson & Johnson	Healthcare	243.47	2026-02-26	586738014353.36	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	245.1100	245.4700	242.0200	7172600
3652	JNJ	Johnson & Johnson	Healthcare	248.43	2026-02-27	598691090802.09	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	244.0300	248.9400	242.5000	16428600
3653	JNJ	Johnson & Johnson	Healthcare	\N	2026-02-28	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3654	JNJ	Johnson & Johnson	Healthcare	\N	2026-03-01	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3655	JNJ	Johnson & Johnson	Healthcare	248.56	2026-03-02	599004389386.78	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	249.1900	251.7100	246.8700	9042400
3656	JNJ	Johnson & Johnson	Healthcare	246.75	2026-03-03	594642478809.75	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	246.4600	247.8800	244.3600	6178700
3657	JNJ	Johnson & Johnson	Healthcare	245.30	2026-03-04	591148133198.53	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	245.7500	246.5700	243.1800	5768000
3658	JNJ	Johnson & Johnson	Healthcare	239.63	2026-03-05	577484012566.19	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	242.6300	243.0000	235.9300	9375400
3659	JNJ	Johnson & Johnson	Healthcare	240.40	2026-03-06	579339608009.95	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	238.1200	240.7900	235.4300	7179800
3660	JNJ	Johnson & Johnson	Healthcare	\N	2026-03-07	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3661	JNJ	Johnson & Johnson	Healthcare	\N	2026-03-08	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3662	JNJ	Johnson & Johnson	Healthcare	242.59	2026-03-09	584617291820.92	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	240.8700	244.0900	240.0400	7844000
3663	JNJ	Johnson & Johnson	Healthcare	243.71	2026-03-10	587316403254.61	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	242.3000	245.0000	240.8200	7214100
3664	JNJ	Johnson & Johnson	Healthcare	242.99	2026-03-11	585581273323.00	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	242.8700	243.6900	241.3600	6933200
3665	JNJ	Johnson & Johnson	Healthcare	242.04	2026-03-12	583291840238.14	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	241.4600	244.4000	240.3000	7710200
3666	JNJ	Johnson & Johnson	Healthcare	241.52	2026-03-13	582038719443.64	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	244.2100	245.5900	241.5000	6415300
3667	JNJ	Johnson & Johnson	Healthcare	\N	2026-03-14	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3668	JNJ	Johnson & Johnson	Healthcare	\N	2026-03-15	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3669	JNJ	Johnson & Johnson	Healthcare	243.19	2026-03-16	586063245687.97	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	243.9200	245.0600	241.6700	7571500
3670	JNJ	Johnson & Johnson	Healthcare	238.11	2026-03-17	573820956402.56	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	243.5800	244.1400	237.2200	7281800
3671	JNJ	Johnson & Johnson	Healthcare	237.28	2026-03-18	571820736154.39	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	237.8700	239.1100	235.4200	6811500
3672	JNJ	Johnson & Johnson	Healthcare	237.60	2026-03-19	572591921356.05	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	238.3400	239.2600	236.3100	7511500
3673	JNJ	Johnson & Johnson	Healthcare	235.37	2026-03-20	567217821008.81	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	236.8300	238.2900	234.5000	17156600
3674	JNJ	Johnson & Johnson	Healthcare	\N	2026-03-21	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3675	JNJ	Johnson & Johnson	Healthcare	\N	2026-03-22	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3676	JNJ	Johnson & Johnson	Healthcare	235.42	2026-03-23	567338323293.08	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	237.4000	238.3100	234.2500	7313700
3677	JNJ	Johnson & Johnson	Healthcare	235.27	2026-03-24	566976853212.39	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	234.1400	236.0000	232.2400	9046200
3678	JNJ	Johnson & Johnson	Healthcare	239.93	2026-03-25	578206952727.59	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	236.8000	241.4600	235.7300	6456400
5425	CVX	Chevron Corporation	Energy	\N	2026-05-25	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
3679	JNJ	Johnson & Johnson	Healthcare	239.24	2026-03-26	576544153584.25	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	240.0000	241.6500	238.9300	5171400
3680	JNJ	Johnson & Johnson	Healthcare	240.45	2026-03-27	579460110294.22	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	241.1900	242.6800	239.1300	7617600
3681	JNJ	Johnson & Johnson	Healthcare	\N	2026-03-28	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3682	JNJ	Johnson & Johnson	Healthcare	\N	2026-03-29	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3683	JNJ	Johnson & Johnson	Healthcare	242.49	2026-03-30	584376324024.50	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	243.4900	244.2100	240.5100	7241300
3684	JNJ	Johnson & Johnson	Healthcare	244.44	2026-03-31	589075618934.22	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	243.0100	245.3300	242.6500	7554200
3685	JNJ	Johnson & Johnson	Healthcare	244.12	2026-04-01	588304433732.56	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	245.6000	247.2000	243.7400	6314600
3686	JNJ	Johnson & Johnson	Healthcare	243.04	2026-04-02	585701738835.14	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	245.1100	247.2100	241.8700	6878700
3687	JNJ	Johnson & Johnson	Healthcare	\N	2026-04-03	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3688	JNJ	Johnson & Johnson	Healthcare	\N	2026-04-04	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3689	JNJ	Johnson & Johnson	Healthcare	\N	2026-04-05	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3690	JNJ	Johnson & Johnson	Healthcare	240.97	2026-04-06	580713267860.86	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	242.6500	243.5200	240.5000	4442400
3691	JNJ	Johnson & Johnson	Healthcare	238.41	2026-04-07	574543933336.08	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	240.7800	240.7800	236.0100	6241100
3692	JNJ	Johnson & Johnson	Healthcare	241.30	2026-04-08	581508538810.53	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	236.6400	241.3300	233.9000	8771100
3693	JNJ	Johnson & Johnson	Healthcare	241.31	2026-04-09	581532624558.53	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	241.3000	244.2000	240.5400	6216500
3694	JNJ	Johnson & Johnson	Healthcare	238.46	2026-04-10	574664435620.36	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	242.0000	242.2600	237.9100	7354500
3695	JNJ	Johnson & Johnson	Healthcare	\N	2026-04-11	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3696	JNJ	Johnson & Johnson	Healthcare	\N	2026-04-12	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3697	JNJ	Johnson & Johnson	Healthcare	237.96	2026-04-13	573459486321.86	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	237.7100	238.3900	235.1800	7663600
3698	JNJ	Johnson & Johnson	Healthcare	240.10	2026-04-14	578616667848.55	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	235.0100	242.1900	233.2500	10318700
3699	JNJ	Johnson & Johnson	Healthcare	238.67	2026-04-15	575170493733.33	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	239.9400	240.4200	236.7500	6463500
3700	JNJ	Johnson & Johnson	Healthcare	234.54	2026-04-16	565217600760.64	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	237.4200	238.1400	232.1200	8668900
3701	JNJ	Johnson & Johnson	Healthcare	234.18	2026-04-17	564350035794.84	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	234.3600	235.5400	232.0400	8946300
3702	JNJ	Johnson & Johnson	Healthcare	\N	2026-04-18	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3703	JNJ	Johnson & Johnson	Healthcare	\N	2026-04-19	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3704	JNJ	Johnson & Johnson	Healthcare	230.69	2026-04-20	555939513225.47	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	234.8100	235.2600	229.5300	7810500
3705	JNJ	Johnson & Johnson	Healthcare	226.16	2026-04-21	545022675522.83	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	229.3500	229.6900	224.7000	11681200
3706	JNJ	Johnson & Johnson	Healthcare	226.10	2026-04-22	544878087490.55	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	226.1800	227.4800	223.7800	9003400
3707	JNJ	Johnson & Johnson	Healthcare	230.65	2026-04-23	555843096689.20	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	227.2500	231.3900	227.0300	7097600
3708	JNJ	Johnson & Johnson	Healthcare	227.50	2026-04-24	548251930817.50	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	229.0300	229.9900	227.0200	6067500
3709	JNJ	Johnson & Johnson	Healthcare	\N	2026-04-25	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3710	JNJ	Johnson & Johnson	Healthcare	\N	2026-04-26	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3711	JNJ	Johnson & Johnson	Healthcare	225.34	2026-04-27	543046541022.67	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	225.7700	227.9100	224.3500	7897800
3712	JNJ	Johnson & Johnson	Healthcare	227.79	2026-04-28	548950785230.89	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	227.7300	231.0300	226.3700	7179800
3713	JNJ	Johnson & Johnson	Healthcare	227.35	2026-04-29	547890460736.80	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	225.5200	228.7100	224.8600	7071100
3714	JNJ	Johnson & Johnson	Healthcare	229.85	2026-04-30	553915207229.30	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	227.9500	231.1600	227.8100	8157200
3715	JNJ	Johnson & Johnson	Healthcare	227.19	2026-05-01	547504868135.97	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	229.0600	229.7700	227.0200	6863600
3716	JNJ	Johnson & Johnson	Healthcare	\N	2026-05-02	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3717	JNJ	Johnson & Johnson	Healthcare	\N	2026-05-03	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3718	JNJ	Johnson & Johnson	Healthcare	224.20	2026-05-04	540299258092.97	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	225.5100	227.0700	223.5800	8215200
3719	JNJ	Johnson & Johnson	Healthcare	225.55	2026-05-05	543552635907.78	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	225.3900	226.5300	224.9000	5556700
3720	JNJ	Johnson & Johnson	Healthcare	224.62	2026-05-06	541311411091.06	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	225.2500	226.3400	222.9500	7982300
3721	JNJ	Johnson & Johnson	Healthcare	222.51	2026-05-07	536226523580.50	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	224.7800	224.7800	220.6300	7269700
3722	JNJ	Johnson & Johnson	Healthcare	221.32	2026-05-08	533358775138.66	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	222.9400	223.3700	220.9200	5550600
3723	JNJ	Johnson & Johnson	Healthcare	\N	2026-05-09	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3724	JNJ	Johnson & Johnson	Healthcare	\N	2026-05-10	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3725	JNJ	Johnson & Johnson	Healthcare	221.43	2026-05-11	533623828683.09	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	221.3200	223.2800	220.3700	6223200
3726	JNJ	Johnson & Johnson	Healthcare	224.26	2026-05-12	540443846125.25	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	223.0000	227.6500	221.6500	8632500
3727	JNJ	Johnson & Johnson	Healthcare	230.42	2026-05-13	555288830308.08	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	225.8200	230.8000	225.4400	7464500
3728	JNJ	Johnson & Johnson	Healthcare	230.80	2026-05-14	556204603542.03	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	231.0000	231.7600	229.1600	6974400
3729	JNJ	Johnson & Johnson	Healthcare	226.71	2026-05-15	546348127105.61	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	230.7700	232.1400	226.4400	12167000
3730	JNJ	Johnson & Johnson	Healthcare	\N	2026-05-16	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3731	JNJ	Johnson & Johnson	Healthcare	\N	2026-05-17	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3732	JNJ	Johnson & Johnson	Healthcare	228.92	2026-05-18	551673982412.58	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	226.7100	229.7000	225.8600	10141600
3733	JNJ	Johnson & Johnson	Healthcare	230.00	2026-05-19	554276677310.00	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	228.9400	230.8500	228.0400	9677900
3734	JNJ	Johnson & Johnson	Healthcare	229.32	2026-05-20	552637963914.66	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	231.6900	232.0000	229.1700	7353800
3735	JNJ	Johnson & Johnson	Healthcare	231.73	2026-05-21	558445791586.61	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	229.3200	231.8900	227.3500	5239000
3736	JNJ	Johnson & Johnson	Healthcare	234.34	2026-05-22	564735628395.67	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	233.0000	235.5000	232.7200	5462300
3737	JNJ	Johnson & Johnson	Healthcare	\N	2026-05-23	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3738	JNJ	Johnson & Johnson	Healthcare	\N	2026-05-24	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3739	JNJ	Johnson & Johnson	Healthcare	\N	2026-05-25	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3740	JNJ	Johnson & Johnson	Healthcare	230.18	2026-05-26	554710441406.84	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	233.0000	233.2400	229.0800	6619600
3741	JNJ	Johnson & Johnson	Healthcare	231.29	2026-05-27	557385430320.39	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	229.9800	232.8900	229.0200	5835500
3742	JNJ	Johnson & Johnson	Healthcare	230.80	2026-05-28	556204603542.03	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	230.0300	231.8700	229.7300	7193400
3743	JNJ	Johnson & Johnson	Healthcare	225.33	2026-05-29	543022455274.67	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	231.2300	231.5000	224.5900	13897700
3744	JNJ	Johnson & Johnson	Healthcare	\N	2026-05-30	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3745	JNJ	Johnson & Johnson	Healthcare	\N	2026-05-31	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3746	JNJ	Johnson & Johnson	Healthcare	223.51	2026-06-01	538636422177.50	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	223.2000	224.4400	220.8400	8041000
3747	JNJ	Johnson & Johnson	Healthcare	222.89	2026-06-02	537142296814.44	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	222.5800	225.5000	221.1700	5669000
3748	JNJ	Johnson & Johnson	Healthcare	223.24	2026-06-03	537985776032.25	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	222.4500	224.9300	222.0000	6507200
3749	JNJ	Johnson & Johnson	Healthcare	228.17	2026-06-04	549866558464.83	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	227.0900	228.6700	225.9000	7274800
3750	JNJ	Johnson & Johnson	Healthcare	232.77	2026-06-05	560952106719.89	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	230.0000	235.2200	229.0000	8034900
3751	JNJ	Johnson & Johnson	Healthcare	\N	2026-06-06	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3752	JNJ	Johnson & Johnson	Healthcare	\N	2026-06-07	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3753	JNJ	Johnson & Johnson	Healthcare	232.16	2026-06-08	559482067104.83	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	232.7700	234.9500	230.5600	7559800
3754	JNJ	Johnson & Johnson	Healthcare	237.00	2026-06-09	571145967489.00	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	232.3800	237.7100	230.4100	8354500
3755	JNJ	Johnson & Johnson	Healthcare	238.49	2026-06-10	574736729636.50	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	238.8500	240.9300	237.0500	8350800
3756	JNJ	Johnson & Johnson	Healthcare	238.33	2026-06-11	574351137035.67	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	240.0000	241.6000	238.1400	7399000
3757	JNJ	Johnson & Johnson	Healthcare	240.87	2026-06-12	580472263292.31	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	240.0000	240.9100	237.5200	6459400
3758	JNJ	Johnson & Johnson	Healthcare	\N	2026-06-13	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3759	JNJ	Johnson & Johnson	Healthcare	\N	2026-06-14	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3760	JNJ	Johnson & Johnson	Healthcare	235.66	2026-06-15	567916712194.33	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	239.0000	239.5000	233.5800	7732000
3761	JNJ	Johnson & Johnson	Healthcare	235.18	2026-06-16	566759934391.84	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	236.3700	236.3700	231.0200	7718100
3762	JNJ	Johnson & Johnson	Healthcare	234.20	2026-06-17	564398244062.97	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	234.0300	235.4300	230.7000	8548000
3763	JNJ	Johnson & Johnson	Healthcare	228.39	2026-06-18	550396739097.94	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	231.7800	232.7500	227.6000	18989800
3764	JNJ	Johnson & Johnson	Healthcare	\N	2026-06-19	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3765	JNJ	Johnson & Johnson	Healthcare	\N	2026-06-20	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3766	JNJ	Johnson & Johnson	Healthcare	\N	2026-06-21	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3767	JNJ	Johnson & Johnson	Healthcare	231.29	2026-06-22	557385430320.39	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	228.9500	231.4500	227.5000	8518300
3768	JNJ	Johnson & Johnson	Healthcare	239.08	2026-06-23	576158560983.42	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	235.6400	239.8000	234.3500	11802000
3769	JNJ	Johnson & Johnson	Healthcare	241.00	2026-06-24	580785561877.00	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	239.8900	243.0400	238.7500	8139200
3770	JNJ	Johnson & Johnson	Healthcare	244.88	2026-06-25	590135980200.44	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	241.2700	248.1900	240.8900	10130400
3771	JNJ	Johnson & Johnson	Healthcare	254.66	2026-06-26	613704785537.33	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	248.2700	255.1100	247.8700	16316800
3772	JNJ	Johnson & Johnson	Healthcare	\N	2026-06-27	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3773	JNJ	Johnson & Johnson	Healthcare	\N	2026-06-28	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3774	JNJ	Johnson & Johnson	Healthcare	258.51	2026-06-29	622982909844.64	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	253.1900	258.5800	252.0300	8608400
3775	JNJ	Johnson & Johnson	Healthcare	253.97	2026-06-30	612041949621.86	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	259.0000	259.9000	253.1700	8469500
3776	JNJ	Johnson & Johnson	Healthcare	253.98	2026-07-01	612066035369.86	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	253.2500	254.2000	251.0800	6516500
3777	JNJ	Johnson & Johnson	Healthcare	263.04	2026-07-02	633899747547.28	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	255.7800	263.1000	254.0000	7998700
3778	JNJ	Johnson & Johnson	Healthcare	\N	2026-07-03	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3779	JNJ	Johnson & Johnson	Healthcare	\N	2026-07-04	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3780	JNJ	Johnson & Johnson	Healthcare	\N	2026-07-05	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3781	JNJ	Johnson & Johnson	Healthcare	259.33	2026-07-06	624958970800.53	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	260.2300	261.3800	255.9300	6803700
3782	JNJ	Johnson & Johnson	Healthcare	267.24	2026-07-07	644021277528.11	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	264.8900	269.4300	264.0500	9089700
3783	JNJ	Johnson & Johnson	Healthcare	263.40	2026-07-08	634767275740.95	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	268.6000	268.6000	263.1300	6769400
3784	JNJ	Johnson & Johnson	Healthcare	259.10	2026-07-09	624404741191.55	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	260.6300	263.4500	258.1300	6426100
3785	JNJ	Johnson & Johnson	Healthcare	256.98	2026-07-10	619295767933.00	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	260.1900	261.3000	255.5200	6534700
3786	JNJ	Johnson & Johnson	Healthcare	\N	2026-07-11	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3787	JNJ	Johnson & Johnson	Healthcare	\N	2026-07-12	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3788	JNJ	Johnson & Johnson	Healthcare	257.77	2026-07-13	621199534872.75	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	257.9500	259.5300	256.1500	5272200
3789	JNJ	Johnson & Johnson	Healthcare	253.85	2026-07-14	611752773557.30	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	255.5300	256.3900	252.1400	8770600
3790	JNJ	Johnson & Johnson	Healthcare	247.02	2026-07-15	595293161727.14	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	250.0900	256.8300	246.0500	10547300
3791	JNJ	Johnson & Johnson	Healthcare	249.97	2026-07-16	602402355233.86	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	248.9000	253.5500	246.3000	11097600
3792	JNJ	Johnson & Johnson	Healthcare	253.04	2026-07-17	609800724805.14	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	252.5900	255.6600	251.9500	10167700
3793	JNJ	Johnson & Johnson	Healthcare	\N	2026-07-18	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3794	JNJ	Johnson & Johnson	Healthcare	\N	2026-07-19	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3795	JNJ	Johnson & Johnson	Healthcare	248.82	2026-07-20	599630986556.16	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	252.0100	254.1800	248.6300	8114700
3796	JNJ	Johnson & Johnson	Healthcare	250.61	2026-07-21	603944688865.06	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	247.4500	251.3400	245.4900	7793100
3797	JNJ	Johnson & Johnson	Healthcare	255.63	2026-07-22	616042390118.19	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	252.7600	256.2900	251.2100	9100200
3798	JNJ	Johnson & Johnson	Healthcare	259.27	2026-07-23	624814382768.25	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	255.2400	260.2000	254.4200	8063300
3799	JNJ	Johnson & Johnson	Healthcare	263.40	2026-07-24	634767275740.95	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	261.4300	263.7100	259.6100	6351800
3800	JNJ	Johnson & Johnson	Healthcare	\N	2026-07-25	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3801	JNJ	Johnson & Johnson	Healthcare	\N	2026-07-26	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3802	JNJ	Johnson & Johnson	Healthcare	265.95	2026-07-27	640912561289.86	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	262.5500	268.8000	261.3500	9647900
3803	JNJ	Johnson & Johnson	Healthcare	266.73	2026-07-28	642792279253.75	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	270.0000	274.9000	266.1800	10491000
3804	JNJ	Johnson & Johnson	Healthcare	265.53	2026-07-29	639900371519.64	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	268.5000	269.3400	264.7900	6105600
3805	JNJ	Johnson & Johnson	Healthcare	255.82	2026-07-30	616500276735.16	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	259.0300	260.5200	254.5600	8216500
3806	JNJ	Johnson & Johnson	Healthcare	256.35	2026-07-31	617777520049.80	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	256.0100	258.4800	253.2900	6782100
3809	JNJ	Johnson & Johnson	Healthcare	254.41	2026-08-03	613102310888.08	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	254.9700	257.7500	250.9100	8136300
3810	JNJ	Johnson & Johnson	Healthcare	254.93	2026-08-04	614355431682.59	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	254.4100	255.5200	250.4400	7362400
3811	JNJ	Johnson & Johnson	Healthcare	257.59	2026-08-05	620765770775.92	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	255.2500	259.3200	254.4700	6472600
3812	JNJ	Johnson & Johnson	Healthcare	256.98	2026-08-06	619295767933.00	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	261.7100	262.1100	255.2800	6931800
3813	JNJ	Johnson & Johnson	Healthcare	259.24	2026-08-07	624742088752.11	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	255.8900	259.6000	255.1200	6532100
3814	JNJ	Johnson & Johnson	Healthcare	\N	2026-08-08	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3815	JNJ	Johnson & Johnson	Healthcare	\N	2026-08-09	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3816	JNJ	Johnson & Johnson	Healthcare	261.81	2026-08-10	630935545797.03	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	259.0600	262.0000	258.5500	8985100
3817	JNJ	Johnson & Johnson	Healthcare	259.80	2026-08-11	626091626082.89	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	261.2300	264.1500	258.3600	5945900
3818	JNJ	Johnson & Johnson	Healthcare	260.86	2026-08-12	628646112712.17	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	256.0000	261.4100	255.2600	4629300
3819	JNJ	Johnson & Johnson	Healthcare	262.08	2026-08-13	631586191942.28	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	261.7300	262.6200	259.6500	4852700
3820	JNJ	Johnson & Johnson	Healthcare	260.35	2026-08-14	627417114437.80	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	260.6500	261.7100	259.1600	4998100
3821	JNJ	Johnson & Johnson	Healthcare	\N	2026-08-15	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3822	JNJ	Johnson & Johnson	Healthcare	\N	2026-08-16	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3823	JNJ	Johnson & Johnson	Healthcare	262.37	2026-08-17	632285083127.81	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	258.8700	264.2800	258.0100	5515500
3824	JNJ	Johnson & Johnson	Healthcare	271.11	2026-08-18	653347573331.42	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	267.6700	271.7300	266.3300	7838200
3825	JNJ	Johnson & Johnson	Healthcare	273.41	2026-08-19	658890384231.08	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	273.0000	276.4700	270.5600	7728500
3826	JNJ	Johnson & Johnson	Healthcare	267.37	2026-08-20	644334576112.81	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	273.4000	273.4000	267.3700	6475900
3827	JNJ	Johnson & Johnson	Healthcare	270.24	2026-08-21	651250973319.11	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	267.8300	272.6600	267.0000	6186800
3828	JNJ	Johnson & Johnson	Healthcare	\N	2026-08-22	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3829	JNJ	Johnson & Johnson	Healthcare	\N	2026-08-23	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3830	JNJ	Johnson & Johnson	Healthcare	273.04	2026-08-24	657998733517.28	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	269.7400	273.9800	268.5700	5436100
3831	JNJ	Johnson & Johnson	Healthcare	273.14	2026-08-25	658239738085.83	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	271.0000	273.8000	270.1800	4687000
3832	JNJ	Johnson & Johnson	Healthcare	270.00	2026-08-26	650672621190.00	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	271.9700	272.9100	269.5500	7214100
3833	JNJ	Johnson & Johnson	Healthcare	265.77	2026-08-27	640478723648.75	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	268.4500	268.4500	263.8300	7306200
3834	JNJ	Johnson & Johnson	Healthcare	268.04	2026-08-28	645949240532.28	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	265.7800	268.3800	264.2700	5765600
3835	JNJ	Johnson & Johnson	Healthcare	\N	2026-08-29	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3836	JNJ	Johnson & Johnson	Healthcare	\N	2026-08-30	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3837	JNJ	Johnson & Johnson	Healthcare	265.85	2026-08-31	640671556721.30	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	267.1300	267.7700	265.1700	7900100
3838	JNJ	Johnson & Johnson	Healthcare	271.19	2026-09-01	653540406403.97	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	270.8300	271.9100	267.0200	6033600
3839	JNJ	Johnson & Johnson	Healthcare	275.21	2026-09-02	663228172287.97	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	274.7400	281.0700	273.5300	7910600
3840	JNJ	Johnson & Johnson	Healthcare	278.43	2026-09-03	670988048712.09	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	277.3200	278.8900	273.1600	5940300
3841	JNJ	Johnson & Johnson	Healthcare	275.23	2026-09-04	663276417328.25	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	275.1300	277.8000	274.7500	4320100
3842	JNJ	Johnson & Johnson	Healthcare	\N	2026-09-05	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3843	JNJ	Johnson & Johnson	Healthcare	\N	2026-09-06	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3844	JNJ	Johnson & Johnson	Healthcare	\N	2026-09-07	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3845	JNJ	Johnson & Johnson	Healthcare	269.12	2026-09-08	648551898657.56	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	271.2800	271.9900	266.8800	8084700
3846	JNJ	Johnson & Johnson	Healthcare	267.08	2026-09-09	643635684927.28	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	268.5100	270.1000	266.7300	6124600
3847	JNJ	Johnson & Johnson	Healthcare	266.35	2026-09-10	641876506019.80	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	270.2100	271.2700	265.7200	4929500
3848	JNJ	Johnson & Johnson	Healthcare	265.58	2026-09-11	640020837031.78	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	268.0300	270.4000	265.2500	4701200
3849	JNJ	Johnson & Johnson	Healthcare	\N	2026-09-12	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3850	JNJ	Johnson & Johnson	Healthcare	\N	2026-09-13	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3851	JNJ	Johnson & Johnson	Healthcare	266.32	2026-09-14	641804212003.66	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	271.0000	271.5500	266.1900	4740800
3852	JNJ	Johnson & Johnson	Healthcare	267.20	2026-09-15	643924934536.11	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	265.8100	267.2000	260.6800	5283500
3853	JNJ	Johnson & Johnson	Healthcare	267.28	2026-09-16	644117694064.39	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	266.8100	268.6500	266.3000	4887300
3854	JNJ	Johnson & Johnson	Healthcare	270.22	2026-09-17	651202801823.11	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	268.0000	270.8700	267.1100	6568800
3855	JNJ	Johnson & Johnson	Healthcare	269.99	2026-09-18	650648498669.86	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	269.4500	272.1100	267.2000	16428400
3856	JNJ	Johnson & Johnson	Healthcare	\N	2026-09-19	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3857	JNJ	Johnson & Johnson	Healthcare	\N	2026-09-20	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3858	JNJ	Johnson & Johnson	Healthcare	269.47	2026-09-21	649395377875.36	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	271.7400	273.7300	268.5000	4485300
3859	JNJ	Johnson & Johnson	Healthcare	269.19	2026-09-22	648720609209.97	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	267.5100	270.1000	265.0400	5680700
3860	JNJ	Johnson & Johnson	Healthcare	269.17	2026-09-23	648672437713.97	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	269.4700	272.1400	266.5000	6632700
3861	JNJ	Johnson & Johnson	Healthcare	270.68	2026-09-24	652311334585.34	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	269.5200	275.2300	269.0100	6320600
3862	JNJ	Johnson & Johnson	Healthcare	271.22	2026-09-25	653612700420.11	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	271.7000	272.2500	269.2600	4085700
3863	JNJ	Johnson & Johnson	Healthcare	\N	2026-09-26	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3864	JNJ	Johnson & Johnson	Healthcare	\N	2026-09-27	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3865	JNJ	Johnson & Johnson	Healthcare	271.95	2026-09-28	655371952871.86	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	270.1700	273.7800	269.2700	7185600
3866	JNJ	Johnson & Johnson	Healthcare	267.57	2026-09-29	644816585249.91	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	269.1100	271.8900	265.5900	5620500
3867	JNJ	Johnson & Johnson	Healthcare	264.74	2026-09-30	637996531035.61	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	267.9100	268.4800	264.5100	6341000
3868	JNJ	Johnson & Johnson	Healthcare	258.66	2026-10-01	623344379925.33	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	263.6800	263.9800	258.3300	8289000
3869	JNJ	Johnson & Johnson	Healthcare	256.03	2026-10-02	617006334848.14	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	259.3800	259.3800	255.1200	10940400
3870	JNJ	Johnson & Johnson	Healthcare	\N	2026-10-03	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3871	JNJ	Johnson & Johnson	Healthcare	\N	2026-10-04	\N	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	\N	\N	\N	\N
3872	JNJ	Johnson & Johnson	Healthcare	252.93	2026-10-05	609535634488.59	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	256.0000	256.2400	252.5100	10026800
3873	JNJ	Johnson & Johnson	Healthcare	254.78	2026-10-06	613993961601.89	2026-10-08 20:55:10.075	2026-10-08 20:55:10.075	254.1500	255.4800	251.1700	5661000
3876	JPM	JPMorgan Chase & Co.	Financials	\N	2026-01-01	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3877	JPM	JPMorgan Chase & Co.	Financials	325.48	2026-01-02	865186471952.31	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	322.5000	325.7300	320.7400	8054000
3878	JPM	JPMorgan Chase & Co.	Financials	\N	2026-01-03	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3879	JPM	JPMorgan Chase & Co.	Financials	\N	2026-01-04	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3880	JPM	JPMorgan Chase & Co.	Financials	334.04	2026-01-05	887940539291.79	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	325.5000	337.2500	325.1900	10752600
3881	JPM	JPMorgan Chase & Co.	Financials	334.61	2026-01-06	889455643770.68	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	332.6200	335.8700	330.6500	7660800
3882	JPM	JPMorgan Chase & Co.	Financials	326.99	2026-01-07	869200277944.20	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	331.1400	332.1500	324.6000	9815200
3883	JPM	JPMorgan Chase & Co.	Financials	329.79	2026-01-08	876643247963.04	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	326.3900	331.4000	325.6500	11737100
3884	JPM	JPMorgan Chase & Co.	Financials	329.19	2026-01-09	875048320021.76	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	329.3400	331.9000	328.1700	6738100
3885	JPM	JPMorgan Chase & Co.	Financials	\N	2026-01-10	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3886	JPM	JPMorgan Chase & Co.	Financials	\N	2026-01-11	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3887	JPM	JPMorgan Chase & Co.	Financials	324.49	2026-01-12	862554812456.70	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	321.8800	326.0200	321.2300	12805100
3888	JPM	JPMorgan Chase & Co.	Financials	310.90	2026-01-13	826430071801.22	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	324.3000	326.8600	310.5700	19371200
3889	JPM	JPMorgan Chase & Co.	Financials	307.87	2026-01-14	818375770875.23	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	308.2000	311.7600	306.1200	25951500
3890	JPM	JPMorgan Chase & Co.	Financials	309.26	2026-01-15	822070688624.55	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	308.4700	312.9400	307.7500	14751400
3891	JPM	JPMorgan Chase & Co.	Financials	312.47	2026-01-16	830603443596.51	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	310.3500	317.2100	310.0000	14652500
3892	JPM	JPMorgan Chase & Co.	Financials	\N	2026-01-17	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3893	JPM	JPMorgan Chase & Co.	Financials	\N	2026-01-18	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3894	JPM	JPMorgan Chase & Co.	Financials	\N	2026-01-19	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3895	JPM	JPMorgan Chase & Co.	Financials	302.74	2026-01-20	804739262715.45	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	306.2100	311.1500	301.8600	12900600
3896	JPM	JPMorgan Chase & Co.	Financials	302.04	2026-01-21	802878581051.79	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	303.4300	305.4000	301.1500	10270100
3897	JPM	JPMorgan Chase & Co.	Financials	303.63	2026-01-22	807105087367.27	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	304.8600	308.2000	302.9000	10535800
3898	JPM	JPMorgan Chase & Co.	Financials	297.72	2026-01-23	791395197220.26	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	302.0000	302.3700	296.5100	11107900
3899	JPM	JPMorgan Chase & Co.	Financials	\N	2026-01-24	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3900	JPM	JPMorgan Chase & Co.	Financials	\N	2026-01-25	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3901	JPM	JPMorgan Chase & Co.	Financials	301.04	2026-01-26	800220394856.79	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	297.8100	301.7800	297.4500	11752700
3902	JPM	JPMorgan Chase & Co.	Financials	300.31	2026-01-27	798279889730.74	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	301.3300	301.9700	298.1500	11527400
3903	JPM	JPMorgan Chase & Co.	Financials	300.77	2026-01-28	799502632666.44	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	300.2700	301.9200	298.0500	9556700
3904	JPM	JPMorgan Chase & Co.	Financials	306.42	2026-01-29	814521449565.32	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	302.4000	306.8300	302.2200	11580000
3905	JPM	JPMorgan Chase & Co.	Financials	305.89	2026-01-30	813112614126.82	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	305.2500	307.9300	302.5600	11953200
3906	JPM	JPMorgan Chase & Co.	Financials	\N	2026-01-31	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3907	JPM	JPMorgan Chase & Co.	Financials	\N	2026-02-01	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3908	JPM	JPMorgan Chase & Co.	Financials	308.14	2026-02-02	819093533065.57	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	304.4600	309.3000	301.3700	9839400
3909	JPM	JPMorgan Chase & Co.	Financials	314.85	2026-02-03	836929939720.03	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	309.7300	316.2500	309.1000	12688000
3910	JPM	JPMorgan Chase & Co.	Financials	317.27	2026-02-04	843362704883.94	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	314.4100	319.3100	314.4100	9848800
3911	JPM	JPMorgan Chase & Co.	Financials	310.16	2026-02-05	824463039975.77	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	315.0000	316.0100	305.5400	9388000
3912	JPM	JPMorgan Chase & Co.	Financials	322.40	2026-02-06	856999213043.72	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	314.7100	324.2500	314.7100	17797400
3913	JPM	JPMorgan Chase & Co.	Financials	\N	2026-02-07	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3914	JPM	JPMorgan Chase & Co.	Financials	\N	2026-02-08	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3915	JPM	JPMorgan Chase & Co.	Financials	322.10	2026-02-09	856201789633.78	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	321.3400	326.4000	320.1100	11477500
3916	JPM	JPMorgan Chase & Co.	Financials	318.28	2026-02-10	846047498899.74	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	322.5500	326.1300	315.1200	9902200
3917	JPM	JPMorgan Chase & Co.	Financials	310.82	2026-02-11	826217452599.04	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	323.2400	325.2800	308.7300	8703500
3918	JPM	JPMorgan Chase & Co.	Financials	302.64	2026-02-12	804473508993.07	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	312.2800	313.6200	300.0200	13443400
3919	JPM	JPMorgan Chase & Co.	Financials	302.55	2026-02-13	804234200848.69	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	298.5200	304.2900	296.5200	9114500
3920	JPM	JPMorgan Chase & Co.	Financials	\N	2026-02-14	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3921	JPM	JPMorgan Chase & Co.	Financials	\N	2026-02-15	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3922	JPM	JPMorgan Chase & Co.	Financials	\N	2026-02-16	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3923	JPM	JPMorgan Chase & Co.	Financials	307.13	2026-02-17	816408739049.77	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	302.7600	308.2400	302.5000	8896800
3924	JPM	JPMorgan Chase & Co.	Financials	308.78	2026-02-18	820794730047.24	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	308.4600	312.2800	307.2200	7209600
3925	JPM	JPMorgan Chase & Co.	Financials	308.05	2026-02-19	818854224921.19	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	307.1700	309.1800	305.1200	6737700
3926	JPM	JPMorgan Chase & Co.	Financials	310.79	2026-02-20	826137710258.04	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	308.4000	311.0000	305.6800	7792700
3927	JPM	JPMorgan Chase & Co.	Financials	\N	2026-02-21	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3928	JPM	JPMorgan Chase & Co.	Financials	\N	2026-02-22	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3929	JPM	JPMorgan Chase & Co.	Financials	297.67	2026-02-23	791262320359.07	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	308.8000	311.0000	295.1000	12955400
3930	JPM	JPMorgan Chase & Co.	Financials	297.30	2026-02-24	790278723324.94	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	296.8200	299.7500	291.3800	13554100
3931	JPM	JPMorgan Chase & Co.	Financials	303.30	2026-02-25	806227840494.94	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	298.6400	303.6600	297.0100	8095500
3932	JPM	JPMorgan Chase & Co.	Financials	306.13	2026-02-26	813750552854.77	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	304.5800	309.0100	303.6400	7007800
3933	JPM	JPMorgan Chase & Co.	Financials	300.30	2026-02-27	798253281909.94	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	300.0000	302.9500	294.4500	18620800
3934	JPM	JPMorgan Chase & Co.	Financials	\N	2026-02-28	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3935	JPM	JPMorgan Chase & Co.	Financials	\N	2026-03-01	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3936	JPM	JPMorgan Chase & Co.	Financials	297.56	2026-03-02	790969877694.49	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	294.8100	299.9800	293.2100	8508900
3937	JPM	JPMorgan Chase & Co.	Financials	300.26	2026-03-03	798147012869.55	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	292.2900	302.3900	289.5000	10278200
3938	JPM	JPMorgan Chase & Co.	Financials	299.39	2026-03-04	795834403859.32	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	299.9900	301.0000	295.8200	8055700
3939	JPM	JPMorgan Chase & Co.	Financials	293.55	2026-03-05	780310525093.69	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	297.9800	301.2400	292.4300	12732500
3940	JPM	JPMorgan Chase & Co.	Financials	289.48	2026-03-06	769491768932.31	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	286.3400	289.9900	283.7100	13496500
3941	JPM	JPMorgan Chase & Co.	Financials	\N	2026-03-07	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3942	JPM	JPMorgan Chase & Co.	Financials	\N	2026-03-08	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3943	JPM	JPMorgan Chase & Co.	Financials	289.92	2026-03-09	770661377347.82	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	285.5000	291.1000	280.4500	12241100
3944	JPM	JPMorgan Chase & Co.	Financials	288.73	2026-03-10	767498129286.06	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	289.2900	292.7500	287.1800	8344900
3945	JPM	JPMorgan Chase & Co.	Financials	287.52	2026-03-11	764281665582.69	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	288.8100	290.4800	284.8600	10205000
3946	JPM	JPMorgan Chase & Co.	Financials	282.89	2026-03-12	751974331641.82	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	282.8300	283.8800	279.1000	13760500
3947	JPM	JPMorgan Chase & Co.	Financials	283.44	2026-03-13	753436301600.51	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	284.6700	287.1900	282.9500	9091200
3948	JPM	JPMorgan Chase & Co.	Financials	\N	2026-03-14	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3949	JPM	JPMorgan Chase & Co.	Financials	\N	2026-03-15	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3950	JPM	JPMorgan Chase & Co.	Financials	286.16	2026-03-16	760666571295.77	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	286.3400	289.2700	284.6100	8149000
3951	JPM	JPMorgan Chase & Co.	Financials	286.89	2026-03-17	762607076421.82	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	289.0000	291.7600	285.9500	8961200
3952	JPM	JPMorgan Chase & Co.	Financials	287.74	2026-03-18	764866469790.45	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	286.8300	289.4100	285.1200	10057000
3953	JPM	JPMorgan Chase & Co.	Financials	287.97	2026-03-19	765477881819.01	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	286.8800	289.5100	284.6200	9846700
3954	JPM	JPMorgan Chase & Co.	Financials	286.56	2026-03-20	761729829549.49	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	288.0800	290.7100	285.2700	22436500
3955	JPM	JPMorgan Chase & Co.	Financials	\N	2026-03-21	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3956	JPM	JPMorgan Chase & Co.	Financials	\N	2026-03-22	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3957	JPM	JPMorgan Chase & Co.	Financials	289.91	2026-03-23	770634769527.02	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	294.3100	295.7500	287.9700	11470800
3958	JPM	JPMorgan Chase & Co.	Financials	292.40	2026-03-24	777253627193.72	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	286.1700	295.4800	285.3700	11092300
3959	JPM	JPMorgan Chase & Co.	Financials	295.42	2026-03-25	785281401420.32	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	294.1500	297.6400	292.4400	12188200
3960	JPM	JPMorgan Chase & Co.	Financials	291.66	2026-03-26	775286595368.27	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	292.5800	294.9900	290.7300	8669200
3961	JPM	JPMorgan Chase & Co.	Financials	282.84	2026-03-27	751841373659.23	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	289.1400	290.1100	281.7500	9873300
3962	JPM	JPMorgan Chase & Co.	Financials	\N	2026-03-28	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3963	JPM	JPMorgan Chase & Co.	Financials	\N	2026-03-29	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3964	JPM	JPMorgan Chase & Co.	Financials	283.77	2026-03-30	754313467351.44	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	284.7400	287.2500	282.3300	11734400
3965	JPM	JPMorgan Chase & Co.	Financials	294.16	2026-03-31	781932060855.77	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	288.4700	295.0700	284.9500	12956900
3966	JPM	JPMorgan Chase & Co.	Financials	295.38	2026-04-01	785175051258.52	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	295.3900	298.7200	292.9100	11267200
3967	JPM	JPMorgan Chase & Co.	Financials	294.60	2026-04-02	783101669271.28	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	291.9100	295.6200	288.7200	6669300
3968	JPM	JPMorgan Chase & Co.	Financials	\N	2026-04-03	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3969	JPM	JPMorgan Chase & Co.	Financials	\N	2026-04-04	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3970	JPM	JPMorgan Chase & Co.	Financials	\N	2026-04-05	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3971	JPM	JPMorgan Chase & Co.	Financials	295.45	2026-04-06	785361143761.31	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	294.0600	296.8300	293.2000	7142600
3972	JPM	JPMorgan Chase & Co.	Financials	297.40	2026-04-07	790544558168.72	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	293.1400	298.1800	292.7000	7849100
3973	JPM	JPMorgan Chase & Co.	Financials	307.97	2026-04-08	818641605719.01	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	307.9700	311.2600	305.3300	10590200
3974	JPM	JPMorgan Chase & Co.	Financials	310.33	2026-04-09	824914886200.93	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	306.9500	311.2600	306.1100	6586600
3975	JPM	JPMorgan Chase & Co.	Financials	309.87	2026-04-10	823692143265.23	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	310.0000	310.3500	306.7200	6069700
3976	JPM	JPMorgan Chase & Co.	Financials	\N	2026-04-11	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3977	JPM	JPMorgan Chase & Co.	Financials	\N	2026-04-12	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3978	JPM	JPMorgan Chase & Co.	Financials	313.68	2026-04-13	833819826178.46	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	307.4700	313.7400	305.4600	8318200
3979	JPM	JPMorgan Chase & Co.	Financials	311.12	2026-04-14	827014876008.98	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	309.8200	314.3200	308.8700	11455500
3980	JPM	JPMorgan Chase & Co.	Financials	305.93	2026-04-15	813218883167.21	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	313.9500	314.2400	304.2600	9885800
3981	JPM	JPMorgan Chase & Co.	Financials	309.95	2026-04-16	823904843588.81	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	305.3500	309.9500	305.2000	8208600
3982	JPM	JPMorgan Chase & Co.	Financials	310.29	2026-04-17	824808617160.54	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	312.4700	314.9000	310.0900	11082400
3983	JPM	JPMorgan Chase & Co.	Financials	\N	2026-04-18	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3984	JPM	JPMorgan Chase & Co.	Financials	\N	2026-04-19	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3985	JPM	JPMorgan Chase & Co.	Financials	316.99	2026-04-20	842618415994.20	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	310.8500	317.1300	310.3700	10772000
3986	JPM	JPMorgan Chase & Co.	Financials	313.00	2026-04-21	832012279035.00	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	317.4900	320.2400	312.7500	7084300
3987	JPM	JPMorgan Chase & Co.	Financials	313.02	2026-04-22	832065413555.19	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	314.8500	315.1500	311.9400	5545900
3988	JPM	JPMorgan Chase & Co.	Financials	311.69	2026-04-23	828530061609.26	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	313.5200	314.9900	308.8900	6969700
3989	JPM	JPMorgan Chase & Co.	Financials	308.28	2026-04-24	819465636949.74	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	311.1500	311.1500	307.8900	5215300
3990	JPM	JPMorgan Chase & Co.	Financials	\N	2026-04-25	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3991	JPM	JPMorgan Chase & Co.	Financials	\N	2026-04-26	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3992	JPM	JPMorgan Chase & Co.	Financials	311.63	2026-04-27	828370576927.27	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	306.8800	312.5800	306.8800	7925300
3993	JPM	JPMorgan Chase & Co.	Financials	311.45	2026-04-28	827892122881.31	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	315.2000	315.4500	311.1700	7398600
3994	JPM	JPMorgan Chase & Co.	Financials	309.25	2026-04-29	822044080803.75	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	310.5700	312.0500	307.2900	8031800
3995	JPM	JPMorgan Chase & Co.	Financials	313.23	2026-04-30	832623691063.56	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	307.0700	314.1000	306.5700	8865400
3996	JPM	JPMorgan Chase & Co.	Financials	312.47	2026-05-01	830603443596.51	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	313.9500	316.0800	311.8300	6135400
3997	JPM	JPMorgan Chase & Co.	Financials	\N	2026-05-02	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3998	JPM	JPMorgan Chase & Co.	Financials	\N	2026-05-03	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
3999	JPM	JPMorgan Chase & Co.	Financials	307.65	2026-05-04	817790966667.47	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	310.6200	310.6500	306.5100	7338200
4000	JPM	JPMorgan Chase & Co.	Financials	309.40	2026-05-05	822442792508.72	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	307.7100	310.9700	306.8000	6316800
4001	JPM	JPMorgan Chase & Co.	Financials	314.90	2026-05-06	837062816581.22	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	311.4500	316.2600	311.3500	8629500
4002	JPM	JPMorgan Chase & Co.	Financials	306.27	2026-05-07	814122656738.94	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	314.6500	316.3000	306.1400	8359600
4003	JPM	JPMorgan Chase & Co.	Financials	302.10	2026-05-08	803038065733.78	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	308.2500	308.9900	300.5000	9464300
4004	JPM	JPMorgan Chase & Co.	Financials	\N	2026-05-09	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4005	JPM	JPMorgan Chase & Co.	Financials	\N	2026-05-10	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4006	JPM	JPMorgan Chase & Co.	Financials	300.00	2026-05-11	797455858500.00	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	302.1000	303.1900	298.8800	9512000
4007	JPM	JPMorgan Chase & Co.	Financials	304.88	2026-05-12	810427820111.02	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	300.0200	306.0600	295.5500	9498200
4008	JPM	JPMorgan Chase & Co.	Financials	300.25	2026-05-13	798120405048.75	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	302.2700	303.0000	300.0700	7709500
4009	JPM	JPMorgan Chase & Co.	Financials	299.91	2026-05-14	797216631477.02	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	302.2500	303.7500	298.8100	7364300
4010	JPM	JPMorgan Chase & Co.	Financials	297.81	2026-05-15	791634424243.24	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	300.2100	300.7900	296.4500	8699300
4011	JPM	JPMorgan Chase & Co.	Financials	\N	2026-05-16	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4012	JPM	JPMorgan Chase & Co.	Financials	\N	2026-05-17	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4013	JPM	JPMorgan Chase & Co.	Financials	300.73	2026-05-18	799396363626.06	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	298.0000	301.2600	297.2200	7546300
4014	JPM	JPMorgan Chase & Co.	Financials	295.70	2026-05-19	786025690310.06	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	301.0900	301.7900	295.2600	8066900
4015	JPM	JPMorgan Chase & Co.	Financials	301.98	2026-05-20	802719096369.81	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	296.7000	302.9300	293.6700	9327000
4016	JPM	JPMorgan Chase & Co.	Financials	303.00	2026-05-21	805430417085.00	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	301.2300	303.9800	300.2100	7874400
4017	JPM	JPMorgan Chase & Co.	Financials	306.38	2026-05-22	814415099403.52	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	304.6800	307.4500	303.8400	5973900
4018	JPM	JPMorgan Chase & Co.	Financials	\N	2026-05-23	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4019	JPM	JPMorgan Chase & Co.	Financials	\N	2026-05-24	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4020	JPM	JPMorgan Chase & Co.	Financials	\N	2026-05-25	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4021	JPM	JPMorgan Chase & Co.	Financials	306.74	2026-05-26	815372007495.45	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	308.4900	309.9300	305.4400	7725400
4022	JPM	JPMorgan Chase & Co.	Financials	299.28	2026-05-27	795541961194.74	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	305.0000	305.9000	295.7500	11779200
4023	JPM	JPMorgan Chase & Co.	Financials	296.73	2026-05-28	788763618846.06	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	297.5700	301.0700	295.7500	9757700
4024	JPM	JPMorgan Chase & Co.	Financials	299.31	2026-05-29	795621703535.74	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	296.4000	299.8800	295.2000	13969000
4025	JPM	JPMorgan Chase & Co.	Financials	\N	2026-05-30	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4026	JPM	JPMorgan Chase & Co.	Financials	\N	2026-05-31	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4027	JPM	JPMorgan Chase & Co.	Financials	296.58	2026-06-01	788364826019.68	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	297.6900	299.5500	295.2700	7930000
4028	JPM	JPMorgan Chase & Co.	Financials	300.96	2026-06-02	800007694533.21	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	296.5000	302.0700	295.2700	8296200
4029	JPM	JPMorgan Chase & Co.	Financials	300.85	2026-06-03	799715332990.03	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	299.9200	301.9600	296.5600	7003900
4030	JPM	JPMorgan Chase & Co.	Financials	310.89	2026-06-04	826403545101.82	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	305.7400	312.9100	304.4400	10345200
4031	JPM	JPMorgan Chase & Co.	Financials	312.37	2026-06-05	830337608752.73	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	314.2900	315.0000	309.6000	9118800
4032	JPM	JPMorgan Chase & Co.	Financials	\N	2026-06-06	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4033	JPM	JPMorgan Chase & Co.	Financials	\N	2026-06-07	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4034	JPM	JPMorgan Chase & Co.	Financials	311.11	2026-06-08	826988268188.18	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	313.2500	316.3000	310.7800	6827000
4035	JPM	JPMorgan Chase & Co.	Financials	312.70	2026-06-09	831214855625.06	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	313.5100	316.4200	309.0100	11594600
4036	JPM	JPMorgan Chase & Co.	Financials	309.14	2026-06-10	821751719260.57	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	312.5600	314.7500	309.0300	7446200
4037	JPM	JPMorgan Chase & Co.	Financials	313.49	2026-06-11	833314764311.70	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	309.5600	314.7200	308.8800	9116600
4038	JPM	JPMorgan Chase & Co.	Financials	320.72	2026-06-12	852533479705.26	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	315.9700	321.3000	315.5500	7426200
4039	JPM	JPMorgan Chase & Co.	Financials	\N	2026-06-13	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4040	JPM	JPMorgan Chase & Co.	Financials	\N	2026-06-14	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4041	JPM	JPMorgan Chase & Co.	Financials	319.40	2026-06-15	849024654458.72	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	323.9200	325.9200	318.8400	7988900
4042	JPM	JPMorgan Chase & Co.	Financials	331.14	2026-06-16	880231815550.57	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	324.3000	331.7500	324.0200	11094900
4043	JPM	JPMorgan Chase & Co.	Financials	333.46	2026-06-17	886398745870.71	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	332.1800	337.7700	331.5000	12246400
4044	JPM	JPMorgan Chase & Co.	Financials	325.22	2026-06-18	864495317582.76	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	336.9500	338.0900	324.1600	20111000
4045	JPM	JPMorgan Chase & Co.	Financials	\N	2026-06-19	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4046	JPM	JPMorgan Chase & Co.	Financials	\N	2026-06-20	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4047	JPM	JPMorgan Chase & Co.	Financials	\N	2026-06-21	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4048	JPM	JPMorgan Chase & Co.	Financials	331.48	2026-06-22	881135589122.31	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	329.7000	332.7700	326.7500	10182500
4049	JPM	JPMorgan Chase & Co.	Financials	334.14	2026-06-23	888206374135.57	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	329.4700	335.3700	327.2100	7582200
4050	JPM	JPMorgan Chase & Co.	Financials	333.45	2026-06-24	886372219171.31	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	333.0700	334.5300	329.7700	7907400
4051	JPM	JPMorgan Chase & Co.	Financials	335.12	2026-06-25	890811344688.98	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	334.9600	343.4500	334.7600	10043100
4052	JPM	JPMorgan Chase & Co.	Financials	329.05	2026-06-26	874676135016.19	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	336.0000	336.4000	327.5000	17640900
4053	JPM	JPMorgan Chase & Co.	Financials	\N	2026-06-27	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4054	JPM	JPMorgan Chase & Co.	Financials	\N	2026-06-28	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4055	JPM	JPMorgan Chase & Co.	Financials	329.39	2026-06-29	875579989709.32	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	328.2800	332.3900	327.2000	7981800
4056	JPM	JPMorgan Chase & Co.	Financials	327.33	2026-06-30	870104051515.93	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	328.8900	330.4400	326.6800	8080100
4057	JPM	JPMorgan Chase & Co.	Financials	334.07	2026-07-01	888020281632.79	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	328.3700	335.6400	325.0100	15210200
4058	JPM	JPMorgan Chase & Co.	Financials	334.47	2026-07-02	889083539886.51	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	338.0200	340.0000	331.7700	8413900
4059	JPM	JPMorgan Chase & Co.	Financials	\N	2026-07-03	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4060	JPM	JPMorgan Chase & Co.	Financials	\N	2026-07-04	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4061	JPM	JPMorgan Chase & Co.	Financials	\N	2026-07-05	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4062	JPM	JPMorgan Chase & Co.	Financials	337.72	2026-07-06	897722645020.26	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	335.0000	339.7200	334.1100	8673500
4063	JPM	JPMorgan Chase & Co.	Financials	339.22	2026-07-07	901709924312.76	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	340.9800	341.4000	337.0900	7115800
4064	JPM	JPMorgan Chase & Co.	Financials	330.62	2026-07-08	878849506811.48	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	336.5300	336.5300	330.1300	18505200
4065	JPM	JPMorgan Chase & Co.	Financials	335.47	2026-07-09	891741726081.51	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	331.4600	337.0000	330.8100	15570600
4066	JPM	JPMorgan Chase & Co.	Financials	336.47	2026-07-10	894399912276.51	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	337.4700	338.5900	335.7700	6299000
4067	JPM	JPMorgan Chase & Co.	Financials	\N	2026-07-11	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4068	JPM	JPMorgan Chase & Co.	Financials	\N	2026-07-12	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4069	JPM	JPMorgan Chase & Co.	Financials	334.53	2026-07-13	889243024568.49	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	338.3400	338.3500	332.5000	7120300
4070	JPM	JPMorgan Chase & Co.	Financials	342.89	2026-07-14	911465503341.82	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	327.0000	344.7300	325.7500	14537900
4071	JPM	JPMorgan Chase & Co.	Financials	346.91	2026-07-15	922151382642.02	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	345.8500	351.2400	344.0500	10750000
4072	JPM	JPMorgan Chase & Co.	Financials	343.15	2026-07-16	912156576589.97	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	349.2800	349.3400	341.1100	12432400
4073	JPM	JPMorgan Chase & Co.	Financials	341.10	2026-07-17	906707327338.78	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	339.0300	346.1300	335.0500	9250900
4074	JPM	JPMorgan Chase & Co.	Financials	\N	2026-07-18	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4075	JPM	JPMorgan Chase & Co.	Financials	\N	2026-07-19	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4076	JPM	JPMorgan Chase & Co.	Financials	338.87	2026-07-20	900779542920.23	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	341.8000	344.2600	337.3700	7723300
4077	JPM	JPMorgan Chase & Co.	Financials	345.23	2026-07-21	917685649303.56	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	340.1200	345.7400	337.3000	6015300
4078	JPM	JPMorgan Chase & Co.	Financials	348.21	2026-07-22	925606992246.96	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	345.0700	349.0700	344.2500	8040200
4079	JPM	JPMorgan Chase & Co.	Financials	349.90	2026-07-23	930099333406.22	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	346.5800	349.9200	345.4200	10913000
4080	JPM	JPMorgan Chase & Co.	Financials	353.21	2026-07-24	938897923221.96	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	350.6400	353.3700	347.5000	7520800
4081	JPM	JPMorgan Chase & Co.	Financials	\N	2026-07-25	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4082	JPM	JPMorgan Chase & Co.	Financials	\N	2026-07-26	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4083	JPM	JPMorgan Chase & Co.	Financials	356.20	2026-07-27	946845955107.56	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	357.8900	359.0500	352.5800	7884900
4084	JPM	JPMorgan Chase & Co.	Financials	357.31	2026-07-28	949796502845.74	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	357.3000	359.3000	354.1500	6533800
4085	JPM	JPMorgan Chase & Co.	Financials	344.71	2026-07-29	916303340564.46	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	356.5000	357.3700	343.7800	8265300
4086	JPM	JPMorgan Chase & Co.	Financials	350.85	2026-07-30	932624642740.03	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	347.5400	352.2800	345.3700	7606500
4087	JPM	JPMorgan Chase & Co.	Financials	351.79	2026-07-31	935123344253.04	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	353.3000	354.4700	349.7000	6603400
4088	JPM	JPMorgan Chase & Co.	Financials	\N	2026-08-01	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4089	JPM	JPMorgan Chase & Co.	Financials	\N	2026-08-02	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4090	JPM	JPMorgan Chase & Co.	Financials	352.64	2026-08-03	937382818743.07	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	353.7500	355.6200	350.8400	6436600
4091	JPM	JPMorgan Chase & Co.	Financials	357.52	2026-08-04	950354699232.69	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	355.0000	363.0000	353.8700	8477200
4092	JPM	JPMorgan Chase & Co.	Financials	359.24	2026-08-05	954926782732.95	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	358.9700	362.1700	358.2000	5269500
4093	JPM	JPMorgan Chase & Co.	Financials	356.30	2026-08-06	947111708829.94	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	362.8100	362.8100	354.9500	5820100
4094	JPM	JPMorgan Chase & Co.	Financials	357.52	2026-08-07	950354699232.69	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	355.7600	358.8500	353.3300	4566200
4095	JPM	JPMorgan Chase & Co.	Financials	\N	2026-08-08	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4096	JPM	JPMorgan Chase & Co.	Financials	\N	2026-08-09	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4097	JPM	JPMorgan Chase & Co.	Financials	359.79	2026-08-10	956388833813.04	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	357.9600	359.9900	356.5000	5327500
4098	JPM	JPMorgan Chase & Co.	Financials	362.04	2026-08-11	962369752751.79	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	360.0500	363.1200	358.6000	4576500
4099	JPM	JPMorgan Chase & Co.	Financials	365.18	2026-08-12	970716415220.96	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	362.9700	366.0900	361.3000	4366800
4100	JPM	JPMorgan Chase & Co.	Financials	363.11	2026-08-13	965213950328.18	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	366.5000	366.5000	361.5200	5102700
4101	JPM	JPMorgan Chase & Co.	Financials	362.84	2026-08-14	964496269259.23	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	363.0000	365.9000	361.4500	5058600
4102	JPM	JPMorgan Chase & Co.	Financials	\N	2026-08-15	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4103	JPM	JPMorgan Chase & Co.	Financials	\N	2026-08-16	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4104	JPM	JPMorgan Chase & Co.	Financials	360.96	2026-08-17	959498866233.21	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	361.9400	365.7500	360.9600	5282600
4105	JPM	JPMorgan Chase & Co.	Financials	363.25	2026-08-18	965586135333.75	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	362.3400	363.5700	359.2700	5525100
4106	JPM	JPMorgan Chase & Co.	Financials	357.26	2026-08-19	949663625984.55	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	363.0100	363.0500	355.6500	6696200
4107	JPM	JPMorgan Chase & Co.	Financials	351.55	2026-08-20	934485324403.69	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	357.6000	357.9500	351.5500	6799700
4108	JPM	JPMorgan Chase & Co.	Financials	351.58	2026-08-21	934565066744.68	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	354.0700	356.8600	350.3700	8112100
4109	JPM	JPMorgan Chase & Co.	Financials	\N	2026-08-22	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4110	JPM	JPMorgan Chase & Co.	Financials	\N	2026-08-23	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4111	JPM	JPMorgan Chase & Co.	Financials	356.39	2026-08-24	947351016974.32	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	353.3000	358.2800	352.8200	4394400
4112	JPM	JPMorgan Chase & Co.	Financials	356.69	2026-08-25	948148440384.26	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	357.0000	357.3700	353.0700	4298000
4113	JPM	JPMorgan Chase & Co.	Financials	356.50	2026-08-26	947643378517.50	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	356.5000	358.3500	354.6000	5796500
4114	JPM	JPMorgan Chase & Co.	Financials	354.22	2026-08-27	941582717237.76	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	354.6800	357.5700	352.2300	5209900
4115	JPM	JPMorgan Chase & Co.	Financials	357.62	2026-08-28	950620534076.48	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	355.6700	358.7300	354.2200	3914500
4116	JPM	JPMorgan Chase & Co.	Financials	\N	2026-08-29	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4117	JPM	JPMorgan Chase & Co.	Financials	\N	2026-08-30	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4118	JPM	JPMorgan Chase & Co.	Financials	356.02	2026-08-31	946367419940.19	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	355.9000	357.7700	354.7700	7962900
4119	JPM	JPMorgan Chase & Co.	Financials	354.95	2026-09-01	943523222363.81	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	355.7300	359.9300	354.1200	5079000
4120	JPM	JPMorgan Chase & Co.	Financials	356.22	2026-09-02	946899089627.76	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	357.5500	361.4700	353.7900	5341400
4121	JPM	JPMorgan Chase & Co.	Financials	362.06	2026-09-03	962422887271.99	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	358.6800	362.8500	356.3900	5414200
4122	JPM	JPMorgan Chase & Co.	Financials	358.64	2026-09-04	953331935913.07	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	361.0000	362.8600	355.2000	4873500
4123	JPM	JPMorgan Chase & Co.	Financials	\N	2026-09-05	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4124	JPM	JPMorgan Chase & Co.	Financials	\N	2026-09-06	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4125	JPM	JPMorgan Chase & Co.	Financials	\N	2026-09-07	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4126	JPM	JPMorgan Chase & Co.	Financials	353.51	2026-09-08	939695427753.30	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	357.1000	358.5500	353.2300	5631400
4127	JPM	JPMorgan Chase & Co.	Financials	354.71	2026-09-09	942885202514.46	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	352.0000	356.3300	348.6900	6318200
4128	JPM	JPMorgan Chase & Co.	Financials	353.56	2026-09-10	939828304614.49	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	353.5100	354.2200	351.1200	4184200
4129	JPM	JPMorgan Chase & Co.	Financials	356.23	2026-09-11	946925697448.56	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	358.3200	360.0500	354.7900	5354600
4130	JPM	JPMorgan Chase & Co.	Financials	\N	2026-09-12	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4131	JPM	JPMorgan Chase & Co.	Financials	\N	2026-09-13	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4132	JPM	JPMorgan Chase & Co.	Financials	350.13	2026-09-14	930710745434.77	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	354.2300	355.2800	347.5500	9609900
4133	JPM	JPMorgan Chase & Co.	Financials	352.49	2026-09-15	936984025916.70	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	351.0000	354.7000	343.0700	14026500
4134	JPM	JPMorgan Chase & Co.	Financials	348.92	2026-09-16	927494362852.82	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	353.3800	355.6000	344.6900	8303400
4135	JPM	JPMorgan Chase & Co.	Financials	349.31	2026-09-17	928531013285.74	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	352.2500	353.4900	345.2700	6480100
4136	JPM	JPMorgan Chase & Co.	Financials	349.67	2026-09-18	929488002499.07	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	347.8900	349.6700	345.0100	18312400
4137	JPM	JPMorgan Chase & Co.	Financials	\N	2026-09-19	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4138	JPM	JPMorgan Chase & Co.	Financials	\N	2026-09-20	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4139	JPM	JPMorgan Chase & Co.	Financials	352.04	2026-09-21	935787890801.79	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	353.6700	354.5000	350.0800	6414700
4140	JPM	JPMorgan Chase & Co.	Financials	340.00	2026-09-22	903783306300.00	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	352.0000	352.1000	337.3000	11485600
4141	JPM	JPMorgan Chase & Co.	Financials	337.53	2026-09-23	897217583153.49	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	337.6100	341.4400	336.9800	7068500
4142	JPM	JPMorgan Chase & Co.	Financials	338.56	2026-09-24	899955511689.49	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	338.1200	339.3700	335.2800	6934300
4143	JPM	JPMorgan Chase & Co.	Financials	343.06	2026-09-25	911917349566.99	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	340.7700	343.3100	338.6400	11460300
4144	JPM	JPMorgan Chase & Co.	Financials	\N	2026-09-26	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4145	JPM	JPMorgan Chase & Co.	Financials	\N	2026-09-27	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4146	JPM	JPMorgan Chase & Co.	Financials	336.59	2026-09-28	894718881640.48	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	341.8300	342.0000	336.3000	10483700
4147	JPM	JPMorgan Chase & Co.	Financials	334.98	2026-09-29	890439240804.81	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	337.0000	338.7500	333.3300	7254900
4148	JPM	JPMorgan Chase & Co.	Financials	330.83	2026-09-30	879407703198.43	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	334.8900	336.3400	330.8300	9113300
4149	JPM	JPMorgan Chase & Co.	Financials	333.18	2026-10-01	885654456980.96	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	328.7500	333.5800	325.8700	8160000
4150	JPM	JPMorgan Chase & Co.	Financials	332.38	2026-10-02	883527940473.52	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	334.0000	334.8500	330.0000	6658200
4151	JPM	JPMorgan Chase & Co.	Financials	\N	2026-10-03	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4152	JPM	JPMorgan Chase & Co.	Financials	\N	2026-10-04	\N	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	\N	\N	\N	\N
4153	JPM	JPMorgan Chase & Co.	Financials	332.38	2026-10-05	883527940473.52	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	333.3100	333.7500	330.5900	5346100
4154	JPM	JPMorgan Chase & Co.	Financials	331.28	2026-10-06	880603919434.74	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	332.7300	333.7900	330.9300	6286800
4155	JPM	JPMorgan Chase & Co.	Financials	329.58	2026-10-07	876084970454.68	2026-10-08 20:55:10.361	2026-10-08 20:55:10.361	327.2000	329.8700	325.0700	7003000
4157	V	Visa Inc.	Financials	\N	2026-01-01	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4158	V	Visa Inc.	Financials	346.48	2026-01-02	590440984939.06	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	349.8700	350.0500	343.4800	5403800
4159	V	Visa Inc.	Financials	\N	2026-01-03	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4160	V	Visa Inc.	Financials	\N	2026-01-04	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4161	V	Visa Inc.	Financials	353.80	2026-01-05	602915050335.04	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	344.5000	357.5400	344.0500	7592200
4162	V	Visa Inc.	Financials	357.56	2026-01-06	609322530706.21	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	353.6800	358.6200	352.0000	6775400
4163	V	Visa Inc.	Financials	355.88	2026-01-07	606459633861.58	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	357.1500	358.2800	354.5100	6333900
4164	V	Visa Inc.	Financials	352.23	2026-01-08	600239632929.56	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	355.0000	356.3500	349.5000	6357600
4165	V	Visa Inc.	Financials	349.77	2026-01-09	596047478258.44	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	352.1600	354.7000	349.1600	4902900
4166	V	Visa Inc.	Financials	\N	2026-01-10	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4167	V	Visa Inc.	Financials	\N	2026-01-11	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4168	V	Visa Inc.	Financials	343.20	2026-01-12	584851497382.96	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	342.7800	346.5100	337.3200	13281300
4169	V	Visa Inc.	Financials	327.88	2026-01-13	558744478429.58	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	337.0000	337.5200	323.8300	20383500
4170	V	Visa Inc.	Financials	329.17	2026-01-14	560942798366.35	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	328.6600	329.9000	323.9400	9388400
4171	V	Visa Inc.	Financials	327.75	2026-01-15	558522935458.50	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	329.3300	331.6900	326.3700	8587700
4172	V	Visa Inc.	Financials	328.30	2026-01-16	559460176638.04	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	326.7800	329.2500	325.4000	8341600
4173	V	Visa Inc.	Financials	\N	2026-01-17	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4174	V	Visa Inc.	Financials	\N	2026-01-18	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4175	V	Visa Inc.	Financials	\N	2026-01-19	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4176	V	Visa Inc.	Financials	325.82	2026-01-20	555234010440.37	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	322.2300	328.3200	321.5600	8279900
4177	V	Visa Inc.	Financials	325.28	2026-01-21	554313775024.10	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	326.4300	328.6700	323.0000	8974600
4178	V	Visa Inc.	Financials	326.36	2026-01-22	556154193851.25	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	326.4600	328.3900	324.0000	6938700
4179	V	Visa Inc.	Financials	326.18	2026-01-23	555847466047.63	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	325.8600	327.8000	324.6200	5667900
4180	V	Visa Inc.	Financials	\N	2026-01-24	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4181	V	Visa Inc.	Financials	\N	2026-01-25	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4182	V	Visa Inc.	Financials	328.49	2026-01-26	559783962210.33	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	328.0000	332.0000	325.0300	7540200
4183	V	Visa Inc.	Financials	325.26	2026-01-27	554279711492.17	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	328.4800	328.9300	324.9100	6365800
4184	V	Visa Inc.	Financials	326.98	2026-01-28	557210787406.06	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	326.7300	328.3900	324.8800	8106000
4185	V	Visa Inc.	Financials	331.80	2026-01-29	565424571067.04	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	330.0000	333.3600	323.5100	10214200
4186	V	Visa Inc.	Financials	321.83	2026-01-30	548434565427.65	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	332.2200	333.0000	321.6000	11199100
4187	V	Visa Inc.	Financials	\N	2026-01-31	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4188	V	Visa Inc.	Financials	\N	2026-02-01	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4189	V	Visa Inc.	Financials	333.84	2026-02-02	568900975524.31	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	324.8300	334.6900	324.1100	8502400
4190	V	Visa Inc.	Financials	328.93	2026-02-03	560533775956.13	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	331.6500	335.7900	328.8700	9081200
4191	V	Visa Inc.	Financials	329.95	2026-02-04	562272004187.46	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	327.1100	331.3100	324.4200	8472300
4192	V	Visa Inc.	Financials	329.13	2026-02-05	560874619297.08	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	333.0000	337.5900	328.8200	8339000
4193	V	Visa Inc.	Financials	331.58	2026-02-06	565049664194.15	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	331.7800	335.1300	327.1000	7798800
4194	V	Visa Inc.	Financials	\N	2026-02-07	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4195	V	Visa Inc.	Financials	\N	2026-02-08	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4196	V	Visa Inc.	Financials	325.58	2026-02-09	554824988030.15	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	330.7600	332.8200	323.6200	8513400
4197	V	Visa Inc.	Financials	328.17	2026-02-10	559238685672.35	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	324.7100	329.8800	324.5500	5801800
4198	V	Visa Inc.	Financials	329.24	2026-02-11	561062046730.83	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	326.9200	331.0400	326.4200	8264300
4199	V	Visa Inc.	Financials	324.18	2026-02-12	552439240659.63	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	328.8900	332.2400	324.0000	9392600
4200	V	Visa Inc.	Financials	314.08	2026-02-13	535227692049.15	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	323.8300	326.4800	312.8200	11653900
4201	V	Visa Inc.	Financials	\N	2026-02-14	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4202	V	Visa Inc.	Financials	\N	2026-02-15	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4203	V	Visa Inc.	Financials	\N	2026-02-16	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4204	V	Visa Inc.	Financials	319.50	2026-02-17	544464005733.00	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	314.4100	321.3800	314.4100	8591700
4205	V	Visa Inc.	Financials	320.30	2026-02-18	545827275086.04	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	319.5000	322.2800	316.7200	7091900
4206	V	Visa Inc.	Financials	318.93	2026-02-19	543492649016.13	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	317.4900	320.2000	315.7300	5967600
4207	V	Visa Inc.	Financials	320.95	2026-02-20	546934989941.46	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	318.1100	322.3500	317.8200	6831100
4208	V	Visa Inc.	Financials	\N	2026-02-21	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4209	V	Visa Inc.	Financials	\N	2026-02-22	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4210	V	Visa Inc.	Financials	306.52	2026-02-23	522344604242.94	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	319.0400	320.5200	304.7100	13048000
4211	V	Visa Inc.	Financials	307.22	2026-02-24	523537503930.90	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	305.5000	309.2700	303.0800	9120200
4212	V	Visa Inc.	Financials	312.99	2026-02-25	533370215453.33	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	308.5500	313.9400	308.2500	7624200
4213	V	Visa Inc.	Financials	316.70	2026-02-26	539692510991.96	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	314.4800	319.4200	313.9400	8725500
4214	V	Visa Inc.	Financials	320.14	2026-02-27	545554662819.75	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	314.4600	320.2300	311.9500	12412900
4215	V	Visa Inc.	Financials	\N	2026-02-28	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4216	V	Visa Inc.	Financials	\N	2026-03-01	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4217	V	Visa Inc.	Financials	320.51	2026-03-02	546185176195.67	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	315.5000	322.6000	314.6000	6674900
4218	V	Visa Inc.	Financials	320.83	2026-03-03	546730452733.65	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	315.8100	322.0400	314.3500	5474300
4219	V	Visa Inc.	Financials	320.47	2026-03-04	546116997126.40	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	321.4400	325.7700	319.8000	5257900
4220	V	Visa Inc.	Financials	319.80	2026-03-05	544975218739.04	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	319.3300	322.8000	314.7700	8267200
4221	V	Visa Inc.	Financials	317.36	2026-03-06	540817179605.25	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	316.0500	317.6900	312.3000	6439700
4222	V	Visa Inc.	Financials	\N	2026-03-07	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4223	V	Visa Inc.	Financials	\N	2026-03-08	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4224	V	Visa Inc.	Financials	315.97	2026-03-09	538448490003.40	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	313.4600	316.4000	310.1500	8381500
4225	V	Visa Inc.	Financials	314.43	2026-03-10	535824141893.13	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	315.4300	317.1300	311.4500	5271300
4226	V	Visa Inc.	Financials	308.96	2026-03-11	526502643376.73	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	313.2500	315.0800	308.3900	6376700
4227	V	Visa Inc.	Financials	306.50	2026-03-12	522310540711.00	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	308.1400	310.9500	306.0200	7514900
4228	V	Visa Inc.	Financials	307.14	2026-03-13	523401197797.75	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	307.5900	310.3500	306.4200	4814100
4229	V	Visa Inc.	Financials	\N	2026-03-14	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4230	V	Visa Inc.	Financials	\N	2026-03-15	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4231	V	Visa Inc.	Financials	310.11	2026-03-16	528462362573.75	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	307.8500	311.1300	307.3800	6401200
4232	V	Visa Inc.	Financials	308.46	2026-03-17	525650587029.73	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	311.3200	312.6900	307.3800	6872200
4233	V	Visa Inc.	Financials	299.02	2026-03-18	509563759037.94	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	307.4100	307.9400	298.5000	7191700
4234	V	Visa Inc.	Financials	299.71	2026-03-19	510739600957.23	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	298.0400	302.4700	297.0300	6826400
4235	V	Visa Inc.	Financials	301.62	2026-03-20	513994462443.42	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	299.8500	302.9200	299.0100	14398100
4236	V	Visa Inc.	Financials	\N	2026-03-21	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4237	V	Visa Inc.	Financials	\N	2026-03-22	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4238	V	Visa Inc.	Financials	304.44	2026-03-23	518800072721.79	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	305.2000	307.8500	302.8500	7824500
4239	V	Visa Inc.	Financials	303.76	2026-03-24	517641288571.17	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	302.0000	306.0400	300.6200	5375900
4240	V	Visa Inc.	Financials	304.91	2026-03-25	519601007768.19	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	305.4800	308.4900	302.1700	6280900
4241	V	Visa Inc.	Financials	305.53	2026-03-26	520657549317.60	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	304.1600	307.8700	303.0000	7652700
4242	V	Visa Inc.	Financials	295.52	2026-03-27	503599364608.94	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	304.3200	304.5900	294.3200	9974400
4243	V	Visa Inc.	Financials	\N	2026-03-28	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4244	V	Visa Inc.	Financials	\N	2026-03-29	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4245	V	Visa Inc.	Financials	299.54	2026-03-30	510449930922.27	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	298.7300	300.6800	295.8900	9330300
4246	V	Visa Inc.	Financials	302.24	2026-03-31	515051003992.83	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	301.6000	303.3400	296.5900	10246900
4247	V	Visa Inc.	Financials	298.51	2026-04-01	508694696927.67	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	305.0500	305.0500	293.8900	7707600
4248	V	Visa Inc.	Financials	300.80	2026-04-02	512597077553.04	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	297.8000	302.4700	295.8500	4376000
4249	V	Visa Inc.	Financials	\N	2026-04-03	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4250	V	Visa Inc.	Financials	\N	2026-04-04	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4251	V	Visa Inc.	Financials	\N	2026-04-05	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4252	V	Visa Inc.	Financials	303.33	2026-04-06	516908480588.65	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	300.7400	304.4200	299.4600	5501000
4253	V	Visa Inc.	Financials	302.55	2026-04-07	515579274767.54	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	302.4400	304.9800	301.1200	4413900
4254	V	Visa Inc.	Financials	308.96	2026-04-08	526502643376.73	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	307.7300	311.0800	307.7000	6879300
4255	V	Visa Inc.	Financials	308.29	2026-04-09	525360916994.77	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	308.0000	309.5800	303.5900	4811500
4256	V	Visa Inc.	Financials	304.36	2026-04-10	518663714583.25	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	308.7100	309.0000	303.5100	5190000
4257	V	Visa Inc.	Financials	\N	2026-04-11	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4258	V	Visa Inc.	Financials	\N	2026-04-12	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4259	V	Visa Inc.	Financials	309.39	2026-04-13	527235451359.25	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	303.9300	309.7500	302.3400	6787200
4260	V	Visa Inc.	Financials	311.37	2026-04-14	530609561209.92	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	308.4700	312.1200	307.4900	5571000
4261	V	Visa Inc.	Financials	315.91	2026-04-15	538346247402.19	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	313.0000	316.7300	311.5200	4831400
4262	V	Visa Inc.	Financials	315.10	2026-04-16	536965920280.48	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	316.3500	318.0000	314.5700	5695800
4263	V	Visa Inc.	Financials	317.02	2026-04-17	540237787529.94	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	316.6000	319.4400	315.1800	8082300
4264	V	Visa Inc.	Financials	\N	2026-04-18	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4265	V	Visa Inc.	Financials	\N	2026-04-19	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4266	V	Visa Inc.	Financials	313.94	2026-04-20	534989143314.79	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	316.4000	317.5500	312.3500	5506800
4267	V	Visa Inc.	Financials	309.94	2026-04-21	528172692538.79	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	314.0100	316.8900	308.8200	6806900
4268	V	Visa Inc.	Financials	311.29	2026-04-22	530473255076.77	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	311.0100	311.3600	308.0600	5666600
4269	V	Visa Inc.	Financials	308.88	2026-04-23	526366337243.58	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	310.5000	312.2000	305.0100	7275000
4270	V	Visa Inc.	Financials	309.42	2026-04-24	527286572659.85	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	307.1000	309.9800	304.5000	5616900
4271	V	Visa Inc.	Financials	\N	2026-04-25	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4272	V	Visa Inc.	Financials	\N	2026-04-26	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4273	V	Visa Inc.	Financials	309.65	2026-04-27	527678485296.02	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	307.5100	310.8200	306.0600	6261500
4274	V	Visa Inc.	Financials	309.30	2026-04-28	527082035452.04	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	312.2000	313.9600	308.7400	8839900
4275	V	Visa Inc.	Financials	334.86	2026-04-29	570639151750.25	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	336.4000	341.9800	333.7900	16658600
4276	V	Visa Inc.	Financials	329.84	2026-04-30	562084524748.31	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	332.1200	332.5000	328.0800	11241100
4277	V	Visa Inc.	Financials	328.03	2026-05-01	559000084932.60	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	332.8800	335.8500	327.9300	6726100
4278	V	Visa Inc.	Financials	\N	2026-05-02	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4279	V	Visa Inc.	Financials	\N	2026-05-03	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4280	V	Visa Inc.	Financials	326.85	2026-05-04	556989244434.98	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	328.0000	329.7900	325.4000	6712400
4281	V	Visa Inc.	Financials	322.03	2026-05-05	548775408768.60	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	325.1100	325.5800	319.6500	5893200
4282	V	Visa Inc.	Financials	318.80	2026-05-06	543271106045.04	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	323.7500	324.5800	318.0000	7808400
4283	V	Visa Inc.	Financials	321.28	2026-05-07	547497324248.10	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	319.5400	323.6900	319.5400	7186100
4284	V	Visa Inc.	Financials	318.79	2026-05-08	543254100281.77	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	320.9900	321.0700	316.1600	5950200
4285	V	Visa Inc.	Financials	\N	2026-05-09	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4286	V	Visa Inc.	Financials	\N	2026-05-10	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4287	V	Visa Inc.	Financials	323.86	2026-05-11	551893912116.25	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	319.1000	325.1800	318.0100	9586200
4288	V	Visa Inc.	Financials	326.42	2026-05-12	556256488457.85	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	324.3200	328.9100	324.2000	6235200
4289	V	Visa Inc.	Financials	320.31	2026-05-13	545844332854.71	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	323.7900	325.4200	319.8000	7950400
4290	V	Visa Inc.	Financials	322.52	2026-05-14	549610407346.94	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	321.3700	323.3300	320.2500	5277400
4291	V	Visa Inc.	Financials	325.75	2026-05-15	555114710070.50	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	324.0000	329.0100	323.8400	6054500
4292	V	Visa Inc.	Financials	\N	2026-05-16	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4293	V	Visa Inc.	Financials	\N	2026-05-17	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4294	V	Visa Inc.	Financials	332.64	2026-05-18	566856071494.75	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	324.4300	333.4300	323.7700	5305800
4295	V	Visa Inc.	Financials	329.91	2026-05-19	562203825118.19	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	333.3300	335.1700	329.4900	12858100
4296	V	Visa Inc.	Financials	330.75	2026-05-20	563635273540.50	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	330.0900	331.6600	326.8200	9422500
4297	V	Visa Inc.	Financials	331.12	2026-05-21	564265786916.42	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	329.8400	332.5200	327.2400	7034500
4298	V	Visa Inc.	Financials	328.88	2026-05-22	560448591123.58	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	330.5200	333.4300	328.8200	7462100
4299	V	Visa Inc.	Financials	\N	2026-05-23	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4300	V	Visa Inc.	Financials	\N	2026-05-24	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4301	V	Visa Inc.	Financials	\N	2026-05-25	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4302	V	Visa Inc.	Financials	326.48	2026-05-26	556358731059.06	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	326.4600	328.5000	324.5100	8705100
4303	V	Visa Inc.	Financials	327.61	2026-05-27	558284334718.75	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	325.8300	331.4600	325.6600	5917400
4304	V	Visa Inc.	Financials	324.95	2026-05-28	553751440717.46	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	326.0100	327.0800	320.9000	8105400
4305	V	Visa Inc.	Financials	326.36	2026-05-29	556154193851.25	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	325.5000	331.6700	325.3500	14104500
4306	V	Visa Inc.	Financials	\N	2026-05-30	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4307	V	Visa Inc.	Financials	\N	2026-05-31	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4308	V	Visa Inc.	Financials	322.77	2026-06-01	550036435520.44	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	327.2600	327.8600	318.6800	10079300
4309	V	Visa Inc.	Financials	317.32	2026-06-02	540749052541.37	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	322.5100	323.5000	313.3900	10125300
4310	V	Visa Inc.	Financials	312.40	2026-06-03	532364795204.52	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	317.6500	317.6500	309.0000	8992800
4311	V	Visa Inc.	Financials	320.18	2026-06-04	545622789883.63	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	316.7900	324.7600	316.7000	6981700
4312	V	Visa Inc.	Financials	323.57	2026-06-05	551399756878.87	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	322.4000	325.9800	320.9700	7176300
4313	V	Visa Inc.	Financials	\N	2026-06-06	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4314	V	Visa Inc.	Financials	\N	2026-06-07	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4315	V	Visa Inc.	Financials	319.67	2026-06-08	544753727773.35	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	321.3500	323.9200	318.4300	5582000
4316	V	Visa Inc.	Financials	325.05	2026-06-09	553921810382.54	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	318.6600	325.4900	317.0000	6340400
4317	V	Visa Inc.	Financials	322.96	2026-06-10	550360221092.73	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	326.6200	326.9000	320.1800	5793100
4318	V	Visa Inc.	Financials	319.05	2026-06-11	543697134218.54	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	322.0000	323.7100	317.9600	5958900
4319	V	Visa Inc.	Financials	322.39	2026-06-12	549388916381.25	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	321.7600	325.9300	319.8000	5543200
4320	V	Visa Inc.	Financials	\N	2026-06-13	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4321	V	Visa Inc.	Financials	\N	2026-06-14	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4322	V	Visa Inc.	Financials	323.82	2026-06-15	551825785052.37	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	323.3600	326.4400	322.7500	6803000
4323	V	Visa Inc.	Financials	333.12	2026-06-16	567674012304.42	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	325.6900	333.2900	324.3800	9248400
4324	V	Visa Inc.	Financials	330.38	2026-06-17	563004760164.58	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	333.5000	336.8200	329.9700	6895200
4325	V	Visa Inc.	Financials	327.24	2026-06-18	557653821342.83	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	331.0000	332.3300	327.0000	14716700
4326	V	Visa Inc.	Financials	\N	2026-06-19	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4327	V	Visa Inc.	Financials	\N	2026-06-20	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4328	V	Visa Inc.	Financials	\N	2026-06-21	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4329	V	Visa Inc.	Financials	326.60	2026-06-22	556563216261.48	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	328.3300	333.0000	325.8600	15132400
4330	V	Visa Inc.	Financials	328.48	2026-06-23	559766956447.06	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	328.8200	331.2800	328.0900	11113400
4331	V	Visa Inc.	Financials	332.23	2026-06-24	566157379049.56	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	329.0000	334.8000	327.2200	8197200
4332	V	Visa Inc.	Financials	330.52	2026-06-25	563243308898.94	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	332.5600	339.9400	330.0700	7050200
4333	V	Visa Inc.	Financials	336.23	2026-06-26	572973829825.56	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	332.2400	339.7200	331.4400	16717400
4334	V	Visa Inc.	Financials	\N	2026-06-27	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4335	V	Visa Inc.	Financials	\N	2026-06-28	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4336	V	Visa Inc.	Financials	341.65	2026-06-29	582210091504.02	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	338.2700	345.8100	338.2700	11710900
4337	V	Visa Inc.	Financials	343.09	2026-06-30	584664017943.81	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	341.7600	344.2900	339.0800	7957900
4338	V	Visa Inc.	Financials	351.08	2026-07-01	598279861727.15	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	344.5600	353.3600	340.9800	13025900
4339	V	Visa Inc.	Financials	362.13	2026-07-02	617110338199.08	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	352.5100	362.1300	352.5100	9814800
4340	V	Visa Inc.	Financials	\N	2026-07-03	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4341	V	Visa Inc.	Financials	\N	2026-07-04	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4342	V	Visa Inc.	Financials	\N	2026-07-05	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4343	V	Visa Inc.	Financials	357.25	2026-07-06	608794259931.50	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	363.0000	365.0200	348.8500	11623800
4344	V	Visa Inc.	Financials	352.20	2026-07-07	600188511628.96	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	348.3900	356.0800	346.9200	7332500
4345	V	Visa Inc.	Financials	347.53	2026-07-08	592230282465.60	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	350.3000	351.6000	345.6900	10215200
4346	V	Visa Inc.	Financials	348.20	2026-07-09	593372060852.96	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	345.3000	348.5000	344.4200	6606300
4347	V	Visa Inc.	Financials	348.97	2026-07-10	594684208905.40	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	350.6300	351.1700	345.3300	4702800
4348	V	Visa Inc.	Financials	\N	2026-07-11	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4349	V	Visa Inc.	Financials	\N	2026-07-12	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4350	V	Visa Inc.	Financials	357.75	2026-07-13	609646316278.50	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	351.7300	359.4900	351.0500	9964600
4351	V	Visa Inc.	Financials	356.02	2026-07-14	606698182595.94	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	355.7700	359.9400	353.6800	6632400
4352	V	Visa Inc.	Financials	355.14	2026-07-15	605198607109.75	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	354.0000	360.4300	349.1200	8850000
4353	V	Visa Inc.	Financials	365.14	2026-07-16	622239734049.75	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	358.0400	365.1400	357.1100	9073200
4354	V	Visa Inc.	Financials	358.56	2026-07-17	611026643400.21	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	363.5700	364.6300	357.0000	7400400
4355	V	Visa Inc.	Financials	\N	2026-07-18	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4356	V	Visa Inc.	Financials	\N	2026-07-19	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4357	V	Visa Inc.	Financials	360.57	2026-07-20	614451926556.87	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	357.1000	363.0000	356.4300	7616800
4358	V	Visa Inc.	Financials	355.82	2026-07-21	606357391260.37	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	356.9900	359.1200	354.6900	6027300
4359	V	Visa Inc.	Financials	353.42	2026-07-22	602267531195.85	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	356.5700	357.5300	352.2700	4622200
4360	V	Visa Inc.	Financials	351.60	2026-07-23	599166033611.48	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	352.0500	352.0500	348.5000	4183300
4361	V	Visa Inc.	Financials	355.74	2026-07-24	606221033121.83	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	353.4700	355.8400	351.0500	4482800
4362	V	Visa Inc.	Financials	\N	2026-07-25	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4363	V	Visa Inc.	Financials	\N	2026-07-26	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4364	V	Visa Inc.	Financials	362.53	2026-07-27	617791972875.60	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	359.3500	363.6600	358.2500	6631100
4365	V	Visa Inc.	Financials	366.59	2026-07-28	624710666252.81	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	365.0600	371.1600	362.7300	11061900
4366	V	Visa Inc.	Financials	368.73	2026-07-29	628357492380.56	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	357.0000	373.9700	355.4800	11289900
4367	V	Visa Inc.	Financials	366.27	2026-07-30	624165337709.44	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	365.0000	367.0000	360.7500	8391400
4368	V	Visa Inc.	Financials	366.13	2026-07-31	623926788975.08	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	363.7600	366.8800	360.1000	7828400
4369	V	Visa Inc.	Financials	\N	2026-08-01	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4370	V	Visa Inc.	Financials	\N	2026-08-02	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4371	V	Visa Inc.	Financials	365.67	2026-08-03	623142911697.35	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	368.5000	371.9700	364.3500	5521300
4372	V	Visa Inc.	Financials	369.59	2026-08-04	629823004334.81	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	361.7600	371.1100	360.0900	7497500
4373	V	Visa Inc.	Financials	368.54	2026-08-05	628033706808.27	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	372.3000	372.4000	366.7200	6065300
4374	V	Visa Inc.	Financials	370.47	2026-08-06	631322631826.40	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	369.5700	371.1000	365.2500	5022300
4375	V	Visa Inc.	Financials	362.50	2026-08-07	617740851575.00	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	368.5100	370.2500	361.5200	5112500
4376	V	Visa Inc.	Financials	\N	2026-08-08	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4377	V	Visa Inc.	Financials	\N	2026-08-09	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4378	V	Visa Inc.	Financials	361.32	2026-08-10	615730011077.37	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	362.0000	364.1700	358.8700	7552200
4379	V	Visa Inc.	Financials	362.82	2026-08-11	618286180118.37	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	360.9800	364.5500	359.9700	4440900
4380	V	Visa Inc.	Financials	359.42	2026-08-12	612492207359.85	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	361.0000	363.3500	358.3100	3794200
4381	V	Visa Inc.	Financials	365.45	2026-08-13	622768004824.46	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	363.7000	365.4500	358.7100	8142600
4382	V	Visa Inc.	Financials	364.15	2026-08-14	620552627119.02	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	365.8900	366.8000	362.7600	8106900
4383	V	Visa Inc.	Financials	\N	2026-08-15	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4384	V	Visa Inc.	Financials	\N	2026-08-16	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4385	V	Visa Inc.	Financials	358.84	2026-08-17	611503792874.31	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	362.8400	363.5600	358.5200	15543400
4386	V	Visa Inc.	Financials	364.25	2026-08-18	620723048789.50	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	359.6200	365.9100	358.0500	6820300
4387	V	Visa Inc.	Financials	365.54	2026-08-19	622921368726.27	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	364.0900	370.6400	362.9000	5866400
4388	V	Visa Inc.	Financials	365.73	2026-08-20	623245154298.56	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	365.1000	368.9300	363.6300	6151500
4389	V	Visa Inc.	Financials	371.04	2026-08-21	632293988543.27	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	367.8700	371.8000	366.6600	6667100
4390	V	Visa Inc.	Financials	\N	2026-08-22	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4391	V	Visa Inc.	Financials	\N	2026-08-23	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4392	V	Visa Inc.	Financials	382.41	2026-08-24	651669741553.19	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	373.2600	383.4300	372.2100	8477500
4393	V	Visa Inc.	Financials	384.14	2026-08-25	654617875235.75	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	381.2100	384.2000	380.2700	6777600
4394	V	Visa Inc.	Financials	383.90	2026-08-26	654208852825.52	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	384.1400	385.5700	381.0800	6075100
4395	V	Visa Inc.	Financials	379.66	2026-08-27	646983431644.69	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	381.1400	381.7700	378.5000	6641500
4396	V	Visa Inc.	Financials	381.60	2026-08-28	650289414431.48	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	380.3000	383.6800	379.0300	4643000
4397	V	Visa Inc.	Financials	\N	2026-08-29	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4398	V	Visa Inc.	Financials	\N	2026-08-30	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4399	V	Visa Inc.	Financials	379.37	2026-08-31	646489224401.92	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	381.3500	382.4800	378.8000	6744800
4400	V	Visa Inc.	Financials	372.67	2026-09-01	635071700555.35	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	379.6500	380.7500	372.2200	5857400
4401	V	Visa Inc.	Financials	378.40	2026-09-02	644836233008.52	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	374.0100	380.1700	374.0100	5599900
4402	V	Visa Inc.	Financials	378.75	2026-09-03	645432682852.50	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	380.1700	382.2100	376.8600	3869500
4403	V	Visa Inc.	Financials	375.07	2026-09-04	639161560619.87	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	374.8900	377.5000	373.6400	4645100
4404	V	Visa Inc.	Financials	\N	2026-09-05	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4405	V	Visa Inc.	Financials	\N	2026-09-06	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4406	V	Visa Inc.	Financials	\N	2026-09-07	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4407	V	Visa Inc.	Financials	368.64	2026-09-08	628204128478.75	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	371.6000	373.5000	367.4400	4929000
4408	V	Visa Inc.	Financials	367.39	2026-09-09	626073987611.25	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	368.4500	369.4800	365.8800	4479800
4409	V	Visa Inc.	Financials	367.21	2026-09-10	625767207802.23	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	366.4000	368.0000	365.5200	3800200
4410	V	Visa Inc.	Financials	370.45	2026-09-11	631288568294.46	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	368.9200	371.8100	367.9800	3492700
4411	V	Visa Inc.	Financials	\N	2026-09-12	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4412	V	Visa Inc.	Financials	\N	2026-09-13	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4413	V	Visa Inc.	Financials	375.28	2026-09-14	639519409724.10	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	375.0700	377.1700	371.6700	6198200
4414	V	Visa Inc.	Financials	375.62	2026-09-15	640098801799.42	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	374.8200	376.3700	372.8200	5014000
4415	V	Visa Inc.	Financials	370.93	2026-09-16	632106509104.13	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	374.9600	376.4700	368.1200	7202300
4416	V	Visa Inc.	Financials	369.93	2026-09-17	630402396410.13	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	371.3800	372.4800	368.3900	4710000
4417	V	Visa Inc.	Financials	368.29	2026-09-18	627607678634.77	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	368.5600	370.8000	366.9300	19583000
4418	V	Visa Inc.	Financials	\N	2026-09-19	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4419	V	Visa Inc.	Financials	\N	2026-09-20	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4420	V	Visa Inc.	Financials	369.95	2026-09-21	630436511947.46	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	369.5400	370.9000	366.0900	7108400
4421	V	Visa Inc.	Financials	362.04	2026-09-22	616956974297.27	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	371.7600	372.0000	359.8000	8773500
4422	V	Visa Inc.	Financials	361.52	2026-09-23	616070802412.94	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	361.2400	366.3300	360.0000	5125600
4423	V	Visa Inc.	Financials	367.98	2026-09-24	627079407860.06	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	362.2700	368.2100	362.0000	4415500
4424	V	Visa Inc.	Financials	367.38	2026-09-25	626056929842.58	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	366.0200	368.3300	363.7900	4576700
4425	V	Visa Inc.	Financials	\N	2026-09-26	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4426	V	Visa Inc.	Financials	\N	2026-09-27	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4427	V	Visa Inc.	Financials	367.74	2026-09-28	626670385449.83	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	366.7000	370.5000	366.0600	6381000
4428	V	Visa Inc.	Financials	365.88	2026-09-29	623500760801.58	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	366.9300	368.2600	365.0000	5471000
4429	V	Visa Inc.	Financials	359.33	2026-09-30	612338791452.65	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	364.5000	364.6000	359.3300	7414100
4430	V	Visa Inc.	Financials	359.85	2026-10-01	613224963336.98	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	358.3500	363.2400	357.3600	5270600
4431	V	Visa Inc.	Financials	360.66	2026-10-02	614605290458.69	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	360.2100	361.3800	356.7500	4009200
4432	V	Visa Inc.	Financials	\N	2026-10-03	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4433	V	Visa Inc.	Financials	\N	2026-10-04	\N	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	\N	\N	\N	\N
4434	V	Visa Inc.	Financials	369.71	2026-10-05	630027489537.23	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	359.4900	370.1700	359.0500	4523500
4435	V	Visa Inc.	Financials	370.64	2026-10-06	631612353866.75	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	368.7900	371.8400	368.1500	3534300
4436	V	Visa Inc.	Financials	372.10	2026-10-07	634100343838.48	2026-10-08 20:55:10.595	2026-10-08 20:55:10.595	369.7200	374.6200	369.6000	4448600
4438	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-01-01	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4439	AMZN	Amazon.com Inc.	Consumer Discretionary	226.50	2026-01-02	2443100024058.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	231.3400	235.4600	224.7000	51456200
4440	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-01-03	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4441	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-01-04	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4442	AMZN	Amazon.com Inc.	Consumer Discretionary	233.06	2026-01-05	2513858214756.55	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	228.8400	234.0000	227.1800	49733300
4443	AMZN	Amazon.com Inc.	Consumer Discretionary	240.93	2026-01-06	2598746449900.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	232.1000	243.1800	232.0700	53764700
4444	AMZN	Amazon.com Inc.	Consumer Discretionary	241.56	2026-01-07	2605541880118.55	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	239.6100	245.2900	239.5200	42236500
4445	AMZN	Amazon.com Inc.	Consumer Discretionary	246.29	2026-01-08	2656561097230.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	243.0600	246.4100	241.8800	39509800
4446	AMZN	Amazon.com Inc.	Consumer Discretionary	247.38	2026-01-09	2668318304108.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	244.5700	247.8600	242.2400	34560000
4447	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-01-10	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4448	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-01-11	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4449	AMZN	Amazon.com Inc.	Consumer Discretionary	246.47	2026-01-12	2658502719257.73	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	246.7300	248.9400	245.9600	35867800
4450	AMZN	Amazon.com Inc.	Consumer Discretionary	242.60	2026-01-13	2616759738401.63	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	246.5300	247.6600	240.2500	38371800
4451	AMZN	Amazon.com Inc.	Consumer Discretionary	236.65	2026-01-14	2552581040979.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	241.1500	241.2800	236.2200	41410600
4452	AMZN	Amazon.com Inc.	Consumer Discretionary	238.18	2026-01-15	2569084087577.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	239.3100	240.6500	236.6300	43003600
4453	AMZN	Amazon.com Inc.	Consumer Discretionary	239.12	2026-01-16	2579223248669.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	239.0900	239.5700	236.4100	45888300
4454	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-01-17	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4455	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-01-18	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4456	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-01-19	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4457	AMZN	Amazon.com Inc.	Consumer Discretionary	231.00	2026-01-20	2491638435132.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	233.7600	235.0900	229.3400	47737900
4458	AMZN	Amazon.com Inc.	Consumer Discretionary	231.31	2026-01-21	2494982166005.55	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	231.0900	232.3000	226.8800	47276100
4459	AMZN	Amazon.com Inc.	Consumer Discretionary	234.34	2026-01-22	2527664682961.82	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	234.0500	235.7200	230.9000	31913300
4460	AMZN	Amazon.com Inc.	Consumer Discretionary	239.16	2026-01-23	2579654793380.18	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	234.9600	240.4500	234.5700	33778500
4461	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-01-24	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4462	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-01-25	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4463	AMZN	Amazon.com Inc.	Consumer Discretionary	238.42	2026-01-26	2571672862085.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	239.9800	240.9500	237.5400	32825500
4464	AMZN	Amazon.com Inc.	Consumer Discretionary	244.68	2026-01-27	2639195125795.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	239.6900	244.8800	238.0800	38029200
4465	AMZN	Amazon.com Inc.	Consumer Discretionary	243.01	2026-01-28	2621182001880.73	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	246.3700	247.7800	241.5300	40882700
4466	AMZN	Amazon.com Inc.	Consumer Discretionary	241.73	2026-01-29	2607375533675.46	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	242.8200	243.0000	236.7400	47229600
4467	AMZN	Amazon.com Inc.	Consumer Discretionary	239.30	2026-01-30	2581164870696.82	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	239.8900	243.3200	237.6400	46585000
4468	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-01-31	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4469	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-02-01	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4470	AMZN	Amazon.com Inc.	Consumer Discretionary	242.96	2026-02-02	2620642817871.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	238.3100	245.6300	238.1700	37546100
4471	AMZN	Amazon.com Inc.	Consumer Discretionary	238.62	2026-02-03	2573830091883.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	244.9800	246.3500	235.4500	53831300
4472	AMZN	Amazon.com Inc.	Consumer Discretionary	232.99	2026-02-04	2513103258391.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	238.8600	238.8600	231.8200	51299900
4473	AMZN	Amazon.com Inc.	Consumer Discretionary	222.69	2026-02-05	2402004195682.45	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	224.9100	226.3100	220.3800	103509200
4474	AMZN	Amazon.com Inc.	Consumer Discretionary	210.32	2026-02-06	2268577549464.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	202.7000	211.4400	200.3100	179210900
4475	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-02-07	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4476	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-02-08	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4477	AMZN	Amazon.com Inc.	Consumer Discretionary	208.72	2026-02-09	2251319381914.73	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	208.9700	212.8100	203.3500	91178400
4478	AMZN	Amazon.com Inc.	Consumer Discretionary	206.96	2026-02-10	2232335529279.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	208.8000	212.6500	206.4100	67175000
4479	AMZN	Amazon.com Inc.	Consumer Discretionary	204.08	2026-02-11	2201270893524.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	208.0600	208.5700	202.4900	65545500
4480	AMZN	Amazon.com Inc.	Consumer Discretionary	199.60	2026-02-12	2152948254805.63	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	203.9600	203.9600	197.5600	83975400
4481	AMZN	Amazon.com Inc.	Consumer Discretionary	198.79	2026-02-13	2144211202560.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	198.8800	201.1600	197.2800	66321600
4482	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-02-14	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4483	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-02-15	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4484	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-02-16	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4485	AMZN	Amazon.com Inc.	Consumer Discretionary	201.15	2026-02-17	2169666909173.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	198.1300	201.7400	196.0000	69879200
4486	AMZN	Amazon.com Inc.	Consumer Discretionary	204.79	2026-02-18	2208929083992.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	202.0700	206.8600	201.5100	51003300
4487	AMZN	Amazon.com Inc.	Consumer Discretionary	204.86	2026-02-19	2209684204943.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	203.8000	205.6400	202.8100	35669600
4488	AMZN	Amazon.com Inc.	Consumer Discretionary	210.11	2026-02-20	2266312351196.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	204.7600	211.1700	203.7500	65881600
4489	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-02-21	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4490	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-02-22	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4491	AMZN	Amazon.com Inc.	Consumer Discretionary	205.27	2026-02-23	2214106633008.54	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	208.1000	208.4300	203.1100	53581500
4492	AMZN	Amazon.com Inc.	Consumer Discretionary	208.56	2026-02-24	2249593532242.55	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	205.4700	210.3600	203.2500	41137200
4493	AMZN	Amazon.com Inc.	Consumer Discretionary	210.64	2026-02-25	2272029084222.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	210.4600	211.5900	208.9300	41346400
4494	AMZN	Amazon.com Inc.	Consumer Discretionary	207.92	2026-02-26	2242690298139.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	210.7300	211.0500	205.3500	47756800
4495	AMZN	Amazon.com Inc.	Consumer Discretionary	210.00	2026-02-27	2265125850120.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	206.8300	210.3300	205.2000	57422800
4496	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-02-28	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4497	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-03-01	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4498	AMZN	Amazon.com Inc.	Consumer Discretionary	208.39	2026-03-02	2247759878685.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	204.5500	209.7300	203.4600	46001000
4499	AMZN	Amazon.com Inc.	Consumer Discretionary	208.73	2026-03-03	2251427185799.46	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	203.1000	209.1800	202.4800	43184900
4500	AMZN	Amazon.com Inc.	Consumer Discretionary	216.82	2026-03-04	2338688587682.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	210.4700	217.5400	210.1500	54731100
4501	AMZN	Amazon.com Inc.	Consumer Discretionary	218.94	2026-03-05	2361555519787.45	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	215.9800	220.4700	215.5900	60943400
4502	AMZN	Amazon.com Inc.	Consumer Discretionary	213.21	2026-03-06	2299749989104.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	214.9900	217.3200	212.5300	51152700
4503	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-03-07	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4504	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-03-08	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4505	AMZN	Amazon.com Inc.	Consumer Discretionary	213.49	2026-03-09	2302770143737.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	210.4500	213.8200	207.1100	54642900
4506	AMZN	Amazon.com Inc.	Consumer Discretionary	214.33	2026-03-10	2311830607637.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	214.1900	215.6500	212.4300	35678800
4507	AMZN	Amazon.com Inc.	Consumer Discretionary	212.65	2026-03-11	2293709515251.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	215.7100	217.0000	211.3500	34199300
4508	AMZN	Amazon.com Inc.	Consumer Discretionary	209.53	2026-03-12	2260056269574.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	210.3900	211.7100	208.1500	44349500
4509	AMZN	Amazon.com Inc.	Consumer Discretionary	207.67	2026-03-13	2239993719746.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	209.6100	210.5600	206.2200	35662100
4510	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-03-14	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4511	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-03-15	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4512	AMZN	Amazon.com Inc.	Consumer Discretionary	211.74	2026-03-16	2283894094986.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	208.3500	212.7200	207.4500	42209300
4513	AMZN	Amazon.com Inc.	Consumer Discretionary	215.20	2026-03-17	2321214647777.18	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	212.8200	215.7000	212.4300	44969900
4514	AMZN	Amazon.com Inc.	Consumer Discretionary	209.87	2026-03-18	2263723576688.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	213.9300	215.1400	208.8300	37846600
4515	AMZN	Amazon.com Inc.	Consumer Discretionary	208.76	2026-03-19	2251750762039.73	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	207.0600	209.1200	206.0500	36440600
4516	AMZN	Amazon.com Inc.	Consumer Discretionary	205.37	2026-03-20	2215185165614.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	207.4000	207.5400	204.3200	63694600
4517	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-03-21	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4518	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-03-22	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4519	AMZN	Amazon.com Inc.	Consumer Discretionary	210.14	2026-03-23	2266635927436.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	209.7900	212.8000	209.5100	44277400
4520	AMZN	Amazon.com Inc.	Consumer Discretionary	207.24	2026-03-24	2235355683912.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	207.9500	209.3500	206.6400	35351400
4521	AMZN	Amazon.com Inc.	Consumer Discretionary	211.71	2026-03-25	2283570518746.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	211.5600	213.0700	209.9000	36388800
4522	AMZN	Amazon.com Inc.	Consumer Discretionary	207.54	2026-03-26	2238591446315.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	210.6100	212.8900	207.1200	46746000
4523	AMZN	Amazon.com Inc.	Consumer Discretionary	199.34	2026-03-27	2150143707941.82	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	206.4600	206.6000	199.1400	56009800
4524	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-03-28	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4525	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-03-29	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4526	AMZN	Amazon.com Inc.	Consumer Discretionary	200.95	2026-03-30	2167509679376.18	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	201.4800	203.8000	199.9800	46373800
4527	AMZN	Amazon.com Inc.	Consumer Discretionary	208.27	2026-03-31	2246465573724.54	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	204.8500	210.2800	204.1400	58470100
4528	AMZN	Amazon.com Inc.	Consumer Discretionary	210.57	2026-04-01	2271274127857.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	210.4400	213.5800	208.1900	45955400
4529	AMZN	Amazon.com Inc.	Consumer Discretionary	209.77	2026-04-02	2262645044082.54	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	206.5400	212.2100	204.9000	31453000
4530	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-04-03	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4531	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-04-04	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4532	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-04-05	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4533	AMZN	Amazon.com Inc.	Consumer Discretionary	212.79	2026-04-06	2295219592568.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	209.8000	212.9500	209.5900	25385500
4534	AMZN	Amazon.com Inc.	Consumer Discretionary	213.77	2026-04-07	2305790298370.54	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	211.2400	213.9700	209.0800	28154600
4535	AMZN	Amazon.com Inc.	Consumer Discretionary	221.25	2026-04-08	2386471877805.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	223.7900	226.1000	219.6200	51092700
4536	AMZN	Amazon.com Inc.	Consumer Discretionary	233.65	2026-04-09	2520222100263.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	225.2300	233.8000	223.2700	65964200
4537	AMZN	Amazon.com Inc.	Consumer Discretionary	238.38	2026-04-10	2571241481960.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	235.3000	240.4300	235.2100	56912800
4538	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-04-11	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4539	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-04-12	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4540	AMZN	Amazon.com Inc.	Consumer Discretionary	239.89	2026-04-13	2587528756203.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	237.4500	240.0000	235.7500	42166200
4541	AMZN	Amazon.com Inc.	Consumer Discretionary	249.02	2026-04-14	2686007851783.54	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	241.7800	252.1800	241.7800	72685000
4542	AMZN	Amazon.com Inc.	Consumer Discretionary	248.50	2026-04-15	2680398922642.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	249.2500	250.4400	247.2000	43045200
4543	AMZN	Amazon.com Inc.	Consumer Discretionary	249.70	2026-04-16	2693342466011.18	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	248.5100	250.0000	244.2000	41895700
4544	AMZN	Amazon.com Inc.	Consumer Discretionary	250.56	2026-04-17	2702618702266.55	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	254.9900	256.1800	250.1100	52029300
4545	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-04-18	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4546	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-04-19	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4547	AMZN	Amazon.com Inc.	Consumer Discretionary	248.28	2026-04-20	2678025920489.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	249.1900	250.1800	245.3700	39463100
4548	AMZN	Amazon.com Inc.	Consumer Discretionary	249.91	2026-04-21	2695607664279.18	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	255.0900	255.0900	249.1000	42922400
4549	AMZN	Amazon.com Inc.	Consumer Discretionary	255.36	2026-04-22	2754393040329.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	252.4400	255.9400	250.3300	36065100
4550	AMZN	Amazon.com Inc.	Consumer Discretionary	255.08	2026-04-23	2751372885696.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	255.3900	258.7900	253.0700	39091400
4551	AMZN	Amazon.com Inc.	Consumer Discretionary	263.99	2026-04-24	2847478814537.19	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	259.9800	264.5000	257.6900	53777400
4552	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-04-25	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4553	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-04-26	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4554	AMZN	Amazon.com Inc.	Consumer Discretionary	261.12	2026-04-27	2816522147253.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	263.4600	264.1500	260.3400	44906800
4555	AMZN	Amazon.com Inc.	Consumer Discretionary	259.70	2026-04-28	2801205766317.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	258.3900	261.0300	256.6300	42204400
4556	AMZN	Amazon.com Inc.	Consumer Discretionary	263.04	2026-04-29	2837232014147.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	257.9900	265.9100	257.7000	72367900
4557	AMZN	Amazon.com Inc.	Consumer Discretionary	265.06	2026-04-30	2859020249060.55	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	273.1700	273.8800	256.1600	100974900
4558	AMZN	Amazon.com Inc.	Consumer Discretionary	268.26	2026-05-01	2893536584159.81	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	265.5800	273.3200	262.7400	50825200
4559	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-05-02	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4560	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-05-03	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4561	AMZN	Amazon.com Inc.	Consumer Discretionary	272.05	2026-05-04	2934416475593.73	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	268.8000	276.1000	268.8000	49083700
4562	AMZN	Amazon.com Inc.	Consumer Discretionary	273.55	2026-05-05	2950595945951.73	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	276.0800	278.5600	272.3800	41908500
4563	AMZN	Amazon.com Inc.	Consumer Discretionary	274.99	2026-05-06	2966128263829.19	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	272.8900	277.8000	272.2100	44552000
4564	AMZN	Amazon.com Inc.	Consumer Discretionary	271.17	2026-05-07	2924924796154.99	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	275.0200	276.6300	270.4900	35892900
4565	AMZN	Amazon.com Inc.	Consumer Discretionary	272.68	2026-05-08	2941211905811.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	271.6300	274.0000	269.9500	34732700
4566	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-05-09	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4567	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-05-10	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4568	AMZN	Amazon.com Inc.	Consumer Discretionary	268.99	2026-05-11	2901410382397.19	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	269.8400	273.6300	268.4800	38176700
4569	AMZN	Amazon.com Inc.	Consumer Discretionary	265.82	2026-05-12	2867217952710.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	266.7100	267.6500	262.6300	36776200
4570	AMZN	Amazon.com Inc.	Consumer Discretionary	270.13	2026-05-13	2913706937871.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	264.4300	270.7200	263.2000	39670900
4571	AMZN	Amazon.com Inc.	Consumer Discretionary	267.22	2026-05-14	2882318725876.73	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	269.1500	270.7800	266.6300	31338400
4572	AMZN	Amazon.com Inc.	Consumer Discretionary	264.14	2026-05-15	2849097024910.72	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	262.5000	264.3600	260.8900	40770300
4573	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-05-16	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4574	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-05-17	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4575	AMZN	Amazon.com Inc.	Consumer Discretionary	264.86	2026-05-18	2856862854677.28	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	263.8700	268.8500	262.5300	33690800
4576	AMZN	Amazon.com Inc.	Consumer Discretionary	259.34	2026-05-19	2797322522261.82	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	262.0400	262.2500	255.1900	40340700
4577	AMZN	Amazon.com Inc.	Consumer Discretionary	265.01	2026-05-20	2858481065050.81	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	260.0500	265.5800	259.5300	34933200
4578	AMZN	Amazon.com Inc.	Consumer Discretionary	268.46	2026-05-21	2895693649370.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	263.5000	269.4900	261.3700	36591700
4579	AMZN	Amazon.com Inc.	Consumer Discretionary	266.32	2026-05-22	2872611109496.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	268.6600	269.7900	266.2400	27535500
4580	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-05-23	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4581	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-05-24	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4582	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-05-25	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4583	AMZN	Amazon.com Inc.	Consumer Discretionary	265.29	2026-05-26	2861501219684.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	267.9400	269.3000	262.0700	38028100
4584	AMZN	Amazon.com Inc.	Consumer Discretionary	271.85	2026-05-27	2932259410382.63	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	266.1500	272.4100	265.7000	40061900
4585	AMZN	Amazon.com Inc.	Consumer Discretionary	274.00	2026-05-28	2955449918728.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	272.2700	274.5000	267.4400	40630400
4586	AMZN	Amazon.com Inc.	Consumer Discretionary	270.64	2026-05-29	2919208063128.72	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	271.2900	274.7500	269.6400	54749600
4587	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-05-30	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4588	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-05-31	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4589	AMZN	Amazon.com Inc.	Consumer Discretionary	261.26	2026-06-01	2818032389155.81	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	266.2900	266.6300	260.7000	53604400
4590	AMZN	Amazon.com Inc.	Consumer Discretionary	256.52	2026-06-02	2766905038987.46	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	257.1600	261.2000	254.3700	41811000
4591	AMZN	Amazon.com Inc.	Consumer Discretionary	250.02	2026-06-03	2696794165355.54	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	254.7000	257.0900	247.7100	51394200
4592	AMZN	Amazon.com Inc.	Consumer Discretionary	253.79	2026-06-04	2737458449020.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	253.1200	255.8300	251.7500	35609800
4593	AMZN	Amazon.com Inc.	Consumer Discretionary	246.03	2026-06-05	2653756714952.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	254.2600	256.3800	245.7800	55607800
4594	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-06-06	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4595	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-06-07	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4596	AMZN	Amazon.com Inc.	Consumer Discretionary	245.22	2026-06-08	2645019827292.73	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	246.6800	249.4200	243.3600	33899500
4597	AMZN	Amazon.com Inc.	Consumer Discretionary	244.19	2026-06-09	2633909937480.45	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	247.7300	250.4300	240.4000	44425400
4598	AMZN	Amazon.com Inc.	Consumer Discretionary	238.00	2026-06-10	2567142630136.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	243.6100	244.0700	237.4500	38590200
4599	AMZN	Amazon.com Inc.	Consumer Discretionary	241.51	2026-06-11	2605002531522.73	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	237.9300	242.1400	235.1800	41335400
4600	AMZN	Amazon.com Inc.	Consumer Discretionary	238.55	2026-06-12	2573075135517.82	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	243.2100	243.3600	233.5900	51186600
4601	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-06-13	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4602	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-06-14	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4603	AMZN	Amazon.com Inc.	Consumer Discretionary	246.02	2026-06-15	2653648911067.54	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	245.0200	247.8100	244.7300	41711600
4604	AMZN	Amazon.com Inc.	Consumer Discretionary	246.00	2026-06-16	2653433138712.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	248.0000	249.5100	245.4500	35187400
4605	AMZN	Amazon.com Inc.	Consumer Discretionary	237.50	2026-06-17	2561749473350.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	244.9000	245.9100	236.0000	44780800
4606	AMZN	Amazon.com Inc.	Consumer Discretionary	244.39	2026-06-18	2636067167277.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	240.1200	245.7300	236.0200	75624400
4607	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-06-19	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4608	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-06-20	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4609	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-06-21	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4610	AMZN	Amazon.com Inc.	Consumer Discretionary	232.79	2026-06-22	2510945864008.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	240.0800	242.0000	232.2400	68388500
4611	AMZN	Amazon.com Inc.	Consumer Discretionary	234.11	2026-06-23	2525183876924.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	232.5500	236.8700	232.0000	60492600
4612	AMZN	Amazon.com Inc.	Consumer Discretionary	234.27	2026-06-24	2526909726596.54	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	233.8500	242.4200	232.9500	70282600
4613	AMZN	Amazon.com Inc.	Consumer Discretionary	227.01	2026-06-25	2448600984728.73	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	232.0200	232.3200	225.5500	77674100
4614	AMZN	Amazon.com Inc.	Consumer Discretionary	232.69	2026-06-26	2509867331402.45	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	227.2100	233.9000	226.1300	248372100
4615	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-06-27	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4616	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-06-28	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4617	AMZN	Amazon.com Inc.	Consumer Discretionary	240.14	2026-06-29	2590225334596.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	234.2200	249.7100	233.8000	77619200
4618	AMZN	Amazon.com Inc.	Consumer Discretionary	238.34	2026-06-30	2570809937249.82	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	237.3500	241.5400	237.1700	66228300
4619	AMZN	Amazon.com Inc.	Consumer Discretionary	241.70	2026-07-01	2607051957435.18	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	239.7500	244.9000	234.9000	53829900
4620	AMZN	Amazon.com Inc.	Consumer Discretionary	242.67	2026-07-02	2617514694766.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	241.6100	246.7200	241.0800	48246400
4621	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-07-03	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4622	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-07-04	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4623	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-07-05	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4624	AMZN	Amazon.com Inc.	Consumer Discretionary	244.16	2026-07-06	2633586361240.18	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	243.8000	246.0400	240.8800	40044000
4625	AMZN	Amazon.com Inc.	Consumer Discretionary	245.98	2026-07-07	2653217366356.46	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	246.9800	248.9300	242.7000	40579600
4626	AMZN	Amazon.com Inc.	Consumer Discretionary	243.62	2026-07-08	2627761659743.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	244.2700	244.8000	240.5200	29653000
4627	AMZN	Amazon.com Inc.	Consumer Discretionary	247.04	2026-07-09	2664650832409.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	239.8200	247.5000	238.2500	38091700
4628	AMZN	Amazon.com Inc.	Consumer Discretionary	245.34	2026-07-10	2646314132253.82	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	249.5500	251.0300	244.4100	31654000
4629	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-07-11	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4630	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-07-12	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4631	AMZN	Amazon.com Inc.	Consumer Discretionary	247.31	2026-07-13	2667563183157.55	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	244.6800	249.6500	244.1800	34636100
4632	AMZN	Amazon.com Inc.	Consumer Discretionary	247.49	2026-07-14	2669504805185.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	245.5500	248.5600	243.8000	30108100
4633	AMZN	Amazon.com Inc.	Consumer Discretionary	254.96	2026-07-15	2750078580735.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	249.7500	256.4800	249.7500	45240600
4634	AMZN	Amazon.com Inc.	Consumer Discretionary	249.89	2026-07-16	2695391891923.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	255.1200	258.0800	248.0000	45343700
4635	AMZN	Amazon.com Inc.	Consumer Discretionary	247.23	2026-07-17	2666700258321.46	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	244.4600	250.2400	243.5900	43572400
4636	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-07-18	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4637	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-07-19	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4638	AMZN	Amazon.com Inc.	Consumer Discretionary	249.99	2026-07-20	2696470589115.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	248.7600	252.8900	248.0000	32406500
4639	AMZN	Amazon.com Inc.	Consumer Discretionary	247.55	2026-07-21	2670151957665.82	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	249.1100	249.3400	246.4200	27732100
4640	AMZN	Amazon.com Inc.	Consumer Discretionary	244.85	2026-07-22	2641028943938.63	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	248.2700	248.4500	242.4500	34112700
4641	AMZN	Amazon.com Inc.	Consumer Discretionary	233.66	2026-07-23	2520330068734.18	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	236.2600	238.3500	232.0500	47465300
4642	AMZN	Amazon.com Inc.	Consumer Discretionary	232.11	2026-07-24	2503611249780.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	234.3800	234.9500	231.3400	35017400
4643	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-07-25	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4644	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-07-26	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4645	AMZN	Amazon.com Inc.	Consumer Discretionary	231.39	2026-07-27	2495845090841.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	235.6700	235.8900	230.9900	34999500
4646	AMZN	Amazon.com Inc.	Consumer Discretionary	230.86	2026-07-28	2490128357815.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	232.8500	233.1100	228.1000	44521600
4647	AMZN	Amazon.com Inc.	Consumer Discretionary	226.65	2026-07-29	2444717905259.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	229.3200	232.8200	226.1600	44957500
4648	AMZN	Amazon.com Inc.	Consumer Discretionary	235.50	2026-07-30	2540176846206.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	233.3500	239.8200	231.0600	101839800
4649	AMZN	Amazon.com Inc.	Consumer Discretionary	271.58	2026-07-31	2929346895048.01	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	265.0000	273.2300	262.0100	129054800
4650	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-08-01	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4651	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-08-02	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4652	AMZN	Amazon.com Inc.	Consumer Discretionary	284.02	2026-08-03	3063528662217.46	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	278.2900	287.2000	278.0000	90830200
4653	AMZN	Amazon.com Inc.	Consumer Discretionary	277.42	2026-08-04	2992339255979.99	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	276.0600	281.0700	275.8200	69748100
4654	AMZN	Amazon.com Inc.	Consumer Discretionary	272.65	2026-08-05	2940888329571.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	281.5900	282.7900	270.7300	45119800
4655	AMZN	Amazon.com Inc.	Consumer Discretionary	272.26	2026-08-06	2936681838447.81	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	272.7700	275.4800	271.0600	30672900
4656	AMZN	Amazon.com Inc.	Consumer Discretionary	274.48	2026-08-07	2960627467744.54	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	272.8700	278.3100	272.7500	33861400
4657	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-08-08	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4658	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-08-09	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4659	AMZN	Amazon.com Inc.	Consumer Discretionary	278.09	2026-08-10	2999565901736.82	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	274.0100	280.1400	273.6000	35731900
4660	AMZN	Amazon.com Inc.	Consumer Discretionary	272.27	2026-08-11	2936789477746.46	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	278.6900	278.8400	271.3600	31895700
4661	AMZN	Amazon.com Inc.	Consumer Discretionary	267.28	2026-08-12	2882965878357.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	273.1800	273.4600	267.1000	29941100
4662	AMZN	Amazon.com Inc.	Consumer Discretionary	265.13	2026-08-13	2859775370011.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	267.2400	269.5800	264.7100	32170200
4663	AMZN	Amazon.com Inc.	Consumer Discretionary	262.65	2026-08-14	2833025193851.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	264.8800	265.8100	262.4200	27251700
4664	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-08-15	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4665	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-08-16	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4666	AMZN	Amazon.com Inc.	Consumer Discretionary	261.31	2026-08-17	2818571573165.55	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	265.4400	265.7500	258.3400	43896500
4667	AMZN	Amazon.com Inc.	Consumer Discretionary	259.45	2026-08-18	2798509187924.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	260.6300	262.1800	257.7300	33171300
4668	AMZN	Amazon.com Inc.	Consumer Discretionary	265.84	2026-08-19	2867433560479.82	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	260.8500	266.4000	258.5800	35762400
4669	AMZN	Amazon.com Inc.	Consumer Discretionary	260.11	2026-08-20	2805627865210.28	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	263.1600	263.8400	259.5200	28374100
4670	AMZN	Amazon.com Inc.	Consumer Discretionary	258.63	2026-08-21	2789664331793.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	260.7400	261.0900	257.0400	35723000
4671	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-08-22	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4672	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-08-23	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4673	AMZN	Amazon.com Inc.	Consumer Discretionary	262.07	2026-08-24	2826769276815.36	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	259.6000	263.3200	259.0500	28070500
4674	AMZN	Amazon.com Inc.	Consumer Discretionary	261.06	2026-08-25	2815874994772.55	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	262.5100	263.8900	259.8300	25550200
4675	AMZN	Amazon.com Inc.	Consumer Discretionary	260.28	2026-08-26	2807461683353.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	261.2800	262.0500	258.2400	21528400
4676	AMZN	Amazon.com Inc.	Consumer Discretionary	256.26	2026-08-27	2764100821295.81	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	259.2300	259.6600	255.0200	35927800
4677	AMZN	Amazon.com Inc.	Consumer Discretionary	266.43	2026-08-28	2873797445986.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	258.3200	267.5600	257.7800	49547400
4678	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-08-29	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4679	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-08-30	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4680	AMZN	Amazon.com Inc.	Consumer Discretionary	259.77	2026-08-31	2801960558096.46	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	263.8300	264.3600	257.1200	46089400
4681	AMZN	Amazon.com Inc.	Consumer Discretionary	254.92	2026-09-01	2749647036023.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	254.8300	255.8200	251.9300	31700100
4682	AMZN	Amazon.com Inc.	Consumer Discretionary	254.98	2026-09-02	2750294188504.46	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	254.2600	256.2400	253.4000	24013300
4683	AMZN	Amazon.com Inc.	Consumer Discretionary	258.90	2026-09-03	2792576517956.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	256.2000	259.5000	256.0000	26891500
4684	AMZN	Amazon.com Inc.	Consumer Discretionary	258.51	2026-09-04	2788370026832.81	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	259.0700	261.1200	255.2900	30749900
4685	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-09-05	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4686	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-09-06	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4687	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-09-07	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4688	AMZN	Amazon.com Inc.	Consumer Discretionary	256.97	2026-09-08	2771759011763.73	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	256.6800	257.9900	254.7500	29398000
4689	AMZN	Amazon.com Inc.	Consumer Discretionary	252.40	2026-09-09	2722465479738.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	253.1200	254.6900	250.6500	33055500
4690	AMZN	Amazon.com Inc.	Consumer Discretionary	251.89	2026-09-10	2716964519067.64	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	250.1100	253.1500	249.5800	25484800
4691	AMZN	Amazon.com Inc.	Consumer Discretionary	256.78	2026-09-11	2769709585851.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	254.0900	257.5900	253.1400	26724100
4692	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-09-12	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4693	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-09-13	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4694	AMZN	Amazon.com Inc.	Consumer Discretionary	253.54	2026-09-14	2734761870627.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	253.1500	255.9500	250.7400	34352800
4695	AMZN	Amazon.com Inc.	Consumer Discretionary	248.42	2026-09-15	2679535997805.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	252.2400	253.2700	247.2200	36275400
4696	AMZN	Amazon.com Inc.	Consumer Discretionary	245.96	2026-09-16	2653001758587.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	248.1000	249.2600	244.3000	33488500
4697	AMZN	Amazon.com Inc.	Consumer Discretionary	251.19	2026-09-17	2709414132484.45	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	251.0700	252.7300	249.2400	30438800
4698	AMZN	Amazon.com Inc.	Consumer Discretionary	253.71	2026-09-18	2736595688770.00	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	252.9200	255.4300	251.8800	52274700
4699	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-09-19	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4700	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-09-20	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4701	AMZN	Amazon.com Inc.	Consumer Discretionary	258.45	2026-09-21	2787722874352.27	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	256.4000	259.4900	253.6000	42979400
4702	AMZN	Amazon.com Inc.	Consumer Discretionary	254.98	2026-09-22	2750294188504.46	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	255.1100	259.0000	253.7800	41982600
4703	AMZN	Amazon.com Inc.	Consumer Discretionary	249.27	2026-09-23	2688704430176.54	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	253.0000	253.9900	247.7600	44209200
4704	AMZN	Amazon.com Inc.	Consumer Discretionary	249.38	2026-09-24	2689890931252.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	246.0200	250.4300	245.6000	33040100
4705	AMZN	Amazon.com Inc.	Consumer Discretionary	249.67	2026-09-25	2693018889770.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	248.5600	250.8800	247.1800	34263900
4706	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-09-26	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4707	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-09-27	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4708	AMZN	Amazon.com Inc.	Consumer Discretionary	246.15	2026-09-28	2655051019913.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	246.6300	247.7700	244.7300	32596700
4709	AMZN	Amazon.com Inc.	Consumer Discretionary	246.67	2026-09-29	2660659949054.91	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	246.7100	248.8400	245.1400	33730400
4710	AMZN	Amazon.com Inc.	Consumer Discretionary	249.15	2026-09-30	2687409960629.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	246.7900	252.4400	246.0800	41913100
4711	AMZN	Amazon.com Inc.	Consumer Discretionary	248.23	2026-10-01	2677486571893.46	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	251.6100	251.8300	246.1200	33243900
4712	AMZN	Amazon.com Inc.	Consumer Discretionary	251.52	2026-10-02	2712973635713.54	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	251.5100	253.5600	250.0200	33433400
4713	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-10-03	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4714	AMZN	Amazon.com Inc.	Consumer Discretionary	\N	2026-10-04	\N	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	\N	\N	\N	\N
4715	AMZN	Amazon.com Inc.	Consumer Discretionary	251.40	2026-10-05	2711679166166.37	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	250.1900	254.5300	250.1800	39273900
4716	AMZN	Amazon.com Inc.	Consumer Discretionary	256.29	2026-10-06	2764424397536.09	2026-10-08 20:55:10.784	2026-10-08 20:55:10.784	253.4000	256.6800	251.0800	34120800
4719	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-01-01	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4720	DIS	The Walt Disney Company	Consumer Discretionary	111.85	2026-01-02	193129927353.98	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	113.4400	113.4400	111.6200	8906200
4721	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-01-03	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4722	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-01-04	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4723	DIS	The Walt Disney Company	Consumer Discretionary	114.07	2026-01-05	196963174384.20	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	111.4200	116.0300	111.3800	12029000
4724	DIS	The Walt Disney Company	Consumer Discretionary	114.57	2026-01-06	197826517835.20	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	113.7900	114.7600	113.1100	7388300
4725	DIS	The Walt Disney Company	Consumer Discretionary	112.91	2026-01-07	194960224428.14	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	114.4600	114.9700	112.5100	8296300
4726	DIS	The Walt Disney Company	Consumer Discretionary	114.17	2026-01-08	197135840439.68	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	112.5500	114.9900	112.5500	9778200
4727	DIS	The Walt Disney Company	Consumer Discretionary	115.88	2026-01-09	200088473461.27	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	114.3100	115.9800	113.9000	8935200
4728	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-01-10	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4729	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-01-11	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4730	DIS	The Walt Disney Company	Consumer Discretionary	112.82	2026-01-12	194804815756.70	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	114.6300	114.9400	112.5500	10833800
4731	DIS	The Walt Disney Company	Consumer Discretionary	112.98	2026-01-13	195081091984.33	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	112.8400	113.2200	111.6100	8945700
4732	DIS	The Walt Disney Company	Consumer Discretionary	113.53	2026-01-14	196030761876.29	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	112.8100	113.5900	112.2600	8950900
4733	DIS	The Walt Disney Company	Consumer Discretionary	113.41	2026-01-15	195823567879.14	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	113.7100	114.1100	112.1700	7958500
4734	DIS	The Walt Disney Company	Consumer Discretionary	111.20	2026-01-16	192007578232.97	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	113.2000	113.8500	111.1200	12049600
4735	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-01-17	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4736	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-01-18	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4737	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-01-19	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4738	DIS	The Walt Disney Company	Consumer Discretionary	110.34	2026-01-20	190522626443.36	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	109.6600	111.0900	108.8000	9818200
4739	DIS	The Walt Disney Company	Consumer Discretionary	113.19	2026-01-21	195443694652.92	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	110.5700	113.2500	110.5000	10041400
4740	DIS	The Walt Disney Company	Consumer Discretionary	113.21	2026-01-22	195478222594.59	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	113.1700	114.2900	112.1700	12437700
4741	DIS	The Walt Disney Company	Consumer Discretionary	110.98	2026-01-23	191627718180.33	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	112.6900	112.9500	110.5500	10819800
4742	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-01-24	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4743	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-01-25	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4744	DIS	The Walt Disney Company	Consumer Discretionary	111.31	2026-01-26	192197514846.08	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	111.6800	112.4100	111.1300	8859800
4745	DIS	The Walt Disney Company	Consumer Discretionary	110.61	2026-01-27	190988839284.11	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	111.5000	111.8000	110.0300	8956900
4746	DIS	The Walt Disney Company	Consumer Discretionary	109.56	2026-01-28	189175812767.58	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	110.2800	111.4300	109.0000	9016600
4747	DIS	The Walt Disney Company	Consumer Discretionary	111.58	2026-01-29	192663727686.82	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	109.6300	111.6700	108.7600	11079000
4748	DIS	The Walt Disney Company	Consumer Discretionary	112.80	2026-01-30	194770287815.03	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	111.3600	112.9500	110.9900	17895200
4749	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-01-31	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4750	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-02-01	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4751	DIS	The Walt Disney Company	Consumer Discretionary	104.45	2026-02-02	180352441644.47	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.0100	108.6100	103.7500	37778500
4752	DIS	The Walt Disney Company	Consumer Discretionary	104.22	2026-02-03	179955311034.21	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.7800	104.9900	102.3400	24827100
4753	DIS	The Walt Disney Company	Consumer Discretionary	107.05	2026-02-04	184841838128.53	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.2000	108.6000	103.6300	19070400
4754	DIS	The Walt Disney Company	Consumer Discretionary	104.97	2026-02-05	181250326210.71	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	107.0500	108.3300	104.8100	11859500
4755	DIS	The Walt Disney Company	Consumer Discretionary	108.70	2026-02-06	187690860977.97	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	106.1300	108.9600	105.3700	12105600
4756	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-02-07	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4757	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-02-08	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4758	DIS	The Walt Disney Company	Consumer Discretionary	107.13	2026-02-09	184979963068.77	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	108.6900	108.9200	106.7700	10515400
4759	DIS	The Walt Disney Company	Consumer Discretionary	109.96	2026-02-10	189866490163.09	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	107.6000	111.1100	107.6000	9815500
4760	DIS	The Walt Disney Company	Consumer Discretionary	108.12	2026-02-11	186689392586.73	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	108.9300	109.8700	107.8000	9374900
4761	DIS	The Walt Disney Company	Consumer Discretionary	102.38	2026-02-12	176778200284.27	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	107.9300	108.1600	101.0200	25319600
4762	DIS	The Walt Disney Company	Consumer Discretionary	105.45	2026-02-13	182079128546.47	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.4000	105.5200	101.2000	12845300
4763	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-02-14	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4764	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-02-15	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4765	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-02-16	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4766	DIS	The Walt Disney Company	Consumer Discretionary	105.44	2026-02-17	182061871162.42	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	106.5700	107.2800	104.3700	10467400
4767	DIS	The Walt Disney Company	Consumer Discretionary	107.10	2026-02-18	184928164569.48	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.9600	107.7300	105.8100	8791600
4768	DIS	The Walt Disney Company	Consumer Discretionary	106.00	2026-02-19	183028811612.00	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	107.1100	107.7700	105.4500	7492900
4769	DIS	The Walt Disney Company	Consumer Discretionary	105.58	2026-02-20	182303606274.82	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.6100	106.2000	104.6500	9043600
4770	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-02-21	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4771	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-02-22	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4772	DIS	The Walt Disney Company	Consumer Discretionary	104.41	2026-02-23	180283385761.14	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.9800	105.1900	102.9600	10626500
4773	DIS	The Walt Disney Company	Consumer Discretionary	106.05	2026-02-24	183115151226.53	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.4500	107.2300	103.9800	13594800
4774	DIS	The Walt Disney Company	Consumer Discretionary	105.05	2026-02-25	181388464324.53	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	106.0000	106.7200	104.5100	8556500
4775	DIS	The Walt Disney Company	Consumer Discretionary	105.55	2026-02-26	182251807775.53	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.4700	106.7700	105.3200	9578500
4776	DIS	The Walt Disney Company	Consumer Discretionary	106.04	2026-02-27	183097880668.91	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.7800	106.3400	103.9300	13954000
4777	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-02-28	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4778	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-03-01	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4779	DIS	The Walt Disney Company	Consumer Discretionary	104.33	2026-03-02	180145247647.32	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.6100	104.6100	102.8600	14178600
4780	DIS	The Walt Disney Company	Consumer Discretionary	103.30	2026-03-03	178366762246.03	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	102.8400	104.3100	102.1500	13608400
4781	DIS	The Walt Disney Company	Consumer Discretionary	103.04	2026-03-04	177917819962.91	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.1700	103.8400	102.6400	9672300
4782	DIS	The Walt Disney Company	Consumer Discretionary	102.41	2026-03-05	176830011957.14	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.1000	104.5500	101.5900	11751500
4783	DIS	The Walt Disney Company	Consumer Discretionary	101.54	2026-03-06	175327789609.91	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.3900	101.8100	99.9500	10448600
4784	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-03-07	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4785	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-03-08	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4786	DIS	The Walt Disney Company	Consumer Discretionary	101.66	2026-03-09	175534996780.64	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	100.5500	101.8700	98.4500	11715100
4787	DIS	The Walt Disney Company	Consumer Discretionary	101.32	2026-03-10	174947916383.70	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.7500	102.2400	100.2400	7833100
4788	DIS	The Walt Disney Company	Consumer Discretionary	100.89	2026-03-11	174205440488.89	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.4000	101.8900	100.4000	8152800
4789	DIS	The Walt Disney Company	Consumer Discretionary	99.43	2026-03-12	171684479192.80	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	100.1000	100.8800	99.3700	10309400
4790	DIS	The Walt Disney Company	Consumer Discretionary	99.29	2026-03-13	171442744080.41	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.8300	100.7700	99.1600	9551500
4791	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-03-14	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4792	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-03-15	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4793	DIS	The Walt Disney Company	Consumer Discretionary	98.66	2026-03-16	170354936074.64	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.4700	99.6900	98.4600	11578500
4794	DIS	The Walt Disney Company	Consumer Discretionary	100.30	2026-03-17	173186701540.03	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.1700	100.7100	99.0200	11785600
4795	DIS	The Walt Disney Company	Consumer Discretionary	99.42	2026-03-18	171667208635.18	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.8400	101.0200	99.0000	12615100
4796	DIS	The Walt Disney Company	Consumer Discretionary	99.20	2026-03-19	171287335408.97	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.0300	100.7800	98.4400	14793800
4797	DIS	The Walt Disney Company	Consumer Discretionary	99.51	2026-03-20	171822617306.62	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.0100	100.0300	98.3900	27544200
4798	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-03-21	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4799	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-03-22	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4800	DIS	The Walt Disney Company	Consumer Discretionary	97.95	2026-03-23	169128976781.47	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	100.2200	100.6000	97.8600	11373000
4801	DIS	The Walt Disney Company	Consumer Discretionary	96.39	2026-03-24	166435349429.89	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	97.7400	98.0500	96.2500	9155700
4802	DIS	The Walt Disney Company	Consumer Discretionary	95.95	2026-03-25	165675602977.47	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	96.8200	97.1800	95.0600	8467500
4803	DIS	The Walt Disney Company	Consumer Discretionary	94.75	2026-03-26	163603583964.50	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	95.1200	96.4000	94.5900	8548800
4804	DIS	The Walt Disney Company	Consumer Discretionary	92.42	2026-03-27	159580400321.18	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	94.1900	94.1900	92.1900	12475900
4805	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-03-28	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4806	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-03-29	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4807	DIS	The Walt Disney Company	Consumer Discretionary	94.32	2026-03-30	162861108069.70	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	92.8900	95.1900	92.8900	10592600
4808	DIS	The Walt Disney Company	Consumer Discretionary	96.38	2026-03-31	166418078872.27	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	95.3400	96.8900	94.1900	11180200
4809	DIS	The Walt Disney Company	Consumer Discretionary	96.56	2026-04-01	166728883041.58	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	97.2600	98.3600	96.4900	8518600
4810	DIS	The Walt Disney Company	Consumer Discretionary	96.61	2026-04-02	166815222656.11	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	96.0000	97.1700	95.0900	6379100
4811	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-04-03	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4812	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-04-04	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4813	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-04-05	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4814	DIS	The Walt Disney Company	Consumer Discretionary	96.28	2026-04-06	166245412816.79	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	96.5000	97.1600	96.1200	5882200
4815	DIS	The Walt Disney Company	Consumer Discretionary	95.78	2026-04-07	165382069365.79	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	95.8000	96.7900	95.3300	7913000
4816	DIS	The Walt Disney Company	Consumer Discretionary	99.18	2026-04-08	171252807467.30	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	98.1000	99.1900	97.6900	10821000
4817	DIS	The Walt Disney Company	Consumer Discretionary	99.79	2026-04-09	172306087531.41	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	98.6600	100.2300	97.6800	8918300
4818	DIS	The Walt Disney Company	Consumer Discretionary	99.17	2026-04-10	171235536909.68	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.8400	100.1600	98.8200	6359600
4819	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-04-11	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4820	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-04-12	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4821	DIS	The Walt Disney Company	Consumer Discretionary	101.18	2026-04-13	174706181271.30	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	98.5300	101.2700	98.5300	6790300
4822	DIS	The Walt Disney Company	Consumer Discretionary	102.59	2026-04-14	177140802952.86	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.3400	103.1000	100.9000	9997400
4823	DIS	The Walt Disney Company	Consumer Discretionary	103.04	2026-04-15	177917819962.91	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	102.6000	103.3800	101.7900	7035300
4824	DIS	The Walt Disney Company	Consumer Discretionary	103.90	2026-04-16	179402771752.52	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.6200	104.5300	102.7800	8145900
4825	DIS	The Walt Disney Company	Consumer Discretionary	106.29	2026-04-17	183529552394.41	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.6900	106.3300	104.6900	10506200
4826	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-04-18	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4827	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-04-19	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4828	DIS	The Walt Disney Company	Consumer Discretionary	106.30	2026-04-20	183546822952.03	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.9100	107.1100	105.9100	6423400
4829	DIS	The Walt Disney Company	Consumer Discretionary	104.29	2026-04-21	180076178590.41	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	106.1900	106.8800	103.9700	7784500
4830	DIS	The Walt Disney Company	Consumer Discretionary	104.82	2026-04-22	180991320540.70	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.0300	106.2800	104.2300	6886600
4831	DIS	The Walt Disney Company	Consumer Discretionary	103.65	2026-04-23	178971100027.02	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.9400	105.2000	102.5500	6147000
4832	DIS	The Walt Disney Company	Consumer Discretionary	102.60	2026-04-24	177158073510.48	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.6000	103.6400	101.9700	5974500
4833	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-04-25	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4834	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-04-26	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4835	DIS	The Walt Disney Company	Consumer Discretionary	102.35	2026-04-27	176726401784.98	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	102.6200	103.8100	102.0600	6524300
4836	DIS	The Walt Disney Company	Consumer Discretionary	101.47	2026-04-28	175206922053.71	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	102.6600	103.2900	100.6100	6409300
4837	DIS	The Walt Disney Company	Consumer Discretionary	101.30	2026-04-29	174913388442.03	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	100.9400	101.4800	100.6000	5533700
4838	DIS	The Walt Disney Company	Consumer Discretionary	103.75	2026-04-30	179143766082.50	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	100.9100	104.1200	100.4200	9203500
4839	DIS	The Walt Disney Company	Consumer Discretionary	103.08	2026-05-01	177986889019.82	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.4000	104.8300	102.9700	5956900
4840	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-05-02	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4841	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-05-03	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4842	DIS	The Walt Disney Company	Consumer Discretionary	101.31	2026-05-04	174930645826.08	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	102.7400	103.0500	101.2700	8400100
4843	DIS	The Walt Disney Company	Consumer Discretionary	100.48	2026-05-05	173497505709.33	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.5300	101.7300	100.0600	14314700
4844	DIS	The Walt Disney Company	Consumer Discretionary	108.06	2026-05-06	186585782414.58	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	106.5200	109.1400	105.3100	23219500
4845	DIS	The Walt Disney Company	Consumer Discretionary	108.66	2026-05-07	187621805094.64	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	109.0500	110.4800	107.0900	14309200
4846	DIS	The Walt Disney Company	Consumer Discretionary	108.02	2026-05-08	186516713357.67	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	109.0300	109.2100	107.5400	8370000
4847	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-05-09	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4848	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-05-10	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4849	DIS	The Walt Disney Company	Consumer Discretionary	104.72	2026-05-11	180818654485.21	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	108.0000	108.3900	104.3800	10562300
4850	DIS	The Walt Disney Company	Consumer Discretionary	106.16	2026-05-12	183305087839.64	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.9900	106.2700	104.2200	8178500
4851	DIS	The Walt Disney Company	Consumer Discretionary	104.90	2026-05-13	181129458654.52	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.3500	105.8800	103.8600	7605900
4852	DIS	The Walt Disney Company	Consumer Discretionary	105.42	2026-05-14	182027330047.18	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.5400	106.2900	104.8500	6144600
4853	DIS	The Walt Disney Company	Consumer Discretionary	102.72	2026-05-15	177365280681.21	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.0300	105.4200	102.3000	9258600
4854	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-05-16	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4855	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-05-17	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4856	DIS	The Walt Disney Company	Consumer Discretionary	103.91	2026-05-18	179420042310.14	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	102.6900	104.7000	102.5500	9037200
4857	DIS	The Walt Disney Company	Consumer Discretionary	102.29	2026-05-19	176622804786.41	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.7100	103.9300	101.9700	7032600
4858	DIS	The Walt Disney Company	Consumer Discretionary	104.08	2026-05-20	179713575921.82	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	102.9100	104.8600	101.6000	7941400
4859	DIS	The Walt Disney Company	Consumer Discretionary	103.58	2026-05-21	178850232470.82	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.6100	104.6200	102.5900	8611200
4860	DIS	The Walt Disney Company	Consumer Discretionary	103.00	2026-05-22	177848750906.00	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.0400	104.5000	102.9800	5693300
4861	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-05-23	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4862	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-05-24	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4863	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-05-25	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4864	DIS	The Walt Disney Company	Consumer Discretionary	103.28	2026-05-26	178332221130.79	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.1000	103.8000	102.3500	6714400
4865	DIS	The Walt Disney Company	Consumer Discretionary	104.18	2026-05-27	179886241977.30	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.3000	105.2500	103.2600	7360100
4866	DIS	The Walt Disney Company	Consumer Discretionary	103.73	2026-05-28	179109238140.83	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.8100	104.4100	103.1000	6511100
4867	DIS	The Walt Disney Company	Consumer Discretionary	101.83	2026-05-29	175828530392.32	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.6300	103.7600	101.8300	13340300
4868	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-05-30	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4869	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-05-31	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4870	DIS	The Walt Disney Company	Consumer Discretionary	102.85	2026-06-01	177589745235.98	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.6600	103.0100	100.3000	8219000
4871	DIS	The Walt Disney Company	Consumer Discretionary	101.41	2026-06-02	175103325055.14	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	102.3500	102.4900	100.0900	8397400
4872	DIS	The Walt Disney Company	Consumer Discretionary	99.39	2026-06-03	171615410135.89	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	100.4400	101.2700	99.2500	7471600
4873	DIS	The Walt Disney Company	Consumer Discretionary	99.34	2026-06-04	171529070521.36	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	100.5400	101.4700	99.0100	9568000
4874	DIS	The Walt Disney Company	Consumer Discretionary	99.71	2026-06-05	172167949417.59	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.6800	100.2000	99.0900	9501600
4875	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-06-06	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4876	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-06-07	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4877	DIS	The Walt Disney Company	Consumer Discretionary	98.87	2026-06-08	170717538743.23	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.5200	99.8400	98.4100	7559200
4878	DIS	The Walt Disney Company	Consumer Discretionary	99.33	2026-06-09	171511813137.32	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.0500	100.0900	98.5100	8616300
4879	DIS	The Walt Disney Company	Consumer Discretionary	98.61	2026-06-10	170268596460.11	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.4900	99.7600	97.9500	7041400
4880	DIS	The Walt Disney Company	Consumer Discretionary	100.34	2026-06-11	173255757423.36	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	98.8300	100.7400	98.1000	9264400
4881	DIS	The Walt Disney Company	Consumer Discretionary	100.04	2026-06-12	172737759256.91	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.0600	101.7700	99.5400	8257200
4882	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-06-13	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4883	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-06-14	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4884	DIS	The Walt Disney Company	Consumer Discretionary	101.69	2026-06-15	175586795279.92	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	100.8800	102.4000	100.5900	10265100
4885	DIS	The Walt Disney Company	Consumer Discretionary	101.28	2026-06-16	174878847326.79	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.4300	101.9300	100.0500	10694600
4886	DIS	The Walt Disney Company	Consumer Discretionary	100.86	2026-06-17	174153641989.61	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	100.6700	102.3600	100.4400	11168700
4887	DIS	The Walt Disney Company	Consumer Discretionary	103.89	2026-06-18	179385501194.89	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.8000	104.2200	100.8000	22943600
4888	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-06-19	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4889	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-06-20	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4890	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-06-21	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4891	DIS	The Walt Disney Company	Consumer Discretionary	102.45	2026-06-22	176899067840.47	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.4100	104.3100	101.5100	17396300
4892	DIS	The Walt Disney Company	Consumer Discretionary	103.53	2026-06-23	178763892856.29	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	102.0200	104.0400	101.8000	14457400
4893	DIS	The Walt Disney Company	Consumer Discretionary	101.12	2026-06-24	174602584272.73	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.1000	104.5300	101.0400	12215500
4894	DIS	The Walt Disney Company	Consumer Discretionary	98.05	2026-06-25	169301656010.53	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.1100	101.5800	97.9900	12054400
4895	DIS	The Walt Disney Company	Consumer Discretionary	98.79	2026-06-26	170579400629.41	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	98.0500	99.4500	97.9000	13921400
4896	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-06-27	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4897	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-06-28	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4898	DIS	The Walt Disney Company	Consumer Discretionary	98.63	2026-06-29	170303124401.77	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.7100	100.0400	98.5000	10418100
4899	DIS	The Walt Disney Company	Consumer Discretionary	96.25	2026-06-30	166193614317.50	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	97.4100	97.6000	95.9900	12717800
4900	DIS	The Walt Disney Company	Consumer Discretionary	95.71	2026-07-01	165261201809.59	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	96.5500	97.7600	95.6500	11590400
4901	DIS	The Walt Disney Company	Consumer Discretionary	99.50	2026-07-02	171805346749.00	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	96.4000	99.5200	95.7700	11297800
4902	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-07-03	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4903	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-07-04	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4904	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-07-05	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4905	DIS	The Walt Disney Company	Consumer Discretionary	97.41	2026-07-06	168196577447.14	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	98.8500	99.4400	97.0200	10171900
4906	DIS	The Walt Disney Company	Consumer Discretionary	97.48	2026-07-07	168317445003.33	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	98.1400	99.0400	96.9200	9936400
4907	DIS	The Walt Disney Company	Consumer Discretionary	96.70	2026-07-08	166970618153.97	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	97.3000	97.6600	96.6400	8720800
4908	DIS	The Walt Disney Company	Consumer Discretionary	96.17	2026-07-09	166055476203.68	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	96.3400	96.5500	94.7800	11448100
4909	DIS	The Walt Disney Company	Consumer Discretionary	95.62	2026-07-10	165105806311.73	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	96.8900	97.0500	95.5200	10678900
4910	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-07-11	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4911	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-07-12	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4912	DIS	The Walt Disney Company	Consumer Discretionary	96.00	2026-07-13	165761942592.00	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	96.1000	97.5400	95.8300	9304200
4913	DIS	The Walt Disney Company	Consumer Discretionary	95.87	2026-07-14	165537478037.23	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	95.5100	96.6900	95.1300	7651600
4914	DIS	The Walt Disney Company	Consumer Discretionary	97.15	2026-07-15	167747635164.02	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	96.1000	97.9000	96.1000	10219200
4915	DIS	The Walt Disney Company	Consumer Discretionary	99.71	2026-07-16	172167949417.59	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	97.2800	99.8500	97.2800	7480000
4916	DIS	The Walt Disney Company	Consumer Discretionary	97.67	2026-07-17	168645506556.68	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	99.0100	99.7900	97.0500	10496500
4917	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-07-18	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4918	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-07-19	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4919	DIS	The Walt Disney Company	Consumer Discretionary	96.41	2026-07-20	166469890545.14	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	97.8500	98.3900	96.0000	9861700
4920	DIS	The Walt Disney Company	Consumer Discretionary	96.14	2026-07-21	166003677704.39	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	96.0000	96.8900	95.8400	9745400
4921	DIS	The Walt Disney Company	Consumer Discretionary	95.87	2026-07-22	165537478037.23	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	97.1200	97.3000	95.6500	9119200
4922	DIS	The Walt Disney Company	Consumer Discretionary	92.83	2026-07-23	160288348274.32	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	94.8100	94.8200	92.4900	13562500
4923	DIS	The Walt Disney Company	Consumer Discretionary	94.85	2026-07-24	163776250019.98	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	93.2600	96.2900	93.0000	12153100
4924	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-07-25	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4925	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-07-26	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4926	DIS	The Walt Disney Company	Consumer Discretionary	96.65	2026-07-27	166884291713.02	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	95.5100	97.1900	95.5100	10593900
4927	DIS	The Walt Disney Company	Consumer Discretionary	98.89	2026-07-28	170752066684.89	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	97.0000	99.2300	96.9700	11389300
4928	DIS	The Walt Disney Company	Consumer Discretionary	98.48	2026-07-29	170044131905.33	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	98.3400	99.4100	97.9900	11070100
4929	DIS	The Walt Disney Company	Consumer Discretionary	96.16	2026-07-30	166038218819.64	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	97.4100	97.4800	94.4600	21112400
4930	DIS	The Walt Disney Company	Consumer Discretionary	96.19	2026-07-31	166090017318.92	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	96.0800	96.5900	95.6000	11193000
4931	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-08-01	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4932	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-08-02	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4933	DIS	The Walt Disney Company	Consumer Discretionary	98.14	2026-08-03	169457051508.39	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	97.6200	99.0500	97.2100	11480300
4934	DIS	The Walt Disney Company	Consumer Discretionary	98.18	2026-08-04	169526120565.30	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	97.8700	98.5700	97.3800	16796800
4935	DIS	The Walt Disney Company	Consumer Discretionary	101.76	2026-08-05	175707662836.12	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.9900	103.2100	99.6900	20809000
4936	DIS	The Walt Disney Company	Consumer Discretionary	104.68	2026-08-06	180749585428.30	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	102.5400	104.7300	102.5200	14047200
4937	DIS	The Walt Disney Company	Consumer Discretionary	104.91	2026-08-07	181146729212.14	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.4200	105.2500	103.7000	10929700
4938	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-08-08	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4939	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-08-09	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4940	DIS	The Walt Disney Company	Consumer Discretionary	103.18	2026-08-10	178159555075.30	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.6100	104.8000	102.8000	8631900
4941	DIS	The Walt Disney Company	Consumer Discretionary	103.53	2026-08-11	178763892856.29	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	102.9500	104.0900	102.7900	6781600
4942	DIS	The Walt Disney Company	Consumer Discretionary	103.22	2026-08-12	178228624132.21	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.2900	103.6800	102.0300	6717500
4943	DIS	The Walt Disney Company	Consumer Discretionary	104.80	2026-08-13	180956792599.03	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.8000	104.9400	103.4600	7100000
4944	DIS	The Walt Disney Company	Consumer Discretionary	106.85	2026-08-14	184496492843.98	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.9900	107.1100	104.9100	8176900
4945	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-08-15	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4946	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-08-16	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4947	DIS	The Walt Disney Company	Consumer Discretionary	103.50	2026-08-17	178712094357.00	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	106.3300	106.6400	103.4600	7635000
4948	DIS	The Walt Disney Company	Consumer Discretionary	103.95	2026-08-18	179489098193.47	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.1900	105.2100	103.6300	6149900
4949	DIS	The Walt Disney Company	Consumer Discretionary	106.93	2026-08-19	184634630957.80	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.0600	107.0600	103.9600	8046100
4950	DIS	The Walt Disney Company	Consumer Discretionary	107.32	2026-08-20	185308037795.70	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	106.8800	108.6900	106.4200	7971500
4951	DIS	The Walt Disney Company	Consumer Discretionary	107.78	2026-08-21	186102312189.79	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	107.5700	108.4100	106.9700	6840800
4952	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-08-22	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4953	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-08-23	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4954	DIS	The Walt Disney Company	Consumer Discretionary	110.61	2026-08-24	190988839284.11	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	108.3900	111.8700	108.0800	12658400
4955	DIS	The Walt Disney Company	Consumer Discretionary	111.25	2026-08-25	192093917847.50	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	110.5000	111.6000	109.7600	6747100
4956	DIS	The Walt Disney Company	Consumer Discretionary	109.63	2026-08-26	189296680323.77	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	111.3000	111.5200	109.4500	8524600
4957	DIS	The Walt Disney Company	Consumer Discretionary	106.82	2026-08-27	184444694344.70	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	108.7800	108.8700	106.7400	8699500
4958	DIS	The Walt Disney Company	Consumer Discretionary	108.10	2026-08-28	186654851471.48	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	107.2500	108.2000	107.0300	5465900
4959	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-08-29	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4960	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-08-30	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4961	DIS	The Walt Disney Company	Consumer Discretionary	107.55	2026-08-31	185705181579.53	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	107.7800	108.0900	106.9700	8728700
4962	DIS	The Walt Disney Company	Consumer Discretionary	106.22	2026-09-01	183408684838.21	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	107.2400	108.9500	106.1400	7033700
4963	DIS	The Walt Disney Company	Consumer Discretionary	107.98	2026-09-02	186447657474.33	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	106.7100	108.9900	106.3300	7555300
4964	DIS	The Walt Disney Company	Consumer Discretionary	107.16	2026-09-03	185031774741.64	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	108.6200	109.2000	106.9000	6241300
4965	DIS	The Walt Disney Company	Consumer Discretionary	105.31	2026-09-04	181837393434.08	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	106.4900	106.8800	105.1700	6103700
4966	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-09-05	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4967	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-09-06	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4968	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-09-07	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4969	DIS	The Walt Disney Company	Consumer Discretionary	105.06	2026-09-08	181405721708.58	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.6800	105.1100	103.7100	7395400
4970	DIS	The Walt Disney Company	Consumer Discretionary	104.18	2026-09-09	179886241977.30	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.4500	104.9300	102.9900	7038100
4971	DIS	The Walt Disney Company	Consumer Discretionary	105.82	2026-09-10	182718007442.70	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.6900	106.1200	103.5700	7607600
4972	DIS	The Walt Disney Company	Consumer Discretionary	106.55	2026-09-11	183978494677.53	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	106.7400	107.3600	105.6400	7255200
4973	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-09-12	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4974	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-09-13	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4975	DIS	The Walt Disney Company	Consumer Discretionary	108.59	2026-09-14	187500924364.86	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	107.0900	109.4200	107.0900	7171700
4976	DIS	The Walt Disney Company	Consumer Discretionary	106.42	2026-09-15	183754016949.18	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	108.1100	108.3200	105.9200	8918200
4977	DIS	The Walt Disney Company	Consumer Discretionary	106.99	2026-09-16	184738227956.38	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	106.4800	108.3400	106.2300	10105700
4978	DIS	The Walt Disney Company	Consumer Discretionary	105.35	2026-09-17	181906462490.98	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	107.5900	107.7100	105.3200	7814300
4979	DIS	The Walt Disney Company	Consumer Discretionary	102.67	2026-09-18	177278941066.68	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.0500	105.0500	102.3700	19139700
4980	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-09-19	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4981	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-09-20	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4982	DIS	The Walt Disney Company	Consumer Discretionary	104.23	2026-09-21	179972581591.83	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.4800	104.6000	103.1800	7126400
4983	DIS	The Walt Disney Company	Consumer Discretionary	103.82	2026-09-22	179264633638.70	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.1000	105.1000	103.3300	7275600
4984	DIS	The Walt Disney Company	Consumer Discretionary	103.46	2026-09-23	178643025300.09	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.2600	104.6200	102.7000	8238700
4985	DIS	The Walt Disney Company	Consumer Discretionary	105.56	2026-09-24	182269065159.58	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.0800	105.7500	103.9000	7884200
4986	DIS	The Walt Disney Company	Consumer Discretionary	106.15	2026-09-25	183287817282.02	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.1500	106.1700	104.4800	7246700
4987	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-09-26	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4988	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-09-27	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4989	DIS	The Walt Disney Company	Consumer Discretionary	105.59	2026-09-28	182320863658.86	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.1200	106.5800	104.7600	12096100
4990	DIS	The Walt Disney Company	Consumer Discretionary	105.41	2026-09-29	182010072663.14	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.4800	105.8400	104.8500	7323300
4991	DIS	The Walt Disney Company	Consumer Discretionary	104.90	2026-09-30	181129458654.52	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	105.7500	106.4000	104.9000	11601200
4992	DIS	The Walt Disney Company	Consumer Discretionary	101.33	2026-10-01	174965186941.32	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	104.5000	104.6400	101.1500	9207400
4993	DIS	The Walt Disney Company	Consumer Discretionary	102.19	2026-10-02	176450138730.92	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.5000	102.6300	101.2300	6704300
4994	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-10-03	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4995	DIS	The Walt Disney Company	Consumer Discretionary	\N	2026-10-04	\N	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	\N	\N	\N	\N
4996	DIS	The Walt Disney Company	Consumer Discretionary	103.61	2026-10-05	178902030970.11	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	101.8100	103.7200	101.3200	7037600
4997	DIS	The Walt Disney Company	Consumer Discretionary	104.03	2026-10-06	179627236307.29	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.4200	104.2700	103.2900	6112600
4998	DIS	The Walt Disney Company	Consumer Discretionary	104.75	2026-10-07	180870452984.50	2026-10-08 20:55:11.081	2026-10-08 20:55:11.081	103.4800	105.2100	102.6200	8643300
5000	XOM	Exxon Mobil Corporation	Energy	\N	2026-01-01	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5001	XOM	Exxon Mobil Corporation	Energy	122.65	2026-01-02	504326008168.28	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	120.0900	122.6800	119.6100	14175100
5002	XOM	Exxon Mobil Corporation	Energy	\N	2026-01-03	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5003	XOM	Exxon Mobil Corporation	Energy	\N	2026-01-04	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5004	XOM	Exxon Mobil Corporation	Energy	125.36	2026-01-05	515469285815.31	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	125.2100	125.9300	122.3900	30112200
5005	XOM	Exxon Mobil Corporation	Energy	121.05	2026-01-06	497746955306.56	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	125.3500	125.8000	121.0000	23328600
5006	XOM	Exxon Mobil Corporation	Energy	118.49	2026-01-07	487220439356.41	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	119.8000	120.1200	118.2700	20353000
5007	XOM	Exxon Mobil Corporation	Energy	122.91	2026-01-08	505395114061.87	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	118.9800	123.6300	118.6600	20232700
5008	XOM	Exxon Mobil Corporation	Energy	124.61	2026-01-09	512385351845.31	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	123.2300	124.8600	123.1000	16137700
5009	XOM	Exxon Mobil Corporation	Energy	\N	2026-01-10	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5010	XOM	Exxon Mobil Corporation	Energy	\N	2026-01-11	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5011	XOM	Exxon Mobil Corporation	Energy	124.03	2026-01-12	510000435379.38	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	124.4600	124.5000	122.5600	15314900
5012	XOM	Exxon Mobil Corporation	Energy	126.54	2026-01-13	520321343182.97	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	125.0000	127.1400	124.8100	21619700
5013	XOM	Exxon Mobil Corporation	Energy	130.20	2026-01-14	535370924643.44	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	127.3500	131.7200	127.1300	27593900
5014	XOM	Exxon Mobil Corporation	Energy	129.13	2026-01-15	530971211472.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	129.1300	130.2000	128.3000	17400000
5015	XOM	Exxon Mobil Corporation	Energy	129.89	2026-01-16	534096241974.69	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	128.9100	130.1600	128.8700	16592400
5016	XOM	Exxon Mobil Corporation	Energy	\N	2026-01-17	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5017	XOM	Exxon Mobil Corporation	Energy	\N	2026-01-18	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5018	XOM	Exxon Mobil Corporation	Energy	\N	2026-01-19	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5019	XOM	Exxon Mobil Corporation	Energy	130.46	2026-01-20	536440061908.43	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	131.5100	131.9400	130.0700	16477300
5020	XOM	Exxon Mobil Corporation	Energy	133.61	2026-01-21	549392559485.31	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	131.9100	133.7300	131.9100	18879900
5021	XOM	Exxon Mobil Corporation	Energy	133.64	2026-01-22	549515911824.69	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	133.0500	134.1800	131.8500	16600100
5022	XOM	Exxon Mobil Corporation	Energy	134.97	2026-01-23	554984762260.62	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	135.0900	135.9800	134.4800	17758200
5023	XOM	Exxon Mobil Corporation	Energy	\N	2026-01-24	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5024	XOM	Exxon Mobil Corporation	Energy	\N	2026-01-25	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5025	XOM	Exxon Mobil Corporation	Energy	134.84	2026-01-26	554450193628.13	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	136.9300	136.9400	134.1700	16056100
5026	XOM	Exxon Mobil Corporation	Energy	136.83	2026-01-27	562632921015.94	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	135.2500	136.9300	134.7100	14517000
5027	XOM	Exxon Mobil Corporation	Energy	137.58	2026-01-28	565716854985.94	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	137.6900	138.0100	136.6700	15637300
5028	XOM	Exxon Mobil Corporation	Energy	140.51	2026-01-29	577764726912.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	140.3200	142.3400	139.1100	35760600
5029	XOM	Exxon Mobil Corporation	Energy	141.40	2026-01-30	581424326046.88	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	138.7400	142.2100	137.8300	29657700
5030	XOM	Exxon Mobil Corporation	Energy	\N	2026-01-31	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5031	XOM	Exxon Mobil Corporation	Energy	\N	2026-02-01	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5032	XOM	Exxon Mobil Corporation	Energy	138.40	2026-02-02	569088590166.88	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	139.8300	140.3200	138.0600	27735600
5033	XOM	Exxon Mobil Corporation	Energy	143.73	2026-02-03	591005088442.82	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	138.6400	145.0100	138.3100	37577800
5034	XOM	Exxon Mobil Corporation	Energy	147.59	2026-02-04	606877071118.13	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	144.1200	147.8400	144.1200	29426200
5035	XOM	Exxon Mobil Corporation	Energy	146.08	2026-02-05	600668106645.94	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	146.5800	146.7300	143.8000	18431700
5036	XOM	Exxon Mobil Corporation	Energy	149.05	2026-02-06	612880490186.56	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	146.6200	149.5700	146.0900	17216000
5037	XOM	Exxon Mobil Corporation	Energy	\N	2026-02-07	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5039	XOM	Exxon Mobil Corporation	Energy	151.21	2026-02-09	621762235078.43	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.2600	151.5500	148.6300	21297300
5040	XOM	Exxon Mobil Corporation	Energy	151.59	2026-02-10	623324718958.13	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	151.3500	151.7800	149.8200	15800300
5041	XOM	Exxon Mobil Corporation	Energy	155.56	2026-02-11	639649014458.75	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	153.9700	156.9300	153.5700	23091500
5042	XOM	Exxon Mobil Corporation	Energy	149.93	2026-02-12	616498930046.26	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	153.8900	155.2500	149.8800	30652500
5043	XOM	Exxon Mobil Corporation	Energy	148.45	2026-02-13	610413317913.44	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	150.5500	151.6600	147.9800	20166000
5044	XOM	Exxon Mobil Corporation	Energy	\N	2026-02-14	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5045	XOM	Exxon Mobil Corporation	Energy	\N	2026-02-15	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5046	XOM	Exxon Mobil Corporation	Energy	\N	2026-02-16	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5047	XOM	Exxon Mobil Corporation	Energy	146.19	2026-02-17	601120419471.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	148.2000	149.1300	145.1500	19766600
5048	XOM	Exxon Mobil Corporation	Energy	150.68	2026-02-18	619582864016.26	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	148.1500	150.9800	147.6100	19849700
5049	XOM	Exxon Mobil Corporation	Energy	150.97	2026-02-19	620775353620.62	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	152.2000	153.3800	150.8400	20305000
5050	XOM	Exxon Mobil Corporation	Energy	147.28	2026-02-20	605602388449.38	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	150.4900	150.8100	146.4600	25908600
5051	XOM	Exxon Mobil Corporation	Energy	\N	2026-02-21	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5052	XOM	Exxon Mobil Corporation	Energy	\N	2026-02-22	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5053	XOM	Exxon Mobil Corporation	Energy	150.76	2026-02-23	619911824502.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	148.1500	151.2700	148.1300	16073100
5054	XOM	Exxon Mobil Corporation	Energy	149.26	2026-02-24	613743956562.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	150.4200	150.7200	148.0300	14185500
5055	XOM	Exxon Mobil Corporation	Energy	149.06	2026-02-25	612921586718.75	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.9100	150.1800	147.3300	15225700
5056	XOM	Exxon Mobil Corporation	Energy	148.54	2026-02-26	610783374931.57	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	147.8100	150.9600	146.7700	15632100
5057	XOM	Exxon Mobil Corporation	Energy	152.50	2026-02-27	627066573900.00	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	151.0000	153.6500	149.2500	30275100
5058	XOM	Exxon Mobil Corporation	Energy	\N	2026-02-28	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5059	XOM	Exxon Mobil Corporation	Energy	\N	2026-03-01	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5060	XOM	Exxon Mobil Corporation	Energy	154.22	2026-03-02	634139067490.62	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	159.3500	159.6100	153.0300	31493100
5061	XOM	Exxon Mobil Corporation	Energy	151.83	2026-03-03	624311600415.94	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	155.4300	156.0500	150.3000	25198900
5062	XOM	Exxon Mobil Corporation	Energy	149.82	2026-03-04	616046679963.74	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	150.7200	151.1600	147.8600	16764800
5063	XOM	Exxon Mobil Corporation	Energy	150.76	2026-03-05	619911824502.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	151.0000	152.3300	149.4700	22969300
5064	XOM	Exxon Mobil Corporation	Energy	151.21	2026-03-06	621762235078.43	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	153.1500	153.8000	149.9600	21136400
5065	XOM	Exxon Mobil Corporation	Energy	\N	2026-03-07	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5066	XOM	Exxon Mobil Corporation	Energy	\N	2026-03-08	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5067	XOM	Exxon Mobil Corporation	Energy	150.44	2026-03-09	618596045301.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	152.0200	153.8900	149.4700	25532700
5068	XOM	Exxon Mobil Corporation	Energy	148.13	2026-03-10	609097538712.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.2500	150.4000	147.7000	19617600
5069	XOM	Exxon Mobil Corporation	Energy	151.58	2026-03-11	623283622425.94	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	147.9900	151.8100	147.6600	15297400
5070	XOM	Exxon Mobil Corporation	Energy	153.53	2026-03-12	631301838199.38	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	152.2700	155.0000	151.6300	26054000
5071	XOM	Exxon Mobil Corporation	Energy	156.12	2026-03-13	641951675117.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	154.3000	156.8900	152.9800	22414100
5072	XOM	Exxon Mobil Corporation	Energy	\N	2026-03-14	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5073	XOM	Exxon Mobil Corporation	Energy	\N	2026-03-15	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5074	XOM	Exxon Mobil Corporation	Energy	157.23	2026-03-16	646515899902.82	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	156.0000	157.7800	154.7600	22835600
5075	XOM	Exxon Mobil Corporation	Energy	158.81	2026-03-17	653012728328.75	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	158.2500	160.4500	156.8000	21592200
5076	XOM	Exxon Mobil Corporation	Energy	157.59	2026-03-18	647996190718.13	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	159.6600	160.1800	157.5300	18947100
5077	XOM	Exxon Mobil Corporation	Energy	158.16	2026-03-19	650340010651.87	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	158.2600	159.5600	154.8400	27082700
5078	XOM	Exxon Mobil Corporation	Energy	159.67	2026-03-20	656548975124.06	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	159.3500	162.4400	159.1000	53942100
5079	XOM	Exxon Mobil Corporation	Energy	\N	2026-03-21	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5080	XOM	Exxon Mobil Corporation	Energy	\N	2026-03-22	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5081	XOM	Exxon Mobil Corporation	Energy	161.13	2026-03-23	662552394192.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	156.1200	161.4200	155.0200	25021300
5082	XOM	Exxon Mobil Corporation	Energy	165.38	2026-03-24	680028020022.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	161.7100	167.4800	161.2500	26131800
5083	XOM	Exxon Mobil Corporation	Energy	163.26	2026-03-25	671310724002.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	163.8700	165.0000	162.9300	17192300
5084	XOM	Exxon Mobil Corporation	Energy	165.43	2026-03-26	680233565426.26	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	164.0900	165.6800	162.0600	18625200
5085	XOM	Exxon Mobil Corporation	Energy	170.99	2026-03-27	703095848627.81	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	165.5800	171.2300	164.8000	30338300
5086	XOM	Exxon Mobil Corporation	Energy	\N	2026-03-28	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5087	XOM	Exxon Mobil Corporation	Energy	\N	2026-03-29	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5088	XOM	Exxon Mobil Corporation	Energy	171.47	2026-03-30	705069548800.62	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	172.5100	176.4100	171.0500	29813500
5089	XOM	Exxon Mobil Corporation	Energy	169.66	2026-03-31	697626998191.87	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	172.6700	174.3800	165.9700	32006700
5090	XOM	Exxon Mobil Corporation	Energy	160.78	2026-04-01	661113199909.38	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	165.7700	168.0000	159.5300	37927600
5091	XOM	Exxon Mobil Corporation	Energy	160.69	2026-04-02	660743142891.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	164.4900	166.9000	159.5900	25377700
5092	XOM	Exxon Mobil Corporation	Energy	\N	2026-04-03	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5093	XOM	Exxon Mobil Corporation	Energy	\N	2026-04-04	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5094	XOM	Exxon Mobil Corporation	Energy	\N	2026-04-05	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5095	XOM	Exxon Mobil Corporation	Energy	163.37	2026-04-06	671763036827.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	160.5700	163.7500	159.5300	16344300
5096	XOM	Exxon Mobil Corporation	Energy	163.91	2026-04-07	673983504421.87	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	164.2200	166.2400	161.7700	25227500
5097	XOM	Exxon Mobil Corporation	Energy	156.22	2026-04-08	642362891410.62	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	153.5200	156.3500	150.9800	31311200
5098	XOM	Exxon Mobil Corporation	Energy	155.04	2026-04-09	637510802671.57	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	156.8600	159.2300	154.3100	25868400
5099	XOM	Exxon Mobil Corporation	Energy	152.51	2026-04-10	627107670432.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	154.0400	155.1200	151.9200	21065000
5100	XOM	Exxon Mobil Corporation	Energy	\N	2026-04-11	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5101	XOM	Exxon Mobil Corporation	Energy	\N	2026-04-12	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5102	XOM	Exxon Mobil Corporation	Energy	152.64	2026-04-13	627642239064.69	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	154.2700	154.6200	151.2800	18685600
5103	XOM	Exxon Mobil Corporation	Energy	149.24	2026-04-14	613661763497.81	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	150.0700	150.1100	146.7200	18528200
5104	XOM	Exxon Mobil Corporation	Energy	149.01	2026-04-15	612715978572.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	148.6000	150.2300	146.9000	15626500
5105	XOM	Exxon Mobil Corporation	Energy	151.98	2026-04-16	624928362112.82	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.5300	152.7800	149.3500	15191000
5106	XOM	Exxon Mobil Corporation	Energy	146.44	2026-04-17	602148397461.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	144.8600	146.8000	141.9700	28947400
5107	XOM	Exxon Mobil Corporation	Energy	\N	2026-04-18	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5108	XOM	Exxon Mobil Corporation	Energy	\N	2026-04-19	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5109	XOM	Exxon Mobil Corporation	Energy	147.68	2026-04-20	607247128136.26	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	147.3800	149.3700	146.3500	16354400
5110	XOM	Exxon Mobil Corporation	Energy	148.36	2026-04-21	610043260895.31	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	147.3700	148.8100	146.2400	17515900
5111	XOM	Exxon Mobil Corporation	Energy	149.50	2026-04-22	614730838020.00	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.3700	150.6800	148.1800	13738700
5112	XOM	Exxon Mobil Corporation	Energy	150.53	2026-04-23	618966102319.38	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.8500	151.2300	148.5000	12970400
5113	XOM	Exxon Mobil Corporation	Energy	148.91	2026-04-24	612304825021.87	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.6400	150.3000	146.9500	13735900
5114	XOM	Exxon Mobil Corporation	Energy	\N	2026-04-25	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5115	XOM	Exxon Mobil Corporation	Energy	\N	2026-04-26	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5116	XOM	Exxon Mobil Corporation	Energy	148.19	2026-04-27	609344243391.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.1600	151.1800	147.9700	13940800
5117	XOM	Exxon Mobil Corporation	Energy	150.56	2026-04-28	619089454658.75	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	151.5300	152.3100	149.8300	15173600
5118	XOM	Exxon Mobil Corporation	Energy	154.67	2026-04-29	635989415324.06	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	152.0200	154.9500	151.0100	14669100
5119	XOM	Exxon Mobil Corporation	Energy	154.33	2026-04-30	634591380315.94	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	152.4300	155.6900	151.3400	22885900
5120	XOM	Exxon Mobil Corporation	Energy	152.75	2026-05-01	628094551890.00	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	152.6100	155.0100	151.1300	15458200
5121	XOM	Exxon Mobil Corporation	Energy	\N	2026-05-02	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5122	XOM	Exxon Mobil Corporation	Energy	\N	2026-05-03	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5123	XOM	Exxon Mobil Corporation	Energy	153.69	2026-05-04	631959759171.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	152.6700	154.4700	149.5200	14238500
5124	XOM	Exxon Mobil Corporation	Energy	154.88	2026-05-05	636852944442.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	153.1000	155.2900	152.4100	12494600
5125	XOM	Exxon Mobil Corporation	Energy	148.69	2026-05-06	611400199371.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.0700	150.3300	147.0900	20527000
5126	XOM	Exxon Mobil Corporation	Energy	146.58	2026-05-07	602724062625.94	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	146.8000	147.0800	144.1900	22509400
5127	XOM	Exxon Mobil Corporation	Energy	144.57	2026-05-08	594459142173.74	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	145.8500	146.5000	143.9200	19550100
5128	XOM	Exxon Mobil Corporation	Energy	\N	2026-05-09	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5129	XOM	Exxon Mobil Corporation	Energy	\N	2026-05-10	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5130	XOM	Exxon Mobil Corporation	Energy	149.68	2026-05-11	615470952056.26	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	146.0200	149.7200	146.0000	14849500
5131	XOM	Exxon Mobil Corporation	Energy	150.63	2026-05-12	619377318612.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	151.2500	151.8100	149.7700	16443100
5132	XOM	Exxon Mobil Corporation	Energy	151.57	2026-05-13	623242525893.74	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	150.0600	151.7900	149.6800	15772800
5133	XOM	Exxon Mobil Corporation	Energy	152.78	2026-05-14	628217904229.38	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	151.9000	153.1200	151.2600	11331500
5134	XOM	Exxon Mobil Corporation	Energy	157.92	2026-05-15	649353129194.06	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	153.7500	158.0000	153.0000	27882400
5135	XOM	Exxon Mobil Corporation	Energy	\N	2026-05-16	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5136	XOM	Exxon Mobil Corporation	Energy	\N	2026-05-17	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5137	XOM	Exxon Mobil Corporation	Energy	160.49	2026-05-18	659920773047.81	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	157.3200	161.7300	155.2300	20065200
5138	XOM	Exxon Mobil Corporation	Energy	162.55	2026-05-19	668391301646.56	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	161.5000	163.3200	159.6400	20715600
5139	XOM	Exxon Mobil Corporation	Energy	156.28	2026-05-20	642609596089.38	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	161.6100	163.6800	156.2700	18509700
5140	XOM	Exxon Mobil Corporation	Energy	155.29	2026-05-21	638538780661.57	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	158.4200	159.3900	153.4600	17061700
5141	XOM	Exxon Mobil Corporation	Energy	154.92	2026-05-22	637017393314.06	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	154.0300	155.5500	153.1700	12948500
5142	XOM	Exxon Mobil Corporation	Energy	\N	2026-05-23	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5143	XOM	Exxon Mobil Corporation	Energy	\N	2026-05-24	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5144	XOM	Exxon Mobil Corporation	Energy	\N	2026-05-25	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5145	XOM	Exxon Mobil Corporation	Energy	149.81	2026-05-26	616005520688.75	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	153.5000	154.5500	149.4700	13057800
5146	XOM	Exxon Mobil Corporation	Energy	147.90	2026-05-27	608151753786.88	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	147.2300	148.6900	145.7500	16241100
5147	XOM	Exxon Mobil Corporation	Energy	146.96	2026-05-28	604286609248.43	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.3400	150.2100	146.8700	14012500
5148	XOM	Exxon Mobil Corporation	Energy	145.26	2026-05-29	597296308722.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	146.1900	146.9300	144.7100	27959900
5149	XOM	Exxon Mobil Corporation	Energy	\N	2026-05-30	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5150	XOM	Exxon Mobil Corporation	Energy	\N	2026-05-31	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5151	XOM	Exxon Mobil Corporation	Energy	149.38	2026-06-01	614237428662.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	147.0200	149.6500	147.0000	16732100
5152	XOM	Exxon Mobil Corporation	Energy	149.56	2026-06-02	614977542698.75	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.0300	150.8300	148.5000	10462400
5153	XOM	Exxon Mobil Corporation	Energy	152.53	2026-06-03	627189926239.38	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	150.6100	154.9100	150.0200	14373000
5154	XOM	Exxon Mobil Corporation	Energy	152.04	2026-06-04	625175066791.57	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	152.0500	153.4300	150.9400	11799400
5155	XOM	Exxon Mobil Corporation	Energy	149.92	2026-06-05	616457833514.06	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	152.0100	152.1300	149.3000	16584000
5156	XOM	Exxon Mobil Corporation	Energy	\N	2026-06-06	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5157	XOM	Exxon Mobil Corporation	Energy	\N	2026-06-07	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5158	XOM	Exxon Mobil Corporation	Energy	151.75	2026-06-08	623982639930.00	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	151.1600	153.8100	150.9000	13870900
5159	XOM	Exxon Mobil Corporation	Energy	148.91	2026-06-09	612304825021.87	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	150.9100	151.1300	147.7800	18163500
5160	XOM	Exxon Mobil Corporation	Energy	150.62	2026-06-10	619336159337.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	151.2300	152.4900	149.5600	14596500
5161	XOM	Exxon Mobil Corporation	Energy	146.60	2026-06-11	602806318433.12	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	152.3000	152.4900	146.4200	17285800
5162	XOM	Exxon Mobil Corporation	Energy	147.01	2026-06-12	604492154652.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	145.6300	148.9100	145.1500	17713100
5163	XOM	Exxon Mobil Corporation	Energy	\N	2026-06-13	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5164	XOM	Exxon Mobil Corporation	Energy	\N	2026-06-14	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5165	XOM	Exxon Mobil Corporation	Energy	140.92	2026-06-15	579450625874.06	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	139.7400	141.9800	137.7200	23631400
5166	XOM	Exxon Mobil Corporation	Energy	141.86	2026-06-16	583315833155.31	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	140.1900	142.1500	139.9800	18925400
5167	XOM	Exxon Mobil Corporation	Energy	140.74	2026-06-17	578710511837.81	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	141.2200	142.3400	140.3200	16663200
5168	XOM	Exxon Mobil Corporation	Energy	137.81	2026-06-18	566662577168.75	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	138.3200	138.4600	135.8500	48063400
5169	XOM	Exxon Mobil Corporation	Energy	\N	2026-06-19	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5170	XOM	Exxon Mobil Corporation	Energy	\N	2026-06-20	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5171	XOM	Exxon Mobil Corporation	Energy	\N	2026-06-21	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5172	XOM	Exxon Mobil Corporation	Energy	138.47	2026-06-22	569376454120.62	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	138.5400	139.0000	137.0200	15783300
5173	XOM	Exxon Mobil Corporation	Energy	139.73	2026-06-23	574557440602.82	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	139.4600	140.3900	138.5000	13699400
5174	XOM	Exxon Mobil Corporation	Energy	136.90	2026-06-24	562920722226.88	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	137.1200	137.6400	135.5900	16212900
5175	XOM	Exxon Mobil Corporation	Energy	137.55	2026-06-25	565593502646.56	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	135.6400	138.0700	134.9500	13288800
5176	XOM	Exxon Mobil Corporation	Energy	136.54	2026-06-26	561440431411.57	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	136.9700	137.5800	135.9200	22684200
5177	XOM	Exxon Mobil Corporation	Energy	\N	2026-06-27	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5178	XOM	Exxon Mobil Corporation	Energy	\N	2026-06-28	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5179	XOM	Exxon Mobil Corporation	Energy	136.06	2026-06-29	559466731238.75	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	136.5800	137.3900	135.3900	11972700
5180	XOM	Exxon Mobil Corporation	Energy	136.72	2026-06-30	562180608190.62	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	136.4800	137.3000	135.3300	28784000
5181	XOM	Exxon Mobil Corporation	Energy	136.28	2026-07-01	560371356889.38	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	136.5300	137.4900	135.6300	12433400
5182	XOM	Exxon Mobil Corporation	Energy	137.09	2026-07-02	563701995538.13	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	137.1500	139.1400	136.3300	13703300
5183	XOM	Exxon Mobil Corporation	Energy	\N	2026-07-03	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5184	XOM	Exxon Mobil Corporation	Energy	\N	2026-07-04	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5185	XOM	Exxon Mobil Corporation	Energy	\N	2026-07-05	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5186	XOM	Exxon Mobil Corporation	Energy	136.44	2026-07-06	561029277861.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	136.5500	137.3700	136.0100	13915100
5187	XOM	Exxon Mobil Corporation	Energy	141.69	2026-07-07	582616815651.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	138.5600	141.7400	138.1300	14667800
5188	XOM	Exxon Mobil Corporation	Energy	141.13	2026-07-08	580314154992.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	143.4400	143.9900	139.8100	18291400
5189	XOM	Exxon Mobil Corporation	Energy	137.46	2026-07-09	565223445628.43	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	139.6600	140.0500	137.1200	14110200
5190	XOM	Exxon Mobil Corporation	Energy	138.88	2026-07-10	571062353082.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	137.9000	138.9700	137.1400	9753500
5191	XOM	Exxon Mobil Corporation	Energy	\N	2026-07-11	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5192	XOM	Exxon Mobil Corporation	Energy	\N	2026-07-12	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5193	XOM	Exxon Mobil Corporation	Energy	144.51	2026-07-13	594212374752.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	140.9200	145.2300	140.4900	18724300
5194	XOM	Exxon Mobil Corporation	Energy	145.09	2026-07-14	596597291218.13	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	145.5100	146.0000	143.8900	16096400
5195	XOM	Exxon Mobil Corporation	Energy	144.51	2026-07-15	594212374752.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	145.0900	145.0900	142.0300	13444500
5196	XOM	Exxon Mobil Corporation	Energy	145.95	2026-07-16	600133538013.44	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	145.2800	146.8700	144.5500	13518000
5197	XOM	Exxon Mobil Corporation	Energy	147.36	2026-07-17	605931348935.31	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.0300	150.0000	147.1700	19031400
5198	XOM	Exxon Mobil Corporation	Energy	\N	2026-07-18	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5199	XOM	Exxon Mobil Corporation	Energy	\N	2026-07-19	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5200	XOM	Exxon Mobil Corporation	Energy	148.36	2026-07-20	610043260895.31	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	146.5000	149.0900	146.2300	12149200
5201	XOM	Exxon Mobil Corporation	Energy	151.71	2026-07-21	623818191058.43	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	149.0100	151.7600	148.4800	13145300
5202	XOM	Exxon Mobil Corporation	Energy	154.45	2026-07-22	635084789673.44	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	153.8600	154.8000	152.9500	13788700
5203	XOM	Exxon Mobil Corporation	Energy	156.89	2026-07-23	645117864894.69	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	156.6000	158.5700	156.0600	15822800
5204	XOM	Exxon Mobil Corporation	Energy	156.94	2026-07-24	645323473041.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	156.9900	158.7100	155.6800	12091600
5205	XOM	Exxon Mobil Corporation	Energy	\N	2026-07-25	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5206	XOM	Exxon Mobil Corporation	Energy	\N	2026-07-26	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5207	XOM	Exxon Mobil Corporation	Energy	154.77	2026-07-27	636400631617.18	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	153.0700	155.4200	152.5000	13955800
5208	XOM	Exxon Mobil Corporation	Energy	153.04	2026-07-28	629286978751.57	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	154.1700	156.1800	151.8800	16299900
5209	XOM	Exxon Mobil Corporation	Energy	156.75	2026-07-29	644542199730.00	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	157.7200	159.0700	155.8600	14571300
5210	XOM	Exxon Mobil Corporation	Energy	156.97	2026-07-30	645446825380.62	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	155.0900	157.7800	154.5300	12578100
5211	XOM	Exxon Mobil Corporation	Energy	155.44	2026-07-31	639155605101.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	153.7400	156.1600	152.1400	15714200
5212	XOM	Exxon Mobil Corporation	Energy	\N	2026-08-01	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5213	XOM	Exxon Mobil Corporation	Energy	\N	2026-08-02	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5214	XOM	Exxon Mobil Corporation	Energy	155.06	2026-08-03	637593058478.75	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	153.4600	155.9100	152.6500	14532800
5215	XOM	Exxon Mobil Corporation	Energy	153.96	2026-08-04	633069992968.43	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	151.6200	154.8400	149.0900	14347900
5216	XOM	Exxon Mobil Corporation	Energy	151.63	2026-08-05	623489230572.50	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	155.0400	155.0400	151.1500	12227500
5217	XOM	Exxon Mobil Corporation	Energy	154.84	2026-08-06	636688432828.13	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	154.2200	154.8700	151.8400	11879100
5218	XOM	Exxon Mobil Corporation	Energy	153.04	2026-08-07	629286978751.57	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	152.6400	153.6700	151.5300	18455200
5219	XOM	Exxon Mobil Corporation	Energy	\N	2026-08-08	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5220	XOM	Exxon Mobil Corporation	Energy	\N	2026-08-09	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5221	XOM	Exxon Mobil Corporation	Energy	159.79	2026-08-10	657042384481.57	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	154.5000	160.3700	154.4500	19761600
5222	XOM	Exxon Mobil Corporation	Energy	159.80	2026-08-11	657083543756.56	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	159.6600	161.6700	159.2700	13744500
5223	XOM	Exxon Mobil Corporation	Energy	159.75	2026-08-12	656877935610.00	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	158.5500	160.2300	157.5600	13219500
5224	XOM	Exxon Mobil Corporation	Energy	158.61	2026-08-13	652190358485.31	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	158.0300	159.7600	157.4300	10542800
5225	XOM	Exxon Mobil Corporation	Energy	160.10	2026-08-14	658317129893.12	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	159.7100	161.2600	159.2500	10231300
5226	XOM	Exxon Mobil Corporation	Energy	\N	2026-08-15	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5227	XOM	Exxon Mobil Corporation	Energy	\N	2026-08-16	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5228	XOM	Exxon Mobil Corporation	Energy	161.46	2026-08-17	663909332668.43	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	160.1000	162.5100	159.0900	12858100
5229	XOM	Exxon Mobil Corporation	Energy	165.56	2026-08-18	680768134058.75	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	164.3500	165.6700	163.2500	18952700
5230	XOM	Exxon Mobil Corporation	Energy	164.77	2026-08-19	677519751217.18	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	166.0700	168.2100	164.6600	13648900
5231	XOM	Exxon Mobil Corporation	Energy	166.15	2026-08-20	683194147056.88	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	167.0200	168.6400	166.0700	13803000
5232	XOM	Exxon Mobil Corporation	Energy	165.11	2026-08-21	678917786225.31	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	166.5400	168.0000	164.6100	14314300
5233	XOM	Exxon Mobil Corporation	Energy	\N	2026-08-22	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5234	XOM	Exxon Mobil Corporation	Energy	\N	2026-08-23	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5235	XOM	Exxon Mobil Corporation	Energy	164.05	2026-08-24	674559169586.56	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	163.8700	165.2200	162.2500	10842500
5236	XOM	Exxon Mobil Corporation	Energy	160.64	2026-08-25	660537534744.69	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	161.4500	162.8100	160.4600	17525300
5237	XOM	Exxon Mobil Corporation	Energy	158.19	2026-08-26	650463362991.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	158.0000	161.1300	157.7600	14838400
5238	XOM	Exxon Mobil Corporation	Energy	156.44	2026-08-27	643267517061.25	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	157.6300	158.1900	156.1400	14288500
5239	XOM	Exxon Mobil Corporation	Energy	156.71	2026-08-28	644377750858.43	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	156.6000	157.4200	155.3200	11352600
5240	XOM	Exxon Mobil Corporation	Energy	\N	2026-08-29	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5241	XOM	Exxon Mobil Corporation	Energy	\N	2026-08-30	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5242	XOM	Exxon Mobil Corporation	Energy	160.95	2026-08-31	661812217413.44	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	159.9400	161.5900	158.7400	18363400
5243	XOM	Exxon Mobil Corporation	Energy	164.55	2026-09-01	676615125566.56	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	163.6000	164.7000	162.2200	11381800
5244	XOM	Exxon Mobil Corporation	Energy	164.15	2026-09-02	674970323136.88	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	163.9300	165.0200	162.7600	11287000
5245	XOM	Exxon Mobil Corporation	Energy	162.21	2026-09-03	666993266638.43	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	164.4300	165.6500	162.0900	13755100
5246	XOM	Exxon Mobil Corporation	Energy	159.47	2026-09-04	655726605280.62	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	161.0200	161.4800	159.1600	16206400
5247	XOM	Exxon Mobil Corporation	Energy	\N	2026-09-05	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5248	XOM	Exxon Mobil Corporation	Energy	\N	2026-09-06	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5249	XOM	Exxon Mobil Corporation	Energy	\N	2026-09-07	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5250	XOM	Exxon Mobil Corporation	Energy	160.66	2026-09-08	660619790551.87	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	160.6100	163.1100	158.7500	12607700
5251	XOM	Exxon Mobil Corporation	Energy	164.23	2026-09-09	675299283622.82	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	162.8800	165.1800	162.5500	13124000
5252	XOM	Exxon Mobil Corporation	Energy	165.23	2026-09-10	679411195582.82	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	167.0000	167.3700	163.1800	16615300
5253	XOM	Exxon Mobil Corporation	Energy	165.99	2026-09-11	682536288827.81	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	165.0700	167.0900	164.0800	11362400
5254	XOM	Exxon Mobil Corporation	Energy	\N	2026-09-12	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5255	XOM	Exxon Mobil Corporation	Energy	\N	2026-09-13	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5256	XOM	Exxon Mobil Corporation	Energy	165.08	2026-09-14	678794433885.94	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	168.7000	169.4500	164.0400	13942100
5257	XOM	Exxon Mobil Corporation	Energy	169.32	2026-09-15	696228963183.74	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	165.3600	169.6400	165.1500	12329200
5258	XOM	Exxon Mobil Corporation	Energy	163.32	2026-09-16	671557491423.74	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	167.2300	167.5000	162.5600	13437800
5259	XOM	Exxon Mobil Corporation	Energy	163.27	2026-09-17	671351883277.18	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	161.8300	163.3900	161.4500	10976500
5260	XOM	Exxon Mobil Corporation	Energy	163.54	2026-09-18	672462054331.57	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	162.5000	163.5400	161.3100	37640600
5261	XOM	Exxon Mobil Corporation	Energy	\N	2026-09-19	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5262	XOM	Exxon Mobil Corporation	Energy	\N	2026-09-20	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5263	XOM	Exxon Mobil Corporation	Energy	158.30	2026-09-21	650915675816.56	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	160.9600	161.9500	157.9400	15752500
5264	XOM	Exxon Mobil Corporation	Energy	158.71	2026-09-22	652601574778.43	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	157.5300	159.9700	155.8500	14189400
5265	XOM	Exxon Mobil Corporation	Energy	161.23	2026-09-23	662963547742.82	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	159.6200	162.1200	159.4200	12569300
5266	XOM	Exxon Mobil Corporation	Energy	162.14	2026-09-24	666705402684.69	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	163.0600	164.9100	161.2000	12484900
5267	XOM	Exxon Mobil Corporation	Energy	160.59	2026-09-25	660331926598.13	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	160.2300	161.7900	159.7800	10996700
5268	XOM	Exxon Mobil Corporation	Energy	\N	2026-09-26	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5269	XOM	Exxon Mobil Corporation	Energy	\N	2026-09-27	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5270	XOM	Exxon Mobil Corporation	Energy	162.52	2026-09-28	668267949307.18	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	162.8000	163.5400	161.0500	12809500
5271	XOM	Exxon Mobil Corporation	Energy	161.35	2026-09-29	663457019843.12	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	160.2200	161.9700	159.2700	9160000
5272	XOM	Exxon Mobil Corporation	Energy	162.75	2026-09-30	669213671490.00	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	162.2300	164.3700	161.8000	13100400
5273	XOM	Exxon Mobil Corporation	Energy	163.82	2026-10-01	673613447403.74	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	161.5000	164.0800	160.8100	11703100
5274	XOM	Exxon Mobil Corporation	Energy	164.01	2026-10-02	674394657972.19	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	161.5500	164.6100	161.5500	11287000
5275	XOM	Exxon Mobil Corporation	Energy	\N	2026-10-03	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5276	XOM	Exxon Mobil Corporation	Energy	\N	2026-10-04	\N	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	\N	\N	\N	\N
5277	XOM	Exxon Mobil Corporation	Energy	164.00	2026-10-05	674353561440.00	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	163.7600	164.7400	161.3900	12475500
5278	XOM	Exxon Mobil Corporation	Energy	164.48	2026-10-06	676327261612.82	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	163.0600	165.9500	162.9400	9285400
5279	XOM	Exxon Mobil Corporation	Energy	164.05	2026-10-07	674559169586.56	2026-10-08 20:55:11.379	2026-10-08 20:55:11.379	165.6000	166.8600	163.4600	9516200
5281	CVX	Chevron Corporation	Energy	\N	2026-01-01	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5282	CVX	Chevron Corporation	Energy	155.90	2026-01-02	305813938443.92	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	152.1700	155.9000	151.2500	6862100
5283	CVX	Chevron Corporation	Energy	\N	2026-01-03	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5284	CVX	Chevron Corporation	Energy	\N	2026-01-04	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5285	CVX	Chevron Corporation	Energy	163.85	2026-01-05	321408708417.58	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	165.7500	165.7500	159.3100	35094900
5286	CVX	Chevron Corporation	Energy	156.54	2026-01-06	307069363342.02	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	164.8800	165.0500	156.1100	20564900
5287	CVX	Chevron Corporation	Energy	155.20	2026-01-07	304440822138.46	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	157.4400	158.0100	154.9000	13537900
5288	CVX	Chevron Corporation	Energy	159.25	2026-01-08	312385321384.50	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	155.5000	160.4400	155.2100	12929600
5289	CVX	Chevron Corporation	Energy	162.11	2026-01-09	317995507945.41	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	160.5600	162.7000	159.9400	12549600
5290	CVX	Chevron Corporation	Energy	\N	2026-01-10	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5291	CVX	Chevron Corporation	Energy	\N	2026-01-11	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5292	CVX	Chevron Corporation	Energy	162.34	2026-01-12	318446668317.55	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	162.7000	163.5600	160.7100	9796800
5293	CVX	Chevron Corporation	Energy	163.87	2026-01-13	321447918932.24	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	163.4700	166.1300	163.3000	12068600
5294	CVX	Chevron Corporation	Energy	167.24	2026-01-14	328058542319.17	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	164.1000	169.3700	164.1000	16414900
5295	CVX	Chevron Corporation	Energy	166.16	2026-01-15	325940007191.45	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	165.7700	167.3300	165.1000	8097400
5296	CVX	Chevron Corporation	Energy	166.26	2026-01-16	326136149559.83	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	166.5900	167.2900	165.8100	9745800
5297	CVX	Chevron Corporation	Energy	\N	2026-01-17	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5298	CVX	Chevron Corporation	Energy	\N	2026-01-18	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5299	CVX	Chevron Corporation	Energy	\N	2026-01-19	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5300	CVX	Chevron Corporation	Energy	165.30	2026-01-20	324253027178.54	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	166.7100	167.6500	165.1500	11142500
5301	CVX	Chevron Corporation	Energy	166.73	2026-01-21	327058105493.15	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	167.0000	168.4800	166.0600	10918500
5302	CVX	Chevron Corporation	Energy	166.66	2026-01-22	326920808828.45	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	166.2600	167.5600	165.7300	8957400
5303	CVX	Chevron Corporation	Energy	166.72	2026-01-23	327038500235.82	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	167.9500	168.4400	166.4400	8368700
5304	CVX	Chevron Corporation	Energy	\N	2026-01-24	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5305	CVX	Chevron Corporation	Energy	\N	2026-01-25	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5306	CVX	Chevron Corporation	Energy	167.50	2026-01-26	328568548395.00	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	168.3300	168.4100	166.7700	8912600
5307	CVX	Chevron Corporation	Energy	169.05	2026-01-27	331609039456.04	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	167.7700	169.3500	166.6500	9784900
5308	CVX	Chevron Corporation	Energy	169.93	2026-01-28	333335229983.61	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	169.9600	170.4200	168.2000	9200200
5309	CVX	Chevron Corporation	Energy	171.19	2026-01-29	335806869265.13	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	172.6500	174.9200	171.0400	16786600
5310	CVX	Chevron Corporation	Energy	176.90	2026-01-30	347007607197.92	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	172.6200	177.3000	171.2700	22946600
5311	CVX	Chevron Corporation	Energy	\N	2026-01-31	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5312	CVX	Chevron Corporation	Energy	\N	2026-02-01	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5313	CVX	Chevron Corporation	Energy	174.03	2026-02-02	341377815379.68	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	173.4400	176.2700	172.6500	14235300
5314	CVX	Chevron Corporation	Energy	178.04	2026-02-03	349243833733.02	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	173.8800	178.8200	173.7500	18425400
5315	CVX	Chevron Corporation	Energy	181.23	2026-02-04	355501352966.15	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	178.8800	182.5900	178.8800	16170500
5316	CVX	Chevron Corporation	Energy	179.23	2026-02-05	351578146418.15	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	179.6400	180.4600	177.4100	10474100
5317	CVX	Chevron Corporation	Energy	180.86	2026-02-06	354775569332.91	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	180.3000	182.1000	179.5100	9901800
5318	CVX	Chevron Corporation	Energy	\N	2026-02-07	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5319	CVX	Chevron Corporation	Energy	\N	2026-02-08	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5320	CVX	Chevron Corporation	Energy	182.60	2026-02-09	358188769805.08	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	181.0100	182.8200	179.9500	12021300
5321	CVX	Chevron Corporation	Energy	182.26	2026-02-10	357521801943.83	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	182.7300	182.9500	180.8600	7458200
5322	CVX	Chevron Corporation	Energy	185.82	2026-02-11	364505134741.89	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	183.9400	186.5200	183.5500	10502100
5323	CVX	Chevron Corporation	Energy	182.40	2026-02-12	357796425204.92	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	185.8000	185.8000	182.0900	9673700
5324	CVX	Chevron Corporation	Energy	183.74	2026-02-13	360424996340.17	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	182.5400	184.8400	181.7200	9034700
5325	CVX	Chevron Corporation	Energy	\N	2026-02-14	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5326	CVX	Chevron Corporation	Energy	\N	2026-02-15	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5327	CVX	Chevron Corporation	Energy	\N	2026-02-16	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5328	CVX	Chevron Corporation	Energy	180.55	2026-02-17	354167477107.04	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	183.3000	183.8000	178.7400	9849000
5329	CVX	Chevron Corporation	Energy	183.87	2026-02-18	360679984412.24	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	183.2300	183.9200	181.9800	10313400
5330	CVX	Chevron Corporation	Energy	184.78	2026-02-19	362465050575.18	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	185.2900	187.9000	184.7400	10773300
5331	CVX	Chevron Corporation	Energy	183.93	2026-02-20	360797675819.61	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	184.5900	184.8900	182.3200	9566200
5332	CVX	Chevron Corporation	Energy	\N	2026-02-21	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5333	CVX	Chevron Corporation	Energy	\N	2026-02-22	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5334	CVX	Chevron Corporation	Energy	184.91	2026-02-23	362720068578.95	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	184.6700	186.6300	184.0500	7047200
5335	CVX	Chevron Corporation	Energy	185.34	2026-02-24	363563543619.55	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	185.2900	185.9600	183.8500	7451800
5336	CVX	Chevron Corporation	Energy	184.22	2026-02-25	361366557530.82	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	185.8400	185.9800	182.5100	9440700
5337	CVX	Chevron Corporation	Energy	184.16	2026-02-26	361248866123.45	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	182.9000	186.2600	181.7600	7133800
5338	CVX	Chevron Corporation	Energy	186.76	2026-02-27	366349016676.83	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	186.0000	187.5500	183.7700	12035500
5339	CVX	Chevron Corporation	Energy	\N	2026-02-28	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5340	CVX	Chevron Corporation	Energy	\N	2026-03-01	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5341	CVX	Chevron Corporation	Energy	189.60	2026-03-02	371919992723.08	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	190.3300	191.4400	187.2200	15809100
5342	CVX	Chevron Corporation	Energy	188.77	2026-03-03	370291858413.85	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	190.5200	191.5600	187.4200	14004200
5343	CVX	Chevron Corporation	Energy	186.03	2026-03-04	364917054667.68	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	187.4500	188.4600	184.1500	11054400
5344	CVX	Chevron Corporation	Energy	189.90	2026-03-05	372508449759.92	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	186.6000	189.9700	186.4900	13567200
5345	CVX	Chevron Corporation	Energy	189.94	2026-03-06	372586930652.63	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	190.8800	192.4100	188.1200	13073100
5346	CVX	Chevron Corporation	Energy	\N	2026-03-07	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5347	CVX	Chevron Corporation	Energy	\N	2026-03-08	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5348	CVX	Chevron Corporation	Energy	189.44	2026-03-09	371606129015.63	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	191.0000	191.6500	188.1100	15987500
5349	CVX	Chevron Corporation	Energy	186.29	2026-03-10	365427060743.52	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	188.6300	189.1800	185.6400	11999600
5350	CVX	Chevron Corporation	Energy	191.79	2026-03-11	376215878750.52	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	186.5900	191.8600	186.4900	11371700
5351	CVX	Chevron Corporation	Energy	196.97	2026-03-12	386376999274.32	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	192.5800	198.8800	191.7700	27151800
5352	CVX	Chevron Corporation	Energy	196.82	2026-03-13	386082770755.89	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	196.0000	197.6300	194.6900	13017000
5353	CVX	Chevron Corporation	Energy	\N	2026-03-14	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5354	CVX	Chevron Corporation	Energy	\N	2026-03-15	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5355	CVX	Chevron Corporation	Energy	196.84	2026-03-16	386121981270.55	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	196.6000	197.8400	195.5800	12683900
5356	CVX	Chevron Corporation	Energy	197.97	2026-03-17	388338602548.32	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	197.4900	200.5800	196.4600	14018600
5357	CVX	Chevron Corporation	Energy	198.61	2026-03-18	389594027446.41	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	199.2200	200.7300	198.5100	13305000
5358	CVX	Chevron Corporation	Energy	201.44	2026-03-19	395145368303.63	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	199.7900	202.4400	199.0000	16918400
5359	CVX	Chevron Corporation	Energy	201.73	2026-03-20	395714220083.15	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	201.4000	205.0800	201.0000	35849500
5360	CVX	Chevron Corporation	Energy	\N	2026-03-21	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5361	CVX	Chevron Corporation	Energy	\N	2026-03-22	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5362	CVX	Chevron Corporation	Energy	205.21	2026-03-23	402540621027.48	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	198.6300	205.3600	197.3700	15735700
5363	CVX	Chevron Corporation	Energy	206.79	2026-03-24	405639927860.52	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	206.0500	209.7900	205.8100	16695500
5364	CVX	Chevron Corporation	Energy	205.15	2026-03-25	402422899688.42	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	206.0000	207.2400	204.6200	8865000
5365	CVX	Chevron Corporation	Energy	207.79	2026-03-26	407601531134.52	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	206.0300	209.2100	205.1600	11085600
5366	CVX	Chevron Corporation	Energy	211.15	2026-03-27	414192519332.42	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	208.1500	212.4600	206.2500	13907800
5367	CVX	Chevron Corporation	Energy	\N	2026-03-28	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5368	CVX	Chevron Corporation	Energy	\N	2026-03-29	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5369	CVX	Chevron Corporation	Energy	210.71	2026-03-30	413329439034.48	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	213.2600	214.7100	210.2900	10409000
5370	CVX	Chevron Corporation	Energy	206.90	2026-03-31	405855705417.92	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	210.9000	213.1000	201.9600	17403900
5371	CVX	Chevron Corporation	Energy	197.41	2026-04-01	387240109503.95	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	201.9900	204.7800	194.9100	23051900
5372	CVX	Chevron Corporation	Energy	198.97	2026-04-02	390300205822.32	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	202.5100	205.4800	198.0400	11528000
5373	CVX	Chevron Corporation	Energy	\N	2026-04-03	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5374	CVX	Chevron Corporation	Energy	\N	2026-04-04	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5375	CVX	Chevron Corporation	Energy	\N	2026-04-05	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5376	CVX	Chevron Corporation	Energy	198.86	2026-04-06	390084428264.91	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	198.5000	199.7700	196.3500	8245700
5377	CVX	Chevron Corporation	Energy	201.54	2026-04-07	395341510672.02	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	199.9700	204.6200	199.2400	11672600
5378	CVX	Chevron Corporation	Energy	192.89	2026-04-08	378373654324.59	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	191.4100	193.1700	188.6000	17195400
5379	CVX	Chevron Corporation	Energy	190.36	2026-04-09	373410800435.91	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	194.3100	196.6700	189.2700	11634000
5380	CVX	Chevron Corporation	Energy	188.55	2026-04-10	369860303299.04	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	189.7100	190.9600	186.4700	11151400
5381	CVX	Chevron Corporation	Energy	\N	2026-04-11	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5382	CVX	Chevron Corporation	Energy	\N	2026-04-12	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5383	CVX	Chevron Corporation	Energy	191.78	2026-04-13	376196273493.18	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	191.4500	192.6100	189.7200	12000200
5384	CVX	Chevron Corporation	Energy	187.02	2026-04-14	366859052684.35	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	188.6000	189.1700	184.6000	12111000
5385	CVX	Chevron Corporation	Energy	184.91	2026-04-15	362720068578.95	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	186.3600	187.2400	184.0400	8661600
5386	CVX	Chevron Corporation	Energy	188.15	2026-04-16	369075644030.42	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	185.6200	188.2300	185.3400	8013200
5387	CVX	Chevron Corporation	Energy	183.99	2026-04-17	360915397158.67	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	181.8900	184.3000	177.7400	15720600
5388	CVX	Chevron Corporation	Energy	\N	2026-04-18	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5389	CVX	Chevron Corporation	Energy	\N	2026-04-19	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5390	CVX	Chevron Corporation	Energy	183.25	2026-04-20	359463799960.50	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	184.5000	186.2700	182.8300	9661100
5391	CVX	Chevron Corporation	Energy	185.98	2026-04-21	364818968517.65	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	183.9700	186.3700	182.3400	9799000
5392	CVX	Chevron Corporation	Energy	186.32	2026-04-22	365485936378.89	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	187.2700	189.4200	186.1200	8708300
5393	CVX	Chevron Corporation	Energy	187.60	2026-04-23	367996786175.08	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	187.1200	188.4200	185.5000	6684700
5394	CVX	Chevron Corporation	Energy	185.21	2026-04-24	363308555547.48	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	185.2300	186.4200	183.2000	9626700
5395	CVX	Chevron Corporation	Energy	\N	2026-04-25	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5396	CVX	Chevron Corporation	Energy	\N	2026-04-26	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5397	CVX	Chevron Corporation	Energy	184.78	2026-04-27	362465050575.18	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	186.1900	188.3700	183.6700	10836600
5398	CVX	Chevron Corporation	Energy	188.36	2026-04-28	369487593887.91	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	188.2800	189.9600	186.5500	10754900
5399	CVX	Chevron Corporation	Energy	192.22	2026-04-29	377059383722.82	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	190.1300	192.6200	189.5000	8644600
5400	CVX	Chevron Corporation	Energy	193.31	2026-04-30	379197524107.87	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	190.2500	194.1300	188.5000	11748600
5401	CVX	Chevron Corporation	Energy	190.63	2026-05-01	373940441700.76	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	191.3000	194.0900	189.7500	10435900
5402	CVX	Chevron Corporation	Energy	\N	2026-05-02	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5403	CVX	Chevron Corporation	Energy	\N	2026-05-03	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5404	CVX	Chevron Corporation	Energy	192.28	2026-05-04	377177075130.18	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	190.8500	193.7100	187.9700	8229500
5405	CVX	Chevron Corporation	Energy	192.64	2026-05-05	377883253506.09	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	191.2200	193.6700	190.4500	5642800
5406	CVX	Chevron Corporation	Energy	185.16	2026-05-06	363210469397.45	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	185.5900	186.7800	183.1400	11082900
5407	CVX	Chevron Corporation	Energy	182.50	2026-05-07	357992597505.00	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	181.5800	183.4400	179.5300	12194000
5408	CVX	Chevron Corporation	Energy	181.62	2026-05-08	356266377045.74	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	182.0400	182.7300	180.7400	13053000
5409	CVX	Chevron Corporation	Energy	\N	2026-05-09	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5410	CVX	Chevron Corporation	Energy	\N	2026-05-10	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5411	CVX	Chevron Corporation	Energy	184.74	2026-05-11	362386599614.17	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	183.0000	185.2000	183.0000	12042100
5412	CVX	Chevron Corporation	Energy	185.95	2026-05-12	364760122813.96	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	186.5000	186.8900	184.6600	8995100
5413	CVX	Chevron Corporation	Energy	186.00	2026-05-13	364858208964.00	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	185.8100	186.0100	183.9600	7554700
5414	CVX	Chevron Corporation	Energy	186.64	2026-05-14	366113633862.09	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	186.1900	187.5700	185.2500	6222400
5415	CVX	Chevron Corporation	Energy	191.10	2026-05-15	374862397634.08	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	188.6000	191.5000	187.9000	11210800
5416	CVX	Chevron Corporation	Energy	\N	2026-05-16	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5417	CVX	Chevron Corporation	Energy	\N	2026-05-17	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5418	CVX	Chevron Corporation	Energy	196.12	2026-05-18	384709624518.74	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	191.1700	196.2000	189.0300	9869700
5419	CVX	Chevron Corporation	Energy	197.25	2026-05-19	386926245796.50	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	194.9300	198.8700	193.4700	11819200
5420	CVX	Chevron Corporation	Energy	191.33	2026-05-20	375313558006.22	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	196.2500	198.1900	191.2700	14564900
5421	CVX	Chevron Corporation	Energy	191.01	2026-05-21	374685830591.33	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	193.7900	194.1600	189.0000	9051200
5422	CVX	Chevron Corporation	Energy	191.43	2026-05-22	375509700374.61	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	190.3700	192.0000	189.8000	7209600
5423	CVX	Chevron Corporation	Energy	\N	2026-05-23	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5426	CVX	Chevron Corporation	Energy	184.71	2026-05-26	362327753910.48	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	190.0000	190.4900	183.9000	14264600
5427	CVX	Chevron Corporation	Energy	182.40	2026-05-27	357796425204.92	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	181.8500	183.7200	180.6700	9442800
5428	CVX	Chevron Corporation	Energy	183.03	2026-05-28	359032244845.68	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	183.7100	185.2600	182.0900	8725400
5429	CVX	Chevron Corporation	Energy	182.46	2026-05-29	357914146543.98	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	182.7200	182.9700	180.4000	13886500
5430	CVX	Chevron Corporation	Energy	\N	2026-05-30	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5431	CVX	Chevron Corporation	Energy	\N	2026-05-31	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5432	CVX	Chevron Corporation	Energy	185.83	2026-06-01	364524739999.22	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	184.3800	187.9400	184.0200	8850500
5433	CVX	Chevron Corporation	Energy	187.55	2026-06-02	367898700025.04	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	184.8800	188.4500	184.8800	6549800
5434	CVX	Chevron Corporation	Energy	189.71	2026-06-03	372135770280.48	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	188.8900	191.4800	187.9600	7983700
5435	CVX	Chevron Corporation	Energy	188.35	2026-06-04	369467988630.58	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	189.0000	190.1000	187.6700	5163200
5436	CVX	Chevron Corporation	Energy	187.31	2026-06-05	367427904463.87	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	189.0600	189.6100	186.5900	6310900
5437	CVX	Chevron Corporation	Energy	\N	2026-06-06	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5438	CVX	Chevron Corporation	Energy	\N	2026-06-07	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5439	CVX	Chevron Corporation	Energy	189.24	2026-06-08	371213814347.17	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	188.7000	191.0300	188.5000	6113000
5440	CVX	Chevron Corporation	Energy	186.76	2026-06-09	366349016676.83	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	188.5000	189.3800	185.4700	8469900
5441	CVX	Chevron Corporation	Energy	189.80	2026-06-10	372312307391.54	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	189.1900	192.6900	188.2300	10041800
5442	CVX	Chevron Corporation	Energy	185.82	2026-06-11	364505134741.89	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	191.8100	192.2500	185.5500	9274100
5443	CVX	Chevron Corporation	Energy	187.22	2026-06-12	367251367352.82	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	185.0800	188.4000	184.3600	8703400
5444	CVX	Chevron Corporation	Energy	\N	2026-06-13	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5445	CVX	Chevron Corporation	Energy	\N	2026-06-14	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5446	CVX	Chevron Corporation	Energy	180.40	2026-06-15	353873218656.92	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	178.9000	181.6700	177.7600	10184900
5447	CVX	Chevron Corporation	Energy	180.11	2026-06-16	353304366877.41	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	178.6200	180.2500	178.3300	6663500
5448	CVX	Chevron Corporation	Energy	177.58	2026-06-17	348341512988.72	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	179.0100	180.0800	177.1000	8430000
5449	CVX	Chevron Corporation	Energy	173.63	2026-06-18	340593186042.76	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	175.6400	175.6400	172.2300	19146100
5450	CVX	Chevron Corporation	Energy	\N	2026-06-19	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5451	CVX	Chevron Corporation	Energy	\N	2026-06-20	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5452	CVX	Chevron Corporation	Energy	\N	2026-06-21	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5453	CVX	Chevron Corporation	Energy	175.06	2026-06-22	343398264357.37	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	174.0800	175.4500	172.8600	11108900
5454	CVX	Chevron Corporation	Energy	175.98	2026-06-23	345202935777.65	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	175.7800	176.4000	174.7000	6555300
5455	CVX	Chevron Corporation	Energy	171.45	2026-06-24	336316875340.96	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	173.8900	173.9900	170.8600	10634600
5456	CVX	Chevron Corporation	Energy	172.24	2026-06-25	337866558689.17	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	170.2200	172.7700	169.2700	7954200
5457	CVX	Chevron Corporation	Energy	171.06	2026-06-26	335551851261.37	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	172.2400	172.2500	169.9300	13102200
5458	CVX	Chevron Corporation	Energy	\N	2026-06-27	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5459	CVX	Chevron Corporation	Energy	\N	2026-06-28	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5460	CVX	Chevron Corporation	Energy	168.47	2026-06-29	330471305965.32	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	171.3700	171.6000	168.3700	8813700
5461	CVX	Chevron Corporation	Energy	165.76	2026-06-30	325155347922.83	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	169.7000	170.4600	165.2000	19428800
5462	CVX	Chevron Corporation	Energy	165.69	2026-07-01	325018051258.13	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	164.7800	167.4700	164.7800	9175500
5463	CVX	Chevron Corporation	Energy	169.20	2026-07-02	331903267974.46	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	168.2800	169.5500	167.4000	9561800
5464	CVX	Chevron Corporation	Energy	\N	2026-07-03	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5465	CVX	Chevron Corporation	Energy	\N	2026-07-04	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5466	CVX	Chevron Corporation	Energy	\N	2026-07-05	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5467	CVX	Chevron Corporation	Energy	168.10	2026-07-06	329745522332.08	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	168.8600	169.2600	167.1600	9974300
5468	CVX	Chevron Corporation	Energy	174.01	2026-07-07	341338574933.33	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	170.1400	174.6100	170.0000	9748900
5469	CVX	Chevron Corporation	Energy	175.97	2026-07-08	345183330520.32	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	176.8000	178.5800	174.9500	9921800
5470	CVX	Chevron Corporation	Energy	174.05	2026-07-09	341417055826.04	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	174.6300	175.5900	173.9000	6582400
5471	CVX	Chevron Corporation	Energy	176.40	2026-07-10	346026805560.92	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	174.9700	176.4200	173.5100	5996600
5472	CVX	Chevron Corporation	Energy	\N	2026-07-11	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5473	CVX	Chevron Corporation	Energy	\N	2026-07-12	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5474	CVX	Chevron Corporation	Energy	182.20	2026-07-13	357404110536.46	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	179.0200	182.3800	179.0200	7685100
5475	CVX	Chevron Corporation	Energy	181.76	2026-07-14	356541000306.83	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	182.7500	183.3600	180.6300	6823300
5476	CVX	Chevron Corporation	Energy	181.60	2026-07-15	356227166531.08	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	182.1700	182.4000	178.5800	6665700
5477	CVX	Chevron Corporation	Energy	183.86	2026-07-16	360660379154.91	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	182.5700	184.8300	181.9500	6257600
5478	CVX	Chevron Corporation	Energy	187.38	2026-07-17	367565231060.26	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	187.4700	188.1500	185.5000	7058300
5479	CVX	Chevron Corporation	Energy	\N	2026-07-18	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5480	CVX	Chevron Corporation	Energy	\N	2026-07-19	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5481	CVX	Chevron Corporation	Energy	189.71	2026-07-20	372135770280.48	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	186.2900	190.3500	185.9300	7767000
5482	CVX	Chevron Corporation	Energy	191.07	2026-07-21	374803551930.39	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	190.5000	191.2600	189.3200	6892400
5483	CVX	Chevron Corporation	Energy	192.98	2026-07-22	378550191435.65	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	193.4000	193.7000	191.9400	6142400
5484	CVX	Chevron Corporation	Energy	194.42	2026-07-23	381374904939.28	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	196.3000	197.6900	194.0200	8150000
5485	CVX	Chevron Corporation	Energy	194.79	2026-07-24	382100688572.52	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	194.4600	196.8700	193.8000	6700400
5486	CVX	Chevron Corporation	Energy	\N	2026-07-25	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5487	CVX	Chevron Corporation	Energy	\N	2026-07-26	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5488	CVX	Chevron Corporation	Energy	190.00	2026-07-27	372704622060.00	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	188.6700	192.4900	188.6700	7369200
5489	CVX	Chevron Corporation	Energy	187.58	2026-07-28	367957545728.72	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	191.4700	191.9700	186.7300	7406800
5490	CVX	Chevron Corporation	Energy	191.86	2026-07-29	376353205346.91	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	192.5000	193.5600	190.7800	8101200
5491	CVX	Chevron Corporation	Energy	192.31	2026-07-30	377235920833.87	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	189.9100	193.1200	189.3100	6645000
5492	CVX	Chevron Corporation	Energy	196.83	2026-07-31	386102376013.22	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	195.1100	197.5500	191.5400	9958100
5493	CVX	Chevron Corporation	Energy	\N	2026-08-01	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5494	CVX	Chevron Corporation	Energy	\N	2026-08-02	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5495	CVX	Chevron Corporation	Energy	193.18	2026-08-03	378942506104.11	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	195.3800	195.8600	191.8100	9544100
5496	CVX	Chevron Corporation	Energy	190.40	2026-08-04	373489251396.92	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	190.1500	191.4700	186.3400	9455900
5497	CVX	Chevron Corporation	Energy	186.41	2026-08-05	365662473489.95	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	191.1900	191.3800	186.2700	8260600
5498	CVX	Chevron Corporation	Energy	189.23	2026-08-06	371194179158.15	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	188.9700	189.7800	187.0200	7182100
5499	CVX	Chevron Corporation	Energy	186.56	2026-08-07	365956702008.37	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	186.2100	187.7500	185.8700	7098800
5500	CVX	Chevron Corporation	Energy	\N	2026-08-08	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5501	CVX	Chevron Corporation	Energy	\N	2026-08-09	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5502	CVX	Chevron Corporation	Energy	194.91	2026-08-10	382336101318.95	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	188.8800	194.9900	188.8800	13667300
5503	CVX	Chevron Corporation	Energy	196.66	2026-08-11	385768907048.45	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	194.2500	197.4600	194.2500	6049800
5504	CVX	Chevron Corporation	Energy	196.60	2026-08-12	385651215641.08	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	195.2200	197.4000	194.5800	7366200
5505	CVX	Chevron Corporation	Energy	197.70	2026-08-13	387808961283.46	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	195.0000	198.1000	193.7500	5908900
5506	CVX	Chevron Corporation	Energy	200.00	2026-08-14	392320654800.00	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	198.8700	201.6300	198.3600	7910500
5507	CVX	Chevron Corporation	Energy	\N	2026-08-15	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5508	CVX	Chevron Corporation	Energy	\N	2026-08-16	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5509	CVX	Chevron Corporation	Energy	202.70	2026-08-17	397616977653.46	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	200.7300	203.6800	199.8000	8357800
5510	CVX	Chevron Corporation	Energy	205.74	2026-08-18	403580268368.17	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	205.0300	206.2200	203.7100	7701600
5511	CVX	Chevron Corporation	Energy	205.76	2026-08-19	403619478882.83	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	205.0500	207.6800	204.2600	8689900
5512	CVX	Chevron Corporation	Energy	205.77	2026-08-20	403639114071.85	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	208.9000	208.9800	205.5200	8200600
5513	CVX	Chevron Corporation	Energy	205.27	2026-08-21	402658312434.85	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	205.9300	207.8200	205.0100	7359100
5514	CVX	Chevron Corporation	Energy	\N	2026-08-22	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5515	CVX	Chevron Corporation	Energy	\N	2026-08-23	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5516	CVX	Chevron Corporation	Energy	203.09	2026-08-24	398382001733.05	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	203.6700	205.3000	201.7500	5853900
5517	CVX	Chevron Corporation	Energy	199.89	2026-08-25	392104877242.59	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	201.0300	202.0600	199.7900	8176800
5518	CVX	Chevron Corporation	Energy	200.21	2026-08-26	392732604657.48	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	198.7300	202.3900	198.1200	6863100
5519	CVX	Chevron Corporation	Energy	199.77	2026-08-27	391869494427.85	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	199.5700	200.8800	197.8200	8112300
5520	CVX	Chevron Corporation	Energy	201.86	2026-08-28	395969238086.91	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	199.9800	202.2400	199.5600	5301000
5521	CVX	Chevron Corporation	Energy	\N	2026-08-29	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5522	CVX	Chevron Corporation	Energy	\N	2026-08-30	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5523	CVX	Chevron Corporation	Energy	206.14	2026-08-31	404364897705.09	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	206.0800	208.4200	203.8400	12067400
5524	CVX	Chevron Corporation	Energy	211.05	2026-09-01	413996376964.04	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	209.0000	211.0800	207.8000	8551500
5525	CVX	Chevron Corporation	Energy	211.78	2026-09-02	415428338973.18	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	210.4900	212.7900	209.4600	7595300
5526	CVX	Chevron Corporation	Energy	211.32	2026-09-03	414526018228.89	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	212.3800	213.2000	211.1700	6668200
5527	CVX	Chevron Corporation	Energy	208.60	2026-09-04	409190454929.08	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	209.5100	209.8600	207.1200	5458400
5528	CVX	Chevron Corporation	Energy	\N	2026-09-05	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5529	CVX	Chevron Corporation	Energy	\N	2026-09-06	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5530	CVX	Chevron Corporation	Energy	\N	2026-09-07	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5531	CVX	Chevron Corporation	Energy	209.80	2026-09-08	411544372871.54	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	211.2500	213.3100	209.1800	7703900
5532	CVX	Chevron Corporation	Energy	213.81	2026-09-09	419410391224.87	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	212.8800	215.2800	212.2300	8384700
5533	CVX	Chevron Corporation	Energy	212.76	2026-09-10	417350701800.83	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	217.4000	217.4000	211.3400	9625200
5534	CVX	Chevron Corporation	Energy	214.06	2026-09-11	419900792043.37	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	212.0200	215.5500	212.0200	6570300
5535	CVX	Chevron Corporation	Energy	\N	2026-09-12	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5536	CVX	Chevron Corporation	Energy	\N	2026-09-13	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5537	CVX	Chevron Corporation	Energy	212.17	2026-09-14	416193363052.78	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	217.0000	217.6500	211.2700	9366000
5538	CVX	Chevron Corporation	Energy	217.77	2026-09-15	427178353359.85	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	212.8900	217.7800	212.7400	9557600
5539	CVX	Chevron Corporation	Energy	211.54	2026-09-16	414957543412.02	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	215.0900	215.2800	210.3700	8045100
5540	CVX	Chevron Corporation	Energy	211.57	2026-09-17	415016419047.39	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	209.6100	211.7500	209.1700	7387300
5541	CVX	Chevron Corporation	Energy	209.51	2026-09-18	410975491160.33	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	211.0900	211.9000	207.3100	47298700
5542	CVX	Chevron Corporation	Energy	\N	2026-09-19	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5543	CVX	Chevron Corporation	Energy	\N	2026-09-20	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5544	CVX	Chevron Corporation	Energy	203.67	2026-09-21	399519735223.78	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	207.8900	209.0000	203.5000	8464000
5545	CVX	Chevron Corporation	Energy	202.41	2026-09-22	397048125873.95	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	201.8700	204.4400	200.7800	9344100
5546	CVX	Chevron Corporation	Energy	205.51	2026-09-23	403129078064.33	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	204.4600	207.0000	203.4800	8257800
5547	CVX	Chevron Corporation	Energy	205.65	2026-09-24	403403701325.42	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	207.2400	208.1000	204.8700	9382800
5548	CVX	Chevron Corporation	Energy	204.45	2026-09-25	401049783382.96	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	203.8100	206.5400	203.4000	7134300
5549	CVX	Chevron Corporation	Energy	\N	2026-09-26	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5550	CVX	Chevron Corporation	Energy	\N	2026-09-27	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5551	CVX	Chevron Corporation	Energy	206.37	2026-09-28	404816058077.24	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	207.0000	208.2500	205.3800	9529800
5552	CVX	Chevron Corporation	Energy	204.38	2026-09-29	400912486718.26	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	203.0500	205.4800	202.7000	5917600
5553	CVX	Chevron Corporation	Energy	204.21	2026-09-30	400579017753.48	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	205.0900	206.8300	204.2100	6390200
5554	CVX	Chevron Corporation	Energy	207.10	2026-10-01	406248050018.08	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	203.3300	207.4100	202.8200	5999700
5555	CVX	Chevron Corporation	Energy	206.69	2026-10-02	405443785492.13	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	204.8000	207.3200	204.4500	6669900
5556	CVX	Chevron Corporation	Energy	\N	2026-10-03	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5557	CVX	Chevron Corporation	Energy	\N	2026-10-04	\N	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	\N	\N	\N	\N
5558	CVX	Chevron Corporation	Energy	206.47	2026-10-05	405012230377.32	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	206.8300	207.2600	201.9600	6445100
5559	CVX	Chevron Corporation	Energy	207.58	2026-10-06	407189611208.72	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	205.5700	208.6900	204.8900	5468800
5560	CVX	Chevron Corporation	Energy	205.15	2026-10-07	402422899688.42	2026-10-08 20:55:11.678	2026-10-08 20:55:11.678	208.4400	210.1400	204.8600	5733000
4717	AMZN	Amazon	Consumer Discretionary	259.92	2026-10-07	2803578623634.24	2026-10-08 20:55:10.784	2026-10-08 14:21:04.994	254.2300	260.1400	253.1700	36225813
3874	JNJ	Johnson & Johnson	Healthcare	258.45	2026-10-07	622838292394.65	2026-10-08 20:55:10.075	2026-10-08 14:25:47.572	256.2100	260.6800	255.7300	5405016
4156	JPM	JPMorgan Chase	Financials	331.42	2026-10-08	880976068746.90	2026-10-08 20:55:10.361	2026-10-09 14:37:18.498	327.2500	332.3100	325.6250	8069273
4718	AMZN	Amazon	Consumer Discretionary	254.06	2026-10-08	2740370826102.32	2026-10-08 20:55:10.784	2026-10-09 14:37:45.787	259.7400	259.8599	253.7800	38649939
3032	MSFT	Microsoft	Technology	522.61	2026-10-08	3880664329051.51	2026-10-08 20:55:08.923	2026-10-09 14:42:02.005	529.8050	533.5100	518.7900	20228699
3313	NVDA	NVIDIA	Technology	230.48	2026-10-08	5565400560000.00	2026-10-08 20:55:09.464	2026-10-09 14:42:15.612	234.9200	237.0700	229.8500	118697435
3594	LLY	Eli Lilly	Healthcare	1169.60	2026-10-08	1042531223224.00	2026-10-08 20:55:09.757	2026-10-09 14:42:35.267	1183.5000	1186.0903	1131.2100	3093768
3875	JNJ	Johnson & Johnson	Healthcare	256.48	2026-10-08	618090792158.56	2026-10-08 20:55:10.075	2026-10-09 14:42:53.092	256.2200	257.8000	251.9450	6177511
4999	DIS	The Walt Disney Company	Consumer Discretionary	107.02	2026-10-08	184790032252.04	2026-10-08 20:55:11.081	2026-10-09 14:44:04.141	104.8100	107.4100	104.0453	14275264
5280	XOM	Exxon Mobil	Energy	168.50	2026-10-08	692857165260.00	2026-10-08 20:55:11.379	2026-10-09 14:44:18.353	167.1100	169.1900	166.7100	13297530
5561	CVX	Chevron	Energy	211.55	2026-10-08	414977172614.70	2026-10-08 20:55:11.678	2026-10-09 14:44:32.256	209.3200	212.3550	208.9600	7628152
4437	V	Visa	Financials	375.10	2026-10-08	704195957650.90	2026-10-08 20:55:10.595	2026-10-09 14:43:32.995	371.4000	379.9900	370.3748	6409439
5562	MSFT	Microsoft	Technology	535.07	2026-10-09	3973186625869.37	2026-10-10 13:48:00.975	2026-10-11 13:42:33.844	528.2350	537.2200	526.2401	18500612
5563	NVDA	NVIDIA	Technology	229.28	2026-10-09	5536424160000.00	2026-10-10 13:48:14.329	2026-10-11 13:42:47.144	233.8350	233.9200	229.1100	84645559
5564	LLY	Eli Lilly	Healthcare	1179.27	2026-10-09	1051150646042.55	2026-10-10 13:48:27.688	2026-10-11 13:43:00.45	1153.5600	1179.8200	1151.6700	1392930
5565	JNJ	Johnson & Johnson	Healthcare	261.44	2026-10-09	630043889199.68	2026-10-10 13:48:41.022	2026-10-11 13:43:13.744	255.0900	261.6100	254.9850	5727276
5566	JPM	JPMorgan Chase	Financials	332.99	2026-10-09	885149421073.05	2026-10-10 13:48:54.474	2026-10-11 13:43:27.043	331.2000	333.5400	330.5800	5058747
5567	V	Visa	Financials	385.45	2026-10-09	723626584581.55	2026-10-10 13:49:08.621	2026-10-11 13:43:41.142	375.7900	386.8400	375.5000	5927535
5568	AMZN	Amazon	Consumer Discretionary	262.43	2026-10-09	2830652270699.96	2026-10-10 13:49:21.981	2026-10-11 13:43:54.461	256.5000	262.8000	256.0000	34769999
5569	DIS	The Walt Disney Company	Consumer Discretionary	108.05	2026-10-09	186568519761.10	2026-10-10 13:49:35.505	2026-10-11 13:44:07.784	107.2200	108.3500	107.1400	7152298
5570	XOM	Exxon Mobil	Energy	168.94	2026-10-09	694666406522.40	2026-10-10 13:49:49.088	2026-10-11 13:44:21.101	167.8700	170.2900	167.8200	8086540
5571	CVX	Chevron	Energy	211.98	2026-10-09	415820662022.52	2026-10-10 13:50:02.452	2026-10-11 13:44:34.407	211.0500	213.7200	210.7100	6300416
\.


--
-- Data for Name: price_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_histories (id, symbol, "closePrice", date) FROM stdin;
\.


--
-- Data for Name: recovery_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recovery_results (id, symbol, "analysisDate", "currentPrice", "highestPrice", "lowestPrice", "avgVolume20", sma50, volume, "periodMonths", "isPassed", reason, "createdAt") FROM stdin;
71	MSFT	2026-10-10	0	0	0	0	0	0	3	f	ไม่ผ่านเกณฑ์: ไม่พบข้อมูลราคาหุ้นในช่วงเวลานี้	2026-10-11 13:38:12.732
72	NVDA	2026-10-10	0	0	0	0	0	0	3	f	ไม่ผ่านเกณฑ์: ไม่พบข้อมูลราคาหุ้นในช่วงเวลานี้	2026-10-11 13:38:12.802
73	LLY	2026-10-10	0	0	0	0	0	0	3	f	ไม่ผ่านเกณฑ์: ไม่พบข้อมูลราคาหุ้นในช่วงเวลานี้	2026-10-11 13:38:12.843
74	JNJ	2026-10-10	0	0	0	0	0	0	3	f	ไม่ผ่านเกณฑ์: ไม่พบข้อมูลราคาหุ้นในช่วงเวลานี้	2026-10-11 13:38:12.882
75	JPM	2026-10-10	0	0	0	0	0	0	3	f	ไม่ผ่านเกณฑ์: ไม่พบข้อมูลราคาหุ้นในช่วงเวลานี้	2026-10-11 13:38:12.922
76	V	2026-10-10	0	0	0	0	0	0	3	f	ไม่ผ่านเกณฑ์: ไม่พบข้อมูลราคาหุ้นในช่วงเวลานี้	2026-10-11 13:38:12.955
77	AMZN	2026-10-10	0	0	0	0	0	0	3	f	ไม่ผ่านเกณฑ์: ไม่พบข้อมูลราคาหุ้นในช่วงเวลานี้	2026-10-11 13:38:12.988
78	DIS	2026-10-10	0	0	0	0	0	0	3	f	ไม่ผ่านเกณฑ์: ไม่พบข้อมูลราคาหุ้นในช่วงเวลานี้	2026-10-11 13:38:13.03
79	XOM	2026-10-10	0	0	0	0	0	0	3	f	ไม่ผ่านเกณฑ์: ไม่พบข้อมูลราคาหุ้นในช่วงเวลานี้	2026-10-11 13:38:13.066
80	CVX	2026-10-10	0	0	0	0	0	0	3	f	ไม่ผ่านเกณฑ์: ไม่พบข้อมูลราคาหุ้นในช่วงเวลานี้	2026-10-11 13:38:13.102
\.


--
-- Data for Name: sma_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sma_records (id, symbol, period, "smaValue", "dataPointsUsed", "calculatedAt", "latestDate") FROM stdin;
1	DIS	20	107.31	20	2026-09-19 10:54:07.911849	\N
2	V	5	303.78	5	2026-09-19 10:54:47.062621	\N
3	V	5	241.76	5	2026-09-19 10:54:47.062621	\N
4	V	5	180.07	5	2026-09-19 10:54:47.062621	\N
5	V	5	181.15	5	2026-09-19 10:54:47.062621	\N
6	V	5	181.96	5	2026-09-19 10:54:47.062621	\N
7	V	5	182.62	5	2026-09-19 10:54:47.062621	\N
8	V	5	243.73	5	2026-09-19 10:54:47.062621	\N
9	V	5	302.83	5	2026-09-19 10:54:47.062621	\N
10	V	5	241.94	5	2026-09-19 10:54:47.062621	\N
11	V	5	181.19	5	2026-09-19 10:54:47.062621	\N
12	V	5	180.12	5	2026-09-19 10:54:47.062621	\N
13	V	5	179.46	5	2026-09-19 10:54:47.062621	\N
14	V	5	180.06	5	2026-09-19 10:54:47.062621	\N
15	V	5	240.22	5	2026-09-19 10:54:47.062621	\N
16	V	5	240.22	5	2026-09-19 10:54:47.062621	\N
17	V	5	180.31	5	2026-09-19 10:54:47.062621	\N
18	V	5	119.86	5	2026-09-19 10:54:47.062621	\N
19	V	5	120.83	5	2026-09-19 10:54:47.062621	\N
20	V	5	121.18	5	2026-09-19 10:54:47.062621	\N
21	V	5	182.97	5	2026-09-19 10:54:47.062621	\N
22	V	5	244.63	5	2026-09-19 10:54:47.062621	\N
23	V	5	305.50	5	2026-09-19 10:54:47.062621	\N
24	V	5	244.83	5	2026-09-19 10:54:47.062621	\N
25	V	5	184.32	5	2026-09-19 10:54:47.062621	\N
26	V	5	184.41	5	2026-09-19 10:54:47.062621	\N
27	V	5	185.02	5	2026-09-19 10:54:47.062621	\N
28	V	5	187.33	5	2026-09-19 10:54:47.062621	\N
29	V	5	250.35	5	2026-09-19 10:54:47.062621	\N
30	V	5	313.76	5	2026-09-19 10:54:47.062621	\N
31	V	5	251.88	5	2026-09-19 10:54:47.062621	\N
32	V	5	189.61	5	2026-09-19 10:54:47.062621	\N
33	V	5	189.21	5	2026-09-19 10:54:47.062621	\N
34	V	5	188.18	5	2026-09-19 10:54:47.062621	\N
35	V	5	187.03	5	2026-09-19 10:54:47.062621	\N
36	V	5	248.81	5	2026-09-19 10:54:47.062621	\N
37	V	5	310.69	5	2026-09-19 10:54:47.062621	\N
38	V	5	247.91	5	2026-09-19 10:54:47.062621	\N
39	V	5	185.92	5	2026-09-19 10:54:47.062621	\N
40	V	5	185.59	5	2026-09-19 10:54:47.062621	\N
41	V	5	185.67	5	2026-09-19 10:54:47.062621	\N
42	V	5	190.76	5	2026-09-19 10:54:47.062621	\N
43	V	5	256.73	5	2026-09-19 10:54:47.062621	\N
44	V	5	322.34	5	2026-09-19 10:54:47.062621	\N
45	V	5	260.41	5	2026-09-19 10:54:47.062621	\N
46	V	5	198.55	5	2026-09-19 10:54:47.062621	\N
47	V	5	196.94	5	2026-09-19 10:54:47.062621	\N
48	V	5	195.38	5	2026-09-19 10:54:47.062621	\N
49	V	5	193.54	5	2026-09-19 10:54:47.062621	\N
50	V	5	257.79	5	2026-09-19 10:54:47.062621	\N
51	V	5	321.55	5	2026-09-19 10:54:47.062621	\N
52	V	5	256.18	5	2026-09-19 10:54:47.062621	\N
53	V	5	191.77	5	2026-09-19 10:54:47.062621	\N
54	V	5	192.79	5	2026-09-19 10:54:47.062621	\N
55	V	5	193.81	5	2026-09-19 10:54:47.062621	\N
56	V	5	194.12	5	2026-09-19 10:54:47.062621	\N
57	V	5	258.62	5	2026-09-19 10:54:47.062621	\N
58	V	5	323.77	5	2026-09-19 10:54:47.062621	\N
59	V	5	259.00	5	2026-09-19 10:54:47.062621	\N
60	V	5	193.72	5	2026-09-19 10:54:47.062621	\N
61	V	5	196.18	5	2026-09-19 10:54:47.062621	\N
62	V	5	197.66	5	2026-09-19 10:54:47.062621	\N
63	V	5	198.66	5	2026-09-19 10:54:47.062621	\N
64	V	5	264.88	5	2026-09-19 10:54:47.062621	\N
65	V	5	330.66	5	2026-09-19 10:54:47.062621	\N
66	V	5	264.13	5	2026-09-19 10:54:47.062621	\N
67	V	5	198.15	5	2026-09-19 10:54:47.062621	\N
68	V	5	132.00	5	2026-09-19 10:54:47.062621	\N
69	V	5	131.07	5	2026-09-19 10:54:47.062621	\N
70	V	5	130.82	5	2026-09-19 10:54:47.062621	\N
71	V	5	195.81	5	2026-09-19 10:54:47.062621	\N
72	V	5	261.08	5	2026-09-19 10:54:47.062621	\N
73	V	5	261.08	5	2026-09-19 10:54:47.062621	\N
74	V	5	195.78	5	2026-09-19 10:54:47.062621	\N
75	V	5	194.82	5	2026-09-19 10:54:47.062621	\N
76	V	5	193.29	5	2026-09-19 10:54:47.062621	\N
77	V	5	190.50	5	2026-09-19 10:54:47.062621	\N
78	V	5	254.53	5	2026-09-19 10:54:47.062621	\N
79	V	5	319.25	5	2026-09-19 10:54:47.062621	\N
80	V	5	254.69	5	2026-09-19 10:54:47.062621	\N
81	V	5	191.23	5	2026-09-19 10:54:47.062621	\N
82	V	5	192.68	5	2026-09-19 10:54:47.062621	\N
83	V	5	193.66	5	2026-09-19 10:54:47.062621	\N
84	V	5	193.54	5	2026-09-19 10:54:47.062621	\N
85	V	5	257.35	5	2026-09-19 10:54:47.062621	\N
86	V	5	321.82	5	2026-09-19 10:54:47.062621	\N
87	V	5	257.89	5	2026-09-19 10:54:47.062621	\N
88	V	5	192.88	5	2026-09-19 10:54:47.062621	\N
89	V	5	193.05	5	2026-09-19 10:54:47.062621	\N
90	V	5	195.87	5	2026-09-19 10:54:47.062621	\N
91	V	5	197.46	5	2026-09-19 10:54:47.062621	\N
92	V	5	262.91	5	2026-09-19 10:54:47.062621	\N
93	V	5	262.91	5	2026-09-19 10:54:47.062621	\N
94	V	5	198.15	5	2026-09-19 10:54:47.062621	\N
95	V	5	131.52	5	2026-09-19 10:54:47.062621	\N
96	V	5	130.77	5	2026-09-19 10:54:47.062621	\N
97	V	5	131.02	5	2026-09-19 10:54:47.062621	\N
98	V	5	197.46	5	2026-09-19 10:54:47.062621	\N
99	V	5	263.57	5	2026-09-19 10:54:47.062621	\N
100	V	5	330.81	5	2026-09-19 10:54:47.062621	\N
101	V	5	265.49	5	2026-09-19 10:54:47.062621	\N
102	V	5	199.80	5	2026-09-19 10:54:47.062621	\N
103	V	5	201.68	5	2026-09-19 10:54:47.062621	\N
104	V	5	204.19	5	2026-09-19 10:54:47.062621	\N
105	V	5	207.16	5	2026-09-19 10:54:47.062621	\N
106	V	5	279.59	5	2026-09-19 10:54:47.062621	\N
107	V	5	279.59	5	2026-09-19 10:54:47.062621	\N
108	V	5	211.26	5	2026-09-19 10:54:47.062621	\N
109	V	5	142.64	5	2026-09-19 10:54:47.062621	\N
110	V	5	143.88	5	2026-09-19 10:54:47.062621	\N
111	V	5	141.89	5	2026-09-19 10:54:47.062621	\N
112	V	5	211.40	5	2026-09-19 10:54:47.062621	\N
113	V	5	281.04	5	2026-09-19 10:54:47.062621	\N
114	V	5	350.83	5	2026-09-19 10:54:47.062621	\N
115	V	5	279.38	5	2026-09-19 10:54:47.062621	\N
116	V	5	208.94	5	2026-09-19 10:54:47.062621	\N
117	V	5	210.98	5	2026-09-19 10:54:47.062621	\N
118	V	5	212.55	5	2026-09-19 10:54:47.062621	\N
119	V	5	213.78	5	2026-09-19 10:54:47.062621	\N
120	V	5	286.81	5	2026-09-19 10:54:47.062621	\N
121	V	5	358.52	5	2026-09-19 10:54:47.062621	\N
122	V	5	286.97	5	2026-09-19 10:54:47.062621	\N
123	V	5	215.77	5	2026-09-19 10:54:47.062621	\N
124	V	5	216.85	5	2026-09-19 10:54:47.062621	\N
125	V	5	214.99	5	2026-09-19 10:54:47.062621	\N
126	V	5	213.96	5	2026-09-19 10:54:47.062621	\N
127	V	5	284.28	5	2026-09-19 10:54:47.062621	\N
128	V	5	355.43	5	2026-09-19 10:54:47.062621	\N
129	V	5	283.32	5	2026-09-19 10:54:47.062621	\N
130	V	5	212.15	5	2026-09-19 10:54:47.062621	\N
131	V	5	213.97	5	2026-09-19 10:54:47.062621	\N
132	V	5	216.97	5	2026-09-19 10:54:47.062621	\N
133	V	5	219.57	5	2026-09-19 10:54:47.062621	\N
134	V	5	292.82	5	2026-09-19 10:54:47.062621	\N
135	V	5	366.05	5	2026-09-19 10:54:47.062621	\N
136	V	5	293.54	5	2026-09-19 10:54:47.062621	\N
137	V	5	220.23	5	2026-09-19 10:54:47.062621	\N
138	V	5	219.61	5	2026-09-19 10:54:47.062621	\N
139	V	5	220.28	5	2026-09-19 10:54:47.062621	\N
140	V	5	220.76	5	2026-09-19 10:54:47.062621	\N
141	V	5	294.85	5	2026-09-19 10:54:47.062621	\N
142	V	5	367.35	5	2026-09-19 10:54:47.062621	\N
143	V	5	294.22	5	2026-09-19 10:54:47.062621	\N
144	V	5	220.30	5	2026-09-19 10:54:47.062621	\N
145	V	5	218.86	5	2026-09-19 10:54:47.062621	\N
146	V	5	217.33	5	2026-09-19 10:54:47.062621	\N
147	V	5	216.71	5	2026-09-19 10:54:47.062621	\N
148	V	5	289.80	5	2026-09-19 10:54:47.062621	\N
149	V	5	362.63	5	2026-09-19 10:54:47.062621	\N
150	V	5	290.37	5	2026-09-19 10:54:47.062621	\N
151	V	5	217.80	5	2026-09-19 10:54:47.062621	\N
152	V	5	217.69	5	2026-09-19 10:54:47.062621	\N
153	V	5	217.45	5	2026-09-19 10:54:47.062621	\N
154	V	5	217.73	5	2026-09-19 10:54:47.062621	\N
155	V	5	290.87	5	2026-09-19 10:54:47.062621	\N
156	V	5	365.08	5	2026-09-19 10:54:47.062621	\N
157	V	5	293.31	5	2026-09-19 10:54:47.062621	\N
158	V	5	220.46	5	2026-09-19 10:54:47.062621	\N
159	V	5	223.84	5	2026-09-19 10:54:47.062621	\N
160	V	5	227.52	5	2026-09-19 10:54:47.062621	\N
161	V	5	230.09	5	2026-09-19 10:54:47.062621	\N
162	V	5	306.02	5	2026-09-19 10:54:47.062621	\N
163	V	5	382.34	5	2026-09-19 10:54:47.062621	\N
164	V	5	305.86	5	2026-09-19 10:54:47.062621	\N
165	V	5	229.03	5	2026-09-19 10:54:47.062621	\N
166	V	5	228.13	5	2026-09-19 10:54:47.062621	\N
167	V	5	226.73	5	2026-09-19 10:54:47.062621	\N
168	V	5	226.09	5	2026-09-19 10:54:47.062621	\N
169	V	5	301.84	5	2026-09-19 10:54:47.062621	\N
170	V	5	376.85	5	2026-09-19 10:54:47.062621	\N
171	V	5	300.98	5	2026-09-19 10:54:47.062621	\N
172	V	5	226.44	5	2026-09-19 10:54:47.062621	\N
173	V	5	150.76	5	2026-09-19 10:54:47.062621	\N
174	V	5	148.74	5	2026-09-19 10:54:47.062621	\N
175	V	5	147.21	5	2026-09-19 10:54:47.062621	\N
176	V	5	220.65	5	2026-09-19 10:54:47.062621	\N
177	V	5	294.74	5	2026-09-19 10:54:47.062621	\N
178	V	5	294.74	5	2026-09-19 10:54:47.062621	\N
179	V	5	221.01	5	2026-09-19 10:54:47.062621	\N
180	V	5	222.59	5	2026-09-19 10:54:47.062621	\N
181	V	5	224.27	5	2026-09-19 10:54:47.062621	\N
182	V	5	224.37	5	2026-09-19 10:54:47.062621	\N
183	V	5	224.37	5	2026-09-19 10:54:47.062621	\N
184	V	20	211.71	20	2026-09-19 10:54:47.096009	\N
185	V	20	196.20	20	2026-09-19 10:54:47.096009	\N
186	V	20	195.95	20	2026-09-19 10:54:47.096009	\N
187	V	20	196.12	20	2026-09-19 10:54:47.096009	\N
188	V	20	196.59	20	2026-09-19 10:54:47.096009	\N
189	V	20	196.92	20	2026-09-19 10:54:47.096009	\N
190	V	20	212.14	20	2026-09-19 10:54:47.096009	\N
191	V	20	212.14	20	2026-09-19 10:54:47.096009	\N
192	V	20	196.92	20	2026-09-19 10:54:47.096009	\N
193	V	20	197.20	20	2026-09-19 10:54:47.096009	\N
194	V	20	197.52	20	2026-09-19 10:54:47.096009	\N
195	V	20	198.04	20	2026-09-19 10:54:47.096009	\N
196	V	20	199.02	20	2026-09-19 10:54:47.096009	\N
197	V	20	214.87	20	2026-09-19 10:54:47.096009	\N
198	V	20	214.87	20	2026-09-19 10:54:47.096009	\N
199	V	20	199.89	20	2026-09-19 10:54:47.096009	\N
200	V	20	200.48	20	2026-09-19 10:54:47.096009	\N
201	V	20	201.05	20	2026-09-19 10:54:47.096009	\N
202	V	20	201.57	20	2026-09-19 10:54:47.096009	\N
203	V	20	217.02	20	2026-09-19 10:54:47.096009	\N
204	V	20	232.49	20	2026-09-19 10:54:47.096009	\N
205	V	20	232.49	20	2026-09-19 10:54:47.096009	\N
206	V	20	217.32	20	2026-09-19 10:54:47.096009	\N
207	V	20	217.68	20	2026-09-19 10:54:47.096009	\N
208	V	20	217.69	20	2026-09-19 10:54:47.096009	\N
209	V	20	219.02	20	2026-09-19 10:54:47.096009	\N
210	V	20	220.30	20	2026-09-19 10:54:47.096009	\N
211	V	20	236.70	20	2026-09-19 10:54:47.096009	\N
212	V	20	236.70	20	2026-09-19 10:54:47.096009	\N
213	V	20	221.23	20	2026-09-19 10:54:47.096009	\N
214	V	20	222.00	20	2026-09-19 10:54:47.096009	\N
215	V	20	222.31	20	2026-09-19 10:54:47.096009	\N
216	V	20	222.49	20	2026-09-19 10:54:47.096009	\N
217	V	20	222.71	20	2026-09-19 10:54:47.096009	\N
218	V	20	238.65	20	2026-09-19 10:54:47.096009	\N
219	V	20	238.65	20	2026-09-19 10:54:47.096009	\N
220	V	20	222.95	20	2026-09-19 10:54:47.096009	\N
221	V	20	223.64	20	2026-09-19 10:54:47.096009	\N
222	V	20	224.40	20	2026-09-19 10:54:47.096009	\N
223	V	20	224.97	20	2026-09-19 10:54:47.096009	\N
224	V	20	225.63	20	2026-09-19 10:54:47.096009	\N
225	V	20	241.91	20	2026-09-19 10:54:47.096009	\N
226	V	20	241.91	20	2026-09-19 10:54:47.096009	\N
227	V	20	226.43	20	2026-09-19 10:54:47.096009	\N
228	V	20	227.60	20	2026-09-19 10:54:47.096009	\N
229	V	20	227.35	20	2026-09-19 10:54:47.096009	\N
230	V	20	227.40	20	2026-09-19 10:54:47.096009	\N
231	V	20	227.55	20	2026-09-19 10:54:47.096009	\N
232	V	20	244.00	20	2026-09-19 10:54:47.096009	\N
233	V	20	244.00	20	2026-09-19 10:54:47.096009	\N
234	V	20	227.65	20	2026-09-19 10:54:47.096009	\N
235	V	20	211.55	20	2026-09-19 10:54:47.096009	\N
236	V	20	211.94	20	2026-09-19 10:54:47.096009	\N
237	V	20	212.25	20	2026-09-19 10:54:47.096009	\N
238	V	20	212.56	20	2026-09-19 10:54:47.096009	\N
239	V	20	228.88	20	2026-09-19 10:54:47.096009	\N
240	V	20	228.88	20	2026-09-19 10:54:47.096009	\N
241	V	20	212.69	20	2026-09-19 10:54:47.096009	\N
242	V	20	212.50	20	2026-09-19 10:54:47.096009	\N
243	V	20	212.35	20	2026-09-19 10:54:47.096009	\N
244	V	20	211.85	20	2026-09-19 10:54:47.096009	\N
245	V	20	211.57	20	2026-09-19 10:54:47.096009	\N
246	V	20	227.75	20	2026-09-19 10:54:47.096009	\N
247	V	20	227.75	20	2026-09-19 10:54:47.096009	\N
248	V	20	211.12	20	2026-09-19 10:54:47.096009	\N
249	V	20	210.60	20	2026-09-19 10:54:47.096009	\N
250	V	20	210.32	20	2026-09-19 10:54:47.096009	\N
251	V	20	209.91	20	2026-09-19 10:54:47.096009	\N
252	V	20	209.42	20	2026-09-19 10:54:47.096009	\N
253	V	20	225.54	20	2026-09-19 10:54:47.096009	\N
254	V	20	225.54	20	2026-09-19 10:54:47.096009	\N
255	V	20	225.54	20	2026-09-19 10:54:47.096009	\N
256	V	20	225.41	20	2026-09-19 10:54:47.096009	\N
257	V	20	225.68	20	2026-09-19 10:54:47.096009	\N
258	V	20	225.95	20	2026-09-19 10:54:47.096009	\N
259	V	20	226.00	20	2026-09-19 10:54:47.096009	\N
260	V	20	226.00	20	2026-09-19 10:54:47.096009	\N
261	V	20	226.00	20	2026-09-19 10:54:47.096009	\N
262	V	20	209.86	20	2026-09-19 10:54:47.096009	\N
263	V	20	210.32	20	2026-09-19 10:54:47.096009	\N
264	V	20	211.13	20	2026-09-19 10:54:47.096009	\N
265	V	20	211.73	20	2026-09-19 10:54:47.096009	\N
266	V	20	212.08	20	2026-09-19 10:54:47.096009	\N
267	V	20	228.89	20	2026-09-19 10:54:47.096009	\N
268	V	20	228.89	20	2026-09-19 10:54:47.096009	\N
269	V	20	212.90	20	2026-09-19 10:54:47.096009	\N
270	V	20	213.73	20	2026-09-19 10:54:47.096009	\N
271	V	20	214.74	20	2026-09-19 10:54:47.096009	\N
272	V	20	216.34	20	2026-09-19 10:54:47.096009	\N
273	V	20	218.33	20	2026-09-19 10:54:47.096009	\N
274	V	20	218.33	20	2026-09-19 10:54:47.096009	\N
275	V	20	218.33	20	2026-09-19 10:54:47.096009	\N
276	V	20	202.14	20	2026-09-19 10:54:47.096009	\N
277	V	20	203.34	20	2026-09-19 10:54:47.096009	\N
278	V	20	204.44	20	2026-09-19 10:54:47.096009	\N
279	V	20	205.45	20	2026-09-19 10:54:47.096009	\N
280	V	20	222.86	20	2026-09-19 10:54:47.096009	\N
281	V	20	240.31	20	2026-09-19 10:54:47.096009	\N
282	V	20	240.31	20	2026-09-19 10:54:47.096009	\N
283	V	20	223.98	20	2026-09-19 10:54:47.096009	\N
284	V	20	225.44	20	2026-09-19 10:54:47.096009	\N
285	V	20	226.63	20	2026-09-19 10:54:47.096009	\N
286	V	20	227.86	20	2026-09-19 10:54:47.096009	\N
287	V	20	229.31	20	2026-09-19 10:54:47.096009	\N
288	V	20	247.24	20	2026-09-19 10:54:47.096009	\N
289	V	20	247.24	20	2026-09-19 10:54:47.096009	\N
290	V	20	230.15	20	2026-09-19 10:54:47.096009	\N
291	V	20	231.03	20	2026-09-19 10:54:47.096009	\N
292	V	20	231.26	20	2026-09-19 10:54:47.096009	\N
293	V	20	230.83	20	2026-09-19 10:54:47.096009	\N
294	V	20	248.41	20	2026-09-19 10:54:47.096009	\N
295	V	20	266.20	20	2026-09-19 10:54:47.096009	\N
296	V	20	266.20	20	2026-09-19 10:54:47.096009	\N
297	V	20	248.33	20	2026-09-19 10:54:47.096009	\N
298	V	20	248.85	20	2026-09-19 10:54:47.096009	\N
299	V	20	249.80	20	2026-09-19 10:54:47.096009	\N
300	V	20	250.83	20	2026-09-19 10:54:47.096009	\N
301	V	20	251.69	20	2026-09-19 10:54:47.096009	\N
302	V	20	270.00	20	2026-09-19 10:54:47.096009	\N
303	V	20	270.00	20	2026-09-19 10:54:47.096009	\N
304	V	20	252.11	20	2026-09-19 10:54:47.096009	\N
305	V	20	252.60	20	2026-09-19 10:54:47.096009	\N
306	V	20	253.32	20	2026-09-19 10:54:47.096009	\N
307	V	20	253.49	20	2026-09-19 10:54:47.096009	\N
308	V	20	254.08	20	2026-09-19 10:54:47.096009	\N
309	V	20	272.21	20	2026-09-19 10:54:47.096009	\N
310	V	20	272.21	20	2026-09-19 10:54:47.096009	\N
311	V	20	254.18	20	2026-09-19 10:54:47.096009	\N
312	V	20	254.45	20	2026-09-19 10:54:47.096009	\N
313	V	20	254.93	20	2026-09-19 10:54:47.096009	\N
314	V	20	255.32	20	2026-09-19 10:54:47.096009	\N
315	V	20	255.80	20	2026-09-19 10:54:47.096009	\N
316	V	20	274.01	20	2026-09-19 10:54:47.096009	\N
317	V	20	274.01	20	2026-09-19 10:54:47.096009	\N
318	V	20	255.88	20	2026-09-19 10:54:47.096009	\N
319	V	20	255.50	20	2026-09-19 10:54:47.096009	\N
320	V	20	255.27	20	2026-09-19 10:54:47.096009	\N
321	V	20	255.23	20	2026-09-19 10:54:47.096009	\N
322	V	20	255.21	20	2026-09-19 10:54:47.096009	\N
323	V	20	273.77	20	2026-09-19 10:54:47.096009	\N
324	V	20	273.77	20	2026-09-19 10:54:47.096009	\N
325	V	20	255.48	20	2026-09-19 10:54:47.096009	\N
326	V	20	256.12	20	2026-09-19 10:54:47.096009	\N
327	V	20	256.90	20	2026-09-19 10:54:47.096009	\N
328	V	20	257.58	20	2026-09-19 10:54:47.096009	\N
329	V	20	258.43	20	2026-09-19 10:54:47.096009	\N
330	V	20	277.51	20	2026-09-19 10:54:47.096009	\N
331	V	20	277.51	20	2026-09-19 10:54:47.096009	\N
332	V	20	259.45	20	2026-09-19 10:54:47.096009	\N
333	V	20	260.27	20	2026-09-19 10:54:47.096009	\N
334	V	20	260.94	20	2026-09-19 10:54:47.096009	\N
335	V	20	261.58	20	2026-09-19 10:54:47.096009	\N
336	V	20	262.31	20	2026-09-19 10:54:47.096009	\N
337	V	20	281.07	20	2026-09-19 10:54:47.096009	\N
338	V	20	281.07	20	2026-09-19 10:54:47.096009	\N
339	V	20	263.13	20	2026-09-19 10:54:47.096009	\N
340	V	20	244.91	20	2026-09-19 10:54:47.096009	\N
341	V	20	245.07	20	2026-09-19 10:54:47.096009	\N
342	V	20	245.15	20	2026-09-19 10:54:47.096009	\N
343	V	20	244.96	20	2026-09-19 10:54:47.096009	\N
344	V	20	263.48	20	2026-09-19 10:54:47.096009	\N
345	V	20	263.48	20	2026-09-19 10:54:47.096009	\N
346	V	20	244.36	20	2026-09-19 10:54:47.096009	\N
347	V	20	243.92	20	2026-09-19 10:54:47.096009	\N
348	V	20	243.51	20	2026-09-19 10:54:47.096009	\N
349	V	20	243.07	20	2026-09-19 10:54:47.096009	\N
350	V	20	223.99	20	2026-09-19 10:54:47.096009	\N
351	MSFT	50	460.20	50	2026-09-19 11:09:06.07616	\N
352	NVDA	50	213.58	50	2026-09-19 11:09:06.101767	\N
353	LLY	50	1179.91	50	2026-09-19 11:09:06.113783	\N
354	JNJ	50	262.93	50	2026-09-19 11:09:06.126705	\N
355	JPM	50	352.54	50	2026-09-19 11:09:06.139422	\N
356	V	50	366.23	50	2026-09-19 11:09:06.15247	\N
357	AMZN	50	255.55	50	2026-09-19 11:09:06.166982	\N
358	DIS	50	102.41	50	2026-09-19 11:09:06.179176	\N
359	XOM	50	156.82	50	2026-09-19 11:09:06.191874	\N
360	CVX	50	197.35	50	2026-09-19 11:09:06.201757	\N
361	DIS	20	107.31	20	2026-09-19 11:29:40.289644	\N
362	V	5	303.78	5	2026-09-22 20:09:40.334253	\N
363	V	5	241.76	5	2026-09-22 20:09:40.334253	\N
364	V	5	180.07	5	2026-09-22 20:09:40.334253	\N
365	V	5	181.15	5	2026-09-22 20:09:40.334253	\N
366	V	5	181.96	5	2026-09-22 20:09:40.334253	\N
367	V	5	182.62	5	2026-09-22 20:09:40.334253	\N
368	V	5	243.73	5	2026-09-22 20:09:40.334253	\N
369	V	5	302.83	5	2026-09-22 20:09:40.334253	\N
370	V	5	241.94	5	2026-09-22 20:09:40.334253	\N
371	V	5	181.19	5	2026-09-22 20:09:40.334253	\N
372	V	5	180.12	5	2026-09-22 20:09:40.334253	\N
373	V	5	179.46	5	2026-09-22 20:09:40.334253	\N
374	V	5	180.06	5	2026-09-22 20:09:40.334253	\N
375	V	5	240.22	5	2026-09-22 20:09:40.334253	\N
376	V	5	240.22	5	2026-09-22 20:09:40.334253	\N
377	V	5	180.31	5	2026-09-22 20:09:40.334253	\N
378	V	5	119.86	5	2026-09-22 20:09:40.334253	\N
379	V	5	120.83	5	2026-09-22 20:09:40.334253	\N
380	V	5	121.18	5	2026-09-22 20:09:40.334253	\N
381	V	5	182.97	5	2026-09-22 20:09:40.334253	\N
382	V	5	244.63	5	2026-09-22 20:09:40.334253	\N
383	V	5	305.50	5	2026-09-22 20:09:40.334253	\N
384	V	5	244.83	5	2026-09-22 20:09:40.334253	\N
385	V	5	184.32	5	2026-09-22 20:09:40.334253	\N
386	V	5	184.41	5	2026-09-22 20:09:40.334253	\N
387	V	5	185.02	5	2026-09-22 20:09:40.334253	\N
388	V	5	187.33	5	2026-09-22 20:09:40.334253	\N
389	V	5	250.35	5	2026-09-22 20:09:40.334253	\N
390	V	5	313.76	5	2026-09-22 20:09:40.334253	\N
391	V	5	251.88	5	2026-09-22 20:09:40.334253	\N
392	V	5	189.61	5	2026-09-22 20:09:40.334253	\N
393	V	5	189.21	5	2026-09-22 20:09:40.334253	\N
394	V	5	188.18	5	2026-09-22 20:09:40.334253	\N
395	V	5	187.03	5	2026-09-22 20:09:40.334253	\N
396	V	5	248.81	5	2026-09-22 20:09:40.334253	\N
397	V	5	310.69	5	2026-09-22 20:09:40.334253	\N
398	V	5	247.91	5	2026-09-22 20:09:40.334253	\N
399	V	5	185.92	5	2026-09-22 20:09:40.334253	\N
400	V	5	185.59	5	2026-09-22 20:09:40.334253	\N
401	V	5	185.67	5	2026-09-22 20:09:40.334253	\N
402	V	5	190.76	5	2026-09-22 20:09:40.334253	\N
403	V	5	256.73	5	2026-09-22 20:09:40.334253	\N
404	V	5	322.34	5	2026-09-22 20:09:40.334253	\N
405	V	5	260.41	5	2026-09-22 20:09:40.334253	\N
406	V	5	198.55	5	2026-09-22 20:09:40.334253	\N
407	V	5	196.94	5	2026-09-22 20:09:40.334253	\N
408	V	5	195.38	5	2026-09-22 20:09:40.334253	\N
409	V	5	193.54	5	2026-09-22 20:09:40.334253	\N
410	V	5	257.79	5	2026-09-22 20:09:40.334253	\N
411	V	5	321.55	5	2026-09-22 20:09:40.334253	\N
412	V	5	256.18	5	2026-09-22 20:09:40.334253	\N
413	V	5	191.77	5	2026-09-22 20:09:40.334253	\N
414	V	5	192.79	5	2026-09-22 20:09:40.334253	\N
415	V	5	193.81	5	2026-09-22 20:09:40.334253	\N
416	V	5	194.12	5	2026-09-22 20:09:40.334253	\N
417	V	5	258.62	5	2026-09-22 20:09:40.334253	\N
418	V	5	323.77	5	2026-09-22 20:09:40.334253	\N
419	V	5	259.00	5	2026-09-22 20:09:40.334253	\N
420	V	5	193.72	5	2026-09-22 20:09:40.334253	\N
421	V	5	196.18	5	2026-09-22 20:09:40.334253	\N
422	V	5	197.66	5	2026-09-22 20:09:40.334253	\N
423	V	5	198.66	5	2026-09-22 20:09:40.334253	\N
424	V	5	264.88	5	2026-09-22 20:09:40.334253	\N
425	V	5	330.66	5	2026-09-22 20:09:40.334253	\N
426	V	5	264.13	5	2026-09-22 20:09:40.334253	\N
427	V	5	198.15	5	2026-09-22 20:09:40.334253	\N
428	V	5	132.00	5	2026-09-22 20:09:40.334253	\N
429	V	5	131.07	5	2026-09-22 20:09:40.334253	\N
430	V	5	130.82	5	2026-09-22 20:09:40.334253	\N
431	V	5	195.81	5	2026-09-22 20:09:40.334253	\N
432	V	5	261.08	5	2026-09-22 20:09:40.334253	\N
433	V	5	261.08	5	2026-09-22 20:09:40.334253	\N
434	V	5	195.78	5	2026-09-22 20:09:40.334253	\N
435	V	5	194.82	5	2026-09-22 20:09:40.334253	\N
436	V	5	193.29	5	2026-09-22 20:09:40.334253	\N
437	V	5	190.50	5	2026-09-22 20:09:40.334253	\N
438	V	5	254.53	5	2026-09-22 20:09:40.334253	\N
439	V	5	319.25	5	2026-09-22 20:09:40.334253	\N
440	V	5	254.69	5	2026-09-22 20:09:40.334253	\N
441	V	5	191.23	5	2026-09-22 20:09:40.334253	\N
442	V	5	192.68	5	2026-09-22 20:09:40.334253	\N
443	V	5	193.66	5	2026-09-22 20:09:40.334253	\N
444	V	5	193.54	5	2026-09-22 20:09:40.334253	\N
445	V	5	257.35	5	2026-09-22 20:09:40.334253	\N
446	V	5	321.82	5	2026-09-22 20:09:40.334253	\N
447	V	5	257.89	5	2026-09-22 20:09:40.334253	\N
448	V	5	192.88	5	2026-09-22 20:09:40.334253	\N
449	V	5	193.05	5	2026-09-22 20:09:40.334253	\N
450	V	5	195.87	5	2026-09-22 20:09:40.334253	\N
451	V	5	197.46	5	2026-09-22 20:09:40.334253	\N
452	V	5	262.91	5	2026-09-22 20:09:40.334253	\N
453	V	5	262.91	5	2026-09-22 20:09:40.334253	\N
454	V	5	198.15	5	2026-09-22 20:09:40.334253	\N
455	V	5	131.52	5	2026-09-22 20:09:40.334253	\N
456	V	5	130.77	5	2026-09-22 20:09:40.334253	\N
457	V	5	131.02	5	2026-09-22 20:09:40.334253	\N
458	V	5	197.46	5	2026-09-22 20:09:40.334253	\N
459	V	5	263.57	5	2026-09-22 20:09:40.334253	\N
460	V	5	330.81	5	2026-09-22 20:09:40.334253	\N
461	V	5	265.49	5	2026-09-22 20:09:40.334253	\N
462	V	5	199.80	5	2026-09-22 20:09:40.334253	\N
463	V	5	201.68	5	2026-09-22 20:09:40.334253	\N
464	V	5	204.19	5	2026-09-22 20:09:40.334253	\N
465	V	5	207.16	5	2026-09-22 20:09:40.334253	\N
466	V	5	279.59	5	2026-09-22 20:09:40.334253	\N
467	V	5	279.59	5	2026-09-22 20:09:40.334253	\N
468	V	5	211.26	5	2026-09-22 20:09:40.334253	\N
469	V	5	142.64	5	2026-09-22 20:09:40.334253	\N
470	V	5	143.88	5	2026-09-22 20:09:40.334253	\N
471	V	5	141.89	5	2026-09-22 20:09:40.334253	\N
472	V	5	211.40	5	2026-09-22 20:09:40.334253	\N
473	V	5	281.04	5	2026-09-22 20:09:40.334253	\N
474	V	5	350.83	5	2026-09-22 20:09:40.334253	\N
475	V	5	279.38	5	2026-09-22 20:09:40.334253	\N
476	V	5	208.94	5	2026-09-22 20:09:40.334253	\N
477	V	5	210.98	5	2026-09-22 20:09:40.334253	\N
478	V	5	212.55	5	2026-09-22 20:09:40.334253	\N
479	V	5	213.78	5	2026-09-22 20:09:40.334253	\N
480	V	5	286.81	5	2026-09-22 20:09:40.334253	\N
481	V	5	358.52	5	2026-09-22 20:09:40.334253	\N
482	V	5	286.97	5	2026-09-22 20:09:40.334253	\N
483	V	5	215.77	5	2026-09-22 20:09:40.334253	\N
484	V	5	216.85	5	2026-09-22 20:09:40.334253	\N
485	V	5	214.99	5	2026-09-22 20:09:40.334253	\N
486	V	5	213.96	5	2026-09-22 20:09:40.334253	\N
487	V	5	284.28	5	2026-09-22 20:09:40.334253	\N
488	V	5	355.43	5	2026-09-22 20:09:40.334253	\N
489	V	5	283.32	5	2026-09-22 20:09:40.334253	\N
490	V	5	212.15	5	2026-09-22 20:09:40.334253	\N
491	V	5	213.97	5	2026-09-22 20:09:40.334253	\N
492	V	5	216.97	5	2026-09-22 20:09:40.334253	\N
493	V	5	219.57	5	2026-09-22 20:09:40.334253	\N
494	V	5	292.82	5	2026-09-22 20:09:40.334253	\N
495	V	5	366.05	5	2026-09-22 20:09:40.334253	\N
496	V	5	293.54	5	2026-09-22 20:09:40.334253	\N
497	V	5	220.23	5	2026-09-22 20:09:40.334253	\N
498	V	5	219.61	5	2026-09-22 20:09:40.334253	\N
499	V	5	220.28	5	2026-09-22 20:09:40.334253	\N
500	V	5	220.76	5	2026-09-22 20:09:40.334253	\N
501	V	5	294.85	5	2026-09-22 20:09:40.334253	\N
502	V	5	367.35	5	2026-09-22 20:09:40.334253	\N
503	V	5	294.22	5	2026-09-22 20:09:40.334253	\N
504	V	5	220.30	5	2026-09-22 20:09:40.334253	\N
505	V	5	218.86	5	2026-09-22 20:09:40.334253	\N
506	V	5	217.33	5	2026-09-22 20:09:40.334253	\N
507	V	5	216.71	5	2026-09-22 20:09:40.334253	\N
508	V	5	289.80	5	2026-09-22 20:09:40.334253	\N
509	V	5	362.63	5	2026-09-22 20:09:40.334253	\N
510	V	5	290.37	5	2026-09-22 20:09:40.334253	\N
511	V	5	217.80	5	2026-09-22 20:09:40.334253	\N
512	V	5	217.69	5	2026-09-22 20:09:40.334253	\N
513	V	5	217.45	5	2026-09-22 20:09:40.334253	\N
514	V	5	217.73	5	2026-09-22 20:09:40.334253	\N
515	V	5	290.87	5	2026-09-22 20:09:40.334253	\N
516	V	5	365.08	5	2026-09-22 20:09:40.334253	\N
517	V	5	293.31	5	2026-09-22 20:09:40.334253	\N
518	V	5	220.46	5	2026-09-22 20:09:40.334253	\N
519	V	5	223.84	5	2026-09-22 20:09:40.334253	\N
520	V	5	227.52	5	2026-09-22 20:09:40.334253	\N
521	V	5	230.09	5	2026-09-22 20:09:40.334253	\N
522	V	5	306.02	5	2026-09-22 20:09:40.334253	\N
523	V	5	382.34	5	2026-09-22 20:09:40.334253	\N
524	V	5	305.86	5	2026-09-22 20:09:40.334253	\N
525	V	5	229.03	5	2026-09-22 20:09:40.334253	\N
526	V	5	228.13	5	2026-09-22 20:09:40.334253	\N
527	V	5	226.73	5	2026-09-22 20:09:40.334253	\N
528	V	5	226.09	5	2026-09-22 20:09:40.334253	\N
529	V	5	301.84	5	2026-09-22 20:09:40.334253	\N
530	V	5	376.85	5	2026-09-22 20:09:40.334253	\N
531	V	5	300.98	5	2026-09-22 20:09:40.334253	\N
532	V	5	226.44	5	2026-09-22 20:09:40.334253	\N
533	V	5	150.76	5	2026-09-22 20:09:40.334253	\N
534	V	5	148.74	5	2026-09-22 20:09:40.334253	\N
535	V	5	147.21	5	2026-09-22 20:09:40.334253	\N
536	V	5	220.65	5	2026-09-22 20:09:40.334253	\N
537	V	5	294.74	5	2026-09-22 20:09:40.334253	\N
538	V	5	294.74	5	2026-09-22 20:09:40.334253	\N
539	V	5	221.01	5	2026-09-22 20:09:40.334253	\N
540	V	5	222.59	5	2026-09-22 20:09:40.334253	\N
541	V	5	224.27	5	2026-09-22 20:09:40.334253	\N
542	V	5	224.37	5	2026-09-22 20:09:40.334253	\N
543	V	5	224.37	5	2026-09-22 20:09:40.334253	\N
544	V	20	211.71	20	2026-09-22 20:09:40.362444	\N
545	V	20	196.20	20	2026-09-22 20:09:40.362444	\N
546	V	20	195.95	20	2026-09-22 20:09:40.362444	\N
547	V	20	196.12	20	2026-09-22 20:09:40.362444	\N
548	V	20	196.59	20	2026-09-22 20:09:40.362444	\N
549	V	20	196.92	20	2026-09-22 20:09:40.362444	\N
550	V	20	212.14	20	2026-09-22 20:09:40.362444	\N
551	V	20	212.14	20	2026-09-22 20:09:40.362444	\N
552	V	20	196.92	20	2026-09-22 20:09:40.362444	\N
553	V	20	197.20	20	2026-09-22 20:09:40.362444	\N
554	V	20	197.52	20	2026-09-22 20:09:40.362444	\N
555	V	20	198.04	20	2026-09-22 20:09:40.362444	\N
556	V	20	199.02	20	2026-09-22 20:09:40.362444	\N
557	V	20	214.87	20	2026-09-22 20:09:40.362444	\N
558	V	20	214.87	20	2026-09-22 20:09:40.362444	\N
559	V	20	199.89	20	2026-09-22 20:09:40.362444	\N
560	V	20	200.48	20	2026-09-22 20:09:40.362444	\N
561	V	20	201.05	20	2026-09-22 20:09:40.362444	\N
562	V	20	201.57	20	2026-09-22 20:09:40.362444	\N
563	V	20	217.02	20	2026-09-22 20:09:40.362444	\N
564	V	20	232.49	20	2026-09-22 20:09:40.362444	\N
565	V	20	232.49	20	2026-09-22 20:09:40.362444	\N
566	V	20	217.32	20	2026-09-22 20:09:40.362444	\N
567	V	20	217.68	20	2026-09-22 20:09:40.362444	\N
568	V	20	217.69	20	2026-09-22 20:09:40.362444	\N
569	V	20	219.02	20	2026-09-22 20:09:40.362444	\N
570	V	20	220.30	20	2026-09-22 20:09:40.362444	\N
571	V	20	236.70	20	2026-09-22 20:09:40.362444	\N
572	V	20	236.70	20	2026-09-22 20:09:40.362444	\N
573	V	20	221.23	20	2026-09-22 20:09:40.362444	\N
574	V	20	222.00	20	2026-09-22 20:09:40.362444	\N
575	V	20	222.31	20	2026-09-22 20:09:40.362444	\N
576	V	20	222.49	20	2026-09-22 20:09:40.362444	\N
577	V	20	222.71	20	2026-09-22 20:09:40.362444	\N
578	V	20	238.65	20	2026-09-22 20:09:40.362444	\N
579	V	20	238.65	20	2026-09-22 20:09:40.362444	\N
580	V	20	222.95	20	2026-09-22 20:09:40.362444	\N
581	V	20	223.64	20	2026-09-22 20:09:40.362444	\N
582	V	20	224.40	20	2026-09-22 20:09:40.362444	\N
583	V	20	224.97	20	2026-09-22 20:09:40.362444	\N
584	V	20	225.63	20	2026-09-22 20:09:40.362444	\N
585	V	20	241.91	20	2026-09-22 20:09:40.362444	\N
586	V	20	241.91	20	2026-09-22 20:09:40.362444	\N
587	V	20	226.43	20	2026-09-22 20:09:40.362444	\N
588	V	20	227.60	20	2026-09-22 20:09:40.362444	\N
589	V	20	227.35	20	2026-09-22 20:09:40.362444	\N
590	V	20	227.40	20	2026-09-22 20:09:40.362444	\N
591	V	20	227.55	20	2026-09-22 20:09:40.362444	\N
592	V	20	244.00	20	2026-09-22 20:09:40.362444	\N
593	V	20	244.00	20	2026-09-22 20:09:40.362444	\N
594	V	20	227.65	20	2026-09-22 20:09:40.362444	\N
595	V	20	211.55	20	2026-09-22 20:09:40.362444	\N
596	V	20	211.94	20	2026-09-22 20:09:40.362444	\N
597	V	20	212.25	20	2026-09-22 20:09:40.362444	\N
598	V	20	212.56	20	2026-09-22 20:09:40.362444	\N
599	V	20	228.88	20	2026-09-22 20:09:40.362444	\N
600	V	20	228.88	20	2026-09-22 20:09:40.362444	\N
601	V	20	212.69	20	2026-09-22 20:09:40.362444	\N
602	V	20	212.50	20	2026-09-22 20:09:40.362444	\N
603	V	20	212.35	20	2026-09-22 20:09:40.362444	\N
604	V	20	211.85	20	2026-09-22 20:09:40.362444	\N
605	V	20	211.57	20	2026-09-22 20:09:40.362444	\N
606	V	20	227.75	20	2026-09-22 20:09:40.362444	\N
607	V	20	227.75	20	2026-09-22 20:09:40.362444	\N
608	V	20	211.12	20	2026-09-22 20:09:40.362444	\N
609	V	20	210.60	20	2026-09-22 20:09:40.362444	\N
610	V	20	210.32	20	2026-09-22 20:09:40.362444	\N
611	V	20	209.91	20	2026-09-22 20:09:40.362444	\N
612	V	20	209.42	20	2026-09-22 20:09:40.362444	\N
613	V	20	225.54	20	2026-09-22 20:09:40.362444	\N
614	V	20	225.54	20	2026-09-22 20:09:40.362444	\N
615	V	20	225.54	20	2026-09-22 20:09:40.362444	\N
616	V	20	225.41	20	2026-09-22 20:09:40.362444	\N
617	V	20	225.68	20	2026-09-22 20:09:40.362444	\N
618	V	20	225.95	20	2026-09-22 20:09:40.362444	\N
619	V	20	226.00	20	2026-09-22 20:09:40.362444	\N
620	V	20	226.00	20	2026-09-22 20:09:40.362444	\N
621	V	20	226.00	20	2026-09-22 20:09:40.362444	\N
622	V	20	209.86	20	2026-09-22 20:09:40.362444	\N
623	V	20	210.32	20	2026-09-22 20:09:40.362444	\N
624	V	20	211.13	20	2026-09-22 20:09:40.362444	\N
625	V	20	211.73	20	2026-09-22 20:09:40.362444	\N
626	V	20	212.08	20	2026-09-22 20:09:40.362444	\N
627	V	20	228.89	20	2026-09-22 20:09:40.362444	\N
628	V	20	228.89	20	2026-09-22 20:09:40.362444	\N
629	V	20	212.90	20	2026-09-22 20:09:40.362444	\N
630	V	20	213.73	20	2026-09-22 20:09:40.362444	\N
631	V	20	214.74	20	2026-09-22 20:09:40.362444	\N
632	V	20	216.34	20	2026-09-22 20:09:40.362444	\N
633	V	20	218.33	20	2026-09-22 20:09:40.362444	\N
634	V	20	218.33	20	2026-09-22 20:09:40.362444	\N
635	V	20	218.33	20	2026-09-22 20:09:40.362444	\N
636	V	20	202.14	20	2026-09-22 20:09:40.362444	\N
637	V	20	203.34	20	2026-09-22 20:09:40.362444	\N
638	V	20	204.44	20	2026-09-22 20:09:40.362444	\N
639	V	20	205.45	20	2026-09-22 20:09:40.362444	\N
640	V	20	222.86	20	2026-09-22 20:09:40.362444	\N
641	V	20	240.31	20	2026-09-22 20:09:40.362444	\N
642	V	20	240.31	20	2026-09-22 20:09:40.362444	\N
643	V	20	223.98	20	2026-09-22 20:09:40.362444	\N
644	V	20	225.44	20	2026-09-22 20:09:40.362444	\N
645	V	20	226.63	20	2026-09-22 20:09:40.362444	\N
646	V	20	227.86	20	2026-09-22 20:09:40.362444	\N
647	V	20	229.31	20	2026-09-22 20:09:40.362444	\N
648	V	20	247.24	20	2026-09-22 20:09:40.362444	\N
649	V	20	247.24	20	2026-09-22 20:09:40.362444	\N
650	V	20	230.15	20	2026-09-22 20:09:40.362444	\N
651	V	20	231.03	20	2026-09-22 20:09:40.362444	\N
652	V	20	231.26	20	2026-09-22 20:09:40.362444	\N
653	V	20	230.83	20	2026-09-22 20:09:40.362444	\N
654	V	20	248.41	20	2026-09-22 20:09:40.362444	\N
655	V	20	266.20	20	2026-09-22 20:09:40.362444	\N
656	V	20	266.20	20	2026-09-22 20:09:40.362444	\N
657	V	20	248.33	20	2026-09-22 20:09:40.362444	\N
658	V	20	248.85	20	2026-09-22 20:09:40.362444	\N
659	V	20	249.80	20	2026-09-22 20:09:40.362444	\N
660	V	20	250.83	20	2026-09-22 20:09:40.362444	\N
661	V	20	251.69	20	2026-09-22 20:09:40.362444	\N
662	V	20	270.00	20	2026-09-22 20:09:40.362444	\N
663	V	20	270.00	20	2026-09-22 20:09:40.362444	\N
664	V	20	252.11	20	2026-09-22 20:09:40.362444	\N
665	V	20	252.60	20	2026-09-22 20:09:40.362444	\N
666	V	20	253.32	20	2026-09-22 20:09:40.362444	\N
667	V	20	253.49	20	2026-09-22 20:09:40.362444	\N
668	V	20	254.08	20	2026-09-22 20:09:40.362444	\N
669	V	20	272.21	20	2026-09-22 20:09:40.362444	\N
670	V	20	272.21	20	2026-09-22 20:09:40.362444	\N
671	V	20	254.18	20	2026-09-22 20:09:40.362444	\N
672	V	20	254.45	20	2026-09-22 20:09:40.362444	\N
673	V	20	254.93	20	2026-09-22 20:09:40.362444	\N
674	V	20	255.32	20	2026-09-22 20:09:40.362444	\N
675	V	20	255.80	20	2026-09-22 20:09:40.362444	\N
676	V	20	274.01	20	2026-09-22 20:09:40.362444	\N
677	V	20	274.01	20	2026-09-22 20:09:40.362444	\N
678	V	20	255.88	20	2026-09-22 20:09:40.362444	\N
679	V	20	255.50	20	2026-09-22 20:09:40.362444	\N
680	V	20	255.27	20	2026-09-22 20:09:40.362444	\N
681	V	20	255.23	20	2026-09-22 20:09:40.362444	\N
682	V	20	255.21	20	2026-09-22 20:09:40.362444	\N
683	V	20	273.77	20	2026-09-22 20:09:40.362444	\N
684	V	20	273.77	20	2026-09-22 20:09:40.362444	\N
685	V	20	255.48	20	2026-09-22 20:09:40.362444	\N
686	V	20	256.12	20	2026-09-22 20:09:40.362444	\N
687	V	20	256.90	20	2026-09-22 20:09:40.362444	\N
688	V	20	257.58	20	2026-09-22 20:09:40.362444	\N
689	V	20	258.43	20	2026-09-22 20:09:40.362444	\N
690	V	20	277.51	20	2026-09-22 20:09:40.362444	\N
691	V	20	277.51	20	2026-09-22 20:09:40.362444	\N
692	V	20	259.45	20	2026-09-22 20:09:40.362444	\N
693	V	20	260.27	20	2026-09-22 20:09:40.362444	\N
694	V	20	260.94	20	2026-09-22 20:09:40.362444	\N
695	V	20	261.58	20	2026-09-22 20:09:40.362444	\N
696	V	20	262.31	20	2026-09-22 20:09:40.362444	\N
697	V	20	281.07	20	2026-09-22 20:09:40.362444	\N
698	V	20	281.07	20	2026-09-22 20:09:40.362444	\N
699	V	20	263.13	20	2026-09-22 20:09:40.362444	\N
700	V	20	244.91	20	2026-09-22 20:09:40.362444	\N
701	V	20	245.07	20	2026-09-22 20:09:40.362444	\N
702	V	20	245.15	20	2026-09-22 20:09:40.362444	\N
703	V	20	244.96	20	2026-09-22 20:09:40.362444	\N
704	V	20	263.48	20	2026-09-22 20:09:40.362444	\N
705	V	20	263.48	20	2026-09-22 20:09:40.362444	\N
706	V	20	244.36	20	2026-09-22 20:09:40.362444	\N
707	V	20	243.92	20	2026-09-22 20:09:40.362444	\N
708	V	20	243.51	20	2026-09-22 20:09:40.362444	\N
709	V	20	243.07	20	2026-09-22 20:09:40.362444	\N
710	V	20	223.99	20	2026-09-22 20:09:40.362444	\N
711	V	5	269.94	5	2026-09-23 22:06:08.131461	\N
712	V	5	202.20	5	2026-09-23 22:06:08.131461	\N
713	V	5	202.49	5	2026-09-23 22:06:08.131461	\N
714	V	5	203.78	5	2026-09-23 22:06:08.131461	\N
715	V	5	205.87	5	2026-09-23 22:06:08.131461	\N
716	V	5	275.06	5	2026-09-23 22:06:08.131461	\N
717	V	5	345.03	5	2026-09-23 22:06:08.131461	\N
718	V	5	277.00	5	2026-09-23 22:06:08.131461	\N
719	V	5	208.72	5	2026-09-23 22:06:08.131461	\N
720	V	5	209.01	5	2026-09-23 22:06:08.131461	\N
721	V	5	210.31	5	2026-09-23 22:06:08.131461	\N
722	V	5	210.61	5	2026-09-23 22:06:08.131461	\N
723	V	5	280.02	5	2026-09-23 22:06:08.131461	\N
724	V	5	348.75	5	2026-09-23 22:06:08.131461	\N
725	V	5	278.89	5	2026-09-23 22:06:08.131461	\N
726	V	5	208.41	5	2026-09-23 22:06:08.131461	\N
727	V	5	206.80	5	2026-09-23 22:06:08.131461	\N
728	V	5	207.07	5	2026-09-23 22:06:08.131461	\N
729	V	5	207.47	5	2026-09-23 22:06:08.131461	\N
730	V	5	274.55	5	2026-09-23 22:06:08.131461	\N
731	V	5	342.93	5	2026-09-23 22:06:08.131461	\N
732	V	5	274.27	5	2026-09-23 22:06:08.131461	\N
733	V	5	204.60	5	2026-09-23 22:06:08.131461	\N
734	V	5	204.34	5	2026-09-23 22:06:08.131461	\N
735	V	5	206.70	5	2026-09-23 22:06:08.131461	\N
736	V	5	207.40	5	2026-09-23 22:06:08.131461	\N
737	V	5	276.59	5	2026-09-23 22:06:08.131461	\N
738	V	5	346.06	5	2026-09-23 22:06:08.131461	\N
739	V	5	277.18	5	2026-09-23 22:06:08.131461	\N
740	V	5	207.74	5	2026-09-23 22:06:08.131461	\N
741	V	5	208.23	5	2026-09-23 22:06:08.131461	\N
742	V	5	208.42	5	2026-09-23 22:06:08.131461	\N
743	V	5	207.20	5	2026-09-23 22:06:08.131461	\N
744	V	5	276.21	5	2026-09-23 22:06:08.131461	\N
745	V	5	344.35	5	2026-09-23 22:06:08.131461	\N
746	V	5	274.79	5	2026-09-23 22:06:08.131461	\N
747	V	5	205.41	5	2026-09-23 22:06:08.131461	\N
748	V	5	204.53	5	2026-09-23 22:06:08.131461	\N
749	V	5	203.59	5	2026-09-23 22:06:08.131461	\N
750	V	5	203.45	5	2026-09-23 22:06:08.131461	\N
751	V	5	270.84	5	2026-09-23 22:06:08.131461	\N
752	V	5	338.04	5	2026-09-23 22:06:08.131461	\N
753	V	5	270.66	5	2026-09-23 22:06:08.131461	\N
754	V	5	202.60	5	2026-09-23 22:06:08.131461	\N
755	V	5	201.57	5	2026-09-23 22:06:08.131461	\N
756	V	5	201.96	5	2026-09-23 22:06:08.131461	\N
757	V	5	202.53	5	2026-09-23 22:06:08.131461	\N
758	V	5	269.75	5	2026-09-23 22:06:08.131461	\N
759	V	5	335.75	5	2026-09-23 22:06:08.131461	\N
760	V	5	268.78	5	2026-09-23 22:06:08.131461	\N
761	V	5	201.00	5	2026-09-23 22:06:08.131461	\N
762	V	5	198.37	5	2026-09-23 22:06:08.131461	\N
763	V	5	195.39	5	2026-09-23 22:06:08.131461	\N
764	V	5	194.21	5	2026-09-23 22:06:08.131461	\N
765	V	5	258.96	5	2026-09-23 22:06:08.131461	\N
766	V	5	324.56	5	2026-09-23 22:06:08.131461	\N
767	V	5	259.41	5	2026-09-23 22:06:08.131461	\N
768	V	5	195.17	5	2026-09-23 22:06:08.131461	\N
769	V	5	196.21	5	2026-09-23 22:06:08.131461	\N
770	V	5	198.36	5	2026-09-23 22:06:08.131461	\N
771	V	5	199.52	5	2026-09-23 22:06:08.131461	\N
772	V	5	199.52	5	2026-09-23 22:06:08.131461	\N
773	V	5	266.41	5	2026-09-23 22:06:08.131461	\N
774	V	5	200.55	5	2026-09-23 22:06:08.131461	\N
775	V	5	133.65	5	2026-09-23 22:06:08.131461	\N
776	V	5	132.97	5	2026-09-23 22:06:08.131461	\N
777	V	5	198.89	5	2026-09-23 22:06:08.131461	\N
778	V	5	197.92	5	2026-09-23 22:06:08.131461	\N
779	V	5	263.34	5	2026-09-23 22:06:08.131461	\N
780	V	5	329.59	5	2026-09-23 22:06:08.131461	\N
781	V	5	263.51	5	2026-09-23 22:06:08.131461	\N
782	V	5	197.59	5	2026-09-23 22:06:08.131461	\N
783	V	5	197.04	5	2026-09-23 22:06:08.131461	\N
784	V	5	196.92	5	2026-09-23 22:06:08.131461	\N
785	V	5	195.81	5	2026-09-23 22:06:08.131461	\N
786	V	5	264.94	5	2026-09-23 22:06:08.131461	\N
787	V	5	334.51	5	2026-09-23 22:06:08.131461	\N
788	V	5	269.14	5	2026-09-23 22:06:08.131461	\N
789	V	5	203.84	5	2026-09-23 22:06:08.131461	\N
790	V	5	208.07	5	2026-09-23 22:06:08.131461	\N
791	V	5	207.97	5	2026-09-23 22:06:08.131461	\N
792	V	5	207.28	5	2026-09-23 22:06:08.131461	\N
793	V	5	276.48	5	2026-09-23 22:06:08.131461	\N
794	V	5	346.33	5	2026-09-23 22:06:08.131461	\N
795	V	5	276.96	5	2026-09-23 22:06:08.131461	\N
796	V	5	207.93	5	2026-09-23 22:06:08.131461	\N
797	V	5	209.47	5	2026-09-23 22:06:08.131461	\N
798	V	5	210.94	5	2026-09-23 22:06:08.131461	\N
799	V	5	212.12	5	2026-09-23 22:06:08.131461	\N
800	V	5	212.12	5	2026-09-23 22:06:08.131461	\N
801	V	5	283.12	5	2026-09-23 22:06:08.131461	\N
802	V	5	212.70	5	2026-09-23 22:06:08.131461	\N
803	V	5	142.03	5	2026-09-23 22:06:08.131461	\N
804	V	5	141.92	5	2026-09-23 22:06:08.131461	\N
805	V	5	212.65	5	2026-09-23 22:06:08.131461	\N
806	V	5	211.79	5	2026-09-23 22:06:08.131461	\N
807	V	5	211.79	5	2026-09-23 22:06:08.131461	\N
808	V	5	281.08	5	2026-09-23 22:06:08.131461	\N
809	V	5	210.16	5	2026-09-23 22:06:08.131461	\N
810	V	5	139.44	5	2026-09-23 22:06:08.131461	\N
811	V	5	140.06	5	2026-09-23 22:06:08.131461	\N
812	V	5	211.57	5	2026-09-23 22:06:08.131461	\N
813	V	5	213.45	5	2026-09-23 22:06:08.131461	\N
814	V	5	283.89	5	2026-09-23 22:06:08.131461	\N
815	V	5	353.85	5	2026-09-23 22:06:08.131461	\N
816	V	5	283.09	5	2026-09-23 22:06:08.131461	\N
817	V	5	211.58	5	2026-09-23 22:06:08.131461	\N
818	V	5	209.04	5	2026-09-23 22:06:08.131461	\N
819	V	5	204.17	5	2026-09-23 22:06:08.131461	\N
820	V	5	200.05	5	2026-09-23 22:06:08.131461	\N
821	V	5	265.60	5	2026-09-23 22:06:08.131461	\N
822	V	5	331.26	5	2026-09-23 22:06:08.131461	\N
823	V	5	262.62	5	2026-09-23 22:06:08.131461	\N
824	V	5	197.04	5	2026-09-23 22:06:08.131461	\N
825	V	5	131.21	5	2026-09-23 22:06:08.131461	\N
826	V	5	130.82	5	2026-09-23 22:06:08.131461	\N
827	V	5	130.22	5	2026-09-23 22:06:08.131461	\N
828	V	5	195.49	5	2026-09-23 22:06:08.131461	\N
829	V	5	260.73	5	2026-09-23 22:06:08.131461	\N
830	V	5	260.73	5	2026-09-23 22:06:08.131461	\N
831	V	5	195.56	5	2026-09-23 22:06:08.131461	\N
832	V	5	196.21	5	2026-09-23 22:06:08.131461	\N
833	V	5	195.99	5	2026-09-23 22:06:08.131461	\N
834	V	5	196.15	5	2026-09-23 22:06:08.131461	\N
835	V	5	262.51	5	2026-09-23 22:06:08.131461	\N
836	V	5	326.87	5	2026-09-23 22:06:08.131461	\N
837	V	5	261.17	5	2026-09-23 22:06:08.131461	\N
838	V	5	196.12	5	2026-09-23 22:06:08.131461	\N
839	V	5	197.49	5	2026-09-23 22:06:08.131461	\N
840	V	5	196.92	5	2026-09-23 22:06:08.131461	\N
841	V	5	198.54	5	2026-09-23 22:06:08.131461	\N
842	V	5	264.37	5	2026-09-23 22:06:08.131461	\N
843	V	5	330.69	5	2026-09-23 22:06:08.131461	\N
844	V	5	263.92	5	2026-09-23 22:06:08.131461	\N
845	V	5	198.13	5	2026-09-23 22:06:08.131461	\N
846	V	5	197.26	5	2026-09-23 22:06:08.131461	\N
847	V	5	197.07	5	2026-09-23 22:06:08.131461	\N
848	V	5	196.60	5	2026-09-23 22:06:08.131461	\N
849	V	5	261.43	5	2026-09-23 22:06:08.131461	\N
850	V	5	324.25	5	2026-09-23 22:06:08.131461	\N
851	V	5	259.13	5	2026-09-23 22:06:08.131461	\N
852	V	5	193.50	5	2026-09-23 22:06:08.131461	\N
853	V	5	127.65	5	2026-09-23 22:06:08.131461	\N
854	V	5	126.72	5	2026-09-23 22:06:08.131461	\N
855	V	5	127.96	5	2026-09-23 22:06:08.131461	\N
856	V	5	191.75	5	2026-09-23 22:06:08.131461	\N
857	V	5	255.94	5	2026-09-23 22:06:08.131461	\N
858	V	5	255.94	5	2026-09-23 22:06:08.131461	\N
859	V	5	192.04	5	2026-09-23 22:06:08.131461	\N
860	V	5	189.28	5	2026-09-23 22:06:08.131461	\N
861	V	5	186.94	5	2026-09-23 22:06:08.131461	\N
862	V	5	185.35	5	2026-09-23 22:06:08.131461	\N
863	V	5	248.69	5	2026-09-23 22:06:08.131461	\N
864	V	5	312.71	5	2026-09-23 22:06:08.131461	\N
865	V	5	251.41	5	2026-09-23 22:06:08.131461	\N
866	V	5	189.97	5	2026-09-23 22:06:08.131461	\N
867	V	5	191.47	5	2026-09-23 22:06:08.131461	\N
868	V	5	192.30	5	2026-09-23 22:06:08.131461	\N
869	V	5	192.36	5	2026-09-23 22:06:08.131461	\N
870	V	5	256.32	5	2026-09-23 22:06:08.131461	\N
871	V	5	319.79	5	2026-09-23 22:06:08.131461	\N
872	V	5	255.69	5	2026-09-23 22:06:08.131461	\N
873	V	5	191.53	5	2026-09-23 22:06:08.131461	\N
874	V	5	190.63	5	2026-09-23 22:06:08.131461	\N
875	V	5	189.55	5	2026-09-23 22:06:08.131461	\N
876	V	5	187.87	5	2026-09-23 22:06:08.131461	\N
877	V	5	249.17	5	2026-09-23 22:06:08.131461	\N
878	V	5	310.60	5	2026-09-23 22:06:08.131461	\N
879	V	5	247.41	5	2026-09-23 22:06:08.131461	\N
880	V	5	184.52	5	2026-09-23 22:06:08.131461	\N
881	V	5	184.75	5	2026-09-23 22:06:08.131461	\N
882	V	5	185.14	5	2026-09-23 22:06:08.131461	\N
883	V	5	183.52	5	2026-09-23 22:06:08.131461	\N
884	V	5	243.46	5	2026-09-23 22:06:08.131461	\N
885	V	5	303.78	5	2026-09-23 22:06:08.131461	\N
886	V	5	241.76	5	2026-09-23 22:06:08.131461	\N
887	V	5	180.07	5	2026-09-23 22:06:08.131461	\N
888	V	5	181.15	5	2026-09-23 22:06:08.131461	\N
889	V	5	181.96	5	2026-09-23 22:06:08.131461	\N
890	V	5	182.62	5	2026-09-23 22:06:08.131461	\N
891	V	5	243.73	5	2026-09-23 22:06:08.131461	\N
892	V	5	302.83	5	2026-09-23 22:06:08.131461	\N
893	V	5	241.94	5	2026-09-23 22:06:08.131461	\N
894	V	5	181.19	5	2026-09-23 22:06:08.131461	\N
895	V	5	180.12	5	2026-09-23 22:06:08.131461	\N
896	V	5	179.46	5	2026-09-23 22:06:08.131461	\N
897	V	5	180.06	5	2026-09-23 22:06:08.131461	\N
898	V	5	240.22	5	2026-09-23 22:06:08.131461	\N
899	V	5	240.22	5	2026-09-23 22:06:08.131461	\N
900	V	5	180.31	5	2026-09-23 22:06:08.131461	\N
901	V	5	119.86	5	2026-09-23 22:06:08.131461	\N
902	V	5	120.83	5	2026-09-23 22:06:08.131461	\N
903	V	5	121.18	5	2026-09-23 22:06:08.131461	\N
904	V	5	182.97	5	2026-09-23 22:06:08.131461	\N
905	V	5	244.63	5	2026-09-23 22:06:08.131461	\N
906	V	5	305.50	5	2026-09-23 22:06:08.131461	\N
907	V	5	244.83	5	2026-09-23 22:06:08.131461	\N
908	V	5	184.32	5	2026-09-23 22:06:08.131461	\N
909	V	5	184.41	5	2026-09-23 22:06:08.131461	\N
910	V	5	185.02	5	2026-09-23 22:06:08.131461	\N
911	V	5	187.33	5	2026-09-23 22:06:08.131461	\N
912	V	5	250.35	5	2026-09-23 22:06:08.131461	\N
913	V	5	313.76	5	2026-09-23 22:06:08.131461	\N
914	V	5	251.88	5	2026-09-23 22:06:08.131461	\N
915	V	5	189.61	5	2026-09-23 22:06:08.131461	\N
916	V	5	189.21	5	2026-09-23 22:06:08.131461	\N
917	V	5	188.18	5	2026-09-23 22:06:08.131461	\N
918	V	5	187.03	5	2026-09-23 22:06:08.131461	\N
919	V	5	248.81	5	2026-09-23 22:06:08.131461	\N
920	V	5	310.69	5	2026-09-23 22:06:08.131461	\N
921	V	5	247.91	5	2026-09-23 22:06:08.131461	\N
922	V	5	185.92	5	2026-09-23 22:06:08.131461	\N
923	V	5	185.59	5	2026-09-23 22:06:08.131461	\N
924	V	5	185.67	5	2026-09-23 22:06:08.131461	\N
925	V	5	190.76	5	2026-09-23 22:06:08.131461	\N
926	V	5	256.73	5	2026-09-23 22:06:08.131461	\N
927	V	5	322.34	5	2026-09-23 22:06:08.131461	\N
928	V	5	260.41	5	2026-09-23 22:06:08.131461	\N
929	V	5	198.55	5	2026-09-23 22:06:08.131461	\N
930	V	5	196.94	5	2026-09-23 22:06:08.131461	\N
931	V	5	195.38	5	2026-09-23 22:06:08.131461	\N
932	V	5	193.54	5	2026-09-23 22:06:08.131461	\N
933	V	5	257.79	5	2026-09-23 22:06:08.131461	\N
934	V	5	321.55	5	2026-09-23 22:06:08.131461	\N
935	V	5	256.18	5	2026-09-23 22:06:08.131461	\N
936	V	5	191.77	5	2026-09-23 22:06:08.131461	\N
937	V	5	192.79	5	2026-09-23 22:06:08.131461	\N
938	V	5	193.81	5	2026-09-23 22:06:08.131461	\N
939	V	5	194.12	5	2026-09-23 22:06:08.131461	\N
940	V	5	258.62	5	2026-09-23 22:06:08.131461	\N
941	V	5	323.77	5	2026-09-23 22:06:08.131461	\N
942	V	5	259.00	5	2026-09-23 22:06:08.131461	\N
943	V	5	193.72	5	2026-09-23 22:06:08.131461	\N
944	V	5	196.18	5	2026-09-23 22:06:08.131461	\N
945	V	5	197.66	5	2026-09-23 22:06:08.131461	\N
946	V	5	198.66	5	2026-09-23 22:06:08.131461	\N
947	V	5	264.88	5	2026-09-23 22:06:08.131461	\N
948	V	5	330.66	5	2026-09-23 22:06:08.131461	\N
949	V	5	264.13	5	2026-09-23 22:06:08.131461	\N
950	V	5	198.15	5	2026-09-23 22:06:08.131461	\N
951	V	5	132.00	5	2026-09-23 22:06:08.131461	\N
952	V	5	131.07	5	2026-09-23 22:06:08.131461	\N
953	V	5	130.82	5	2026-09-23 22:06:08.131461	\N
954	V	5	195.81	5	2026-09-23 22:06:08.131461	\N
955	V	5	261.08	5	2026-09-23 22:06:08.131461	\N
956	V	5	261.08	5	2026-09-23 22:06:08.131461	\N
957	V	5	195.78	5	2026-09-23 22:06:08.131461	\N
958	V	5	194.82	5	2026-09-23 22:06:08.131461	\N
959	V	5	193.29	5	2026-09-23 22:06:08.131461	\N
960	V	5	190.50	5	2026-09-23 22:06:08.131461	\N
961	V	5	254.53	5	2026-09-23 22:06:08.131461	\N
962	V	5	319.25	5	2026-09-23 22:06:08.131461	\N
963	V	5	254.69	5	2026-09-23 22:06:08.131461	\N
964	V	5	191.23	5	2026-09-23 22:06:08.131461	\N
965	V	5	192.68	5	2026-09-23 22:06:08.131461	\N
966	V	5	193.66	5	2026-09-23 22:06:08.131461	\N
967	V	5	193.54	5	2026-09-23 22:06:08.131461	\N
968	V	5	257.35	5	2026-09-23 22:06:08.131461	\N
969	V	5	321.82	5	2026-09-23 22:06:08.131461	\N
970	V	5	257.89	5	2026-09-23 22:06:08.131461	\N
971	V	5	192.88	5	2026-09-23 22:06:08.131461	\N
972	V	5	193.05	5	2026-09-23 22:06:08.131461	\N
973	V	5	195.87	5	2026-09-23 22:06:08.131461	\N
974	V	5	197.46	5	2026-09-23 22:06:08.131461	\N
975	V	5	262.91	5	2026-09-23 22:06:08.131461	\N
976	V	5	262.91	5	2026-09-23 22:06:08.131461	\N
977	V	5	198.15	5	2026-09-23 22:06:08.131461	\N
978	V	5	131.52	5	2026-09-23 22:06:08.131461	\N
979	V	5	130.77	5	2026-09-23 22:06:08.131461	\N
980	V	5	131.02	5	2026-09-23 22:06:08.131461	\N
981	V	5	197.46	5	2026-09-23 22:06:08.131461	\N
982	V	5	263.57	5	2026-09-23 22:06:08.131461	\N
983	V	5	330.81	5	2026-09-23 22:06:08.131461	\N
984	V	5	265.49	5	2026-09-23 22:06:08.131461	\N
985	V	5	199.80	5	2026-09-23 22:06:08.131461	\N
986	V	5	201.68	5	2026-09-23 22:06:08.131461	\N
987	V	5	204.19	5	2026-09-23 22:06:08.131461	\N
988	V	5	207.16	5	2026-09-23 22:06:08.131461	\N
989	V	5	279.59	5	2026-09-23 22:06:08.131461	\N
990	V	5	279.59	5	2026-09-23 22:06:08.131461	\N
991	V	5	211.26	5	2026-09-23 22:06:08.131461	\N
992	V	5	142.64	5	2026-09-23 22:06:08.131461	\N
993	V	5	143.88	5	2026-09-23 22:06:08.131461	\N
994	V	5	141.89	5	2026-09-23 22:06:08.131461	\N
995	V	5	211.40	5	2026-09-23 22:06:08.131461	\N
996	V	5	281.04	5	2026-09-23 22:06:08.131461	\N
997	V	5	350.83	5	2026-09-23 22:06:08.131461	\N
998	V	5	279.38	5	2026-09-23 22:06:08.131461	\N
999	V	5	208.94	5	2026-09-23 22:06:08.131461	\N
1000	V	5	210.98	5	2026-09-23 22:06:08.131461	\N
1001	V	5	212.55	5	2026-09-23 22:06:08.131461	\N
1002	V	5	213.78	5	2026-09-23 22:06:08.131461	\N
1003	V	5	286.81	5	2026-09-23 22:06:08.131461	\N
1004	V	5	358.52	5	2026-09-23 22:06:08.131461	\N
1005	V	5	286.97	5	2026-09-23 22:06:08.131461	\N
1006	V	5	215.77	5	2026-09-23 22:06:08.131461	\N
1007	V	5	216.85	5	2026-09-23 22:06:08.131461	\N
1008	V	5	214.99	5	2026-09-23 22:06:08.131461	\N
1009	V	5	213.96	5	2026-09-23 22:06:08.131461	\N
1010	V	5	284.28	5	2026-09-23 22:06:08.131461	\N
1011	V	5	355.43	5	2026-09-23 22:06:08.131461	\N
1012	V	5	283.32	5	2026-09-23 22:06:08.131461	\N
1013	V	5	212.15	5	2026-09-23 22:06:08.131461	\N
1014	V	5	213.97	5	2026-09-23 22:06:08.131461	\N
1015	V	5	216.97	5	2026-09-23 22:06:08.131461	\N
1016	V	5	219.57	5	2026-09-23 22:06:08.131461	\N
1017	V	5	292.82	5	2026-09-23 22:06:08.131461	\N
1018	V	5	366.05	5	2026-09-23 22:06:08.131461	\N
1019	V	5	293.54	5	2026-09-23 22:06:08.131461	\N
1020	V	5	220.23	5	2026-09-23 22:06:08.131461	\N
1021	V	5	219.61	5	2026-09-23 22:06:08.131461	\N
1022	V	5	220.28	5	2026-09-23 22:06:08.131461	\N
1023	V	5	220.76	5	2026-09-23 22:06:08.131461	\N
1024	V	5	294.85	5	2026-09-23 22:06:08.131461	\N
1025	V	5	367.35	5	2026-09-23 22:06:08.131461	\N
1026	V	5	294.22	5	2026-09-23 22:06:08.131461	\N
1027	V	5	220.30	5	2026-09-23 22:06:08.131461	\N
1028	V	5	218.86	5	2026-09-23 22:06:08.131461	\N
1029	V	5	217.33	5	2026-09-23 22:06:08.131461	\N
1030	V	5	216.71	5	2026-09-23 22:06:08.131461	\N
1031	V	5	289.80	5	2026-09-23 22:06:08.131461	\N
1032	V	5	362.63	5	2026-09-23 22:06:08.131461	\N
1033	V	5	290.37	5	2026-09-23 22:06:08.131461	\N
1034	V	5	217.80	5	2026-09-23 22:06:08.131461	\N
1035	V	5	217.69	5	2026-09-23 22:06:08.131461	\N
1036	V	5	217.45	5	2026-09-23 22:06:08.131461	\N
1037	V	5	217.73	5	2026-09-23 22:06:08.131461	\N
1038	V	5	290.87	5	2026-09-23 22:06:08.131461	\N
1039	V	5	365.08	5	2026-09-23 22:06:08.131461	\N
1040	V	5	293.31	5	2026-09-23 22:06:08.131461	\N
1041	V	5	220.46	5	2026-09-23 22:06:08.131461	\N
1042	V	5	223.84	5	2026-09-23 22:06:08.131461	\N
1043	V	5	227.52	5	2026-09-23 22:06:08.131461	\N
1044	V	5	230.09	5	2026-09-23 22:06:08.131461	\N
1045	V	5	306.02	5	2026-09-23 22:06:08.131461	\N
1046	V	5	382.34	5	2026-09-23 22:06:08.131461	\N
1047	V	5	305.86	5	2026-09-23 22:06:08.131461	\N
1048	V	5	229.03	5	2026-09-23 22:06:08.131461	\N
1049	V	5	228.13	5	2026-09-23 22:06:08.131461	\N
1050	V	5	226.73	5	2026-09-23 22:06:08.131461	\N
1051	V	5	226.09	5	2026-09-23 22:06:08.131461	\N
1052	V	5	301.84	5	2026-09-23 22:06:08.131461	\N
1053	V	5	376.85	5	2026-09-23 22:06:08.131461	\N
1054	V	5	300.98	5	2026-09-23 22:06:08.131461	\N
1055	V	5	226.44	5	2026-09-23 22:06:08.131461	\N
1056	V	5	150.76	5	2026-09-23 22:06:08.131461	\N
1057	V	5	148.74	5	2026-09-23 22:06:08.131461	\N
1058	V	5	147.21	5	2026-09-23 22:06:08.131461	\N
1059	V	5	220.65	5	2026-09-23 22:06:08.131461	\N
1060	V	5	294.74	5	2026-09-23 22:06:08.131461	\N
1061	V	5	294.74	5	2026-09-23 22:06:08.131461	\N
1062	V	5	221.01	5	2026-09-23 22:06:08.131461	\N
1063	V	5	222.59	5	2026-09-23 22:06:08.131461	\N
1064	V	5	224.27	5	2026-09-23 22:06:08.131461	\N
1065	V	5	224.37	5	2026-09-23 22:06:08.131461	\N
1066	V	5	298.35	5	2026-09-23 22:06:08.131461	\N
1067	V	5	372.01	5	2026-09-23 22:06:08.131461	\N
1068	V	5	296.95	5	2026-09-23 22:06:08.131461	\N
1069	V	5	221.83	5	2026-09-23 22:06:08.131461	\N
1070	V	5	221.63	5	2026-09-23 22:06:08.131461	\N
1071	V	5	220.06	5	2026-09-23 22:06:08.131461	\N
1072	V	5	146.40	5	2026-09-23 22:06:08.131461	\N
1073	V	20	240.93	20	2026-09-23 22:06:08.177377	\N
1074	V	20	241.16	20	2026-09-23 22:06:08.177377	\N
1075	V	20	241.64	20	2026-09-23 22:06:08.177377	\N
1076	V	20	242.18	20	2026-09-23 22:06:08.177377	\N
1077	V	20	242.08	20	2026-09-23 22:06:08.177377	\N
1078	V	20	259.18	20	2026-09-23 22:06:08.177377	\N
1079	V	20	259.18	20	2026-09-23 22:06:08.177377	\N
1080	V	20	242.17	20	2026-09-23 22:06:08.177377	\N
1081	V	20	242.32	20	2026-09-23 22:06:08.177377	\N
1082	V	20	242.29	20	2026-09-23 22:06:08.177377	\N
1083	V	20	242.26	20	2026-09-23 22:06:08.177377	\N
1084	V	20	242.07	20	2026-09-23 22:06:08.177377	\N
1085	V	20	259.44	20	2026-09-23 22:06:08.177377	\N
1086	V	20	259.44	20	2026-09-23 22:06:08.177377	\N
1087	V	20	241.97	20	2026-09-23 22:06:08.177377	\N
1088	V	20	241.74	20	2026-09-23 22:06:08.177377	\N
1089	V	20	241.52	20	2026-09-23 22:06:08.177377	\N
1090	V	20	241.23	20	2026-09-23 22:06:08.177377	\N
1091	V	20	241.30	20	2026-09-23 22:06:08.177377	\N
1092	V	20	258.34	20	2026-09-23 22:06:08.177377	\N
1093	V	20	258.34	20	2026-09-23 22:06:08.177377	\N
1094	V	20	241.17	20	2026-09-23 22:06:08.177377	\N
1095	V	20	240.60	20	2026-09-23 22:06:08.177377	\N
1096	V	20	240.33	20	2026-09-23 22:06:08.177377	\N
1097	V	20	240.56	20	2026-09-23 22:06:08.177377	\N
1098	V	20	240.31	20	2026-09-23 22:06:08.177377	\N
1099	V	20	257.12	20	2026-09-23 22:06:08.177377	\N
1100	V	20	257.12	20	2026-09-23 22:06:08.177377	\N
1101	V	20	239.89	20	2026-09-23 22:06:08.177377	\N
1102	V	20	239.28	20	2026-09-23 22:06:08.177377	\N
1103	V	20	238.96	20	2026-09-23 22:06:08.177377	\N
1104	V	20	238.60	20	2026-09-23 22:06:08.177377	\N
1105	V	20	238.04	20	2026-09-23 22:06:08.177377	\N
1106	V	20	254.54	20	2026-09-23 22:06:08.177377	\N
1107	V	20	254.54	20	2026-09-23 22:06:08.177377	\N
1108	V	20	237.15	20	2026-09-23 22:06:08.177377	\N
1109	V	20	236.09	20	2026-09-23 22:06:08.177377	\N
1110	V	20	235.08	20	2026-09-23 22:06:08.177377	\N
1111	V	20	234.04	20	2026-09-23 22:06:08.177377	\N
1112	V	20	233.19	20	2026-09-23 22:06:08.177377	\N
1113	V	20	249.59	20	2026-09-23 22:06:08.177377	\N
1114	V	20	249.59	20	2026-09-23 22:06:08.177377	\N
1115	V	20	232.74	20	2026-09-23 22:06:08.177377	\N
1116	V	20	232.19	20	2026-09-23 22:06:08.177377	\N
1117	V	20	231.92	20	2026-09-23 22:06:08.177377	\N
1118	V	20	231.76	20	2026-09-23 22:06:08.177377	\N
1119	V	20	214.96	20	2026-09-23 22:06:08.177377	\N
1120	V	20	231.68	20	2026-09-23 22:06:08.177377	\N
1121	V	20	231.68	20	2026-09-23 22:06:08.177377	\N
1122	V	20	214.94	20	2026-09-23 22:06:08.177377	\N
1123	V	20	214.51	20	2026-09-23 22:06:08.177377	\N
1124	V	20	214.05	20	2026-09-23 22:06:08.177377	\N
1125	V	20	213.72	20	2026-09-23 22:06:08.177377	\N
1126	V	20	213.58	20	2026-09-23 22:06:08.177377	\N
1127	V	20	230.14	20	2026-09-23 22:06:08.177377	\N
1128	V	20	230.14	20	2026-09-23 22:06:08.177377	\N
1129	V	20	213.85	20	2026-09-23 22:06:08.177377	\N
1130	V	20	214.14	20	2026-09-23 22:06:08.177377	\N
1131	V	20	214.26	20	2026-09-23 22:06:08.177377	\N
1132	V	20	214.35	20	2026-09-23 22:06:08.177377	\N
1133	V	20	215.24	20	2026-09-23 22:06:08.177377	\N
1134	V	20	232.63	20	2026-09-23 22:06:08.177377	\N
1135	V	20	232.63	20	2026-09-23 22:06:08.177377	\N
1136	V	20	216.16	20	2026-09-23 22:06:08.177377	\N
1137	V	20	216.78	20	2026-09-23 22:06:08.177377	\N
1138	V	20	217.35	20	2026-09-23 22:06:08.177377	\N
1139	V	20	234.57	20	2026-09-23 22:06:08.177377	\N
1140	V	20	235.15	20	2026-09-23 22:06:08.177377	\N
1141	V	20	252.61	20	2026-09-23 22:06:08.177377	\N
1142	V	20	252.61	20	2026-09-23 22:06:08.177377	\N
1143	V	20	236.09	20	2026-09-23 22:06:08.177377	\N
1144	V	20	237.21	20	2026-09-23 22:06:08.177377	\N
1145	V	20	238.40	20	2026-09-23 22:06:08.177377	\N
1146	V	20	239.80	20	2026-09-23 22:06:08.177377	\N
1147	V	20	223.24	20	2026-09-23 22:06:08.177377	\N
1148	V	20	240.99	20	2026-09-23 22:06:08.177377	\N
1149	V	20	240.99	20	2026-09-23 22:06:08.177377	\N
1150	V	20	224.65	20	2026-09-23 22:06:08.177377	\N
1151	V	20	226.05	20	2026-09-23 22:06:08.177377	\N
1152	V	20	227.45	20	2026-09-23 22:06:08.177377	\N
1153	V	20	227.70	20	2026-09-23 22:06:08.177377	\N
1154	V	20	210.31	20	2026-09-23 22:06:08.177377	\N
1155	V	20	227.64	20	2026-09-23 22:06:08.177377	\N
1156	V	20	227.64	20	2026-09-23 22:06:08.177377	\N
1157	V	20	210.29	20	2026-09-23 22:06:08.177377	\N
1158	V	20	210.72	20	2026-09-23 22:06:08.177377	\N
1159	V	20	211.38	20	2026-09-23 22:06:08.177377	\N
1160	V	20	211.88	20	2026-09-23 22:06:08.177377	\N
1161	V	20	212.03	20	2026-09-23 22:06:08.177377	\N
1162	V	20	229.51	20	2026-09-23 22:06:08.177377	\N
1163	V	20	229.51	20	2026-09-23 22:06:08.177377	\N
1164	V	20	211.91	20	2026-09-23 22:06:08.177377	\N
1165	V	20	211.40	20	2026-09-23 22:06:08.177377	\N
1166	V	20	210.04	20	2026-09-23 22:06:08.177377	\N
1167	V	20	226.50	20	2026-09-23 22:06:08.177377	\N
1168	V	20	225.13	20	2026-09-23 22:06:08.177377	\N
1169	V	20	241.55	20	2026-09-23 22:06:08.177377	\N
1170	V	20	241.55	20	2026-09-23 22:06:08.177377	\N
1171	V	20	223.82	20	2026-09-23 22:06:08.177377	\N
1172	V	20	206.14	20	2026-09-23 22:06:08.177377	\N
1173	V	20	204.89	20	2026-09-23 22:06:08.177377	\N
1174	V	20	221.16	20	2026-09-23 22:06:08.177377	\N
1175	V	20	220.15	20	2026-09-23 22:06:08.177377	\N
1176	V	20	236.46	20	2026-09-23 22:06:08.177377	\N
1177	V	20	236.46	20	2026-09-23 22:06:08.177377	\N
1178	V	20	218.77	20	2026-09-23 22:06:08.177377	\N
1179	V	20	217.32	20	2026-09-23 22:06:08.177377	\N
1180	V	20	215.78	20	2026-09-23 22:06:08.177377	\N
1181	V	20	214.52	20	2026-09-23 22:06:08.177377	\N
1182	V	20	213.62	20	2026-09-23 22:06:08.177377	\N
1183	V	20	229.71	20	2026-09-23 22:06:08.177377	\N
1184	V	20	229.71	20	2026-09-23 22:06:08.177377	\N
1185	V	20	212.56	20	2026-09-23 22:06:08.177377	\N
1186	V	20	212.85	20	2026-09-23 22:06:08.177377	\N
1187	V	20	212.84	20	2026-09-23 22:06:08.177377	\N
1188	V	20	212.95	20	2026-09-23 22:06:08.177377	\N
1189	V	20	212.99	20	2026-09-23 22:06:08.177377	\N
1190	V	20	229.57	20	2026-09-23 22:06:08.177377	\N
1191	V	20	229.57	20	2026-09-23 22:06:08.177377	\N
1192	V	20	229.57	20	2026-09-23 22:06:08.177377	\N
1193	V	20	229.56	20	2026-09-23 22:06:08.177377	\N
1194	V	20	229.70	20	2026-09-23 22:06:08.177377	\N
1195	V	20	229.85	20	2026-09-23 22:06:08.177377	\N
1196	V	20	229.75	20	2026-09-23 22:06:08.177377	\N
1197	V	20	245.45	20	2026-09-23 22:06:08.177377	\N
1198	V	20	245.45	20	2026-09-23 22:06:08.177377	\N
1199	V	20	229.03	20	2026-09-23 22:06:08.177377	\N
1200	V	20	212.76	20	2026-09-23 22:06:08.177377	\N
1201	V	20	212.39	20	2026-09-23 22:06:08.177377	\N
1202	V	20	211.82	20	2026-09-23 22:06:08.177377	\N
1203	V	20	211.67	20	2026-09-23 22:06:08.177377	\N
1204	V	20	227.72	20	2026-09-23 22:06:08.177377	\N
1205	V	20	227.72	20	2026-09-23 22:06:08.177377	\N
1206	V	20	211.03	20	2026-09-23 22:06:08.177377	\N
1207	V	20	209.91	20	2026-09-23 22:06:08.177377	\N
1208	V	20	208.77	20	2026-09-23 22:06:08.177377	\N
1209	V	20	207.96	20	2026-09-23 22:06:08.177377	\N
1210	V	20	207.22	20	2026-09-23 22:06:08.177377	\N
1211	V	20	223.22	20	2026-09-23 22:06:08.177377	\N
1212	V	20	223.22	20	2026-09-23 22:06:08.177377	\N
1213	V	20	206.95	20	2026-09-23 22:06:08.177377	\N
1214	V	20	206.56	20	2026-09-23 22:06:08.177377	\N
1215	V	20	206.14	20	2026-09-23 22:06:08.177377	\N
1216	V	20	205.96	20	2026-09-23 22:06:08.177377	\N
1217	V	20	206.24	20	2026-09-23 22:06:08.177377	\N
1218	V	20	222.11	20	2026-09-23 22:06:08.177377	\N
1219	V	20	222.11	20	2026-09-23 22:06:08.177377	\N
1220	V	20	222.11	20	2026-09-23 22:06:08.177377	\N
1221	V	20	221.93	20	2026-09-23 22:06:08.177377	\N
1222	V	20	221.64	20	2026-09-23 22:06:08.177377	\N
1223	V	20	221.14	20	2026-09-23 22:06:08.177377	\N
1224	V	20	220.42	20	2026-09-23 22:06:08.177377	\N
1225	V	20	235.78	20	2026-09-23 22:06:08.177377	\N
1226	V	20	235.78	20	2026-09-23 22:06:08.177377	\N
1227	V	20	220.45	20	2026-09-23 22:06:08.177377	\N
1228	V	20	220.60	20	2026-09-23 22:06:08.177377	\N
1229	V	20	220.37	20	2026-09-23 22:06:08.177377	\N
1230	V	20	219.48	20	2026-09-23 22:06:08.177377	\N
1231	V	20	218.46	20	2026-09-23 22:06:08.177377	\N
1232	V	20	233.54	20	2026-09-23 22:06:08.177377	\N
1233	V	20	233.54	20	2026-09-23 22:06:08.177377	\N
1234	V	20	217.52	20	2026-09-23 22:06:08.177377	\N
1235	V	20	216.70	20	2026-09-23 22:06:08.177377	\N
1236	V	20	215.86	20	2026-09-23 22:06:08.177377	\N
1237	V	20	215.12	20	2026-09-23 22:06:08.177377	\N
1238	V	20	214.53	20	2026-09-23 22:06:08.177377	\N
1239	V	20	229.30	20	2026-09-23 22:06:08.177377	\N
1240	V	20	229.30	20	2026-09-23 22:06:08.177377	\N
1241	V	20	213.51	20	2026-09-23 22:06:08.177377	\N
1242	V	20	212.76	20	2026-09-23 22:06:08.177377	\N
1243	V	20	212.43	20	2026-09-23 22:06:08.177377	\N
1244	V	20	212.03	20	2026-09-23 22:06:08.177377	\N
1245	V	20	211.71	20	2026-09-23 22:06:08.177377	\N
1246	V	20	211.71	20	2026-09-23 22:06:08.177377	\N
1247	V	20	211.71	20	2026-09-23 22:06:08.177377	\N
1248	V	20	196.20	20	2026-09-23 22:06:08.177377	\N
1249	V	20	195.95	20	2026-09-23 22:06:08.177377	\N
1250	V	20	196.12	20	2026-09-23 22:06:08.177377	\N
1251	V	20	196.59	20	2026-09-23 22:06:08.177377	\N
1252	V	20	196.92	20	2026-09-23 22:06:08.177377	\N
1253	V	20	212.14	20	2026-09-23 22:06:08.177377	\N
1254	V	20	212.14	20	2026-09-23 22:06:08.177377	\N
1255	V	20	196.92	20	2026-09-23 22:06:08.177377	\N
1256	V	20	197.20	20	2026-09-23 22:06:08.177377	\N
1257	V	20	197.52	20	2026-09-23 22:06:08.177377	\N
1258	V	20	198.04	20	2026-09-23 22:06:08.177377	\N
1259	V	20	199.02	20	2026-09-23 22:06:08.177377	\N
1260	V	20	214.87	20	2026-09-23 22:06:08.177377	\N
1261	V	20	214.87	20	2026-09-23 22:06:08.177377	\N
1262	V	20	199.89	20	2026-09-23 22:06:08.177377	\N
1263	V	20	200.48	20	2026-09-23 22:06:08.177377	\N
1264	V	20	201.05	20	2026-09-23 22:06:08.177377	\N
1265	V	20	201.57	20	2026-09-23 22:06:08.177377	\N
1266	V	20	217.02	20	2026-09-23 22:06:08.177377	\N
1267	V	20	232.49	20	2026-09-23 22:06:08.177377	\N
1268	V	20	232.49	20	2026-09-23 22:06:08.177377	\N
1269	V	20	217.32	20	2026-09-23 22:06:08.177377	\N
1270	V	20	217.68	20	2026-09-23 22:06:08.177377	\N
1271	V	20	217.69	20	2026-09-23 22:06:08.177377	\N
1272	V	20	219.02	20	2026-09-23 22:06:08.177377	\N
1273	V	20	220.30	20	2026-09-23 22:06:08.177377	\N
1274	V	20	236.70	20	2026-09-23 22:06:08.177377	\N
1275	V	20	236.70	20	2026-09-23 22:06:08.177377	\N
1276	V	20	221.23	20	2026-09-23 22:06:08.177377	\N
1277	V	20	222.00	20	2026-09-23 22:06:08.177377	\N
1278	V	20	222.31	20	2026-09-23 22:06:08.177377	\N
1279	V	20	222.49	20	2026-09-23 22:06:08.177377	\N
1280	V	20	222.71	20	2026-09-23 22:06:08.177377	\N
1281	V	20	238.65	20	2026-09-23 22:06:08.177377	\N
1282	V	20	238.65	20	2026-09-23 22:06:08.177377	\N
1283	V	20	222.95	20	2026-09-23 22:06:08.177377	\N
1284	V	20	223.64	20	2026-09-23 22:06:08.177377	\N
1285	V	20	224.40	20	2026-09-23 22:06:08.177377	\N
1286	V	20	224.97	20	2026-09-23 22:06:08.177377	\N
1287	V	20	225.63	20	2026-09-23 22:06:08.177377	\N
1288	V	20	241.91	20	2026-09-23 22:06:08.177377	\N
1289	V	20	241.91	20	2026-09-23 22:06:08.177377	\N
1290	V	20	226.43	20	2026-09-23 22:06:08.177377	\N
1291	V	20	227.60	20	2026-09-23 22:06:08.177377	\N
1292	V	20	227.35	20	2026-09-23 22:06:08.177377	\N
1293	V	20	227.40	20	2026-09-23 22:06:08.177377	\N
1294	V	20	227.55	20	2026-09-23 22:06:08.177377	\N
1295	V	20	244.00	20	2026-09-23 22:06:08.177377	\N
1296	V	20	244.00	20	2026-09-23 22:06:08.177377	\N
1297	V	20	227.65	20	2026-09-23 22:06:08.177377	\N
1298	V	20	211.55	20	2026-09-23 22:06:08.177377	\N
1299	V	20	211.94	20	2026-09-23 22:06:08.177377	\N
1300	V	20	212.25	20	2026-09-23 22:06:08.177377	\N
1301	V	20	212.56	20	2026-09-23 22:06:08.177377	\N
1302	V	20	228.88	20	2026-09-23 22:06:08.177377	\N
1303	V	20	228.88	20	2026-09-23 22:06:08.177377	\N
1304	V	20	212.69	20	2026-09-23 22:06:08.177377	\N
1305	V	20	212.50	20	2026-09-23 22:06:08.177377	\N
1306	V	20	212.35	20	2026-09-23 22:06:08.177377	\N
1307	V	20	211.85	20	2026-09-23 22:06:08.177377	\N
1308	V	20	211.57	20	2026-09-23 22:06:08.177377	\N
1309	V	20	227.75	20	2026-09-23 22:06:08.177377	\N
1310	V	20	227.75	20	2026-09-23 22:06:08.177377	\N
1311	V	20	211.12	20	2026-09-23 22:06:08.177377	\N
1312	V	20	210.60	20	2026-09-23 22:06:08.177377	\N
1313	V	20	210.32	20	2026-09-23 22:06:08.177377	\N
1314	V	20	209.91	20	2026-09-23 22:06:08.177377	\N
1315	V	20	209.42	20	2026-09-23 22:06:08.177377	\N
1316	V	20	225.54	20	2026-09-23 22:06:08.177377	\N
1317	V	20	225.54	20	2026-09-23 22:06:08.177377	\N
1318	V	20	225.54	20	2026-09-23 22:06:08.177377	\N
1319	V	20	225.41	20	2026-09-23 22:06:08.177377	\N
1320	V	20	225.68	20	2026-09-23 22:06:08.177377	\N
1321	V	20	225.95	20	2026-09-23 22:06:08.177377	\N
1322	V	20	226.00	20	2026-09-23 22:06:08.177377	\N
1323	V	20	226.00	20	2026-09-23 22:06:08.177377	\N
1324	V	20	226.00	20	2026-09-23 22:06:08.177377	\N
1325	V	20	209.86	20	2026-09-23 22:06:08.177377	\N
1326	V	20	210.32	20	2026-09-23 22:06:08.177377	\N
1327	V	20	211.13	20	2026-09-23 22:06:08.177377	\N
1328	V	20	211.73	20	2026-09-23 22:06:08.177377	\N
1329	V	20	212.08	20	2026-09-23 22:06:08.177377	\N
1330	V	20	228.89	20	2026-09-23 22:06:08.177377	\N
1331	V	20	228.89	20	2026-09-23 22:06:08.177377	\N
1332	V	20	212.90	20	2026-09-23 22:06:08.177377	\N
1333	V	20	213.73	20	2026-09-23 22:06:08.177377	\N
1334	V	20	214.74	20	2026-09-23 22:06:08.177377	\N
1335	V	20	216.34	20	2026-09-23 22:06:08.177377	\N
1336	V	20	218.33	20	2026-09-23 22:06:08.177377	\N
1337	V	20	218.33	20	2026-09-23 22:06:08.177377	\N
1338	V	20	218.33	20	2026-09-23 22:06:08.177377	\N
1339	V	20	202.14	20	2026-09-23 22:06:08.177377	\N
1340	V	20	203.34	20	2026-09-23 22:06:08.177377	\N
1341	V	20	204.44	20	2026-09-23 22:06:08.177377	\N
1342	V	20	205.45	20	2026-09-23 22:06:08.177377	\N
1343	V	20	222.86	20	2026-09-23 22:06:08.177377	\N
1344	V	20	240.31	20	2026-09-23 22:06:08.177377	\N
1345	V	20	240.31	20	2026-09-23 22:06:08.177377	\N
1346	V	20	223.98	20	2026-09-23 22:06:08.177377	\N
1347	V	20	225.44	20	2026-09-23 22:06:08.177377	\N
1348	V	20	226.63	20	2026-09-23 22:06:08.177377	\N
1349	V	20	227.86	20	2026-09-23 22:06:08.177377	\N
1350	V	20	229.31	20	2026-09-23 22:06:08.177377	\N
1351	V	20	247.24	20	2026-09-23 22:06:08.177377	\N
1352	V	20	247.24	20	2026-09-23 22:06:08.177377	\N
1353	V	20	230.15	20	2026-09-23 22:06:08.177377	\N
1354	V	20	231.03	20	2026-09-23 22:06:08.177377	\N
1355	V	20	231.26	20	2026-09-23 22:06:08.177377	\N
1356	V	20	230.83	20	2026-09-23 22:06:08.177377	\N
1357	V	20	248.41	20	2026-09-23 22:06:08.177377	\N
1358	V	20	266.20	20	2026-09-23 22:06:08.177377	\N
1359	V	20	266.20	20	2026-09-23 22:06:08.177377	\N
1360	V	20	248.33	20	2026-09-23 22:06:08.177377	\N
1361	V	20	248.85	20	2026-09-23 22:06:08.177377	\N
1362	V	20	249.80	20	2026-09-23 22:06:08.177377	\N
1363	V	20	250.83	20	2026-09-23 22:06:08.177377	\N
1364	V	20	251.69	20	2026-09-23 22:06:08.177377	\N
1365	V	20	270.00	20	2026-09-23 22:06:08.177377	\N
1366	V	20	270.00	20	2026-09-23 22:06:08.177377	\N
1367	V	20	252.11	20	2026-09-23 22:06:08.177377	\N
1368	V	20	252.60	20	2026-09-23 22:06:08.177377	\N
1369	V	20	253.32	20	2026-09-23 22:06:08.177377	\N
1370	V	20	253.49	20	2026-09-23 22:06:08.177377	\N
1371	V	20	254.08	20	2026-09-23 22:06:08.177377	\N
1372	V	20	272.21	20	2026-09-23 22:06:08.177377	\N
1373	V	20	272.21	20	2026-09-23 22:06:08.177377	\N
1374	V	20	254.18	20	2026-09-23 22:06:08.177377	\N
1375	V	20	254.45	20	2026-09-23 22:06:08.177377	\N
1376	V	20	254.93	20	2026-09-23 22:06:08.177377	\N
1377	V	20	255.32	20	2026-09-23 22:06:08.177377	\N
1378	V	20	255.80	20	2026-09-23 22:06:08.177377	\N
1379	V	20	274.01	20	2026-09-23 22:06:08.177377	\N
1380	V	20	274.01	20	2026-09-23 22:06:08.177377	\N
1381	V	20	255.88	20	2026-09-23 22:06:08.177377	\N
1382	V	20	255.50	20	2026-09-23 22:06:08.177377	\N
1383	V	20	255.27	20	2026-09-23 22:06:08.177377	\N
1384	V	20	255.23	20	2026-09-23 22:06:08.177377	\N
1385	V	20	255.21	20	2026-09-23 22:06:08.177377	\N
1386	V	20	273.77	20	2026-09-23 22:06:08.177377	\N
1387	V	20	273.77	20	2026-09-23 22:06:08.177377	\N
1388	V	20	255.48	20	2026-09-23 22:06:08.177377	\N
1389	V	20	256.12	20	2026-09-23 22:06:08.177377	\N
1390	V	20	256.90	20	2026-09-23 22:06:08.177377	\N
1391	V	20	257.58	20	2026-09-23 22:06:08.177377	\N
1392	V	20	258.43	20	2026-09-23 22:06:08.177377	\N
1393	V	20	277.51	20	2026-09-23 22:06:08.177377	\N
1394	V	20	277.51	20	2026-09-23 22:06:08.177377	\N
1395	V	20	259.45	20	2026-09-23 22:06:08.177377	\N
1396	V	20	260.27	20	2026-09-23 22:06:08.177377	\N
1397	V	20	260.94	20	2026-09-23 22:06:08.177377	\N
1398	V	20	261.58	20	2026-09-23 22:06:08.177377	\N
1399	V	20	262.31	20	2026-09-23 22:06:08.177377	\N
1400	V	20	281.07	20	2026-09-23 22:06:08.177377	\N
1401	V	20	281.07	20	2026-09-23 22:06:08.177377	\N
1402	V	20	263.13	20	2026-09-23 22:06:08.177377	\N
1403	V	20	244.91	20	2026-09-23 22:06:08.177377	\N
1404	V	20	245.07	20	2026-09-23 22:06:08.177377	\N
1405	V	20	245.15	20	2026-09-23 22:06:08.177377	\N
1406	V	20	244.96	20	2026-09-23 22:06:08.177377	\N
1407	V	20	263.48	20	2026-09-23 22:06:08.177377	\N
1408	V	20	263.48	20	2026-09-23 22:06:08.177377	\N
1409	V	20	244.36	20	2026-09-23 22:06:08.177377	\N
1410	V	20	243.92	20	2026-09-23 22:06:08.177377	\N
1411	V	20	243.51	20	2026-09-23 22:06:08.177377	\N
1412	V	20	243.07	20	2026-09-23 22:06:08.177377	\N
1413	V	20	242.49	20	2026-09-23 22:06:08.177377	\N
1414	V	20	260.90	20	2026-09-23 22:06:08.177377	\N
1415	V	20	260.90	20	2026-09-23 22:06:08.177377	\N
1416	V	20	241.93	20	2026-09-23 22:06:08.177377	\N
1417	V	20	241.80	20	2026-09-23 22:06:08.177377	\N
1418	V	20	240.98	20	2026-09-23 22:06:08.177377	\N
1419	V	20	222.04	20	2026-09-23 22:06:08.177377	\N
1420	DIS	20	106.48	20	2026-09-23 22:08:29.941916	\N
1421	V	5	269.94	5	2026-09-23 23:29:52.551431	\N
1422	V	5	202.20	5	2026-09-23 23:29:52.551431	\N
1423	V	5	202.49	5	2026-09-23 23:29:52.551431	\N
1424	V	5	203.78	5	2026-09-23 23:29:52.551431	\N
1425	V	5	205.87	5	2026-09-23 23:29:52.551431	\N
1426	V	5	275.06	5	2026-09-23 23:29:52.551431	\N
1427	V	5	345.03	5	2026-09-23 23:29:52.551431	\N
1428	V	5	277.00	5	2026-09-23 23:29:52.551431	\N
1429	V	5	208.72	5	2026-09-23 23:29:52.551431	\N
1430	V	5	209.01	5	2026-09-23 23:29:52.551431	\N
1431	V	5	210.31	5	2026-09-23 23:29:52.551431	\N
1432	V	5	210.61	5	2026-09-23 23:29:52.551431	\N
1433	V	5	280.02	5	2026-09-23 23:29:52.551431	\N
1434	V	5	348.75	5	2026-09-23 23:29:52.551431	\N
1435	V	5	278.89	5	2026-09-23 23:29:52.551431	\N
1436	V	5	208.41	5	2026-09-23 23:29:52.551431	\N
1437	V	5	206.80	5	2026-09-23 23:29:52.551431	\N
1438	V	5	207.07	5	2026-09-23 23:29:52.551431	\N
1439	V	5	207.47	5	2026-09-23 23:29:52.551431	\N
1440	V	5	274.55	5	2026-09-23 23:29:52.551431	\N
1441	V	5	342.93	5	2026-09-23 23:29:52.551431	\N
1442	V	5	274.27	5	2026-09-23 23:29:52.551431	\N
1443	V	5	204.60	5	2026-09-23 23:29:52.551431	\N
1444	V	5	204.34	5	2026-09-23 23:29:52.551431	\N
1445	V	5	206.70	5	2026-09-23 23:29:52.551431	\N
1446	V	5	207.40	5	2026-09-23 23:29:52.551431	\N
1447	V	5	276.59	5	2026-09-23 23:29:52.551431	\N
1448	V	5	346.06	5	2026-09-23 23:29:52.551431	\N
1449	V	5	277.18	5	2026-09-23 23:29:52.551431	\N
1450	V	5	207.74	5	2026-09-23 23:29:52.551431	\N
1451	V	5	208.23	5	2026-09-23 23:29:52.551431	\N
1452	V	5	208.42	5	2026-09-23 23:29:52.551431	\N
1453	V	5	207.20	5	2026-09-23 23:29:52.551431	\N
1454	V	5	276.21	5	2026-09-23 23:29:52.551431	\N
1455	V	5	344.35	5	2026-09-23 23:29:52.551431	\N
1456	V	5	274.79	5	2026-09-23 23:29:52.551431	\N
1457	V	5	205.41	5	2026-09-23 23:29:52.551431	\N
1458	V	5	204.53	5	2026-09-23 23:29:52.551431	\N
1459	V	5	203.59	5	2026-09-23 23:29:52.551431	\N
1460	V	5	203.45	5	2026-09-23 23:29:52.551431	\N
1461	V	5	270.84	5	2026-09-23 23:29:52.551431	\N
1462	V	5	338.04	5	2026-09-23 23:29:52.551431	\N
1463	V	5	270.66	5	2026-09-23 23:29:52.551431	\N
1464	V	5	202.60	5	2026-09-23 23:29:52.551431	\N
1465	V	5	201.57	5	2026-09-23 23:29:52.551431	\N
1466	V	5	201.96	5	2026-09-23 23:29:52.551431	\N
1467	V	5	202.53	5	2026-09-23 23:29:52.551431	\N
1468	V	5	269.75	5	2026-09-23 23:29:52.551431	\N
1469	V	5	335.75	5	2026-09-23 23:29:52.551431	\N
1470	V	5	268.78	5	2026-09-23 23:29:52.551431	\N
1471	V	5	201.00	5	2026-09-23 23:29:52.551431	\N
1472	V	5	198.37	5	2026-09-23 23:29:52.551431	\N
1473	V	5	195.39	5	2026-09-23 23:29:52.551431	\N
1474	V	5	194.21	5	2026-09-23 23:29:52.551431	\N
1475	V	5	258.96	5	2026-09-23 23:29:52.551431	\N
1476	V	5	324.56	5	2026-09-23 23:29:52.551431	\N
1477	V	5	259.41	5	2026-09-23 23:29:52.551431	\N
1478	V	5	195.17	5	2026-09-23 23:29:52.551431	\N
1479	V	5	196.21	5	2026-09-23 23:29:52.551431	\N
1480	V	5	198.36	5	2026-09-23 23:29:52.551431	\N
1481	V	5	199.52	5	2026-09-23 23:29:52.551431	\N
1482	V	5	199.52	5	2026-09-23 23:29:52.551431	\N
1483	V	5	266.41	5	2026-09-23 23:29:52.551431	\N
1484	V	5	200.55	5	2026-09-23 23:29:52.551431	\N
1485	V	5	133.65	5	2026-09-23 23:29:52.551431	\N
1486	V	5	132.97	5	2026-09-23 23:29:52.551431	\N
1487	V	5	198.89	5	2026-09-23 23:29:52.551431	\N
1488	V	5	197.92	5	2026-09-23 23:29:52.551431	\N
1489	V	5	263.34	5	2026-09-23 23:29:52.551431	\N
1490	V	5	329.59	5	2026-09-23 23:29:52.551431	\N
1491	V	5	263.51	5	2026-09-23 23:29:52.551431	\N
1492	V	5	197.59	5	2026-09-23 23:29:52.551431	\N
1493	V	5	197.04	5	2026-09-23 23:29:52.551431	\N
1494	V	5	196.92	5	2026-09-23 23:29:52.551431	\N
1495	V	5	195.81	5	2026-09-23 23:29:52.551431	\N
1496	V	5	264.94	5	2026-09-23 23:29:52.551431	\N
1497	V	5	334.51	5	2026-09-23 23:29:52.551431	\N
1498	V	5	269.14	5	2026-09-23 23:29:52.551431	\N
1499	V	5	203.84	5	2026-09-23 23:29:52.551431	\N
1500	V	5	208.07	5	2026-09-23 23:29:52.551431	\N
1501	V	5	207.97	5	2026-09-23 23:29:52.551431	\N
1502	V	5	207.28	5	2026-09-23 23:29:52.551431	\N
1503	V	5	276.48	5	2026-09-23 23:29:52.551431	\N
1504	V	5	346.33	5	2026-09-23 23:29:52.551431	\N
1505	V	5	276.96	5	2026-09-23 23:29:52.551431	\N
1506	V	5	207.93	5	2026-09-23 23:29:52.551431	\N
1507	V	5	209.47	5	2026-09-23 23:29:52.551431	\N
1508	V	5	210.94	5	2026-09-23 23:29:52.551431	\N
1509	V	5	212.12	5	2026-09-23 23:29:52.551431	\N
1510	V	5	212.12	5	2026-09-23 23:29:52.551431	\N
1511	V	5	283.12	5	2026-09-23 23:29:52.551431	\N
1512	V	5	212.70	5	2026-09-23 23:29:52.551431	\N
1513	V	5	142.03	5	2026-09-23 23:29:52.551431	\N
1514	V	5	141.92	5	2026-09-23 23:29:52.551431	\N
1515	V	5	212.65	5	2026-09-23 23:29:52.551431	\N
1516	V	5	211.79	5	2026-09-23 23:29:52.551431	\N
1517	V	5	211.79	5	2026-09-23 23:29:52.551431	\N
1518	V	5	281.08	5	2026-09-23 23:29:52.551431	\N
1519	V	5	210.16	5	2026-09-23 23:29:52.551431	\N
1520	V	5	139.44	5	2026-09-23 23:29:52.551431	\N
1521	V	5	140.06	5	2026-09-23 23:29:52.551431	\N
1522	V	5	211.57	5	2026-09-23 23:29:52.551431	\N
1523	V	5	213.45	5	2026-09-23 23:29:52.551431	\N
1524	V	5	283.89	5	2026-09-23 23:29:52.551431	\N
1525	V	5	353.85	5	2026-09-23 23:29:52.551431	\N
1526	V	5	283.09	5	2026-09-23 23:29:52.551431	\N
1527	V	5	211.58	5	2026-09-23 23:29:52.551431	\N
1528	V	5	209.04	5	2026-09-23 23:29:52.551431	\N
1529	V	5	204.17	5	2026-09-23 23:29:52.551431	\N
1530	V	5	200.05	5	2026-09-23 23:29:52.551431	\N
1531	V	5	265.60	5	2026-09-23 23:29:52.551431	\N
1532	V	5	331.26	5	2026-09-23 23:29:52.551431	\N
1533	V	5	262.62	5	2026-09-23 23:29:52.551431	\N
1534	V	5	197.04	5	2026-09-23 23:29:52.551431	\N
1535	V	5	131.21	5	2026-09-23 23:29:52.551431	\N
1536	V	5	130.82	5	2026-09-23 23:29:52.551431	\N
1537	V	5	130.22	5	2026-09-23 23:29:52.551431	\N
1538	V	5	195.49	5	2026-09-23 23:29:52.551431	\N
1539	V	5	260.73	5	2026-09-23 23:29:52.551431	\N
1540	V	5	260.73	5	2026-09-23 23:29:52.551431	\N
1541	V	5	195.56	5	2026-09-23 23:29:52.551431	\N
1542	V	5	196.21	5	2026-09-23 23:29:52.551431	\N
1543	V	5	195.99	5	2026-09-23 23:29:52.551431	\N
1544	V	5	196.15	5	2026-09-23 23:29:52.551431	\N
1545	V	5	262.51	5	2026-09-23 23:29:52.551431	\N
1546	V	5	326.87	5	2026-09-23 23:29:52.551431	\N
1547	V	5	261.17	5	2026-09-23 23:29:52.551431	\N
1548	V	5	196.12	5	2026-09-23 23:29:52.551431	\N
1549	V	5	197.49	5	2026-09-23 23:29:52.551431	\N
1550	V	5	196.92	5	2026-09-23 23:29:52.551431	\N
1551	V	5	198.54	5	2026-09-23 23:29:52.551431	\N
1552	V	5	264.37	5	2026-09-23 23:29:52.551431	\N
1553	V	5	330.69	5	2026-09-23 23:29:52.551431	\N
1554	V	5	263.92	5	2026-09-23 23:29:52.551431	\N
1555	V	5	198.13	5	2026-09-23 23:29:52.551431	\N
1556	V	5	197.26	5	2026-09-23 23:29:52.551431	\N
1557	V	5	197.07	5	2026-09-23 23:29:52.551431	\N
1558	V	5	196.60	5	2026-09-23 23:29:52.551431	\N
1559	V	5	261.43	5	2026-09-23 23:29:52.551431	\N
1560	V	5	324.25	5	2026-09-23 23:29:52.551431	\N
1561	V	5	259.13	5	2026-09-23 23:29:52.551431	\N
1562	V	5	193.50	5	2026-09-23 23:29:52.551431	\N
1563	V	5	127.65	5	2026-09-23 23:29:52.551431	\N
1564	V	5	126.72	5	2026-09-23 23:29:52.551431	\N
1565	V	5	127.96	5	2026-09-23 23:29:52.551431	\N
1566	V	5	191.75	5	2026-09-23 23:29:52.551431	\N
1567	V	5	255.94	5	2026-09-23 23:29:52.551431	\N
1568	V	5	255.94	5	2026-09-23 23:29:52.551431	\N
1569	V	5	192.04	5	2026-09-23 23:29:52.551431	\N
1570	V	5	189.28	5	2026-09-23 23:29:52.551431	\N
1571	V	5	186.94	5	2026-09-23 23:29:52.551431	\N
1572	V	5	185.35	5	2026-09-23 23:29:52.551431	\N
1573	V	5	248.69	5	2026-09-23 23:29:52.551431	\N
1574	V	5	312.71	5	2026-09-23 23:29:52.551431	\N
1575	V	5	251.41	5	2026-09-23 23:29:52.551431	\N
1576	V	5	189.97	5	2026-09-23 23:29:52.551431	\N
1577	V	5	191.47	5	2026-09-23 23:29:52.551431	\N
1578	V	5	192.30	5	2026-09-23 23:29:52.551431	\N
1579	V	5	192.36	5	2026-09-23 23:29:52.551431	\N
1580	V	5	256.32	5	2026-09-23 23:29:52.551431	\N
1581	V	5	319.79	5	2026-09-23 23:29:52.551431	\N
1582	V	5	255.69	5	2026-09-23 23:29:52.551431	\N
1583	V	5	191.53	5	2026-09-23 23:29:52.551431	\N
1584	V	5	190.63	5	2026-09-23 23:29:52.551431	\N
1585	V	5	189.55	5	2026-09-23 23:29:52.551431	\N
1586	V	5	187.87	5	2026-09-23 23:29:52.551431	\N
1587	V	5	249.17	5	2026-09-23 23:29:52.551431	\N
1588	V	5	310.60	5	2026-09-23 23:29:52.551431	\N
1589	V	5	247.41	5	2026-09-23 23:29:52.551431	\N
1590	V	5	184.52	5	2026-09-23 23:29:52.551431	\N
1591	V	5	184.75	5	2026-09-23 23:29:52.551431	\N
1592	V	5	185.14	5	2026-09-23 23:29:52.551431	\N
1593	V	5	183.52	5	2026-09-23 23:29:52.551431	\N
1594	V	5	243.46	5	2026-09-23 23:29:52.551431	\N
1595	V	5	303.78	5	2026-09-23 23:29:52.551431	\N
1596	V	5	241.76	5	2026-09-23 23:29:52.551431	\N
1597	V	5	180.07	5	2026-09-23 23:29:52.551431	\N
1598	V	5	181.15	5	2026-09-23 23:29:52.551431	\N
1599	V	5	181.96	5	2026-09-23 23:29:52.551431	\N
1600	V	5	182.62	5	2026-09-23 23:29:52.551431	\N
1601	V	5	243.73	5	2026-09-23 23:29:52.551431	\N
1602	V	5	302.83	5	2026-09-23 23:29:52.551431	\N
1603	V	5	241.94	5	2026-09-23 23:29:52.551431	\N
1604	V	5	181.19	5	2026-09-23 23:29:52.551431	\N
1605	V	5	180.12	5	2026-09-23 23:29:52.551431	\N
1606	V	5	179.46	5	2026-09-23 23:29:52.551431	\N
1607	V	5	180.06	5	2026-09-23 23:29:52.551431	\N
1608	V	5	240.22	5	2026-09-23 23:29:52.551431	\N
1609	V	5	240.22	5	2026-09-23 23:29:52.551431	\N
1610	V	5	180.31	5	2026-09-23 23:29:52.551431	\N
1611	V	5	119.86	5	2026-09-23 23:29:52.551431	\N
1612	V	5	120.83	5	2026-09-23 23:29:52.551431	\N
1613	V	5	121.18	5	2026-09-23 23:29:52.551431	\N
1614	V	5	182.97	5	2026-09-23 23:29:52.551431	\N
1615	V	5	244.63	5	2026-09-23 23:29:52.551431	\N
1616	V	5	305.50	5	2026-09-23 23:29:52.551431	\N
1617	V	5	244.83	5	2026-09-23 23:29:52.551431	\N
1618	V	5	184.32	5	2026-09-23 23:29:52.551431	\N
1619	V	5	184.41	5	2026-09-23 23:29:52.551431	\N
1620	V	5	185.02	5	2026-09-23 23:29:52.551431	\N
1621	V	5	187.33	5	2026-09-23 23:29:52.551431	\N
1622	V	5	250.35	5	2026-09-23 23:29:52.551431	\N
1623	V	5	313.76	5	2026-09-23 23:29:52.551431	\N
1624	V	5	251.88	5	2026-09-23 23:29:52.551431	\N
1625	V	5	189.61	5	2026-09-23 23:29:52.551431	\N
1626	V	5	189.21	5	2026-09-23 23:29:52.551431	\N
1627	V	5	188.18	5	2026-09-23 23:29:52.551431	\N
1628	V	5	187.03	5	2026-09-23 23:29:52.551431	\N
1629	V	5	248.81	5	2026-09-23 23:29:52.551431	\N
1630	V	5	310.69	5	2026-09-23 23:29:52.551431	\N
1631	V	5	247.91	5	2026-09-23 23:29:52.551431	\N
1632	V	5	185.92	5	2026-09-23 23:29:52.551431	\N
1633	V	5	185.59	5	2026-09-23 23:29:52.551431	\N
1634	V	5	185.67	5	2026-09-23 23:29:52.551431	\N
1635	V	5	190.76	5	2026-09-23 23:29:52.551431	\N
1636	V	5	256.73	5	2026-09-23 23:29:52.551431	\N
1637	V	5	322.34	5	2026-09-23 23:29:52.551431	\N
1638	V	5	260.41	5	2026-09-23 23:29:52.551431	\N
1639	V	5	198.55	5	2026-09-23 23:29:52.551431	\N
1640	V	5	196.94	5	2026-09-23 23:29:52.551431	\N
1641	V	5	195.38	5	2026-09-23 23:29:52.551431	\N
1642	V	5	193.54	5	2026-09-23 23:29:52.551431	\N
1643	V	5	257.79	5	2026-09-23 23:29:52.551431	\N
1644	V	5	321.55	5	2026-09-23 23:29:52.551431	\N
1645	V	5	256.18	5	2026-09-23 23:29:52.551431	\N
1646	V	5	191.77	5	2026-09-23 23:29:52.551431	\N
1647	V	5	192.79	5	2026-09-23 23:29:52.551431	\N
1648	V	5	193.81	5	2026-09-23 23:29:52.551431	\N
1649	V	5	194.12	5	2026-09-23 23:29:52.551431	\N
1650	V	5	258.62	5	2026-09-23 23:29:52.551431	\N
1651	V	5	323.77	5	2026-09-23 23:29:52.551431	\N
1652	V	5	259.00	5	2026-09-23 23:29:52.551431	\N
1653	V	5	193.72	5	2026-09-23 23:29:52.551431	\N
1654	V	5	196.18	5	2026-09-23 23:29:52.551431	\N
1655	V	5	197.66	5	2026-09-23 23:29:52.551431	\N
1656	V	5	198.66	5	2026-09-23 23:29:52.551431	\N
1657	V	5	264.88	5	2026-09-23 23:29:52.551431	\N
1658	V	5	330.66	5	2026-09-23 23:29:52.551431	\N
1659	V	5	264.13	5	2026-09-23 23:29:52.551431	\N
1660	V	5	198.15	5	2026-09-23 23:29:52.551431	\N
1661	V	5	132.00	5	2026-09-23 23:29:52.551431	\N
1662	V	5	131.07	5	2026-09-23 23:29:52.551431	\N
1663	V	5	130.82	5	2026-09-23 23:29:52.551431	\N
1664	V	5	195.81	5	2026-09-23 23:29:52.551431	\N
1665	V	5	261.08	5	2026-09-23 23:29:52.551431	\N
1666	V	5	261.08	5	2026-09-23 23:29:52.551431	\N
1667	V	5	195.78	5	2026-09-23 23:29:52.551431	\N
1668	V	5	194.82	5	2026-09-23 23:29:52.551431	\N
1669	V	5	193.29	5	2026-09-23 23:29:52.551431	\N
1670	V	5	190.50	5	2026-09-23 23:29:52.551431	\N
1671	V	5	254.53	5	2026-09-23 23:29:52.551431	\N
1672	V	5	319.25	5	2026-09-23 23:29:52.551431	\N
1673	V	5	254.69	5	2026-09-23 23:29:52.551431	\N
1674	V	5	191.23	5	2026-09-23 23:29:52.551431	\N
1675	V	5	192.68	5	2026-09-23 23:29:52.551431	\N
1676	V	5	193.66	5	2026-09-23 23:29:52.551431	\N
1677	V	5	193.54	5	2026-09-23 23:29:52.551431	\N
1678	V	5	257.35	5	2026-09-23 23:29:52.551431	\N
1679	V	5	321.82	5	2026-09-23 23:29:52.551431	\N
1680	V	5	257.89	5	2026-09-23 23:29:52.551431	\N
1681	V	5	192.88	5	2026-09-23 23:29:52.551431	\N
1682	V	5	193.05	5	2026-09-23 23:29:52.551431	\N
1683	V	5	195.87	5	2026-09-23 23:29:52.551431	\N
1684	V	5	197.46	5	2026-09-23 23:29:52.551431	\N
1685	V	5	262.91	5	2026-09-23 23:29:52.551431	\N
1686	V	5	262.91	5	2026-09-23 23:29:52.551431	\N
1687	V	5	198.15	5	2026-09-23 23:29:52.551431	\N
1688	V	5	131.52	5	2026-09-23 23:29:52.551431	\N
1689	V	5	130.77	5	2026-09-23 23:29:52.551431	\N
1690	V	5	131.02	5	2026-09-23 23:29:52.551431	\N
1691	V	5	197.46	5	2026-09-23 23:29:52.551431	\N
1692	V	5	263.57	5	2026-09-23 23:29:52.551431	\N
1693	V	5	330.81	5	2026-09-23 23:29:52.551431	\N
1694	V	5	265.49	5	2026-09-23 23:29:52.551431	\N
1695	V	5	199.80	5	2026-09-23 23:29:52.551431	\N
1696	V	5	201.68	5	2026-09-23 23:29:52.551431	\N
1697	V	5	204.19	5	2026-09-23 23:29:52.551431	\N
1698	V	5	207.16	5	2026-09-23 23:29:52.551431	\N
1699	V	5	279.59	5	2026-09-23 23:29:52.551431	\N
1700	V	5	279.59	5	2026-09-23 23:29:52.551431	\N
1701	V	5	211.26	5	2026-09-23 23:29:52.551431	\N
1702	V	5	142.64	5	2026-09-23 23:29:52.551431	\N
1703	V	5	143.88	5	2026-09-23 23:29:52.551431	\N
1704	V	5	141.89	5	2026-09-23 23:29:52.551431	\N
1705	V	5	211.40	5	2026-09-23 23:29:52.551431	\N
1706	V	5	281.04	5	2026-09-23 23:29:52.551431	\N
1707	V	5	350.83	5	2026-09-23 23:29:52.551431	\N
1708	V	5	279.38	5	2026-09-23 23:29:52.551431	\N
1709	V	5	208.94	5	2026-09-23 23:29:52.551431	\N
1710	V	5	210.98	5	2026-09-23 23:29:52.551431	\N
1711	V	5	212.55	5	2026-09-23 23:29:52.551431	\N
1712	V	5	213.78	5	2026-09-23 23:29:52.551431	\N
1713	V	5	286.81	5	2026-09-23 23:29:52.551431	\N
1714	V	5	358.52	5	2026-09-23 23:29:52.551431	\N
1715	V	5	286.97	5	2026-09-23 23:29:52.551431	\N
1716	V	5	215.77	5	2026-09-23 23:29:52.551431	\N
1717	V	5	216.85	5	2026-09-23 23:29:52.551431	\N
1718	V	5	214.99	5	2026-09-23 23:29:52.551431	\N
1719	V	5	213.96	5	2026-09-23 23:29:52.551431	\N
1720	V	5	284.28	5	2026-09-23 23:29:52.551431	\N
1721	V	5	355.43	5	2026-09-23 23:29:52.551431	\N
1722	V	5	283.32	5	2026-09-23 23:29:52.551431	\N
1723	V	5	212.15	5	2026-09-23 23:29:52.551431	\N
1724	V	5	213.97	5	2026-09-23 23:29:52.551431	\N
1725	V	5	216.97	5	2026-09-23 23:29:52.551431	\N
1726	V	5	219.57	5	2026-09-23 23:29:52.551431	\N
1727	V	5	292.82	5	2026-09-23 23:29:52.551431	\N
1728	V	5	366.05	5	2026-09-23 23:29:52.551431	\N
1729	V	5	293.54	5	2026-09-23 23:29:52.551431	\N
1730	V	5	220.23	5	2026-09-23 23:29:52.551431	\N
1731	V	5	219.61	5	2026-09-23 23:29:52.551431	\N
1732	V	5	220.28	5	2026-09-23 23:29:52.551431	\N
1733	V	5	220.76	5	2026-09-23 23:29:52.551431	\N
1734	V	5	294.85	5	2026-09-23 23:29:52.551431	\N
1735	V	5	367.35	5	2026-09-23 23:29:52.551431	\N
1736	V	5	294.22	5	2026-09-23 23:29:52.551431	\N
1737	V	5	220.30	5	2026-09-23 23:29:52.551431	\N
1738	V	5	218.86	5	2026-09-23 23:29:52.551431	\N
1739	V	5	217.33	5	2026-09-23 23:29:52.551431	\N
1740	V	5	216.71	5	2026-09-23 23:29:52.551431	\N
1741	V	5	289.80	5	2026-09-23 23:29:52.551431	\N
1742	V	5	362.63	5	2026-09-23 23:29:52.551431	\N
1743	V	5	290.37	5	2026-09-23 23:29:52.551431	\N
1744	V	5	217.80	5	2026-09-23 23:29:52.551431	\N
1745	V	5	217.69	5	2026-09-23 23:29:52.551431	\N
1746	V	5	217.45	5	2026-09-23 23:29:52.551431	\N
1747	V	5	217.73	5	2026-09-23 23:29:52.551431	\N
1748	V	5	290.87	5	2026-09-23 23:29:52.551431	\N
1749	V	5	365.08	5	2026-09-23 23:29:52.551431	\N
1750	V	5	293.31	5	2026-09-23 23:29:52.551431	\N
1751	V	5	220.46	5	2026-09-23 23:29:52.551431	\N
1752	V	5	223.84	5	2026-09-23 23:29:52.551431	\N
1753	V	5	227.52	5	2026-09-23 23:29:52.551431	\N
1754	V	5	230.09	5	2026-09-23 23:29:52.551431	\N
1755	V	5	306.02	5	2026-09-23 23:29:52.551431	\N
1756	V	5	382.34	5	2026-09-23 23:29:52.551431	\N
1757	V	5	305.86	5	2026-09-23 23:29:52.551431	\N
1758	V	5	229.03	5	2026-09-23 23:29:52.551431	\N
1759	V	5	228.13	5	2026-09-23 23:29:52.551431	\N
1760	V	5	226.73	5	2026-09-23 23:29:52.551431	\N
1761	V	5	226.09	5	2026-09-23 23:29:52.551431	\N
1762	V	5	301.84	5	2026-09-23 23:29:52.551431	\N
1763	V	5	376.85	5	2026-09-23 23:29:52.551431	\N
1764	V	5	300.98	5	2026-09-23 23:29:52.551431	\N
1765	V	5	226.44	5	2026-09-23 23:29:52.551431	\N
1766	V	5	150.76	5	2026-09-23 23:29:52.551431	\N
1767	V	5	148.74	5	2026-09-23 23:29:52.551431	\N
1768	V	5	147.21	5	2026-09-23 23:29:52.551431	\N
1769	V	5	220.65	5	2026-09-23 23:29:52.551431	\N
1770	V	5	294.74	5	2026-09-23 23:29:52.551431	\N
1771	V	5	294.74	5	2026-09-23 23:29:52.551431	\N
1772	V	5	221.01	5	2026-09-23 23:29:52.551431	\N
1773	V	5	222.59	5	2026-09-23 23:29:52.551431	\N
1774	V	5	224.27	5	2026-09-23 23:29:52.551431	\N
1775	V	5	224.37	5	2026-09-23 23:29:52.551431	\N
1776	V	5	298.35	5	2026-09-23 23:29:52.551431	\N
1777	V	5	372.01	5	2026-09-23 23:29:52.551431	\N
1778	V	5	296.95	5	2026-09-23 23:29:52.551431	\N
1779	V	5	221.83	5	2026-09-23 23:29:52.551431	\N
1780	V	5	221.63	5	2026-09-23 23:29:52.551431	\N
1781	V	5	220.06	5	2026-09-23 23:29:52.551431	\N
1782	V	5	146.40	5	2026-09-23 23:29:52.551431	\N
1783	V	20	240.93	20	2026-09-23 23:29:52.607493	\N
1784	V	20	241.16	20	2026-09-23 23:29:52.607493	\N
1785	V	20	241.64	20	2026-09-23 23:29:52.607493	\N
1786	V	20	242.18	20	2026-09-23 23:29:52.607493	\N
1787	V	20	242.08	20	2026-09-23 23:29:52.607493	\N
1788	V	20	259.18	20	2026-09-23 23:29:52.607493	\N
1789	V	20	259.18	20	2026-09-23 23:29:52.607493	\N
1790	V	20	242.17	20	2026-09-23 23:29:52.607493	\N
1791	V	20	242.32	20	2026-09-23 23:29:52.607493	\N
1792	V	20	242.29	20	2026-09-23 23:29:52.607493	\N
1793	V	20	242.26	20	2026-09-23 23:29:52.607493	\N
1794	V	20	242.07	20	2026-09-23 23:29:52.607493	\N
1795	V	20	259.44	20	2026-09-23 23:29:52.607493	\N
1796	V	20	259.44	20	2026-09-23 23:29:52.607493	\N
1797	V	20	241.97	20	2026-09-23 23:29:52.607493	\N
1798	V	20	241.74	20	2026-09-23 23:29:52.607493	\N
1799	V	20	241.52	20	2026-09-23 23:29:52.607493	\N
1800	V	20	241.23	20	2026-09-23 23:29:52.607493	\N
1801	V	20	241.30	20	2026-09-23 23:29:52.607493	\N
1802	V	20	258.34	20	2026-09-23 23:29:52.607493	\N
1803	V	20	258.34	20	2026-09-23 23:29:52.607493	\N
1804	V	20	241.17	20	2026-09-23 23:29:52.607493	\N
1805	V	20	240.60	20	2026-09-23 23:29:52.607493	\N
1806	V	20	240.33	20	2026-09-23 23:29:52.607493	\N
1807	V	20	240.56	20	2026-09-23 23:29:52.607493	\N
1808	V	20	240.31	20	2026-09-23 23:29:52.607493	\N
1809	V	20	257.12	20	2026-09-23 23:29:52.607493	\N
1810	V	20	257.12	20	2026-09-23 23:29:52.607493	\N
1811	V	20	239.89	20	2026-09-23 23:29:52.607493	\N
1812	V	20	239.28	20	2026-09-23 23:29:52.607493	\N
1813	V	20	238.96	20	2026-09-23 23:29:52.607493	\N
1814	V	20	238.60	20	2026-09-23 23:29:52.607493	\N
1815	V	20	238.04	20	2026-09-23 23:29:52.607493	\N
1816	V	20	254.54	20	2026-09-23 23:29:52.607493	\N
1817	V	20	254.54	20	2026-09-23 23:29:52.607493	\N
1818	V	20	237.15	20	2026-09-23 23:29:52.607493	\N
1819	V	20	236.09	20	2026-09-23 23:29:52.607493	\N
1820	V	20	235.08	20	2026-09-23 23:29:52.607493	\N
1821	V	20	234.04	20	2026-09-23 23:29:52.607493	\N
1822	V	20	233.19	20	2026-09-23 23:29:52.607493	\N
1823	V	20	249.59	20	2026-09-23 23:29:52.607493	\N
1824	V	20	249.59	20	2026-09-23 23:29:52.607493	\N
1825	V	20	232.74	20	2026-09-23 23:29:52.607493	\N
1826	V	20	232.19	20	2026-09-23 23:29:52.607493	\N
1827	V	20	231.92	20	2026-09-23 23:29:52.607493	\N
1828	V	20	231.76	20	2026-09-23 23:29:52.607493	\N
1829	V	20	214.96	20	2026-09-23 23:29:52.607493	\N
1830	V	20	231.68	20	2026-09-23 23:29:52.607493	\N
1831	V	20	231.68	20	2026-09-23 23:29:52.607493	\N
1832	V	20	214.94	20	2026-09-23 23:29:52.607493	\N
1833	V	20	214.51	20	2026-09-23 23:29:52.607493	\N
1834	V	20	214.05	20	2026-09-23 23:29:52.607493	\N
1835	V	20	213.72	20	2026-09-23 23:29:52.607493	\N
1836	V	20	213.58	20	2026-09-23 23:29:52.607493	\N
1837	V	20	230.14	20	2026-09-23 23:29:52.607493	\N
1838	V	20	230.14	20	2026-09-23 23:29:52.607493	\N
1839	V	20	213.85	20	2026-09-23 23:29:52.607493	\N
1840	V	20	214.14	20	2026-09-23 23:29:52.607493	\N
1841	V	20	214.26	20	2026-09-23 23:29:52.607493	\N
1842	V	20	214.35	20	2026-09-23 23:29:52.607493	\N
1843	V	20	215.24	20	2026-09-23 23:29:52.607493	\N
1844	V	20	232.63	20	2026-09-23 23:29:52.607493	\N
1845	V	20	232.63	20	2026-09-23 23:29:52.607493	\N
1846	V	20	216.16	20	2026-09-23 23:29:52.607493	\N
1847	V	20	216.78	20	2026-09-23 23:29:52.607493	\N
1848	V	20	217.35	20	2026-09-23 23:29:52.607493	\N
1849	V	20	234.57	20	2026-09-23 23:29:52.607493	\N
1850	V	20	235.15	20	2026-09-23 23:29:52.607493	\N
1851	V	20	252.61	20	2026-09-23 23:29:52.607493	\N
1852	V	20	252.61	20	2026-09-23 23:29:52.607493	\N
1853	V	20	236.09	20	2026-09-23 23:29:52.607493	\N
1854	V	20	237.21	20	2026-09-23 23:29:52.607493	\N
1855	V	20	238.40	20	2026-09-23 23:29:52.607493	\N
1856	V	20	239.80	20	2026-09-23 23:29:52.607493	\N
1857	V	20	223.24	20	2026-09-23 23:29:52.607493	\N
1858	V	20	240.99	20	2026-09-23 23:29:52.607493	\N
1859	V	20	240.99	20	2026-09-23 23:29:52.607493	\N
1860	V	20	224.65	20	2026-09-23 23:29:52.607493	\N
1861	V	20	226.05	20	2026-09-23 23:29:52.607493	\N
1862	V	20	227.45	20	2026-09-23 23:29:52.607493	\N
1863	V	20	227.70	20	2026-09-23 23:29:52.607493	\N
1864	V	20	210.31	20	2026-09-23 23:29:52.607493	\N
1865	V	20	227.64	20	2026-09-23 23:29:52.607493	\N
1866	V	20	227.64	20	2026-09-23 23:29:52.607493	\N
1867	V	20	210.29	20	2026-09-23 23:29:52.607493	\N
1868	V	20	210.72	20	2026-09-23 23:29:52.607493	\N
1869	V	20	211.38	20	2026-09-23 23:29:52.607493	\N
1870	V	20	211.88	20	2026-09-23 23:29:52.607493	\N
1871	V	20	212.03	20	2026-09-23 23:29:52.607493	\N
1872	V	20	229.51	20	2026-09-23 23:29:52.607493	\N
1873	V	20	229.51	20	2026-09-23 23:29:52.607493	\N
1874	V	20	211.91	20	2026-09-23 23:29:52.607493	\N
1875	V	20	211.40	20	2026-09-23 23:29:52.607493	\N
1876	V	20	210.04	20	2026-09-23 23:29:52.607493	\N
1877	V	20	226.50	20	2026-09-23 23:29:52.607493	\N
1878	V	20	225.13	20	2026-09-23 23:29:52.607493	\N
1879	V	20	241.55	20	2026-09-23 23:29:52.607493	\N
1880	V	20	241.55	20	2026-09-23 23:29:52.607493	\N
1881	V	20	223.82	20	2026-09-23 23:29:52.607493	\N
1882	V	20	206.14	20	2026-09-23 23:29:52.607493	\N
1883	V	20	204.89	20	2026-09-23 23:29:52.607493	\N
1884	V	20	221.16	20	2026-09-23 23:29:52.607493	\N
1885	V	20	220.15	20	2026-09-23 23:29:52.607493	\N
1886	V	20	236.46	20	2026-09-23 23:29:52.607493	\N
1887	V	20	236.46	20	2026-09-23 23:29:52.607493	\N
1888	V	20	218.77	20	2026-09-23 23:29:52.607493	\N
1889	V	20	217.32	20	2026-09-23 23:29:52.607493	\N
1890	V	20	215.78	20	2026-09-23 23:29:52.607493	\N
1891	V	20	214.52	20	2026-09-23 23:29:52.607493	\N
1892	V	20	213.62	20	2026-09-23 23:29:52.607493	\N
1893	V	20	229.71	20	2026-09-23 23:29:52.607493	\N
1894	V	20	229.71	20	2026-09-23 23:29:52.607493	\N
1895	V	20	212.56	20	2026-09-23 23:29:52.607493	\N
1896	V	20	212.85	20	2026-09-23 23:29:52.607493	\N
1897	V	20	212.84	20	2026-09-23 23:29:52.607493	\N
1898	V	20	212.95	20	2026-09-23 23:29:52.607493	\N
1899	V	20	212.99	20	2026-09-23 23:29:52.607493	\N
1900	V	20	229.57	20	2026-09-23 23:29:52.607493	\N
1901	V	20	229.57	20	2026-09-23 23:29:52.607493	\N
1902	V	20	229.57	20	2026-09-23 23:29:52.607493	\N
1903	V	20	229.56	20	2026-09-23 23:29:52.607493	\N
1904	V	20	229.70	20	2026-09-23 23:29:52.607493	\N
1905	V	20	229.85	20	2026-09-23 23:29:52.607493	\N
1906	V	20	229.75	20	2026-09-23 23:29:52.607493	\N
1907	V	20	245.45	20	2026-09-23 23:29:52.607493	\N
1908	V	20	245.45	20	2026-09-23 23:29:52.607493	\N
1909	V	20	229.03	20	2026-09-23 23:29:52.607493	\N
1910	V	20	212.76	20	2026-09-23 23:29:52.607493	\N
1911	V	20	212.39	20	2026-09-23 23:29:52.607493	\N
1912	V	20	211.82	20	2026-09-23 23:29:52.607493	\N
1913	V	20	211.67	20	2026-09-23 23:29:52.607493	\N
1914	V	20	227.72	20	2026-09-23 23:29:52.607493	\N
1915	V	20	227.72	20	2026-09-23 23:29:52.607493	\N
1916	V	20	211.03	20	2026-09-23 23:29:52.607493	\N
1917	V	20	209.91	20	2026-09-23 23:29:52.607493	\N
1918	V	20	208.77	20	2026-09-23 23:29:52.607493	\N
1919	V	20	207.96	20	2026-09-23 23:29:52.607493	\N
1920	V	20	207.22	20	2026-09-23 23:29:52.607493	\N
1921	V	20	223.22	20	2026-09-23 23:29:52.607493	\N
1922	V	20	223.22	20	2026-09-23 23:29:52.607493	\N
1923	V	20	206.95	20	2026-09-23 23:29:52.607493	\N
1924	V	20	206.56	20	2026-09-23 23:29:52.607493	\N
1925	V	20	206.14	20	2026-09-23 23:29:52.607493	\N
1926	V	20	205.96	20	2026-09-23 23:29:52.607493	\N
1927	V	20	206.24	20	2026-09-23 23:29:52.607493	\N
1928	V	20	222.11	20	2026-09-23 23:29:52.607493	\N
1929	V	20	222.11	20	2026-09-23 23:29:52.607493	\N
1930	V	20	222.11	20	2026-09-23 23:29:52.607493	\N
1931	V	20	221.93	20	2026-09-23 23:29:52.607493	\N
1932	V	20	221.64	20	2026-09-23 23:29:52.607493	\N
1933	V	20	221.14	20	2026-09-23 23:29:52.607493	\N
1934	V	20	220.42	20	2026-09-23 23:29:52.607493	\N
1935	V	20	235.78	20	2026-09-23 23:29:52.607493	\N
1936	V	20	235.78	20	2026-09-23 23:29:52.607493	\N
1937	V	20	220.45	20	2026-09-23 23:29:52.607493	\N
1938	V	20	220.60	20	2026-09-23 23:29:52.607493	\N
1939	V	20	220.37	20	2026-09-23 23:29:52.607493	\N
1940	V	20	219.48	20	2026-09-23 23:29:52.607493	\N
1941	V	20	218.46	20	2026-09-23 23:29:52.607493	\N
1942	V	20	233.54	20	2026-09-23 23:29:52.607493	\N
1943	V	20	233.54	20	2026-09-23 23:29:52.607493	\N
1944	V	20	217.52	20	2026-09-23 23:29:52.607493	\N
1945	V	20	216.70	20	2026-09-23 23:29:52.607493	\N
1946	V	20	215.86	20	2026-09-23 23:29:52.607493	\N
1947	V	20	215.12	20	2026-09-23 23:29:52.607493	\N
1948	V	20	214.53	20	2026-09-23 23:29:52.607493	\N
1949	V	20	229.30	20	2026-09-23 23:29:52.607493	\N
1950	V	20	229.30	20	2026-09-23 23:29:52.607493	\N
1951	V	20	213.51	20	2026-09-23 23:29:52.607493	\N
1952	V	20	212.76	20	2026-09-23 23:29:52.607493	\N
1953	V	20	212.43	20	2026-09-23 23:29:52.607493	\N
1954	V	20	212.03	20	2026-09-23 23:29:52.607493	\N
1955	V	20	211.71	20	2026-09-23 23:29:52.607493	\N
1956	V	20	211.71	20	2026-09-23 23:29:52.607493	\N
1957	V	20	211.71	20	2026-09-23 23:29:52.607493	\N
1958	V	20	196.20	20	2026-09-23 23:29:52.607493	\N
1959	V	20	195.95	20	2026-09-23 23:29:52.607493	\N
1960	V	20	196.12	20	2026-09-23 23:29:52.607493	\N
1961	V	20	196.59	20	2026-09-23 23:29:52.607493	\N
1962	V	20	196.92	20	2026-09-23 23:29:52.607493	\N
1963	V	20	212.14	20	2026-09-23 23:29:52.607493	\N
1964	V	20	212.14	20	2026-09-23 23:29:52.607493	\N
1965	V	20	196.92	20	2026-09-23 23:29:52.607493	\N
1966	V	20	197.20	20	2026-09-23 23:29:52.607493	\N
1967	V	20	197.52	20	2026-09-23 23:29:52.607493	\N
1968	V	20	198.04	20	2026-09-23 23:29:52.607493	\N
1969	V	20	199.02	20	2026-09-23 23:29:52.607493	\N
1970	V	20	214.87	20	2026-09-23 23:29:52.607493	\N
1971	V	20	214.87	20	2026-09-23 23:29:52.607493	\N
1972	V	20	199.89	20	2026-09-23 23:29:52.607493	\N
1973	V	20	200.48	20	2026-09-23 23:29:52.607493	\N
1974	V	20	201.05	20	2026-09-23 23:29:52.607493	\N
1975	V	20	201.57	20	2026-09-23 23:29:52.607493	\N
1976	V	20	217.02	20	2026-09-23 23:29:52.607493	\N
1977	V	20	232.49	20	2026-09-23 23:29:52.607493	\N
1978	V	20	232.49	20	2026-09-23 23:29:52.607493	\N
1979	V	20	217.32	20	2026-09-23 23:29:52.607493	\N
1980	V	20	217.68	20	2026-09-23 23:29:52.607493	\N
1981	V	20	217.69	20	2026-09-23 23:29:52.607493	\N
1982	V	20	219.02	20	2026-09-23 23:29:52.607493	\N
1983	V	20	220.30	20	2026-09-23 23:29:52.607493	\N
1984	V	20	236.70	20	2026-09-23 23:29:52.607493	\N
1985	V	20	236.70	20	2026-09-23 23:29:52.607493	\N
1986	V	20	221.23	20	2026-09-23 23:29:52.607493	\N
1987	V	20	222.00	20	2026-09-23 23:29:52.607493	\N
1988	V	20	222.31	20	2026-09-23 23:29:52.607493	\N
1989	V	20	222.49	20	2026-09-23 23:29:52.607493	\N
1990	V	20	222.71	20	2026-09-23 23:29:52.607493	\N
1991	V	20	238.65	20	2026-09-23 23:29:52.607493	\N
1992	V	20	238.65	20	2026-09-23 23:29:52.607493	\N
1993	V	20	222.95	20	2026-09-23 23:29:52.607493	\N
1994	V	20	223.64	20	2026-09-23 23:29:52.607493	\N
1995	V	20	224.40	20	2026-09-23 23:29:52.607493	\N
1996	V	20	224.97	20	2026-09-23 23:29:52.607493	\N
1997	V	20	225.63	20	2026-09-23 23:29:52.607493	\N
1998	V	20	241.91	20	2026-09-23 23:29:52.607493	\N
1999	V	20	241.91	20	2026-09-23 23:29:52.607493	\N
2000	V	20	226.43	20	2026-09-23 23:29:52.607493	\N
2001	V	20	227.60	20	2026-09-23 23:29:52.607493	\N
2002	V	20	227.35	20	2026-09-23 23:29:52.607493	\N
2003	V	20	227.40	20	2026-09-23 23:29:52.607493	\N
2004	V	20	227.55	20	2026-09-23 23:29:52.607493	\N
2005	V	20	244.00	20	2026-09-23 23:29:52.607493	\N
2006	V	20	244.00	20	2026-09-23 23:29:52.607493	\N
2007	V	20	227.65	20	2026-09-23 23:29:52.607493	\N
2008	V	20	211.55	20	2026-09-23 23:29:52.607493	\N
2009	V	20	211.94	20	2026-09-23 23:29:52.607493	\N
2010	V	20	212.25	20	2026-09-23 23:29:52.607493	\N
2011	V	20	212.56	20	2026-09-23 23:29:52.607493	\N
2012	V	20	228.88	20	2026-09-23 23:29:52.607493	\N
2013	V	20	228.88	20	2026-09-23 23:29:52.607493	\N
2014	V	20	212.69	20	2026-09-23 23:29:52.607493	\N
2015	V	20	212.50	20	2026-09-23 23:29:52.607493	\N
2016	V	20	212.35	20	2026-09-23 23:29:52.607493	\N
2017	V	20	211.85	20	2026-09-23 23:29:52.607493	\N
2018	V	20	211.57	20	2026-09-23 23:29:52.607493	\N
2019	V	20	227.75	20	2026-09-23 23:29:52.607493	\N
2020	V	20	227.75	20	2026-09-23 23:29:52.607493	\N
2021	V	20	211.12	20	2026-09-23 23:29:52.607493	\N
2022	V	20	210.60	20	2026-09-23 23:29:52.607493	\N
2023	V	20	210.32	20	2026-09-23 23:29:52.607493	\N
2024	V	20	209.91	20	2026-09-23 23:29:52.607493	\N
2025	V	20	209.42	20	2026-09-23 23:29:52.607493	\N
2026	V	20	225.54	20	2026-09-23 23:29:52.607493	\N
2027	V	20	225.54	20	2026-09-23 23:29:52.607493	\N
2028	V	20	225.54	20	2026-09-23 23:29:52.607493	\N
2029	V	20	225.41	20	2026-09-23 23:29:52.607493	\N
2030	V	20	225.68	20	2026-09-23 23:29:52.607493	\N
2031	V	20	225.95	20	2026-09-23 23:29:52.607493	\N
2032	V	20	226.00	20	2026-09-23 23:29:52.607493	\N
2033	V	20	226.00	20	2026-09-23 23:29:52.607493	\N
2034	V	20	226.00	20	2026-09-23 23:29:52.607493	\N
2035	V	20	209.86	20	2026-09-23 23:29:52.607493	\N
2036	V	20	210.32	20	2026-09-23 23:29:52.607493	\N
2037	V	20	211.13	20	2026-09-23 23:29:52.607493	\N
2038	V	20	211.73	20	2026-09-23 23:29:52.607493	\N
2039	V	20	212.08	20	2026-09-23 23:29:52.607493	\N
2040	V	20	228.89	20	2026-09-23 23:29:52.607493	\N
2041	V	20	228.89	20	2026-09-23 23:29:52.607493	\N
2042	V	20	212.90	20	2026-09-23 23:29:52.607493	\N
2043	V	20	213.73	20	2026-09-23 23:29:52.607493	\N
2044	V	20	214.74	20	2026-09-23 23:29:52.607493	\N
2045	V	20	216.34	20	2026-09-23 23:29:52.607493	\N
2046	V	20	218.33	20	2026-09-23 23:29:52.607493	\N
2047	V	20	218.33	20	2026-09-23 23:29:52.607493	\N
2048	V	20	218.33	20	2026-09-23 23:29:52.607493	\N
2049	V	20	202.14	20	2026-09-23 23:29:52.607493	\N
2050	V	20	203.34	20	2026-09-23 23:29:52.607493	\N
2051	V	20	204.44	20	2026-09-23 23:29:52.607493	\N
2052	V	20	205.45	20	2026-09-23 23:29:52.607493	\N
2053	V	20	222.86	20	2026-09-23 23:29:52.607493	\N
2054	V	20	240.31	20	2026-09-23 23:29:52.607493	\N
2055	V	20	240.31	20	2026-09-23 23:29:52.607493	\N
2056	V	20	223.98	20	2026-09-23 23:29:52.607493	\N
2057	V	20	225.44	20	2026-09-23 23:29:52.607493	\N
2058	V	20	226.63	20	2026-09-23 23:29:52.607493	\N
2059	V	20	227.86	20	2026-09-23 23:29:52.607493	\N
2060	V	20	229.31	20	2026-09-23 23:29:52.607493	\N
2061	V	20	247.24	20	2026-09-23 23:29:52.607493	\N
2062	V	20	247.24	20	2026-09-23 23:29:52.607493	\N
2063	V	20	230.15	20	2026-09-23 23:29:52.607493	\N
2064	V	20	231.03	20	2026-09-23 23:29:52.607493	\N
2065	V	20	231.26	20	2026-09-23 23:29:52.607493	\N
2066	V	20	230.83	20	2026-09-23 23:29:52.607493	\N
2067	V	20	248.41	20	2026-09-23 23:29:52.607493	\N
2068	V	20	266.20	20	2026-09-23 23:29:52.607493	\N
2069	V	20	266.20	20	2026-09-23 23:29:52.607493	\N
2070	V	20	248.33	20	2026-09-23 23:29:52.607493	\N
2071	V	20	248.85	20	2026-09-23 23:29:52.607493	\N
2072	V	20	249.80	20	2026-09-23 23:29:52.607493	\N
2073	V	20	250.83	20	2026-09-23 23:29:52.607493	\N
2074	V	20	251.69	20	2026-09-23 23:29:52.607493	\N
2075	V	20	270.00	20	2026-09-23 23:29:52.607493	\N
2076	V	20	270.00	20	2026-09-23 23:29:52.607493	\N
2077	V	20	252.11	20	2026-09-23 23:29:52.607493	\N
2078	V	20	252.60	20	2026-09-23 23:29:52.607493	\N
2079	V	20	253.32	20	2026-09-23 23:29:52.607493	\N
2080	V	20	253.49	20	2026-09-23 23:29:52.607493	\N
2081	V	20	254.08	20	2026-09-23 23:29:52.607493	\N
2082	V	20	272.21	20	2026-09-23 23:29:52.607493	\N
2083	V	20	272.21	20	2026-09-23 23:29:52.607493	\N
2084	V	20	254.18	20	2026-09-23 23:29:52.607493	\N
2085	V	20	254.45	20	2026-09-23 23:29:52.607493	\N
2086	V	20	254.93	20	2026-09-23 23:29:52.607493	\N
2087	V	20	255.32	20	2026-09-23 23:29:52.607493	\N
2088	V	20	255.80	20	2026-09-23 23:29:52.607493	\N
2089	V	20	274.01	20	2026-09-23 23:29:52.607493	\N
2090	V	20	274.01	20	2026-09-23 23:29:52.607493	\N
2091	V	20	255.88	20	2026-09-23 23:29:52.607493	\N
2092	V	20	255.50	20	2026-09-23 23:29:52.607493	\N
2093	V	20	255.27	20	2026-09-23 23:29:52.607493	\N
2094	V	20	255.23	20	2026-09-23 23:29:52.607493	\N
2095	V	20	255.21	20	2026-09-23 23:29:52.607493	\N
2096	V	20	273.77	20	2026-09-23 23:29:52.607493	\N
2097	V	20	273.77	20	2026-09-23 23:29:52.607493	\N
2098	V	20	255.48	20	2026-09-23 23:29:52.607493	\N
2099	V	20	256.12	20	2026-09-23 23:29:52.607493	\N
2100	V	20	256.90	20	2026-09-23 23:29:52.607493	\N
2101	V	20	257.58	20	2026-09-23 23:29:52.607493	\N
2102	V	20	258.43	20	2026-09-23 23:29:52.607493	\N
2103	V	20	277.51	20	2026-09-23 23:29:52.607493	\N
2104	V	20	277.51	20	2026-09-23 23:29:52.607493	\N
2105	V	20	259.45	20	2026-09-23 23:29:52.607493	\N
2106	V	20	260.27	20	2026-09-23 23:29:52.607493	\N
2107	V	20	260.94	20	2026-09-23 23:29:52.607493	\N
2108	V	20	261.58	20	2026-09-23 23:29:52.607493	\N
2109	V	20	262.31	20	2026-09-23 23:29:52.607493	\N
2110	V	20	281.07	20	2026-09-23 23:29:52.607493	\N
2111	V	20	281.07	20	2026-09-23 23:29:52.607493	\N
2112	V	20	263.13	20	2026-09-23 23:29:52.607493	\N
2113	V	20	244.91	20	2026-09-23 23:29:52.607493	\N
2114	V	20	245.07	20	2026-09-23 23:29:52.607493	\N
2115	V	20	245.15	20	2026-09-23 23:29:52.607493	\N
2116	V	20	244.96	20	2026-09-23 23:29:52.607493	\N
2117	V	20	263.48	20	2026-09-23 23:29:52.607493	\N
2118	V	20	263.48	20	2026-09-23 23:29:52.607493	\N
2119	V	20	244.36	20	2026-09-23 23:29:52.607493	\N
2120	V	20	243.92	20	2026-09-23 23:29:52.607493	\N
2121	V	20	243.51	20	2026-09-23 23:29:52.607493	\N
2122	V	20	243.07	20	2026-09-23 23:29:52.607493	\N
2123	V	20	242.49	20	2026-09-23 23:29:52.607493	\N
2124	V	20	260.90	20	2026-09-23 23:29:52.607493	\N
2125	V	20	260.90	20	2026-09-23 23:29:52.607493	\N
2126	V	20	241.93	20	2026-09-23 23:29:52.607493	\N
2127	V	20	241.80	20	2026-09-23 23:29:52.607493	\N
2128	V	20	240.98	20	2026-09-23 23:29:52.607493	\N
2129	V	20	222.04	20	2026-09-23 23:29:52.607493	\N
2130	DIS	20	106.48	20	2026-09-23 23:30:52.238539	\N
2131	DIS	20	106.48	20	2026-09-25 22:21:00.064706	\N
2132	V	5	269.94	5	2026-09-25 22:26:16.30254	\N
2133	V	5	202.20	5	2026-09-25 22:26:16.30254	\N
2134	V	5	202.49	5	2026-09-25 22:26:16.30254	\N
2135	V	5	203.78	5	2026-09-25 22:26:16.30254	\N
2136	V	5	205.87	5	2026-09-25 22:26:16.30254	\N
2137	V	5	275.06	5	2026-09-25 22:26:16.30254	\N
2138	V	5	345.03	5	2026-09-25 22:26:16.30254	\N
2139	V	5	277.00	5	2026-09-25 22:26:16.30254	\N
2140	V	5	208.72	5	2026-09-25 22:26:16.30254	\N
2141	V	5	209.01	5	2026-09-25 22:26:16.30254	\N
2142	V	5	210.31	5	2026-09-25 22:26:16.30254	\N
2143	V	5	210.61	5	2026-09-25 22:26:16.30254	\N
2144	V	5	280.02	5	2026-09-25 22:26:16.30254	\N
2145	V	5	348.75	5	2026-09-25 22:26:16.30254	\N
2146	V	5	278.89	5	2026-09-25 22:26:16.30254	\N
2147	V	5	208.41	5	2026-09-25 22:26:16.30254	\N
2148	V	5	206.80	5	2026-09-25 22:26:16.30254	\N
2149	V	5	207.07	5	2026-09-25 22:26:16.30254	\N
2150	V	5	207.47	5	2026-09-25 22:26:16.30254	\N
2151	V	5	274.55	5	2026-09-25 22:26:16.30254	\N
2152	V	5	342.93	5	2026-09-25 22:26:16.30254	\N
2153	V	5	274.27	5	2026-09-25 22:26:16.30254	\N
2154	V	5	204.60	5	2026-09-25 22:26:16.30254	\N
2155	V	5	204.34	5	2026-09-25 22:26:16.30254	\N
2156	V	5	206.70	5	2026-09-25 22:26:16.30254	\N
2157	V	5	207.40	5	2026-09-25 22:26:16.30254	\N
2158	V	5	276.59	5	2026-09-25 22:26:16.30254	\N
2159	V	5	346.06	5	2026-09-25 22:26:16.30254	\N
2160	V	5	277.18	5	2026-09-25 22:26:16.30254	\N
2161	V	5	207.74	5	2026-09-25 22:26:16.30254	\N
2162	V	5	208.23	5	2026-09-25 22:26:16.30254	\N
2163	V	5	208.42	5	2026-09-25 22:26:16.30254	\N
2164	V	5	207.20	5	2026-09-25 22:26:16.30254	\N
2165	V	5	276.21	5	2026-09-25 22:26:16.30254	\N
2166	V	5	344.35	5	2026-09-25 22:26:16.30254	\N
2167	V	5	274.79	5	2026-09-25 22:26:16.30254	\N
2168	V	5	205.41	5	2026-09-25 22:26:16.30254	\N
2169	V	5	204.53	5	2026-09-25 22:26:16.30254	\N
2170	V	5	203.59	5	2026-09-25 22:26:16.30254	\N
2171	V	5	203.45	5	2026-09-25 22:26:16.30254	\N
2172	V	5	270.84	5	2026-09-25 22:26:16.30254	\N
2173	V	5	338.04	5	2026-09-25 22:26:16.30254	\N
2174	V	5	270.66	5	2026-09-25 22:26:16.30254	\N
2175	V	5	202.60	5	2026-09-25 22:26:16.30254	\N
2176	V	5	201.57	5	2026-09-25 22:26:16.30254	\N
2177	V	5	201.96	5	2026-09-25 22:26:16.30254	\N
2178	V	5	202.53	5	2026-09-25 22:26:16.30254	\N
2179	V	5	269.75	5	2026-09-25 22:26:16.30254	\N
2180	V	5	335.75	5	2026-09-25 22:26:16.30254	\N
2181	V	5	268.78	5	2026-09-25 22:26:16.30254	\N
2182	V	5	201.00	5	2026-09-25 22:26:16.30254	\N
2183	V	5	198.37	5	2026-09-25 22:26:16.30254	\N
2184	V	5	195.39	5	2026-09-25 22:26:16.30254	\N
2185	V	5	194.21	5	2026-09-25 22:26:16.30254	\N
2186	V	5	258.96	5	2026-09-25 22:26:16.30254	\N
2187	V	5	324.56	5	2026-09-25 22:26:16.30254	\N
2188	V	5	259.41	5	2026-09-25 22:26:16.30254	\N
2189	V	5	195.17	5	2026-09-25 22:26:16.30254	\N
2190	V	5	196.21	5	2026-09-25 22:26:16.30254	\N
2191	V	5	198.36	5	2026-09-25 22:26:16.30254	\N
2192	V	5	199.52	5	2026-09-25 22:26:16.30254	\N
2193	V	5	199.52	5	2026-09-25 22:26:16.30254	\N
2194	V	5	266.41	5	2026-09-25 22:26:16.30254	\N
2195	V	5	200.55	5	2026-09-25 22:26:16.30254	\N
2196	V	5	133.65	5	2026-09-25 22:26:16.30254	\N
2197	V	5	132.97	5	2026-09-25 22:26:16.30254	\N
2198	V	5	198.89	5	2026-09-25 22:26:16.30254	\N
2199	V	5	197.92	5	2026-09-25 22:26:16.30254	\N
2200	V	5	263.34	5	2026-09-25 22:26:16.30254	\N
2201	V	5	329.59	5	2026-09-25 22:26:16.30254	\N
2202	V	5	263.51	5	2026-09-25 22:26:16.30254	\N
2203	V	5	197.59	5	2026-09-25 22:26:16.30254	\N
2204	V	5	197.04	5	2026-09-25 22:26:16.30254	\N
2205	V	5	196.92	5	2026-09-25 22:26:16.30254	\N
2206	V	5	195.81	5	2026-09-25 22:26:16.30254	\N
2207	V	5	264.94	5	2026-09-25 22:26:16.30254	\N
2208	V	5	334.51	5	2026-09-25 22:26:16.30254	\N
2209	V	5	269.14	5	2026-09-25 22:26:16.30254	\N
2210	V	5	203.84	5	2026-09-25 22:26:16.30254	\N
2211	V	5	208.07	5	2026-09-25 22:26:16.30254	\N
2212	V	5	207.97	5	2026-09-25 22:26:16.30254	\N
2213	V	5	207.28	5	2026-09-25 22:26:16.30254	\N
2214	V	5	276.48	5	2026-09-25 22:26:16.30254	\N
2215	V	5	346.33	5	2026-09-25 22:26:16.30254	\N
2216	V	5	276.96	5	2026-09-25 22:26:16.30254	\N
2217	V	5	207.93	5	2026-09-25 22:26:16.30254	\N
2218	V	5	209.47	5	2026-09-25 22:26:16.30254	\N
2219	V	5	210.94	5	2026-09-25 22:26:16.30254	\N
2220	V	5	212.12	5	2026-09-25 22:26:16.30254	\N
2221	V	5	212.12	5	2026-09-25 22:26:16.30254	\N
2222	V	5	283.12	5	2026-09-25 22:26:16.30254	\N
2223	V	5	212.70	5	2026-09-25 22:26:16.30254	\N
2224	V	5	142.03	5	2026-09-25 22:26:16.30254	\N
2225	V	5	141.92	5	2026-09-25 22:26:16.30254	\N
2226	V	5	212.65	5	2026-09-25 22:26:16.30254	\N
2227	V	5	211.79	5	2026-09-25 22:26:16.30254	\N
2228	V	5	211.79	5	2026-09-25 22:26:16.30254	\N
2229	V	5	281.08	5	2026-09-25 22:26:16.30254	\N
2230	V	5	210.16	5	2026-09-25 22:26:16.30254	\N
2231	V	5	139.44	5	2026-09-25 22:26:16.30254	\N
2232	V	5	140.06	5	2026-09-25 22:26:16.30254	\N
2233	V	5	211.57	5	2026-09-25 22:26:16.30254	\N
2234	V	5	213.45	5	2026-09-25 22:26:16.30254	\N
2235	V	5	283.89	5	2026-09-25 22:26:16.30254	\N
2236	V	5	353.85	5	2026-09-25 22:26:16.30254	\N
2237	V	5	283.09	5	2026-09-25 22:26:16.30254	\N
2238	V	5	211.58	5	2026-09-25 22:26:16.30254	\N
2239	V	5	209.04	5	2026-09-25 22:26:16.30254	\N
2240	V	5	204.17	5	2026-09-25 22:26:16.30254	\N
2241	V	5	200.05	5	2026-09-25 22:26:16.30254	\N
2242	V	5	265.60	5	2026-09-25 22:26:16.30254	\N
2243	V	5	331.26	5	2026-09-25 22:26:16.30254	\N
2244	V	5	262.62	5	2026-09-25 22:26:16.30254	\N
2245	V	5	197.04	5	2026-09-25 22:26:16.30254	\N
2246	V	5	131.21	5	2026-09-25 22:26:16.30254	\N
2247	V	5	130.82	5	2026-09-25 22:26:16.30254	\N
2248	V	5	130.22	5	2026-09-25 22:26:16.30254	\N
2249	V	5	195.49	5	2026-09-25 22:26:16.30254	\N
2250	V	5	260.73	5	2026-09-25 22:26:16.30254	\N
2251	V	5	260.73	5	2026-09-25 22:26:16.30254	\N
2252	V	5	195.56	5	2026-09-25 22:26:16.30254	\N
2253	V	5	196.21	5	2026-09-25 22:26:16.30254	\N
2254	V	5	195.99	5	2026-09-25 22:26:16.30254	\N
2255	V	5	196.15	5	2026-09-25 22:26:16.30254	\N
2256	V	5	262.51	5	2026-09-25 22:26:16.30254	\N
2257	V	5	326.87	5	2026-09-25 22:26:16.30254	\N
2258	V	5	261.17	5	2026-09-25 22:26:16.30254	\N
2259	V	5	196.12	5	2026-09-25 22:26:16.30254	\N
2260	V	5	197.49	5	2026-09-25 22:26:16.30254	\N
2261	V	5	196.92	5	2026-09-25 22:26:16.30254	\N
2262	V	5	198.54	5	2026-09-25 22:26:16.30254	\N
2263	V	5	264.37	5	2026-09-25 22:26:16.30254	\N
2264	V	5	330.69	5	2026-09-25 22:26:16.30254	\N
2265	V	5	263.92	5	2026-09-25 22:26:16.30254	\N
2266	V	5	198.13	5	2026-09-25 22:26:16.30254	\N
2267	V	5	197.26	5	2026-09-25 22:26:16.30254	\N
2268	V	5	197.07	5	2026-09-25 22:26:16.30254	\N
2269	V	5	196.60	5	2026-09-25 22:26:16.30254	\N
2270	V	5	261.43	5	2026-09-25 22:26:16.30254	\N
2271	V	5	324.25	5	2026-09-25 22:26:16.30254	\N
2272	V	5	259.13	5	2026-09-25 22:26:16.30254	\N
2273	V	5	193.50	5	2026-09-25 22:26:16.30254	\N
2274	V	5	127.65	5	2026-09-25 22:26:16.30254	\N
2275	V	5	126.72	5	2026-09-25 22:26:16.30254	\N
2276	V	5	127.96	5	2026-09-25 22:26:16.30254	\N
2277	V	5	191.75	5	2026-09-25 22:26:16.30254	\N
2278	V	5	255.94	5	2026-09-25 22:26:16.30254	\N
2279	V	5	255.94	5	2026-09-25 22:26:16.30254	\N
2280	V	5	192.04	5	2026-09-25 22:26:16.30254	\N
2281	V	5	189.28	5	2026-09-25 22:26:16.30254	\N
2282	V	5	186.94	5	2026-09-25 22:26:16.30254	\N
2283	V	5	185.35	5	2026-09-25 22:26:16.30254	\N
2284	V	5	248.69	5	2026-09-25 22:26:16.30254	\N
2285	V	5	312.71	5	2026-09-25 22:26:16.30254	\N
2286	V	5	251.41	5	2026-09-25 22:26:16.30254	\N
2287	V	5	189.97	5	2026-09-25 22:26:16.30254	\N
2288	V	5	191.47	5	2026-09-25 22:26:16.30254	\N
2289	V	5	192.30	5	2026-09-25 22:26:16.30254	\N
2290	V	5	192.36	5	2026-09-25 22:26:16.30254	\N
2291	V	5	256.32	5	2026-09-25 22:26:16.30254	\N
2292	V	5	319.79	5	2026-09-25 22:26:16.30254	\N
2293	V	5	255.69	5	2026-09-25 22:26:16.30254	\N
2294	V	5	191.53	5	2026-09-25 22:26:16.30254	\N
2295	V	5	190.63	5	2026-09-25 22:26:16.30254	\N
2296	V	5	189.55	5	2026-09-25 22:26:16.30254	\N
2297	V	5	187.87	5	2026-09-25 22:26:16.30254	\N
2298	V	5	249.17	5	2026-09-25 22:26:16.30254	\N
2299	V	5	310.60	5	2026-09-25 22:26:16.30254	\N
2300	V	5	247.41	5	2026-09-25 22:26:16.30254	\N
2301	V	5	184.52	5	2026-09-25 22:26:16.30254	\N
2302	V	5	184.75	5	2026-09-25 22:26:16.30254	\N
2303	V	5	185.14	5	2026-09-25 22:26:16.30254	\N
2304	V	5	183.52	5	2026-09-25 22:26:16.30254	\N
2305	V	5	243.46	5	2026-09-25 22:26:16.30254	\N
2306	V	5	303.78	5	2026-09-25 22:26:16.30254	\N
2307	V	5	241.76	5	2026-09-25 22:26:16.30254	\N
2308	V	5	180.07	5	2026-09-25 22:26:16.30254	\N
2309	V	5	181.15	5	2026-09-25 22:26:16.30254	\N
2310	V	5	181.96	5	2026-09-25 22:26:16.30254	\N
2311	V	5	182.62	5	2026-09-25 22:26:16.30254	\N
2312	V	5	243.73	5	2026-09-25 22:26:16.30254	\N
2313	V	5	302.83	5	2026-09-25 22:26:16.30254	\N
2314	V	5	241.94	5	2026-09-25 22:26:16.30254	\N
2315	V	5	181.19	5	2026-09-25 22:26:16.30254	\N
2316	V	5	180.12	5	2026-09-25 22:26:16.30254	\N
2317	V	5	179.46	5	2026-09-25 22:26:16.30254	\N
2318	V	5	180.06	5	2026-09-25 22:26:16.30254	\N
2319	V	5	240.22	5	2026-09-25 22:26:16.30254	\N
2320	V	5	240.22	5	2026-09-25 22:26:16.30254	\N
2321	V	5	180.31	5	2026-09-25 22:26:16.30254	\N
2322	V	5	119.86	5	2026-09-25 22:26:16.30254	\N
2323	V	5	120.83	5	2026-09-25 22:26:16.30254	\N
2324	V	5	121.18	5	2026-09-25 22:26:16.30254	\N
2325	V	5	182.97	5	2026-09-25 22:26:16.30254	\N
2326	V	5	244.63	5	2026-09-25 22:26:16.30254	\N
2327	V	5	305.50	5	2026-09-25 22:26:16.30254	\N
2328	V	5	244.83	5	2026-09-25 22:26:16.30254	\N
2329	V	5	184.32	5	2026-09-25 22:26:16.30254	\N
2330	V	5	184.41	5	2026-09-25 22:26:16.30254	\N
2331	V	5	185.02	5	2026-09-25 22:26:16.30254	\N
2332	V	5	187.33	5	2026-09-25 22:26:16.30254	\N
2333	V	5	250.35	5	2026-09-25 22:26:16.30254	\N
2334	V	5	313.76	5	2026-09-25 22:26:16.30254	\N
2335	V	5	251.88	5	2026-09-25 22:26:16.30254	\N
2336	V	5	189.61	5	2026-09-25 22:26:16.30254	\N
2337	V	5	189.21	5	2026-09-25 22:26:16.30254	\N
2338	V	5	188.18	5	2026-09-25 22:26:16.30254	\N
2339	V	5	187.03	5	2026-09-25 22:26:16.30254	\N
2340	V	5	248.81	5	2026-09-25 22:26:16.30254	\N
2341	V	5	310.69	5	2026-09-25 22:26:16.30254	\N
2342	V	5	247.91	5	2026-09-25 22:26:16.30254	\N
2343	V	5	185.92	5	2026-09-25 22:26:16.30254	\N
2344	V	5	185.59	5	2026-09-25 22:26:16.30254	\N
2345	V	5	185.67	5	2026-09-25 22:26:16.30254	\N
2346	V	5	190.76	5	2026-09-25 22:26:16.30254	\N
2347	V	5	256.73	5	2026-09-25 22:26:16.30254	\N
2348	V	5	322.34	5	2026-09-25 22:26:16.30254	\N
2349	V	5	260.41	5	2026-09-25 22:26:16.30254	\N
2350	V	5	198.55	5	2026-09-25 22:26:16.30254	\N
2351	V	5	196.94	5	2026-09-25 22:26:16.30254	\N
2352	V	5	195.38	5	2026-09-25 22:26:16.30254	\N
2353	V	5	193.54	5	2026-09-25 22:26:16.30254	\N
2354	V	5	257.79	5	2026-09-25 22:26:16.30254	\N
2355	V	5	321.55	5	2026-09-25 22:26:16.30254	\N
2356	V	5	256.18	5	2026-09-25 22:26:16.30254	\N
2357	V	5	191.77	5	2026-09-25 22:26:16.30254	\N
2358	V	5	192.79	5	2026-09-25 22:26:16.30254	\N
2359	V	5	193.81	5	2026-09-25 22:26:16.30254	\N
2360	V	5	194.12	5	2026-09-25 22:26:16.30254	\N
2361	V	5	258.62	5	2026-09-25 22:26:16.30254	\N
2362	V	5	323.77	5	2026-09-25 22:26:16.30254	\N
2363	V	5	259.00	5	2026-09-25 22:26:16.30254	\N
2364	V	5	193.72	5	2026-09-25 22:26:16.30254	\N
2365	V	5	196.18	5	2026-09-25 22:26:16.30254	\N
2366	V	5	197.66	5	2026-09-25 22:26:16.30254	\N
2367	V	5	198.66	5	2026-09-25 22:26:16.30254	\N
2368	V	5	264.88	5	2026-09-25 22:26:16.30254	\N
2369	V	5	330.66	5	2026-09-25 22:26:16.30254	\N
2370	V	5	264.13	5	2026-09-25 22:26:16.30254	\N
2371	V	5	198.15	5	2026-09-25 22:26:16.30254	\N
2372	V	5	132.00	5	2026-09-25 22:26:16.30254	\N
2373	V	5	131.07	5	2026-09-25 22:26:16.30254	\N
2374	V	5	130.82	5	2026-09-25 22:26:16.30254	\N
2375	V	5	195.81	5	2026-09-25 22:26:16.30254	\N
2376	V	5	261.08	5	2026-09-25 22:26:16.30254	\N
2377	V	5	261.08	5	2026-09-25 22:26:16.30254	\N
2378	V	5	195.78	5	2026-09-25 22:26:16.30254	\N
2379	V	5	194.82	5	2026-09-25 22:26:16.30254	\N
2380	V	5	193.29	5	2026-09-25 22:26:16.30254	\N
2381	V	5	190.50	5	2026-09-25 22:26:16.30254	\N
2382	V	5	254.53	5	2026-09-25 22:26:16.30254	\N
2383	V	5	319.25	5	2026-09-25 22:26:16.30254	\N
2384	V	5	254.69	5	2026-09-25 22:26:16.30254	\N
2385	V	5	191.23	5	2026-09-25 22:26:16.30254	\N
2386	V	5	192.68	5	2026-09-25 22:26:16.30254	\N
2387	V	5	193.66	5	2026-09-25 22:26:16.30254	\N
2388	V	5	193.54	5	2026-09-25 22:26:16.30254	\N
2389	V	5	257.35	5	2026-09-25 22:26:16.30254	\N
2390	V	5	321.82	5	2026-09-25 22:26:16.30254	\N
2391	V	5	257.89	5	2026-09-25 22:26:16.30254	\N
2392	V	5	192.88	5	2026-09-25 22:26:16.30254	\N
2393	V	5	193.05	5	2026-09-25 22:26:16.30254	\N
2394	V	5	195.87	5	2026-09-25 22:26:16.30254	\N
2395	V	5	197.46	5	2026-09-25 22:26:16.30254	\N
2396	V	5	262.91	5	2026-09-25 22:26:16.30254	\N
2397	V	5	262.91	5	2026-09-25 22:26:16.30254	\N
2398	V	5	198.15	5	2026-09-25 22:26:16.30254	\N
2399	V	5	131.52	5	2026-09-25 22:26:16.30254	\N
2400	V	5	130.77	5	2026-09-25 22:26:16.30254	\N
2401	V	5	131.02	5	2026-09-25 22:26:16.30254	\N
2402	V	5	197.46	5	2026-09-25 22:26:16.30254	\N
2403	V	5	263.57	5	2026-09-25 22:26:16.30254	\N
2404	V	5	330.81	5	2026-09-25 22:26:16.30254	\N
2405	V	5	265.49	5	2026-09-25 22:26:16.30254	\N
2406	V	5	199.80	5	2026-09-25 22:26:16.30254	\N
2407	V	5	201.68	5	2026-09-25 22:26:16.30254	\N
2408	V	5	204.19	5	2026-09-25 22:26:16.30254	\N
2409	V	5	207.16	5	2026-09-25 22:26:16.30254	\N
2410	V	5	279.59	5	2026-09-25 22:26:16.30254	\N
2411	V	5	279.59	5	2026-09-25 22:26:16.30254	\N
2412	V	5	211.26	5	2026-09-25 22:26:16.30254	\N
2413	V	5	142.64	5	2026-09-25 22:26:16.30254	\N
2414	V	5	143.88	5	2026-09-25 22:26:16.30254	\N
2415	V	5	141.89	5	2026-09-25 22:26:16.30254	\N
2416	V	5	211.40	5	2026-09-25 22:26:16.30254	\N
2417	V	5	281.04	5	2026-09-25 22:26:16.30254	\N
2418	V	5	350.83	5	2026-09-25 22:26:16.30254	\N
2419	V	5	279.38	5	2026-09-25 22:26:16.30254	\N
2420	V	5	208.94	5	2026-09-25 22:26:16.30254	\N
2421	V	5	210.98	5	2026-09-25 22:26:16.30254	\N
2422	V	5	212.55	5	2026-09-25 22:26:16.30254	\N
2423	V	5	213.78	5	2026-09-25 22:26:16.30254	\N
2424	V	5	286.81	5	2026-09-25 22:26:16.30254	\N
2425	V	5	358.52	5	2026-09-25 22:26:16.30254	\N
2426	V	5	286.97	5	2026-09-25 22:26:16.30254	\N
2427	V	5	215.77	5	2026-09-25 22:26:16.30254	\N
2428	V	5	216.85	5	2026-09-25 22:26:16.30254	\N
2429	V	5	214.99	5	2026-09-25 22:26:16.30254	\N
2430	V	5	213.96	5	2026-09-25 22:26:16.30254	\N
2431	V	5	284.28	5	2026-09-25 22:26:16.30254	\N
2432	V	5	355.43	5	2026-09-25 22:26:16.30254	\N
2433	V	5	283.32	5	2026-09-25 22:26:16.30254	\N
2434	V	5	212.15	5	2026-09-25 22:26:16.30254	\N
2435	V	5	213.97	5	2026-09-25 22:26:16.30254	\N
2436	V	5	216.97	5	2026-09-25 22:26:16.30254	\N
2437	V	5	219.57	5	2026-09-25 22:26:16.30254	\N
2438	V	5	292.82	5	2026-09-25 22:26:16.30254	\N
2439	V	5	366.05	5	2026-09-25 22:26:16.30254	\N
2440	V	5	293.54	5	2026-09-25 22:26:16.30254	\N
2441	V	5	220.23	5	2026-09-25 22:26:16.30254	\N
2442	V	5	219.61	5	2026-09-25 22:26:16.30254	\N
2443	V	5	220.28	5	2026-09-25 22:26:16.30254	\N
2444	V	5	220.76	5	2026-09-25 22:26:16.30254	\N
2445	V	5	294.85	5	2026-09-25 22:26:16.30254	\N
2446	V	5	367.35	5	2026-09-25 22:26:16.30254	\N
2447	V	5	294.22	5	2026-09-25 22:26:16.30254	\N
2448	V	5	220.30	5	2026-09-25 22:26:16.30254	\N
2449	V	5	218.86	5	2026-09-25 22:26:16.30254	\N
2450	V	5	217.33	5	2026-09-25 22:26:16.30254	\N
2451	V	5	216.71	5	2026-09-25 22:26:16.30254	\N
2452	V	5	289.80	5	2026-09-25 22:26:16.30254	\N
2453	V	5	362.63	5	2026-09-25 22:26:16.30254	\N
2454	V	5	290.37	5	2026-09-25 22:26:16.30254	\N
2455	V	5	217.80	5	2026-09-25 22:26:16.30254	\N
2456	V	5	217.69	5	2026-09-25 22:26:16.30254	\N
2457	V	5	217.45	5	2026-09-25 22:26:16.30254	\N
2458	V	5	217.73	5	2026-09-25 22:26:16.30254	\N
2459	V	5	290.87	5	2026-09-25 22:26:16.30254	\N
2460	V	5	365.08	5	2026-09-25 22:26:16.30254	\N
2461	V	5	293.31	5	2026-09-25 22:26:16.30254	\N
2462	V	5	220.46	5	2026-09-25 22:26:16.30254	\N
2463	V	5	223.84	5	2026-09-25 22:26:16.30254	\N
2464	V	5	227.52	5	2026-09-25 22:26:16.30254	\N
2465	V	5	230.09	5	2026-09-25 22:26:16.30254	\N
2466	V	5	306.02	5	2026-09-25 22:26:16.30254	\N
2467	V	5	382.34	5	2026-09-25 22:26:16.30254	\N
2468	V	5	305.86	5	2026-09-25 22:26:16.30254	\N
2469	V	5	229.03	5	2026-09-25 22:26:16.30254	\N
2470	V	5	228.13	5	2026-09-25 22:26:16.30254	\N
2471	V	5	226.73	5	2026-09-25 22:26:16.30254	\N
2472	V	5	226.09	5	2026-09-25 22:26:16.30254	\N
2473	V	5	301.84	5	2026-09-25 22:26:16.30254	\N
2474	V	5	376.85	5	2026-09-25 22:26:16.30254	\N
2475	V	5	300.98	5	2026-09-25 22:26:16.30254	\N
2476	V	5	226.44	5	2026-09-25 22:26:16.30254	\N
2477	V	5	150.76	5	2026-09-25 22:26:16.30254	\N
2478	V	5	148.74	5	2026-09-25 22:26:16.30254	\N
2479	V	5	147.21	5	2026-09-25 22:26:16.30254	\N
2480	V	5	220.65	5	2026-09-25 22:26:16.30254	\N
2481	V	5	294.74	5	2026-09-25 22:26:16.30254	\N
2482	V	5	294.74	5	2026-09-25 22:26:16.30254	\N
2483	V	5	221.01	5	2026-09-25 22:26:16.30254	\N
2484	V	5	222.59	5	2026-09-25 22:26:16.30254	\N
2485	V	5	224.27	5	2026-09-25 22:26:16.30254	\N
2486	V	5	224.37	5	2026-09-25 22:26:16.30254	\N
2487	V	5	298.35	5	2026-09-25 22:26:16.30254	\N
2488	V	5	372.01	5	2026-09-25 22:26:16.30254	\N
2489	V	5	296.95	5	2026-09-25 22:26:16.30254	\N
2490	V	5	221.83	5	2026-09-25 22:26:16.30254	\N
2491	V	5	221.63	5	2026-09-25 22:26:16.30254	\N
2492	V	5	220.06	5	2026-09-25 22:26:16.30254	\N
2493	V	5	146.40	5	2026-09-25 22:26:16.30254	\N
2494	V	20	240.93	20	2026-09-25 22:26:16.340194	\N
2495	V	20	241.16	20	2026-09-25 22:26:16.340194	\N
2496	V	20	241.64	20	2026-09-25 22:26:16.340194	\N
2497	V	20	242.18	20	2026-09-25 22:26:16.340194	\N
2498	V	20	242.08	20	2026-09-25 22:26:16.340194	\N
2499	V	20	259.18	20	2026-09-25 22:26:16.340194	\N
2500	V	20	259.18	20	2026-09-25 22:26:16.340194	\N
2501	V	20	242.17	20	2026-09-25 22:26:16.340194	\N
2502	V	20	242.32	20	2026-09-25 22:26:16.340194	\N
2503	V	20	242.29	20	2026-09-25 22:26:16.340194	\N
2504	V	20	242.26	20	2026-09-25 22:26:16.340194	\N
2505	V	20	242.07	20	2026-09-25 22:26:16.340194	\N
2506	V	20	259.44	20	2026-09-25 22:26:16.340194	\N
2507	V	20	259.44	20	2026-09-25 22:26:16.340194	\N
2508	V	20	241.97	20	2026-09-25 22:26:16.340194	\N
2509	V	20	241.74	20	2026-09-25 22:26:16.340194	\N
2510	V	20	241.52	20	2026-09-25 22:26:16.340194	\N
2511	V	20	241.23	20	2026-09-25 22:26:16.340194	\N
2512	V	20	241.30	20	2026-09-25 22:26:16.340194	\N
2513	V	20	258.34	20	2026-09-25 22:26:16.340194	\N
2514	V	20	258.34	20	2026-09-25 22:26:16.340194	\N
2515	V	20	241.17	20	2026-09-25 22:26:16.340194	\N
2516	V	20	240.60	20	2026-09-25 22:26:16.340194	\N
2517	V	20	240.33	20	2026-09-25 22:26:16.340194	\N
2518	V	20	240.56	20	2026-09-25 22:26:16.340194	\N
2519	V	20	240.31	20	2026-09-25 22:26:16.340194	\N
2520	V	20	257.12	20	2026-09-25 22:26:16.340194	\N
2521	V	20	257.12	20	2026-09-25 22:26:16.340194	\N
2522	V	20	239.89	20	2026-09-25 22:26:16.340194	\N
2523	V	20	239.28	20	2026-09-25 22:26:16.340194	\N
2524	V	20	238.96	20	2026-09-25 22:26:16.340194	\N
2525	V	20	238.60	20	2026-09-25 22:26:16.340194	\N
2526	V	20	238.04	20	2026-09-25 22:26:16.340194	\N
2527	V	20	254.54	20	2026-09-25 22:26:16.340194	\N
2528	V	20	254.54	20	2026-09-25 22:26:16.340194	\N
2529	V	20	237.15	20	2026-09-25 22:26:16.340194	\N
2530	V	20	236.09	20	2026-09-25 22:26:16.340194	\N
2531	V	20	235.08	20	2026-09-25 22:26:16.340194	\N
2532	V	20	234.04	20	2026-09-25 22:26:16.340194	\N
2533	V	20	233.19	20	2026-09-25 22:26:16.340194	\N
2534	V	20	249.59	20	2026-09-25 22:26:16.340194	\N
2535	V	20	249.59	20	2026-09-25 22:26:16.340194	\N
2536	V	20	232.74	20	2026-09-25 22:26:16.340194	\N
2537	V	20	232.19	20	2026-09-25 22:26:16.340194	\N
2538	V	20	231.92	20	2026-09-25 22:26:16.340194	\N
2539	V	20	231.76	20	2026-09-25 22:26:16.340194	\N
2540	V	20	214.96	20	2026-09-25 22:26:16.340194	\N
2541	V	20	231.68	20	2026-09-25 22:26:16.340194	\N
2542	V	20	231.68	20	2026-09-25 22:26:16.340194	\N
2543	V	20	214.94	20	2026-09-25 22:26:16.340194	\N
2544	V	20	214.51	20	2026-09-25 22:26:16.340194	\N
2545	V	20	214.05	20	2026-09-25 22:26:16.340194	\N
2546	V	20	213.72	20	2026-09-25 22:26:16.340194	\N
2547	V	20	213.58	20	2026-09-25 22:26:16.340194	\N
2548	V	20	230.14	20	2026-09-25 22:26:16.340194	\N
2549	V	20	230.14	20	2026-09-25 22:26:16.340194	\N
2550	V	20	213.85	20	2026-09-25 22:26:16.340194	\N
2551	V	20	214.14	20	2026-09-25 22:26:16.340194	\N
2552	V	20	214.26	20	2026-09-25 22:26:16.340194	\N
2553	V	20	214.35	20	2026-09-25 22:26:16.340194	\N
2554	V	20	215.24	20	2026-09-25 22:26:16.340194	\N
2555	V	20	232.63	20	2026-09-25 22:26:16.340194	\N
2556	V	20	232.63	20	2026-09-25 22:26:16.340194	\N
2557	V	20	216.16	20	2026-09-25 22:26:16.340194	\N
2558	V	20	216.78	20	2026-09-25 22:26:16.340194	\N
2559	V	20	217.35	20	2026-09-25 22:26:16.340194	\N
2560	V	20	234.57	20	2026-09-25 22:26:16.340194	\N
2561	V	20	235.15	20	2026-09-25 22:26:16.340194	\N
2562	V	20	252.61	20	2026-09-25 22:26:16.340194	\N
2563	V	20	252.61	20	2026-09-25 22:26:16.340194	\N
2564	V	20	236.09	20	2026-09-25 22:26:16.340194	\N
2565	V	20	237.21	20	2026-09-25 22:26:16.340194	\N
2566	V	20	238.40	20	2026-09-25 22:26:16.340194	\N
2567	V	20	239.80	20	2026-09-25 22:26:16.340194	\N
2568	V	20	223.24	20	2026-09-25 22:26:16.340194	\N
2569	V	20	240.99	20	2026-09-25 22:26:16.340194	\N
2570	V	20	240.99	20	2026-09-25 22:26:16.340194	\N
2571	V	20	224.65	20	2026-09-25 22:26:16.340194	\N
2572	V	20	226.05	20	2026-09-25 22:26:16.340194	\N
2573	V	20	227.45	20	2026-09-25 22:26:16.340194	\N
2574	V	20	227.70	20	2026-09-25 22:26:16.340194	\N
2575	V	20	210.31	20	2026-09-25 22:26:16.340194	\N
2576	V	20	227.64	20	2026-09-25 22:26:16.340194	\N
2577	V	20	227.64	20	2026-09-25 22:26:16.340194	\N
2578	V	20	210.29	20	2026-09-25 22:26:16.340194	\N
2579	V	20	210.72	20	2026-09-25 22:26:16.340194	\N
2580	V	20	211.38	20	2026-09-25 22:26:16.340194	\N
2581	V	20	211.88	20	2026-09-25 22:26:16.340194	\N
2582	V	20	212.03	20	2026-09-25 22:26:16.340194	\N
2583	V	20	229.51	20	2026-09-25 22:26:16.340194	\N
2584	V	20	229.51	20	2026-09-25 22:26:16.340194	\N
2585	V	20	211.91	20	2026-09-25 22:26:16.340194	\N
2586	V	20	211.40	20	2026-09-25 22:26:16.340194	\N
2587	V	20	210.04	20	2026-09-25 22:26:16.340194	\N
2588	V	20	226.50	20	2026-09-25 22:26:16.340194	\N
2589	V	20	225.13	20	2026-09-25 22:26:16.340194	\N
2590	V	20	241.55	20	2026-09-25 22:26:16.340194	\N
2591	V	20	241.55	20	2026-09-25 22:26:16.340194	\N
2592	V	20	223.82	20	2026-09-25 22:26:16.340194	\N
2593	V	20	206.14	20	2026-09-25 22:26:16.340194	\N
2594	V	20	204.89	20	2026-09-25 22:26:16.340194	\N
2595	V	20	221.16	20	2026-09-25 22:26:16.340194	\N
2596	V	20	220.15	20	2026-09-25 22:26:16.340194	\N
2597	V	20	236.46	20	2026-09-25 22:26:16.340194	\N
2598	V	20	236.46	20	2026-09-25 22:26:16.340194	\N
2599	V	20	218.77	20	2026-09-25 22:26:16.340194	\N
2600	V	20	217.32	20	2026-09-25 22:26:16.340194	\N
2601	V	20	215.78	20	2026-09-25 22:26:16.340194	\N
2602	V	20	214.52	20	2026-09-25 22:26:16.340194	\N
2603	V	20	213.62	20	2026-09-25 22:26:16.340194	\N
2604	V	20	229.71	20	2026-09-25 22:26:16.340194	\N
2605	V	20	229.71	20	2026-09-25 22:26:16.340194	\N
2606	V	20	212.56	20	2026-09-25 22:26:16.340194	\N
2607	V	20	212.85	20	2026-09-25 22:26:16.340194	\N
2608	V	20	212.84	20	2026-09-25 22:26:16.340194	\N
2609	V	20	212.95	20	2026-09-25 22:26:16.340194	\N
2610	V	20	212.99	20	2026-09-25 22:26:16.340194	\N
2611	V	20	229.57	20	2026-09-25 22:26:16.340194	\N
2612	V	20	229.57	20	2026-09-25 22:26:16.340194	\N
2613	V	20	229.57	20	2026-09-25 22:26:16.340194	\N
2614	V	20	229.56	20	2026-09-25 22:26:16.340194	\N
2615	V	20	229.70	20	2026-09-25 22:26:16.340194	\N
2616	V	20	229.85	20	2026-09-25 22:26:16.340194	\N
2617	V	20	229.75	20	2026-09-25 22:26:16.340194	\N
2618	V	20	245.45	20	2026-09-25 22:26:16.340194	\N
2619	V	20	245.45	20	2026-09-25 22:26:16.340194	\N
2620	V	20	229.03	20	2026-09-25 22:26:16.340194	\N
2621	V	20	212.76	20	2026-09-25 22:26:16.340194	\N
2622	V	20	212.39	20	2026-09-25 22:26:16.340194	\N
2623	V	20	211.82	20	2026-09-25 22:26:16.340194	\N
2624	V	20	211.67	20	2026-09-25 22:26:16.340194	\N
2625	V	20	227.72	20	2026-09-25 22:26:16.340194	\N
2626	V	20	227.72	20	2026-09-25 22:26:16.340194	\N
2627	V	20	211.03	20	2026-09-25 22:26:16.340194	\N
2628	V	20	209.91	20	2026-09-25 22:26:16.340194	\N
2629	V	20	208.77	20	2026-09-25 22:26:16.340194	\N
2630	V	20	207.96	20	2026-09-25 22:26:16.340194	\N
2631	V	20	207.22	20	2026-09-25 22:26:16.340194	\N
2632	V	20	223.22	20	2026-09-25 22:26:16.340194	\N
2633	V	20	223.22	20	2026-09-25 22:26:16.340194	\N
2634	V	20	206.95	20	2026-09-25 22:26:16.340194	\N
2635	V	20	206.56	20	2026-09-25 22:26:16.340194	\N
2636	V	20	206.14	20	2026-09-25 22:26:16.340194	\N
2637	V	20	205.96	20	2026-09-25 22:26:16.340194	\N
2638	V	20	206.24	20	2026-09-25 22:26:16.340194	\N
2639	V	20	222.11	20	2026-09-25 22:26:16.340194	\N
2640	V	20	222.11	20	2026-09-25 22:26:16.340194	\N
2641	V	20	222.11	20	2026-09-25 22:26:16.340194	\N
2642	V	20	221.93	20	2026-09-25 22:26:16.340194	\N
2643	V	20	221.64	20	2026-09-25 22:26:16.340194	\N
2644	V	20	221.14	20	2026-09-25 22:26:16.340194	\N
2645	V	20	220.42	20	2026-09-25 22:26:16.340194	\N
2646	V	20	235.78	20	2026-09-25 22:26:16.340194	\N
2647	V	20	235.78	20	2026-09-25 22:26:16.340194	\N
2648	V	20	220.45	20	2026-09-25 22:26:16.340194	\N
2649	V	20	220.60	20	2026-09-25 22:26:16.340194	\N
2650	V	20	220.37	20	2026-09-25 22:26:16.340194	\N
2651	V	20	219.48	20	2026-09-25 22:26:16.340194	\N
2652	V	20	218.46	20	2026-09-25 22:26:16.340194	\N
2653	V	20	233.54	20	2026-09-25 22:26:16.340194	\N
2654	V	20	233.54	20	2026-09-25 22:26:16.340194	\N
2655	V	20	217.52	20	2026-09-25 22:26:16.340194	\N
2656	V	20	216.70	20	2026-09-25 22:26:16.340194	\N
2657	V	20	215.86	20	2026-09-25 22:26:16.340194	\N
2658	V	20	215.12	20	2026-09-25 22:26:16.340194	\N
2659	V	20	214.53	20	2026-09-25 22:26:16.340194	\N
2660	V	20	229.30	20	2026-09-25 22:26:16.340194	\N
2661	V	20	229.30	20	2026-09-25 22:26:16.340194	\N
2662	V	20	213.51	20	2026-09-25 22:26:16.340194	\N
2663	V	20	212.76	20	2026-09-25 22:26:16.340194	\N
2664	V	20	212.43	20	2026-09-25 22:26:16.340194	\N
2665	V	20	212.03	20	2026-09-25 22:26:16.340194	\N
2666	V	20	211.71	20	2026-09-25 22:26:16.340194	\N
2667	V	20	211.71	20	2026-09-25 22:26:16.340194	\N
2668	V	20	211.71	20	2026-09-25 22:26:16.340194	\N
2669	V	20	196.20	20	2026-09-25 22:26:16.340194	\N
2670	V	20	195.95	20	2026-09-25 22:26:16.340194	\N
2671	V	20	196.12	20	2026-09-25 22:26:16.340194	\N
2672	V	20	196.59	20	2026-09-25 22:26:16.340194	\N
2673	V	20	196.92	20	2026-09-25 22:26:16.340194	\N
2674	V	20	212.14	20	2026-09-25 22:26:16.340194	\N
2675	V	20	212.14	20	2026-09-25 22:26:16.340194	\N
2676	V	20	196.92	20	2026-09-25 22:26:16.340194	\N
2677	V	20	197.20	20	2026-09-25 22:26:16.340194	\N
2678	V	20	197.52	20	2026-09-25 22:26:16.340194	\N
2679	V	20	198.04	20	2026-09-25 22:26:16.340194	\N
2680	V	20	199.02	20	2026-09-25 22:26:16.340194	\N
2681	V	20	214.87	20	2026-09-25 22:26:16.340194	\N
2682	V	20	214.87	20	2026-09-25 22:26:16.340194	\N
2683	V	20	199.89	20	2026-09-25 22:26:16.340194	\N
2684	V	20	200.48	20	2026-09-25 22:26:16.340194	\N
2685	V	20	201.05	20	2026-09-25 22:26:16.340194	\N
2686	V	20	201.57	20	2026-09-25 22:26:16.340194	\N
2687	V	20	217.02	20	2026-09-25 22:26:16.340194	\N
2688	V	20	232.49	20	2026-09-25 22:26:16.340194	\N
2689	V	20	232.49	20	2026-09-25 22:26:16.340194	\N
2690	V	20	217.32	20	2026-09-25 22:26:16.340194	\N
2691	V	20	217.68	20	2026-09-25 22:26:16.340194	\N
2692	V	20	217.69	20	2026-09-25 22:26:16.340194	\N
2693	V	20	219.02	20	2026-09-25 22:26:16.340194	\N
2694	V	20	220.30	20	2026-09-25 22:26:16.340194	\N
2695	V	20	236.70	20	2026-09-25 22:26:16.340194	\N
2696	V	20	236.70	20	2026-09-25 22:26:16.340194	\N
2697	V	20	221.23	20	2026-09-25 22:26:16.340194	\N
2698	V	20	222.00	20	2026-09-25 22:26:16.340194	\N
2699	V	20	222.31	20	2026-09-25 22:26:16.340194	\N
2700	V	20	222.49	20	2026-09-25 22:26:16.340194	\N
2701	V	20	222.71	20	2026-09-25 22:26:16.340194	\N
2702	V	20	238.65	20	2026-09-25 22:26:16.340194	\N
2703	V	20	238.65	20	2026-09-25 22:26:16.340194	\N
2704	V	20	222.95	20	2026-09-25 22:26:16.340194	\N
2705	V	20	223.64	20	2026-09-25 22:26:16.340194	\N
2706	V	20	224.40	20	2026-09-25 22:26:16.340194	\N
2707	V	20	224.97	20	2026-09-25 22:26:16.340194	\N
2708	V	20	225.63	20	2026-09-25 22:26:16.340194	\N
2709	V	20	241.91	20	2026-09-25 22:26:16.340194	\N
2710	V	20	241.91	20	2026-09-25 22:26:16.340194	\N
2711	V	20	226.43	20	2026-09-25 22:26:16.340194	\N
2712	V	20	227.60	20	2026-09-25 22:26:16.340194	\N
2713	V	20	227.35	20	2026-09-25 22:26:16.340194	\N
2714	V	20	227.40	20	2026-09-25 22:26:16.340194	\N
2715	V	20	227.55	20	2026-09-25 22:26:16.340194	\N
2716	V	20	244.00	20	2026-09-25 22:26:16.340194	\N
2717	V	20	244.00	20	2026-09-25 22:26:16.340194	\N
2718	V	20	227.65	20	2026-09-25 22:26:16.340194	\N
2719	V	20	211.55	20	2026-09-25 22:26:16.340194	\N
2720	V	20	211.94	20	2026-09-25 22:26:16.340194	\N
2721	V	20	212.25	20	2026-09-25 22:26:16.340194	\N
2722	V	20	212.56	20	2026-09-25 22:26:16.340194	\N
2723	V	20	228.88	20	2026-09-25 22:26:16.340194	\N
2724	V	20	228.88	20	2026-09-25 22:26:16.340194	\N
2725	V	20	212.69	20	2026-09-25 22:26:16.340194	\N
2726	V	20	212.50	20	2026-09-25 22:26:16.340194	\N
2727	V	20	212.35	20	2026-09-25 22:26:16.340194	\N
2728	V	20	211.85	20	2026-09-25 22:26:16.340194	\N
2729	V	20	211.57	20	2026-09-25 22:26:16.340194	\N
2730	V	20	227.75	20	2026-09-25 22:26:16.340194	\N
2731	V	20	227.75	20	2026-09-25 22:26:16.340194	\N
2732	V	20	211.12	20	2026-09-25 22:26:16.340194	\N
2733	V	20	210.60	20	2026-09-25 22:26:16.340194	\N
2734	V	20	210.32	20	2026-09-25 22:26:16.340194	\N
2735	V	20	209.91	20	2026-09-25 22:26:16.340194	\N
2736	V	20	209.42	20	2026-09-25 22:26:16.340194	\N
2737	V	20	225.54	20	2026-09-25 22:26:16.340194	\N
2738	V	20	225.54	20	2026-09-25 22:26:16.340194	\N
2739	V	20	225.54	20	2026-09-25 22:26:16.340194	\N
2740	V	20	225.41	20	2026-09-25 22:26:16.340194	\N
2741	V	20	225.68	20	2026-09-25 22:26:16.340194	\N
2742	V	20	225.95	20	2026-09-25 22:26:16.340194	\N
2743	V	20	226.00	20	2026-09-25 22:26:16.340194	\N
2744	V	20	226.00	20	2026-09-25 22:26:16.340194	\N
2745	V	20	226.00	20	2026-09-25 22:26:16.340194	\N
2746	V	20	209.86	20	2026-09-25 22:26:16.340194	\N
2747	V	20	210.32	20	2026-09-25 22:26:16.340194	\N
2748	V	20	211.13	20	2026-09-25 22:26:16.340194	\N
2749	V	20	211.73	20	2026-09-25 22:26:16.340194	\N
2750	V	20	212.08	20	2026-09-25 22:26:16.340194	\N
2751	V	20	228.89	20	2026-09-25 22:26:16.340194	\N
2752	V	20	228.89	20	2026-09-25 22:26:16.340194	\N
2753	V	20	212.90	20	2026-09-25 22:26:16.340194	\N
2754	V	20	213.73	20	2026-09-25 22:26:16.340194	\N
2755	V	20	214.74	20	2026-09-25 22:26:16.340194	\N
2756	V	20	216.34	20	2026-09-25 22:26:16.340194	\N
2757	V	20	218.33	20	2026-09-25 22:26:16.340194	\N
2758	V	20	218.33	20	2026-09-25 22:26:16.340194	\N
2759	V	20	218.33	20	2026-09-25 22:26:16.340194	\N
2760	V	20	202.14	20	2026-09-25 22:26:16.340194	\N
2761	V	20	203.34	20	2026-09-25 22:26:16.340194	\N
2762	V	20	204.44	20	2026-09-25 22:26:16.340194	\N
2763	V	20	205.45	20	2026-09-25 22:26:16.340194	\N
2764	V	20	222.86	20	2026-09-25 22:26:16.340194	\N
2765	V	20	240.31	20	2026-09-25 22:26:16.340194	\N
2766	V	20	240.31	20	2026-09-25 22:26:16.340194	\N
2767	V	20	223.98	20	2026-09-25 22:26:16.340194	\N
2768	V	20	225.44	20	2026-09-25 22:26:16.340194	\N
2769	V	20	226.63	20	2026-09-25 22:26:16.340194	\N
2770	V	20	227.86	20	2026-09-25 22:26:16.340194	\N
2771	V	20	229.31	20	2026-09-25 22:26:16.340194	\N
2772	V	20	247.24	20	2026-09-25 22:26:16.340194	\N
2773	V	20	247.24	20	2026-09-25 22:26:16.340194	\N
2774	V	20	230.15	20	2026-09-25 22:26:16.340194	\N
2775	V	20	231.03	20	2026-09-25 22:26:16.340194	\N
2776	V	20	231.26	20	2026-09-25 22:26:16.340194	\N
2777	V	20	230.83	20	2026-09-25 22:26:16.340194	\N
2778	V	20	248.41	20	2026-09-25 22:26:16.340194	\N
2779	V	20	266.20	20	2026-09-25 22:26:16.340194	\N
2780	V	20	266.20	20	2026-09-25 22:26:16.340194	\N
2781	V	20	248.33	20	2026-09-25 22:26:16.340194	\N
2782	V	20	248.85	20	2026-09-25 22:26:16.340194	\N
2783	V	20	249.80	20	2026-09-25 22:26:16.340194	\N
2784	V	20	250.83	20	2026-09-25 22:26:16.340194	\N
2785	V	20	251.69	20	2026-09-25 22:26:16.340194	\N
2786	V	20	270.00	20	2026-09-25 22:26:16.340194	\N
2787	V	20	270.00	20	2026-09-25 22:26:16.340194	\N
2788	V	20	252.11	20	2026-09-25 22:26:16.340194	\N
2789	V	20	252.60	20	2026-09-25 22:26:16.340194	\N
2790	V	20	253.32	20	2026-09-25 22:26:16.340194	\N
2791	V	20	253.49	20	2026-09-25 22:26:16.340194	\N
2792	V	20	254.08	20	2026-09-25 22:26:16.340194	\N
2793	V	20	272.21	20	2026-09-25 22:26:16.340194	\N
2794	V	20	272.21	20	2026-09-25 22:26:16.340194	\N
2795	V	20	254.18	20	2026-09-25 22:26:16.340194	\N
2796	V	20	254.45	20	2026-09-25 22:26:16.340194	\N
2797	V	20	254.93	20	2026-09-25 22:26:16.340194	\N
2798	V	20	255.32	20	2026-09-25 22:26:16.340194	\N
2799	V	20	255.80	20	2026-09-25 22:26:16.340194	\N
2800	V	20	274.01	20	2026-09-25 22:26:16.340194	\N
2801	V	20	274.01	20	2026-09-25 22:26:16.340194	\N
2802	V	20	255.88	20	2026-09-25 22:26:16.340194	\N
2803	V	20	255.50	20	2026-09-25 22:26:16.340194	\N
2804	V	20	255.27	20	2026-09-25 22:26:16.340194	\N
2805	V	20	255.23	20	2026-09-25 22:26:16.340194	\N
2806	V	20	255.21	20	2026-09-25 22:26:16.340194	\N
2807	V	20	273.77	20	2026-09-25 22:26:16.340194	\N
2808	V	20	273.77	20	2026-09-25 22:26:16.340194	\N
2809	V	20	255.48	20	2026-09-25 22:26:16.340194	\N
2810	V	20	256.12	20	2026-09-25 22:26:16.340194	\N
2811	V	20	256.90	20	2026-09-25 22:26:16.340194	\N
2812	V	20	257.58	20	2026-09-25 22:26:16.340194	\N
2813	V	20	258.43	20	2026-09-25 22:26:16.340194	\N
2814	V	20	277.51	20	2026-09-25 22:26:16.340194	\N
2815	V	20	277.51	20	2026-09-25 22:26:16.340194	\N
2816	V	20	259.45	20	2026-09-25 22:26:16.340194	\N
2817	V	20	260.27	20	2026-09-25 22:26:16.340194	\N
2818	V	20	260.94	20	2026-09-25 22:26:16.340194	\N
2819	V	20	261.58	20	2026-09-25 22:26:16.340194	\N
2820	V	20	262.31	20	2026-09-25 22:26:16.340194	\N
2821	V	20	281.07	20	2026-09-25 22:26:16.340194	\N
2822	V	20	281.07	20	2026-09-25 22:26:16.340194	\N
2823	V	20	263.13	20	2026-09-25 22:26:16.340194	\N
2824	V	20	244.91	20	2026-09-25 22:26:16.340194	\N
2825	V	20	245.07	20	2026-09-25 22:26:16.340194	\N
2826	V	20	245.15	20	2026-09-25 22:26:16.340194	\N
2827	V	20	244.96	20	2026-09-25 22:26:16.340194	\N
2828	V	20	263.48	20	2026-09-25 22:26:16.340194	\N
2829	V	20	263.48	20	2026-09-25 22:26:16.340194	\N
2830	V	20	244.36	20	2026-09-25 22:26:16.340194	\N
2831	V	20	243.92	20	2026-09-25 22:26:16.340194	\N
2832	V	20	243.51	20	2026-09-25 22:26:16.340194	\N
2833	V	20	243.07	20	2026-09-25 22:26:16.340194	\N
2834	V	20	242.49	20	2026-09-25 22:26:16.340194	\N
2835	V	20	260.90	20	2026-09-25 22:26:16.340194	\N
2836	V	20	260.90	20	2026-09-25 22:26:16.340194	\N
2837	V	20	241.93	20	2026-09-25 22:26:16.340194	\N
2838	V	20	241.80	20	2026-09-25 22:26:16.340194	\N
2839	V	20	240.98	20	2026-09-25 22:26:16.340194	\N
2840	V	20	222.04	20	2026-09-25 22:26:16.340194	\N
2841	V	5	269.94	5	2026-09-25 23:25:02.58654	\N
2842	V	5	202.20	5	2026-09-25 23:25:02.58654	\N
2843	V	5	202.49	5	2026-09-25 23:25:02.58654	\N
2844	V	5	203.78	5	2026-09-25 23:25:02.58654	\N
2845	V	5	205.87	5	2026-09-25 23:25:02.58654	\N
2846	V	5	275.06	5	2026-09-25 23:25:02.58654	\N
2847	V	5	345.03	5	2026-09-25 23:25:02.58654	\N
2848	V	5	277.00	5	2026-09-25 23:25:02.58654	\N
2849	V	5	208.72	5	2026-09-25 23:25:02.58654	\N
2850	V	5	209.01	5	2026-09-25 23:25:02.58654	\N
2851	V	5	210.31	5	2026-09-25 23:25:02.58654	\N
2852	V	5	210.61	5	2026-09-25 23:25:02.58654	\N
2853	V	5	280.02	5	2026-09-25 23:25:02.58654	\N
2854	V	5	348.75	5	2026-09-25 23:25:02.58654	\N
2855	V	5	278.89	5	2026-09-25 23:25:02.58654	\N
2856	V	5	208.41	5	2026-09-25 23:25:02.58654	\N
2857	V	5	206.80	5	2026-09-25 23:25:02.58654	\N
2858	V	5	207.07	5	2026-09-25 23:25:02.58654	\N
2859	V	5	207.47	5	2026-09-25 23:25:02.58654	\N
2860	V	5	274.55	5	2026-09-25 23:25:02.58654	\N
2861	V	5	342.93	5	2026-09-25 23:25:02.58654	\N
2862	V	5	274.27	5	2026-09-25 23:25:02.58654	\N
2863	V	5	204.60	5	2026-09-25 23:25:02.58654	\N
2864	V	5	204.34	5	2026-09-25 23:25:02.58654	\N
2865	V	5	206.70	5	2026-09-25 23:25:02.58654	\N
2866	V	5	207.40	5	2026-09-25 23:25:02.58654	\N
2867	V	5	276.59	5	2026-09-25 23:25:02.58654	\N
2868	V	5	346.06	5	2026-09-25 23:25:02.58654	\N
2869	V	5	277.18	5	2026-09-25 23:25:02.58654	\N
2870	V	5	207.74	5	2026-09-25 23:25:02.58654	\N
2871	V	5	208.23	5	2026-09-25 23:25:02.58654	\N
2872	V	5	208.42	5	2026-09-25 23:25:02.58654	\N
2873	V	5	207.20	5	2026-09-25 23:25:02.58654	\N
2874	V	5	276.21	5	2026-09-25 23:25:02.58654	\N
2875	V	5	344.35	5	2026-09-25 23:25:02.58654	\N
2876	V	5	274.79	5	2026-09-25 23:25:02.58654	\N
2877	V	5	205.41	5	2026-09-25 23:25:02.58654	\N
2878	V	5	204.53	5	2026-09-25 23:25:02.58654	\N
2879	V	5	203.59	5	2026-09-25 23:25:02.58654	\N
2880	V	5	203.45	5	2026-09-25 23:25:02.58654	\N
2881	V	5	270.84	5	2026-09-25 23:25:02.58654	\N
2882	V	5	338.04	5	2026-09-25 23:25:02.58654	\N
2883	V	5	270.66	5	2026-09-25 23:25:02.58654	\N
2884	V	5	202.60	5	2026-09-25 23:25:02.58654	\N
2885	V	5	201.57	5	2026-09-25 23:25:02.58654	\N
2886	V	5	201.96	5	2026-09-25 23:25:02.58654	\N
2887	V	5	202.53	5	2026-09-25 23:25:02.58654	\N
2888	V	5	269.75	5	2026-09-25 23:25:02.58654	\N
2889	V	5	335.75	5	2026-09-25 23:25:02.58654	\N
2890	V	5	268.78	5	2026-09-25 23:25:02.58654	\N
2891	V	5	201.00	5	2026-09-25 23:25:02.58654	\N
2892	V	5	198.37	5	2026-09-25 23:25:02.58654	\N
2893	V	5	195.39	5	2026-09-25 23:25:02.58654	\N
2894	V	5	194.21	5	2026-09-25 23:25:02.58654	\N
2895	V	5	258.96	5	2026-09-25 23:25:02.58654	\N
2896	V	5	324.56	5	2026-09-25 23:25:02.58654	\N
2897	V	5	259.41	5	2026-09-25 23:25:02.58654	\N
2898	V	5	195.17	5	2026-09-25 23:25:02.58654	\N
2899	V	5	196.21	5	2026-09-25 23:25:02.58654	\N
2900	V	5	198.36	5	2026-09-25 23:25:02.58654	\N
2901	V	5	199.52	5	2026-09-25 23:25:02.58654	\N
2902	V	5	199.52	5	2026-09-25 23:25:02.58654	\N
2903	V	5	266.41	5	2026-09-25 23:25:02.58654	\N
2904	V	5	200.55	5	2026-09-25 23:25:02.58654	\N
2905	V	5	133.65	5	2026-09-25 23:25:02.58654	\N
2906	V	5	132.97	5	2026-09-25 23:25:02.58654	\N
2907	V	5	198.89	5	2026-09-25 23:25:02.58654	\N
2908	V	5	197.92	5	2026-09-25 23:25:02.58654	\N
2909	V	5	263.34	5	2026-09-25 23:25:02.58654	\N
2910	V	5	329.59	5	2026-09-25 23:25:02.58654	\N
2911	V	5	263.51	5	2026-09-25 23:25:02.58654	\N
2912	V	5	197.59	5	2026-09-25 23:25:02.58654	\N
2913	V	5	197.04	5	2026-09-25 23:25:02.58654	\N
2914	V	5	196.92	5	2026-09-25 23:25:02.58654	\N
2915	V	5	195.81	5	2026-09-25 23:25:02.58654	\N
2916	V	5	264.94	5	2026-09-25 23:25:02.58654	\N
2917	V	5	334.51	5	2026-09-25 23:25:02.58654	\N
2918	V	5	269.14	5	2026-09-25 23:25:02.58654	\N
2919	V	5	203.84	5	2026-09-25 23:25:02.58654	\N
2920	V	5	208.07	5	2026-09-25 23:25:02.58654	\N
2921	V	5	207.97	5	2026-09-25 23:25:02.58654	\N
2922	V	5	207.28	5	2026-09-25 23:25:02.58654	\N
2923	V	5	276.48	5	2026-09-25 23:25:02.58654	\N
2924	V	5	346.33	5	2026-09-25 23:25:02.58654	\N
2925	V	5	276.96	5	2026-09-25 23:25:02.58654	\N
2926	V	5	207.93	5	2026-09-25 23:25:02.58654	\N
2927	V	5	209.47	5	2026-09-25 23:25:02.58654	\N
2928	V	5	210.94	5	2026-09-25 23:25:02.58654	\N
2929	V	5	212.12	5	2026-09-25 23:25:02.58654	\N
2930	V	5	212.12	5	2026-09-25 23:25:02.58654	\N
2931	V	5	283.12	5	2026-09-25 23:25:02.58654	\N
2932	V	5	212.70	5	2026-09-25 23:25:02.58654	\N
2933	V	5	142.03	5	2026-09-25 23:25:02.58654	\N
2934	V	5	141.92	5	2026-09-25 23:25:02.58654	\N
2935	V	5	212.65	5	2026-09-25 23:25:02.58654	\N
2936	V	5	211.79	5	2026-09-25 23:25:02.58654	\N
2937	V	5	211.79	5	2026-09-25 23:25:02.58654	\N
2938	V	5	281.08	5	2026-09-25 23:25:02.58654	\N
2939	V	5	210.16	5	2026-09-25 23:25:02.58654	\N
2940	V	5	139.44	5	2026-09-25 23:25:02.58654	\N
2941	V	5	140.06	5	2026-09-25 23:25:02.58654	\N
2942	V	5	211.57	5	2026-09-25 23:25:02.58654	\N
2943	V	5	213.45	5	2026-09-25 23:25:02.58654	\N
2944	V	5	283.89	5	2026-09-25 23:25:02.58654	\N
2945	V	5	353.85	5	2026-09-25 23:25:02.58654	\N
2946	V	5	283.09	5	2026-09-25 23:25:02.58654	\N
2947	V	5	211.58	5	2026-09-25 23:25:02.58654	\N
2948	V	5	209.04	5	2026-09-25 23:25:02.58654	\N
2949	V	5	204.17	5	2026-09-25 23:25:02.58654	\N
2950	V	5	200.05	5	2026-09-25 23:25:02.58654	\N
2951	V	5	265.60	5	2026-09-25 23:25:02.58654	\N
2952	V	5	331.26	5	2026-09-25 23:25:02.58654	\N
2953	V	5	262.62	5	2026-09-25 23:25:02.58654	\N
2954	V	5	197.04	5	2026-09-25 23:25:02.58654	\N
2955	V	5	131.21	5	2026-09-25 23:25:02.58654	\N
2956	V	5	130.82	5	2026-09-25 23:25:02.58654	\N
2957	V	5	130.22	5	2026-09-25 23:25:02.58654	\N
2958	V	5	195.49	5	2026-09-25 23:25:02.58654	\N
2959	V	5	260.73	5	2026-09-25 23:25:02.58654	\N
2960	V	5	260.73	5	2026-09-25 23:25:02.58654	\N
2961	V	5	195.56	5	2026-09-25 23:25:02.58654	\N
2962	V	5	196.21	5	2026-09-25 23:25:02.58654	\N
2963	V	5	195.99	5	2026-09-25 23:25:02.58654	\N
2964	V	5	196.15	5	2026-09-25 23:25:02.58654	\N
2965	V	5	262.51	5	2026-09-25 23:25:02.58654	\N
2966	V	5	326.87	5	2026-09-25 23:25:02.58654	\N
2967	V	5	261.17	5	2026-09-25 23:25:02.58654	\N
2968	V	5	196.12	5	2026-09-25 23:25:02.58654	\N
2969	V	5	197.49	5	2026-09-25 23:25:02.58654	\N
2970	V	5	196.92	5	2026-09-25 23:25:02.58654	\N
2971	V	5	198.54	5	2026-09-25 23:25:02.58654	\N
2972	V	5	264.37	5	2026-09-25 23:25:02.58654	\N
2973	V	5	330.69	5	2026-09-25 23:25:02.58654	\N
2974	V	5	263.92	5	2026-09-25 23:25:02.58654	\N
2975	V	5	198.13	5	2026-09-25 23:25:02.58654	\N
2976	V	5	197.26	5	2026-09-25 23:25:02.58654	\N
2977	V	5	197.07	5	2026-09-25 23:25:02.58654	\N
2978	V	5	196.60	5	2026-09-25 23:25:02.58654	\N
2979	V	5	261.43	5	2026-09-25 23:25:02.58654	\N
2980	V	5	324.25	5	2026-09-25 23:25:02.58654	\N
2981	V	5	259.13	5	2026-09-25 23:25:02.58654	\N
2982	V	5	193.50	5	2026-09-25 23:25:02.58654	\N
2983	V	5	127.65	5	2026-09-25 23:25:02.58654	\N
2984	V	5	126.72	5	2026-09-25 23:25:02.58654	\N
2985	V	5	127.96	5	2026-09-25 23:25:02.58654	\N
2986	V	5	191.75	5	2026-09-25 23:25:02.58654	\N
2987	V	5	255.94	5	2026-09-25 23:25:02.58654	\N
2988	V	5	255.94	5	2026-09-25 23:25:02.58654	\N
2989	V	5	192.04	5	2026-09-25 23:25:02.58654	\N
2990	V	5	189.28	5	2026-09-25 23:25:02.58654	\N
2991	V	5	186.94	5	2026-09-25 23:25:02.58654	\N
2992	V	5	185.35	5	2026-09-25 23:25:02.58654	\N
2993	V	5	248.69	5	2026-09-25 23:25:02.58654	\N
2994	V	5	312.71	5	2026-09-25 23:25:02.58654	\N
2995	V	5	251.41	5	2026-09-25 23:25:02.58654	\N
2996	V	5	189.97	5	2026-09-25 23:25:02.58654	\N
2997	V	5	191.47	5	2026-09-25 23:25:02.58654	\N
2998	V	5	192.30	5	2026-09-25 23:25:02.58654	\N
2999	V	5	192.36	5	2026-09-25 23:25:02.58654	\N
3000	V	5	256.32	5	2026-09-25 23:25:02.58654	\N
3001	V	5	319.79	5	2026-09-25 23:25:02.58654	\N
3002	V	5	255.69	5	2026-09-25 23:25:02.58654	\N
3003	V	5	191.53	5	2026-09-25 23:25:02.58654	\N
3004	V	5	190.63	5	2026-09-25 23:25:02.58654	\N
3005	V	5	189.55	5	2026-09-25 23:25:02.58654	\N
3006	V	5	187.87	5	2026-09-25 23:25:02.58654	\N
3007	V	5	249.17	5	2026-09-25 23:25:02.58654	\N
3008	V	5	310.60	5	2026-09-25 23:25:02.58654	\N
3009	V	5	247.41	5	2026-09-25 23:25:02.58654	\N
3010	V	5	184.52	5	2026-09-25 23:25:02.58654	\N
3011	V	5	184.75	5	2026-09-25 23:25:02.58654	\N
3012	V	5	185.14	5	2026-09-25 23:25:02.58654	\N
3013	V	5	183.52	5	2026-09-25 23:25:02.58654	\N
3014	V	5	243.46	5	2026-09-25 23:25:02.58654	\N
3015	V	5	303.78	5	2026-09-25 23:25:02.58654	\N
3016	V	5	241.76	5	2026-09-25 23:25:02.58654	\N
3017	V	5	180.07	5	2026-09-25 23:25:02.58654	\N
3018	V	5	181.15	5	2026-09-25 23:25:02.58654	\N
3019	V	5	181.96	5	2026-09-25 23:25:02.58654	\N
3020	V	5	182.62	5	2026-09-25 23:25:02.58654	\N
3021	V	5	243.73	5	2026-09-25 23:25:02.58654	\N
3022	V	5	302.83	5	2026-09-25 23:25:02.58654	\N
3023	V	5	241.94	5	2026-09-25 23:25:02.58654	\N
3024	V	5	181.19	5	2026-09-25 23:25:02.58654	\N
3025	V	5	180.12	5	2026-09-25 23:25:02.58654	\N
3026	V	5	179.46	5	2026-09-25 23:25:02.58654	\N
3027	V	5	180.06	5	2026-09-25 23:25:02.58654	\N
3028	V	5	240.22	5	2026-09-25 23:25:02.58654	\N
3029	V	5	240.22	5	2026-09-25 23:25:02.58654	\N
3030	V	5	180.31	5	2026-09-25 23:25:02.58654	\N
3031	V	5	119.86	5	2026-09-25 23:25:02.58654	\N
3032	V	5	120.83	5	2026-09-25 23:25:02.58654	\N
3033	V	5	121.18	5	2026-09-25 23:25:02.58654	\N
3034	V	5	182.97	5	2026-09-25 23:25:02.58654	\N
3035	V	5	244.63	5	2026-09-25 23:25:02.58654	\N
3036	V	5	305.50	5	2026-09-25 23:25:02.58654	\N
3037	V	5	244.83	5	2026-09-25 23:25:02.58654	\N
3038	V	5	184.32	5	2026-09-25 23:25:02.58654	\N
3039	V	5	184.41	5	2026-09-25 23:25:02.58654	\N
3040	V	5	185.02	5	2026-09-25 23:25:02.58654	\N
3041	V	5	187.33	5	2026-09-25 23:25:02.58654	\N
3042	V	5	250.35	5	2026-09-25 23:25:02.58654	\N
3043	V	5	313.76	5	2026-09-25 23:25:02.58654	\N
3044	V	5	251.88	5	2026-09-25 23:25:02.58654	\N
3045	V	5	189.61	5	2026-09-25 23:25:02.58654	\N
3046	V	5	189.21	5	2026-09-25 23:25:02.58654	\N
3047	V	5	188.18	5	2026-09-25 23:25:02.58654	\N
3048	V	5	187.03	5	2026-09-25 23:25:02.58654	\N
3049	V	5	248.81	5	2026-09-25 23:25:02.58654	\N
3050	V	5	310.69	5	2026-09-25 23:25:02.58654	\N
3051	V	5	247.91	5	2026-09-25 23:25:02.58654	\N
3052	V	5	185.92	5	2026-09-25 23:25:02.58654	\N
3053	V	5	185.59	5	2026-09-25 23:25:02.58654	\N
3054	V	5	185.67	5	2026-09-25 23:25:02.58654	\N
3055	V	5	190.76	5	2026-09-25 23:25:02.58654	\N
3056	V	5	256.73	5	2026-09-25 23:25:02.58654	\N
3057	V	5	322.34	5	2026-09-25 23:25:02.58654	\N
3058	V	5	260.41	5	2026-09-25 23:25:02.58654	\N
3059	V	5	198.55	5	2026-09-25 23:25:02.58654	\N
3060	V	5	196.94	5	2026-09-25 23:25:02.58654	\N
3061	V	5	195.38	5	2026-09-25 23:25:02.58654	\N
3062	V	5	193.54	5	2026-09-25 23:25:02.58654	\N
3063	V	5	257.79	5	2026-09-25 23:25:02.58654	\N
3064	V	5	321.55	5	2026-09-25 23:25:02.58654	\N
3065	V	5	256.18	5	2026-09-25 23:25:02.58654	\N
3066	V	5	191.77	5	2026-09-25 23:25:02.58654	\N
3067	V	5	192.79	5	2026-09-25 23:25:02.58654	\N
3068	V	5	193.81	5	2026-09-25 23:25:02.58654	\N
3069	V	5	194.12	5	2026-09-25 23:25:02.58654	\N
3070	V	5	258.62	5	2026-09-25 23:25:02.58654	\N
3071	V	5	323.77	5	2026-09-25 23:25:02.58654	\N
3072	V	5	259.00	5	2026-09-25 23:25:02.58654	\N
3073	V	5	193.72	5	2026-09-25 23:25:02.58654	\N
3074	V	5	196.18	5	2026-09-25 23:25:02.58654	\N
3075	V	5	197.66	5	2026-09-25 23:25:02.58654	\N
3076	V	5	198.66	5	2026-09-25 23:25:02.58654	\N
3077	V	5	264.88	5	2026-09-25 23:25:02.58654	\N
3078	V	5	330.66	5	2026-09-25 23:25:02.58654	\N
3079	V	5	264.13	5	2026-09-25 23:25:02.58654	\N
3080	V	5	198.15	5	2026-09-25 23:25:02.58654	\N
3081	V	5	132.00	5	2026-09-25 23:25:02.58654	\N
3082	V	5	131.07	5	2026-09-25 23:25:02.58654	\N
3083	V	5	130.82	5	2026-09-25 23:25:02.58654	\N
3084	V	5	195.81	5	2026-09-25 23:25:02.58654	\N
3085	V	5	261.08	5	2026-09-25 23:25:02.58654	\N
3086	V	5	261.08	5	2026-09-25 23:25:02.58654	\N
3087	V	5	195.78	5	2026-09-25 23:25:02.58654	\N
3088	V	5	194.82	5	2026-09-25 23:25:02.58654	\N
3089	V	5	193.29	5	2026-09-25 23:25:02.58654	\N
3090	V	5	190.50	5	2026-09-25 23:25:02.58654	\N
3091	V	5	254.53	5	2026-09-25 23:25:02.58654	\N
3092	V	5	319.25	5	2026-09-25 23:25:02.58654	\N
3093	V	5	254.69	5	2026-09-25 23:25:02.58654	\N
3094	V	5	191.23	5	2026-09-25 23:25:02.58654	\N
3095	V	5	192.68	5	2026-09-25 23:25:02.58654	\N
3096	V	5	193.66	5	2026-09-25 23:25:02.58654	\N
3097	V	5	193.54	5	2026-09-25 23:25:02.58654	\N
3098	V	5	257.35	5	2026-09-25 23:25:02.58654	\N
3099	V	5	321.82	5	2026-09-25 23:25:02.58654	\N
3100	V	5	257.89	5	2026-09-25 23:25:02.58654	\N
3101	V	5	192.88	5	2026-09-25 23:25:02.58654	\N
3102	V	5	193.05	5	2026-09-25 23:25:02.58654	\N
3103	V	5	195.87	5	2026-09-25 23:25:02.58654	\N
3104	V	5	197.46	5	2026-09-25 23:25:02.58654	\N
3105	V	5	262.91	5	2026-09-25 23:25:02.58654	\N
3106	V	5	262.91	5	2026-09-25 23:25:02.58654	\N
3107	V	5	198.15	5	2026-09-25 23:25:02.58654	\N
3108	V	5	131.52	5	2026-09-25 23:25:02.58654	\N
3109	V	5	130.77	5	2026-09-25 23:25:02.58654	\N
3110	V	5	131.02	5	2026-09-25 23:25:02.58654	\N
3111	V	5	197.46	5	2026-09-25 23:25:02.58654	\N
3112	V	5	263.57	5	2026-09-25 23:25:02.58654	\N
3113	V	5	330.81	5	2026-09-25 23:25:02.58654	\N
3114	V	5	265.49	5	2026-09-25 23:25:02.58654	\N
3115	V	5	199.80	5	2026-09-25 23:25:02.58654	\N
3116	V	5	201.68	5	2026-09-25 23:25:02.58654	\N
3117	V	5	204.19	5	2026-09-25 23:25:02.58654	\N
3118	V	5	207.16	5	2026-09-25 23:25:02.58654	\N
3119	V	5	279.59	5	2026-09-25 23:25:02.58654	\N
3120	V	5	279.59	5	2026-09-25 23:25:02.58654	\N
3121	V	5	211.26	5	2026-09-25 23:25:02.58654	\N
3122	V	5	142.64	5	2026-09-25 23:25:02.58654	\N
3123	V	5	143.88	5	2026-09-25 23:25:02.58654	\N
3124	V	5	141.89	5	2026-09-25 23:25:02.58654	\N
3125	V	5	211.40	5	2026-09-25 23:25:02.58654	\N
3126	V	5	281.04	5	2026-09-25 23:25:02.58654	\N
3127	V	5	350.83	5	2026-09-25 23:25:02.58654	\N
3128	V	5	279.38	5	2026-09-25 23:25:02.58654	\N
3129	V	5	208.94	5	2026-09-25 23:25:02.58654	\N
3130	V	5	210.98	5	2026-09-25 23:25:02.58654	\N
3131	V	5	212.55	5	2026-09-25 23:25:02.58654	\N
3132	V	5	213.78	5	2026-09-25 23:25:02.58654	\N
3133	V	5	286.81	5	2026-09-25 23:25:02.58654	\N
3134	V	5	358.52	5	2026-09-25 23:25:02.58654	\N
3135	V	5	286.97	5	2026-09-25 23:25:02.58654	\N
3136	V	5	215.77	5	2026-09-25 23:25:02.58654	\N
3137	V	5	216.85	5	2026-09-25 23:25:02.58654	\N
3138	V	5	214.99	5	2026-09-25 23:25:02.58654	\N
3139	V	5	213.96	5	2026-09-25 23:25:02.58654	\N
3140	V	5	284.28	5	2026-09-25 23:25:02.58654	\N
3141	V	5	355.43	5	2026-09-25 23:25:02.58654	\N
3142	V	5	283.32	5	2026-09-25 23:25:02.58654	\N
3143	V	5	212.15	5	2026-09-25 23:25:02.58654	\N
3144	V	5	213.97	5	2026-09-25 23:25:02.58654	\N
3145	V	5	216.97	5	2026-09-25 23:25:02.58654	\N
3146	V	5	219.57	5	2026-09-25 23:25:02.58654	\N
3147	V	5	292.82	5	2026-09-25 23:25:02.58654	\N
3148	V	5	366.05	5	2026-09-25 23:25:02.58654	\N
3149	V	5	293.54	5	2026-09-25 23:25:02.58654	\N
3150	V	5	220.23	5	2026-09-25 23:25:02.58654	\N
3151	V	5	219.61	5	2026-09-25 23:25:02.58654	\N
3152	V	5	220.28	5	2026-09-25 23:25:02.58654	\N
3153	V	5	220.76	5	2026-09-25 23:25:02.58654	\N
3154	V	5	294.85	5	2026-09-25 23:25:02.58654	\N
3155	V	5	367.35	5	2026-09-25 23:25:02.58654	\N
3156	V	5	294.22	5	2026-09-25 23:25:02.58654	\N
3157	V	5	220.30	5	2026-09-25 23:25:02.58654	\N
3158	V	5	218.86	5	2026-09-25 23:25:02.58654	\N
3159	V	5	217.33	5	2026-09-25 23:25:02.58654	\N
3160	V	5	216.71	5	2026-09-25 23:25:02.58654	\N
3161	V	5	289.80	5	2026-09-25 23:25:02.58654	\N
3162	V	5	362.63	5	2026-09-25 23:25:02.58654	\N
3163	V	5	290.37	5	2026-09-25 23:25:02.58654	\N
3164	V	5	217.80	5	2026-09-25 23:25:02.58654	\N
3165	V	5	217.69	5	2026-09-25 23:25:02.58654	\N
3166	V	5	217.45	5	2026-09-25 23:25:02.58654	\N
3167	V	5	217.73	5	2026-09-25 23:25:02.58654	\N
3168	V	5	290.87	5	2026-09-25 23:25:02.58654	\N
3169	V	5	365.08	5	2026-09-25 23:25:02.58654	\N
3170	V	5	293.31	5	2026-09-25 23:25:02.58654	\N
3171	V	5	220.46	5	2026-09-25 23:25:02.58654	\N
3172	V	5	223.84	5	2026-09-25 23:25:02.58654	\N
3173	V	5	227.52	5	2026-09-25 23:25:02.58654	\N
3174	V	5	230.09	5	2026-09-25 23:25:02.58654	\N
3175	V	5	306.02	5	2026-09-25 23:25:02.58654	\N
3176	V	5	382.34	5	2026-09-25 23:25:02.58654	\N
3177	V	5	305.86	5	2026-09-25 23:25:02.58654	\N
3178	V	5	229.03	5	2026-09-25 23:25:02.58654	\N
3179	V	5	228.13	5	2026-09-25 23:25:02.58654	\N
3180	V	5	226.73	5	2026-09-25 23:25:02.58654	\N
3181	V	5	226.09	5	2026-09-25 23:25:02.58654	\N
3182	V	5	301.84	5	2026-09-25 23:25:02.58654	\N
3183	V	5	376.85	5	2026-09-25 23:25:02.58654	\N
3184	V	5	300.98	5	2026-09-25 23:25:02.58654	\N
3185	V	5	226.44	5	2026-09-25 23:25:02.58654	\N
3186	V	5	150.76	5	2026-09-25 23:25:02.58654	\N
3187	V	5	148.74	5	2026-09-25 23:25:02.58654	\N
3188	V	5	147.21	5	2026-09-25 23:25:02.58654	\N
3189	V	5	220.65	5	2026-09-25 23:25:02.58654	\N
3190	V	5	294.74	5	2026-09-25 23:25:02.58654	\N
3191	V	5	294.74	5	2026-09-25 23:25:02.58654	\N
3192	V	5	221.01	5	2026-09-25 23:25:02.58654	\N
3193	V	5	222.59	5	2026-09-25 23:25:02.58654	\N
3194	V	5	224.27	5	2026-09-25 23:25:02.58654	\N
3195	V	5	224.37	5	2026-09-25 23:25:02.58654	\N
3196	V	5	298.35	5	2026-09-25 23:25:02.58654	\N
3197	V	5	372.01	5	2026-09-25 23:25:02.58654	\N
3198	V	5	296.95	5	2026-09-25 23:25:02.58654	\N
3199	V	5	221.83	5	2026-09-25 23:25:02.58654	\N
3200	V	5	221.63	5	2026-09-25 23:25:02.58654	\N
3201	V	5	220.06	5	2026-09-25 23:25:02.58654	\N
3202	V	5	146.40	5	2026-09-25 23:25:02.58654	\N
3203	V	20	240.93	20	2026-09-25 23:25:02.63685	\N
3204	V	20	241.16	20	2026-09-25 23:25:02.63685	\N
3205	V	20	241.64	20	2026-09-25 23:25:02.63685	\N
3206	V	20	242.18	20	2026-09-25 23:25:02.63685	\N
3207	V	20	242.08	20	2026-09-25 23:25:02.63685	\N
3208	V	20	259.18	20	2026-09-25 23:25:02.63685	\N
3209	V	20	259.18	20	2026-09-25 23:25:02.63685	\N
3210	V	20	242.17	20	2026-09-25 23:25:02.63685	\N
3211	V	20	242.32	20	2026-09-25 23:25:02.63685	\N
3212	V	20	242.29	20	2026-09-25 23:25:02.63685	\N
3213	V	20	242.26	20	2026-09-25 23:25:02.63685	\N
3214	V	20	242.07	20	2026-09-25 23:25:02.63685	\N
3215	V	20	259.44	20	2026-09-25 23:25:02.63685	\N
3216	V	20	259.44	20	2026-09-25 23:25:02.63685	\N
3217	V	20	241.97	20	2026-09-25 23:25:02.63685	\N
3218	V	20	241.74	20	2026-09-25 23:25:02.63685	\N
3219	V	20	241.52	20	2026-09-25 23:25:02.63685	\N
3220	V	20	241.23	20	2026-09-25 23:25:02.63685	\N
3221	V	20	241.30	20	2026-09-25 23:25:02.63685	\N
3222	V	20	258.34	20	2026-09-25 23:25:02.63685	\N
3223	V	20	258.34	20	2026-09-25 23:25:02.63685	\N
3224	V	20	241.17	20	2026-09-25 23:25:02.63685	\N
3225	V	20	240.60	20	2026-09-25 23:25:02.63685	\N
3226	V	20	240.33	20	2026-09-25 23:25:02.63685	\N
3227	V	20	240.56	20	2026-09-25 23:25:02.63685	\N
3228	V	20	240.31	20	2026-09-25 23:25:02.63685	\N
3229	V	20	257.12	20	2026-09-25 23:25:02.63685	\N
3230	V	20	257.12	20	2026-09-25 23:25:02.63685	\N
3231	V	20	239.89	20	2026-09-25 23:25:02.63685	\N
3232	V	20	239.28	20	2026-09-25 23:25:02.63685	\N
3233	V	20	238.96	20	2026-09-25 23:25:02.63685	\N
3234	V	20	238.60	20	2026-09-25 23:25:02.63685	\N
3235	V	20	238.04	20	2026-09-25 23:25:02.63685	\N
3236	V	20	254.54	20	2026-09-25 23:25:02.63685	\N
3237	V	20	254.54	20	2026-09-25 23:25:02.63685	\N
3238	V	20	237.15	20	2026-09-25 23:25:02.63685	\N
3239	V	20	236.09	20	2026-09-25 23:25:02.63685	\N
3240	V	20	235.08	20	2026-09-25 23:25:02.63685	\N
3241	V	20	234.04	20	2026-09-25 23:25:02.63685	\N
3242	V	20	233.19	20	2026-09-25 23:25:02.63685	\N
3243	V	20	249.59	20	2026-09-25 23:25:02.63685	\N
3244	V	20	249.59	20	2026-09-25 23:25:02.63685	\N
3245	V	20	232.74	20	2026-09-25 23:25:02.63685	\N
3246	V	20	232.19	20	2026-09-25 23:25:02.63685	\N
3247	V	20	231.92	20	2026-09-25 23:25:02.63685	\N
3248	V	20	231.76	20	2026-09-25 23:25:02.63685	\N
3249	V	20	214.96	20	2026-09-25 23:25:02.63685	\N
3250	V	20	231.68	20	2026-09-25 23:25:02.63685	\N
3251	V	20	231.68	20	2026-09-25 23:25:02.63685	\N
3252	V	20	214.94	20	2026-09-25 23:25:02.63685	\N
3253	V	20	214.51	20	2026-09-25 23:25:02.63685	\N
3254	V	20	214.05	20	2026-09-25 23:25:02.63685	\N
3255	V	20	213.72	20	2026-09-25 23:25:02.63685	\N
3256	V	20	213.58	20	2026-09-25 23:25:02.63685	\N
3257	V	20	230.14	20	2026-09-25 23:25:02.63685	\N
3258	V	20	230.14	20	2026-09-25 23:25:02.63685	\N
3259	V	20	213.85	20	2026-09-25 23:25:02.63685	\N
3260	V	20	214.14	20	2026-09-25 23:25:02.63685	\N
3261	V	20	214.26	20	2026-09-25 23:25:02.63685	\N
3262	V	20	214.35	20	2026-09-25 23:25:02.63685	\N
3263	V	20	215.24	20	2026-09-25 23:25:02.63685	\N
3264	V	20	232.63	20	2026-09-25 23:25:02.63685	\N
3265	V	20	232.63	20	2026-09-25 23:25:02.63685	\N
3266	V	20	216.16	20	2026-09-25 23:25:02.63685	\N
3267	V	20	216.78	20	2026-09-25 23:25:02.63685	\N
3268	V	20	217.35	20	2026-09-25 23:25:02.63685	\N
3269	V	20	234.57	20	2026-09-25 23:25:02.63685	\N
3270	V	20	235.15	20	2026-09-25 23:25:02.63685	\N
3271	V	20	252.61	20	2026-09-25 23:25:02.63685	\N
3272	V	20	252.61	20	2026-09-25 23:25:02.63685	\N
3273	V	20	236.09	20	2026-09-25 23:25:02.63685	\N
3274	V	20	237.21	20	2026-09-25 23:25:02.63685	\N
3275	V	20	238.40	20	2026-09-25 23:25:02.63685	\N
3276	V	20	239.80	20	2026-09-25 23:25:02.63685	\N
3277	V	20	223.24	20	2026-09-25 23:25:02.63685	\N
3278	V	20	240.99	20	2026-09-25 23:25:02.63685	\N
3279	V	20	240.99	20	2026-09-25 23:25:02.63685	\N
3280	V	20	224.65	20	2026-09-25 23:25:02.63685	\N
3281	V	20	226.05	20	2026-09-25 23:25:02.63685	\N
3282	V	20	227.45	20	2026-09-25 23:25:02.63685	\N
3283	V	20	227.70	20	2026-09-25 23:25:02.63685	\N
3284	V	20	210.31	20	2026-09-25 23:25:02.63685	\N
3285	V	20	227.64	20	2026-09-25 23:25:02.63685	\N
3286	V	20	227.64	20	2026-09-25 23:25:02.63685	\N
3287	V	20	210.29	20	2026-09-25 23:25:02.63685	\N
3288	V	20	210.72	20	2026-09-25 23:25:02.63685	\N
3289	V	20	211.38	20	2026-09-25 23:25:02.63685	\N
3290	V	20	211.88	20	2026-09-25 23:25:02.63685	\N
3291	V	20	212.03	20	2026-09-25 23:25:02.63685	\N
3292	V	20	229.51	20	2026-09-25 23:25:02.63685	\N
3293	V	20	229.51	20	2026-09-25 23:25:02.63685	\N
3294	V	20	211.91	20	2026-09-25 23:25:02.63685	\N
3295	V	20	211.40	20	2026-09-25 23:25:02.63685	\N
3296	V	20	210.04	20	2026-09-25 23:25:02.63685	\N
3297	V	20	226.50	20	2026-09-25 23:25:02.63685	\N
3298	V	20	225.13	20	2026-09-25 23:25:02.63685	\N
3299	V	20	241.55	20	2026-09-25 23:25:02.63685	\N
3300	V	20	241.55	20	2026-09-25 23:25:02.63685	\N
3301	V	20	223.82	20	2026-09-25 23:25:02.63685	\N
3302	V	20	206.14	20	2026-09-25 23:25:02.63685	\N
3303	V	20	204.89	20	2026-09-25 23:25:02.63685	\N
3304	V	20	221.16	20	2026-09-25 23:25:02.63685	\N
3305	V	20	220.15	20	2026-09-25 23:25:02.63685	\N
3306	V	20	236.46	20	2026-09-25 23:25:02.63685	\N
3307	V	20	236.46	20	2026-09-25 23:25:02.63685	\N
3308	V	20	218.77	20	2026-09-25 23:25:02.63685	\N
3309	V	20	217.32	20	2026-09-25 23:25:02.63685	\N
3310	V	20	215.78	20	2026-09-25 23:25:02.63685	\N
3311	V	20	214.52	20	2026-09-25 23:25:02.63685	\N
3312	V	20	213.62	20	2026-09-25 23:25:02.63685	\N
3313	V	20	229.71	20	2026-09-25 23:25:02.63685	\N
3314	V	20	229.71	20	2026-09-25 23:25:02.63685	\N
3315	V	20	212.56	20	2026-09-25 23:25:02.63685	\N
3316	V	20	212.85	20	2026-09-25 23:25:02.63685	\N
3317	V	20	212.84	20	2026-09-25 23:25:02.63685	\N
3318	V	20	212.95	20	2026-09-25 23:25:02.63685	\N
3319	V	20	212.99	20	2026-09-25 23:25:02.63685	\N
3320	V	20	229.57	20	2026-09-25 23:25:02.63685	\N
3321	V	20	229.57	20	2026-09-25 23:25:02.63685	\N
3322	V	20	229.57	20	2026-09-25 23:25:02.63685	\N
3323	V	20	229.56	20	2026-09-25 23:25:02.63685	\N
3324	V	20	229.70	20	2026-09-25 23:25:02.63685	\N
3325	V	20	229.85	20	2026-09-25 23:25:02.63685	\N
3326	V	20	229.75	20	2026-09-25 23:25:02.63685	\N
3327	V	20	245.45	20	2026-09-25 23:25:02.63685	\N
3328	V	20	245.45	20	2026-09-25 23:25:02.63685	\N
3329	V	20	229.03	20	2026-09-25 23:25:02.63685	\N
3330	V	20	212.76	20	2026-09-25 23:25:02.63685	\N
3331	V	20	212.39	20	2026-09-25 23:25:02.63685	\N
3332	V	20	211.82	20	2026-09-25 23:25:02.63685	\N
3333	V	20	211.67	20	2026-09-25 23:25:02.63685	\N
3334	V	20	227.72	20	2026-09-25 23:25:02.63685	\N
3335	V	20	227.72	20	2026-09-25 23:25:02.63685	\N
3336	V	20	211.03	20	2026-09-25 23:25:02.63685	\N
3337	V	20	209.91	20	2026-09-25 23:25:02.63685	\N
3338	V	20	208.77	20	2026-09-25 23:25:02.63685	\N
3339	V	20	207.96	20	2026-09-25 23:25:02.63685	\N
3340	V	20	207.22	20	2026-09-25 23:25:02.63685	\N
3341	V	20	223.22	20	2026-09-25 23:25:02.63685	\N
3342	V	20	223.22	20	2026-09-25 23:25:02.63685	\N
3343	V	20	206.95	20	2026-09-25 23:25:02.63685	\N
3344	V	20	206.56	20	2026-09-25 23:25:02.63685	\N
3345	V	20	206.14	20	2026-09-25 23:25:02.63685	\N
3346	V	20	205.96	20	2026-09-25 23:25:02.63685	\N
3347	V	20	206.24	20	2026-09-25 23:25:02.63685	\N
3348	V	20	222.11	20	2026-09-25 23:25:02.63685	\N
3349	V	20	222.11	20	2026-09-25 23:25:02.63685	\N
3350	V	20	222.11	20	2026-09-25 23:25:02.63685	\N
3351	V	20	221.93	20	2026-09-25 23:25:02.63685	\N
3352	V	20	221.64	20	2026-09-25 23:25:02.63685	\N
3353	V	20	221.14	20	2026-09-25 23:25:02.63685	\N
3354	V	20	220.42	20	2026-09-25 23:25:02.63685	\N
3355	V	20	235.78	20	2026-09-25 23:25:02.63685	\N
3356	V	20	235.78	20	2026-09-25 23:25:02.63685	\N
3357	V	20	220.45	20	2026-09-25 23:25:02.63685	\N
3358	V	20	220.60	20	2026-09-25 23:25:02.63685	\N
3359	V	20	220.37	20	2026-09-25 23:25:02.63685	\N
3360	V	20	219.48	20	2026-09-25 23:25:02.63685	\N
3361	V	20	218.46	20	2026-09-25 23:25:02.63685	\N
3362	V	20	233.54	20	2026-09-25 23:25:02.63685	\N
3363	V	20	233.54	20	2026-09-25 23:25:02.63685	\N
3364	V	20	217.52	20	2026-09-25 23:25:02.63685	\N
3365	V	20	216.70	20	2026-09-25 23:25:02.63685	\N
3366	V	20	215.86	20	2026-09-25 23:25:02.63685	\N
3367	V	20	215.12	20	2026-09-25 23:25:02.63685	\N
3368	V	20	214.53	20	2026-09-25 23:25:02.63685	\N
3369	V	20	229.30	20	2026-09-25 23:25:02.63685	\N
3370	V	20	229.30	20	2026-09-25 23:25:02.63685	\N
3371	V	20	213.51	20	2026-09-25 23:25:02.63685	\N
3372	V	20	212.76	20	2026-09-25 23:25:02.63685	\N
3373	V	20	212.43	20	2026-09-25 23:25:02.63685	\N
3374	V	20	212.03	20	2026-09-25 23:25:02.63685	\N
3375	V	20	211.71	20	2026-09-25 23:25:02.63685	\N
3376	V	20	211.71	20	2026-09-25 23:25:02.63685	\N
3377	V	20	211.71	20	2026-09-25 23:25:02.63685	\N
3378	V	20	196.20	20	2026-09-25 23:25:02.63685	\N
3379	V	20	195.95	20	2026-09-25 23:25:02.63685	\N
3380	V	20	196.12	20	2026-09-25 23:25:02.63685	\N
3381	V	20	196.59	20	2026-09-25 23:25:02.63685	\N
3382	V	20	196.92	20	2026-09-25 23:25:02.63685	\N
3383	V	20	212.14	20	2026-09-25 23:25:02.63685	\N
3384	V	20	212.14	20	2026-09-25 23:25:02.63685	\N
3385	V	20	196.92	20	2026-09-25 23:25:02.63685	\N
3386	V	20	197.20	20	2026-09-25 23:25:02.63685	\N
3387	V	20	197.52	20	2026-09-25 23:25:02.63685	\N
3388	V	20	198.04	20	2026-09-25 23:25:02.63685	\N
3389	V	20	199.02	20	2026-09-25 23:25:02.63685	\N
3390	V	20	214.87	20	2026-09-25 23:25:02.63685	\N
3391	V	20	214.87	20	2026-09-25 23:25:02.63685	\N
3392	V	20	199.89	20	2026-09-25 23:25:02.63685	\N
3393	V	20	200.48	20	2026-09-25 23:25:02.63685	\N
3394	V	20	201.05	20	2026-09-25 23:25:02.63685	\N
3395	V	20	201.57	20	2026-09-25 23:25:02.63685	\N
3396	V	20	217.02	20	2026-09-25 23:25:02.63685	\N
3397	V	20	232.49	20	2026-09-25 23:25:02.63685	\N
3398	V	20	232.49	20	2026-09-25 23:25:02.63685	\N
3399	V	20	217.32	20	2026-09-25 23:25:02.63685	\N
3400	V	20	217.68	20	2026-09-25 23:25:02.63685	\N
3401	V	20	217.69	20	2026-09-25 23:25:02.63685	\N
3402	V	20	219.02	20	2026-09-25 23:25:02.63685	\N
3403	V	20	220.30	20	2026-09-25 23:25:02.63685	\N
3404	V	20	236.70	20	2026-09-25 23:25:02.63685	\N
3405	V	20	236.70	20	2026-09-25 23:25:02.63685	\N
3406	V	20	221.23	20	2026-09-25 23:25:02.63685	\N
3407	V	20	222.00	20	2026-09-25 23:25:02.63685	\N
3408	V	20	222.31	20	2026-09-25 23:25:02.63685	\N
3409	V	20	222.49	20	2026-09-25 23:25:02.63685	\N
3410	V	20	222.71	20	2026-09-25 23:25:02.63685	\N
3411	V	20	238.65	20	2026-09-25 23:25:02.63685	\N
3412	V	20	238.65	20	2026-09-25 23:25:02.63685	\N
3413	V	20	222.95	20	2026-09-25 23:25:02.63685	\N
3414	V	20	223.64	20	2026-09-25 23:25:02.63685	\N
3415	V	20	224.40	20	2026-09-25 23:25:02.63685	\N
3416	V	20	224.97	20	2026-09-25 23:25:02.63685	\N
3417	V	20	225.63	20	2026-09-25 23:25:02.63685	\N
3418	V	20	241.91	20	2026-09-25 23:25:02.63685	\N
3419	V	20	241.91	20	2026-09-25 23:25:02.63685	\N
3420	V	20	226.43	20	2026-09-25 23:25:02.63685	\N
3421	V	20	227.60	20	2026-09-25 23:25:02.63685	\N
3422	V	20	227.35	20	2026-09-25 23:25:02.63685	\N
3423	V	20	227.40	20	2026-09-25 23:25:02.63685	\N
3424	V	20	227.55	20	2026-09-25 23:25:02.63685	\N
3425	V	20	244.00	20	2026-09-25 23:25:02.63685	\N
3426	V	20	244.00	20	2026-09-25 23:25:02.63685	\N
3427	V	20	227.65	20	2026-09-25 23:25:02.63685	\N
3428	V	20	211.55	20	2026-09-25 23:25:02.63685	\N
3429	V	20	211.94	20	2026-09-25 23:25:02.63685	\N
3430	V	20	212.25	20	2026-09-25 23:25:02.63685	\N
3431	V	20	212.56	20	2026-09-25 23:25:02.63685	\N
3432	V	20	228.88	20	2026-09-25 23:25:02.63685	\N
3433	V	20	228.88	20	2026-09-25 23:25:02.63685	\N
3434	V	20	212.69	20	2026-09-25 23:25:02.63685	\N
3435	V	20	212.50	20	2026-09-25 23:25:02.63685	\N
3436	V	20	212.35	20	2026-09-25 23:25:02.63685	\N
3437	V	20	211.85	20	2026-09-25 23:25:02.63685	\N
3438	V	20	211.57	20	2026-09-25 23:25:02.63685	\N
3439	V	20	227.75	20	2026-09-25 23:25:02.63685	\N
3440	V	20	227.75	20	2026-09-25 23:25:02.63685	\N
3441	V	20	211.12	20	2026-09-25 23:25:02.63685	\N
3442	V	20	210.60	20	2026-09-25 23:25:02.63685	\N
3443	V	20	210.32	20	2026-09-25 23:25:02.63685	\N
3444	V	20	209.91	20	2026-09-25 23:25:02.63685	\N
3445	V	20	209.42	20	2026-09-25 23:25:02.63685	\N
3446	V	20	225.54	20	2026-09-25 23:25:02.63685	\N
3447	V	20	225.54	20	2026-09-25 23:25:02.63685	\N
3448	V	20	225.54	20	2026-09-25 23:25:02.63685	\N
3449	V	20	225.41	20	2026-09-25 23:25:02.63685	\N
3450	V	20	225.68	20	2026-09-25 23:25:02.63685	\N
3451	V	20	225.95	20	2026-09-25 23:25:02.63685	\N
3452	V	20	226.00	20	2026-09-25 23:25:02.63685	\N
3453	V	20	226.00	20	2026-09-25 23:25:02.63685	\N
3454	V	20	226.00	20	2026-09-25 23:25:02.63685	\N
3455	V	20	209.86	20	2026-09-25 23:25:02.63685	\N
3456	V	20	210.32	20	2026-09-25 23:25:02.63685	\N
3457	V	20	211.13	20	2026-09-25 23:25:02.63685	\N
3458	V	20	211.73	20	2026-09-25 23:25:02.63685	\N
3459	V	20	212.08	20	2026-09-25 23:25:02.63685	\N
3460	V	20	228.89	20	2026-09-25 23:25:02.63685	\N
3461	V	20	228.89	20	2026-09-25 23:25:02.63685	\N
3462	V	20	212.90	20	2026-09-25 23:25:02.63685	\N
3463	V	20	213.73	20	2026-09-25 23:25:02.63685	\N
3464	V	20	214.74	20	2026-09-25 23:25:02.63685	\N
3465	V	20	216.34	20	2026-09-25 23:25:02.63685	\N
3466	V	20	218.33	20	2026-09-25 23:25:02.63685	\N
3467	V	20	218.33	20	2026-09-25 23:25:02.63685	\N
3468	V	20	218.33	20	2026-09-25 23:25:02.63685	\N
3469	V	20	202.14	20	2026-09-25 23:25:02.63685	\N
3470	V	20	203.34	20	2026-09-25 23:25:02.63685	\N
3471	V	20	204.44	20	2026-09-25 23:25:02.63685	\N
3472	V	20	205.45	20	2026-09-25 23:25:02.63685	\N
3473	V	20	222.86	20	2026-09-25 23:25:02.63685	\N
3474	V	20	240.31	20	2026-09-25 23:25:02.63685	\N
3475	V	20	240.31	20	2026-09-25 23:25:02.63685	\N
3476	V	20	223.98	20	2026-09-25 23:25:02.63685	\N
3477	V	20	225.44	20	2026-09-25 23:25:02.63685	\N
3478	V	20	226.63	20	2026-09-25 23:25:02.63685	\N
3479	V	20	227.86	20	2026-09-25 23:25:02.63685	\N
3480	V	20	229.31	20	2026-09-25 23:25:02.63685	\N
3481	V	20	247.24	20	2026-09-25 23:25:02.63685	\N
3482	V	20	247.24	20	2026-09-25 23:25:02.63685	\N
3483	V	20	230.15	20	2026-09-25 23:25:02.63685	\N
3484	V	20	231.03	20	2026-09-25 23:25:02.63685	\N
3485	V	20	231.26	20	2026-09-25 23:25:02.63685	\N
3486	V	20	230.83	20	2026-09-25 23:25:02.63685	\N
3487	V	20	248.41	20	2026-09-25 23:25:02.63685	\N
3488	V	20	266.20	20	2026-09-25 23:25:02.63685	\N
3489	V	20	266.20	20	2026-09-25 23:25:02.63685	\N
3490	V	20	248.33	20	2026-09-25 23:25:02.63685	\N
3491	V	20	248.85	20	2026-09-25 23:25:02.63685	\N
3492	V	20	249.80	20	2026-09-25 23:25:02.63685	\N
3493	V	20	250.83	20	2026-09-25 23:25:02.63685	\N
3494	V	20	251.69	20	2026-09-25 23:25:02.63685	\N
3495	V	20	270.00	20	2026-09-25 23:25:02.63685	\N
3496	V	20	270.00	20	2026-09-25 23:25:02.63685	\N
3497	V	20	252.11	20	2026-09-25 23:25:02.63685	\N
3498	V	20	252.60	20	2026-09-25 23:25:02.63685	\N
3499	V	20	253.32	20	2026-09-25 23:25:02.63685	\N
3500	V	20	253.49	20	2026-09-25 23:25:02.63685	\N
3501	V	20	254.08	20	2026-09-25 23:25:02.63685	\N
3502	V	20	272.21	20	2026-09-25 23:25:02.63685	\N
3503	V	20	272.21	20	2026-09-25 23:25:02.63685	\N
3504	V	20	254.18	20	2026-09-25 23:25:02.63685	\N
3505	V	20	254.45	20	2026-09-25 23:25:02.63685	\N
3506	V	20	254.93	20	2026-09-25 23:25:02.63685	\N
3507	V	20	255.32	20	2026-09-25 23:25:02.63685	\N
3508	V	20	255.80	20	2026-09-25 23:25:02.63685	\N
3509	V	20	274.01	20	2026-09-25 23:25:02.63685	\N
3510	V	20	274.01	20	2026-09-25 23:25:02.63685	\N
3511	V	20	255.88	20	2026-09-25 23:25:02.63685	\N
3512	V	20	255.50	20	2026-09-25 23:25:02.63685	\N
3513	V	20	255.27	20	2026-09-25 23:25:02.63685	\N
3514	V	20	255.23	20	2026-09-25 23:25:02.63685	\N
3515	V	20	255.21	20	2026-09-25 23:25:02.63685	\N
3516	V	20	273.77	20	2026-09-25 23:25:02.63685	\N
3517	V	20	273.77	20	2026-09-25 23:25:02.63685	\N
3518	V	20	255.48	20	2026-09-25 23:25:02.63685	\N
3519	V	20	256.12	20	2026-09-25 23:25:02.63685	\N
3520	V	20	256.90	20	2026-09-25 23:25:02.63685	\N
3521	V	20	257.58	20	2026-09-25 23:25:02.63685	\N
3522	V	20	258.43	20	2026-09-25 23:25:02.63685	\N
3523	V	20	277.51	20	2026-09-25 23:25:02.63685	\N
3524	V	20	277.51	20	2026-09-25 23:25:02.63685	\N
3525	V	20	259.45	20	2026-09-25 23:25:02.63685	\N
3526	V	20	260.27	20	2026-09-25 23:25:02.63685	\N
3527	V	20	260.94	20	2026-09-25 23:25:02.63685	\N
3528	V	20	261.58	20	2026-09-25 23:25:02.63685	\N
3529	V	20	262.31	20	2026-09-25 23:25:02.63685	\N
3530	V	20	281.07	20	2026-09-25 23:25:02.63685	\N
3531	V	20	281.07	20	2026-09-25 23:25:02.63685	\N
3532	V	20	263.13	20	2026-09-25 23:25:02.63685	\N
3533	V	20	244.91	20	2026-09-25 23:25:02.63685	\N
3534	V	20	245.07	20	2026-09-25 23:25:02.63685	\N
3535	V	20	245.15	20	2026-09-25 23:25:02.63685	\N
3536	V	20	244.96	20	2026-09-25 23:25:02.63685	\N
3537	V	20	263.48	20	2026-09-25 23:25:02.63685	\N
3538	V	20	263.48	20	2026-09-25 23:25:02.63685	\N
3539	V	20	244.36	20	2026-09-25 23:25:02.63685	\N
3540	V	20	243.92	20	2026-09-25 23:25:02.63685	\N
3541	V	20	243.51	20	2026-09-25 23:25:02.63685	\N
3542	V	20	243.07	20	2026-09-25 23:25:02.63685	\N
3543	V	20	242.49	20	2026-09-25 23:25:02.63685	\N
3544	V	20	260.90	20	2026-09-25 23:25:02.63685	\N
3545	V	20	260.90	20	2026-09-25 23:25:02.63685	\N
3546	V	20	241.93	20	2026-09-25 23:25:02.63685	\N
3547	V	20	241.80	20	2026-09-25 23:25:02.63685	\N
3548	V	20	240.98	20	2026-09-25 23:25:02.63685	\N
3549	V	20	222.04	20	2026-09-25 23:25:02.63685	\N
3550	DIS	20	106.48	20	2026-09-25 23:34:41.63543	\N
3551	V	5	269.94	5	2026-09-25 23:35:27.679216	\N
3552	V	5	202.20	5	2026-09-25 23:35:27.679216	\N
3553	V	5	202.49	5	2026-09-25 23:35:27.679216	\N
3554	V	5	203.78	5	2026-09-25 23:35:27.679216	\N
3555	V	5	205.87	5	2026-09-25 23:35:27.679216	\N
3556	V	5	275.06	5	2026-09-25 23:35:27.679216	\N
3557	V	5	345.03	5	2026-09-25 23:35:27.679216	\N
3558	V	5	277.00	5	2026-09-25 23:35:27.679216	\N
3559	V	5	208.72	5	2026-09-25 23:35:27.679216	\N
3560	V	5	209.01	5	2026-09-25 23:35:27.679216	\N
3561	V	5	210.31	5	2026-09-25 23:35:27.679216	\N
3562	V	5	210.61	5	2026-09-25 23:35:27.679216	\N
3563	V	5	280.02	5	2026-09-25 23:35:27.679216	\N
3564	V	5	348.75	5	2026-09-25 23:35:27.679216	\N
3565	V	5	278.89	5	2026-09-25 23:35:27.679216	\N
3566	V	5	208.41	5	2026-09-25 23:35:27.679216	\N
3567	V	5	206.80	5	2026-09-25 23:35:27.679216	\N
3568	V	5	207.07	5	2026-09-25 23:35:27.679216	\N
3569	V	5	207.47	5	2026-09-25 23:35:27.679216	\N
3570	V	5	274.55	5	2026-09-25 23:35:27.679216	\N
3571	V	5	342.93	5	2026-09-25 23:35:27.679216	\N
3572	V	5	274.27	5	2026-09-25 23:35:27.679216	\N
3573	V	5	204.60	5	2026-09-25 23:35:27.679216	\N
3574	V	5	204.34	5	2026-09-25 23:35:27.679216	\N
3575	V	5	206.70	5	2026-09-25 23:35:27.679216	\N
3576	V	5	207.40	5	2026-09-25 23:35:27.679216	\N
3577	V	5	276.59	5	2026-09-25 23:35:27.679216	\N
3578	V	5	346.06	5	2026-09-25 23:35:27.679216	\N
3579	V	5	277.18	5	2026-09-25 23:35:27.679216	\N
3580	V	5	207.74	5	2026-09-25 23:35:27.679216	\N
3581	V	5	208.23	5	2026-09-25 23:35:27.679216	\N
3582	V	5	208.42	5	2026-09-25 23:35:27.679216	\N
3583	V	5	207.20	5	2026-09-25 23:35:27.679216	\N
3584	V	5	276.21	5	2026-09-25 23:35:27.679216	\N
3585	V	5	344.35	5	2026-09-25 23:35:27.679216	\N
3586	V	5	274.79	5	2026-09-25 23:35:27.679216	\N
3587	V	5	205.41	5	2026-09-25 23:35:27.679216	\N
3588	V	5	204.53	5	2026-09-25 23:35:27.679216	\N
3589	V	5	203.59	5	2026-09-25 23:35:27.679216	\N
3590	V	5	203.45	5	2026-09-25 23:35:27.679216	\N
3591	V	5	270.84	5	2026-09-25 23:35:27.679216	\N
3592	V	5	338.04	5	2026-09-25 23:35:27.679216	\N
3593	V	5	270.66	5	2026-09-25 23:35:27.679216	\N
3594	V	5	202.60	5	2026-09-25 23:35:27.679216	\N
3595	V	5	201.57	5	2026-09-25 23:35:27.679216	\N
3596	V	5	201.96	5	2026-09-25 23:35:27.679216	\N
3597	V	5	202.53	5	2026-09-25 23:35:27.679216	\N
3598	V	5	269.75	5	2026-09-25 23:35:27.679216	\N
3599	V	5	335.75	5	2026-09-25 23:35:27.679216	\N
3600	V	5	268.78	5	2026-09-25 23:35:27.679216	\N
3601	V	5	201.00	5	2026-09-25 23:35:27.679216	\N
3602	V	5	198.37	5	2026-09-25 23:35:27.679216	\N
3603	V	5	195.39	5	2026-09-25 23:35:27.679216	\N
3604	V	5	194.21	5	2026-09-25 23:35:27.679216	\N
3605	V	5	258.96	5	2026-09-25 23:35:27.679216	\N
3606	V	5	324.56	5	2026-09-25 23:35:27.679216	\N
3607	V	5	259.41	5	2026-09-25 23:35:27.679216	\N
3608	V	5	195.17	5	2026-09-25 23:35:27.679216	\N
3609	V	5	196.21	5	2026-09-25 23:35:27.679216	\N
3610	V	5	198.36	5	2026-09-25 23:35:27.679216	\N
3611	V	5	199.52	5	2026-09-25 23:35:27.679216	\N
3612	V	5	199.52	5	2026-09-25 23:35:27.679216	\N
3613	V	5	266.41	5	2026-09-25 23:35:27.679216	\N
3614	V	5	200.55	5	2026-09-25 23:35:27.679216	\N
3615	V	5	133.65	5	2026-09-25 23:35:27.679216	\N
3616	V	5	132.97	5	2026-09-25 23:35:27.679216	\N
3617	V	5	198.89	5	2026-09-25 23:35:27.679216	\N
3618	V	5	197.92	5	2026-09-25 23:35:27.679216	\N
3619	V	5	263.34	5	2026-09-25 23:35:27.679216	\N
3620	V	5	329.59	5	2026-09-25 23:35:27.679216	\N
3621	V	5	263.51	5	2026-09-25 23:35:27.679216	\N
3622	V	5	197.59	5	2026-09-25 23:35:27.679216	\N
3623	V	5	197.04	5	2026-09-25 23:35:27.679216	\N
3624	V	5	196.92	5	2026-09-25 23:35:27.679216	\N
3625	V	5	195.81	5	2026-09-25 23:35:27.679216	\N
3626	V	5	264.94	5	2026-09-25 23:35:27.679216	\N
3627	V	5	334.51	5	2026-09-25 23:35:27.679216	\N
3628	V	5	269.14	5	2026-09-25 23:35:27.679216	\N
3629	V	5	203.84	5	2026-09-25 23:35:27.679216	\N
3630	V	5	208.07	5	2026-09-25 23:35:27.679216	\N
3631	V	5	207.97	5	2026-09-25 23:35:27.679216	\N
3632	V	5	207.28	5	2026-09-25 23:35:27.679216	\N
3633	V	5	276.48	5	2026-09-25 23:35:27.679216	\N
3634	V	5	346.33	5	2026-09-25 23:35:27.679216	\N
3635	V	5	276.96	5	2026-09-25 23:35:27.679216	\N
3636	V	5	207.93	5	2026-09-25 23:35:27.679216	\N
3637	V	5	209.47	5	2026-09-25 23:35:27.679216	\N
3638	V	5	210.94	5	2026-09-25 23:35:27.679216	\N
3639	V	5	212.12	5	2026-09-25 23:35:27.679216	\N
3640	V	5	212.12	5	2026-09-25 23:35:27.679216	\N
3641	V	5	283.12	5	2026-09-25 23:35:27.679216	\N
3642	V	5	212.70	5	2026-09-25 23:35:27.679216	\N
3643	V	5	142.03	5	2026-09-25 23:35:27.679216	\N
3644	V	5	141.92	5	2026-09-25 23:35:27.679216	\N
3645	V	5	212.65	5	2026-09-25 23:35:27.679216	\N
3646	V	5	211.79	5	2026-09-25 23:35:27.679216	\N
3647	V	5	211.79	5	2026-09-25 23:35:27.679216	\N
3648	V	5	281.08	5	2026-09-25 23:35:27.679216	\N
3649	V	5	210.16	5	2026-09-25 23:35:27.679216	\N
3650	V	5	139.44	5	2026-09-25 23:35:27.679216	\N
3651	V	5	140.06	5	2026-09-25 23:35:27.679216	\N
3652	V	5	211.57	5	2026-09-25 23:35:27.679216	\N
3653	V	5	213.45	5	2026-09-25 23:35:27.679216	\N
3654	V	5	283.89	5	2026-09-25 23:35:27.679216	\N
3655	V	5	353.85	5	2026-09-25 23:35:27.679216	\N
3656	V	5	283.09	5	2026-09-25 23:35:27.679216	\N
3657	V	5	211.58	5	2026-09-25 23:35:27.679216	\N
3658	V	5	209.04	5	2026-09-25 23:35:27.679216	\N
3659	V	5	204.17	5	2026-09-25 23:35:27.679216	\N
3660	V	5	200.05	5	2026-09-25 23:35:27.679216	\N
3661	V	5	265.60	5	2026-09-25 23:35:27.679216	\N
3662	V	5	331.26	5	2026-09-25 23:35:27.679216	\N
3663	V	5	262.62	5	2026-09-25 23:35:27.679216	\N
3664	V	5	197.04	5	2026-09-25 23:35:27.679216	\N
3665	V	5	131.21	5	2026-09-25 23:35:27.679216	\N
3666	V	5	130.82	5	2026-09-25 23:35:27.679216	\N
3667	V	5	130.22	5	2026-09-25 23:35:27.679216	\N
3668	V	5	195.49	5	2026-09-25 23:35:27.679216	\N
3669	V	5	260.73	5	2026-09-25 23:35:27.679216	\N
3670	V	5	260.73	5	2026-09-25 23:35:27.679216	\N
3671	V	5	195.56	5	2026-09-25 23:35:27.679216	\N
3672	V	5	196.21	5	2026-09-25 23:35:27.679216	\N
3673	V	5	195.99	5	2026-09-25 23:35:27.679216	\N
3674	V	5	196.15	5	2026-09-25 23:35:27.679216	\N
3675	V	5	262.51	5	2026-09-25 23:35:27.679216	\N
3676	V	5	326.87	5	2026-09-25 23:35:27.679216	\N
3677	V	5	261.17	5	2026-09-25 23:35:27.679216	\N
3678	V	5	196.12	5	2026-09-25 23:35:27.679216	\N
3679	V	5	197.49	5	2026-09-25 23:35:27.679216	\N
3680	V	5	196.92	5	2026-09-25 23:35:27.679216	\N
3681	V	5	198.54	5	2026-09-25 23:35:27.679216	\N
3682	V	5	264.37	5	2026-09-25 23:35:27.679216	\N
3683	V	5	330.69	5	2026-09-25 23:35:27.679216	\N
3684	V	5	263.92	5	2026-09-25 23:35:27.679216	\N
3685	V	5	198.13	5	2026-09-25 23:35:27.679216	\N
3686	V	5	197.26	5	2026-09-25 23:35:27.679216	\N
3687	V	5	197.07	5	2026-09-25 23:35:27.679216	\N
3688	V	5	196.60	5	2026-09-25 23:35:27.679216	\N
3689	V	5	261.43	5	2026-09-25 23:35:27.679216	\N
3690	V	5	324.25	5	2026-09-25 23:35:27.679216	\N
3691	V	5	259.13	5	2026-09-25 23:35:27.679216	\N
3692	V	5	193.50	5	2026-09-25 23:35:27.679216	\N
3693	V	5	127.65	5	2026-09-25 23:35:27.679216	\N
3694	V	5	126.72	5	2026-09-25 23:35:27.679216	\N
3695	V	5	127.96	5	2026-09-25 23:35:27.679216	\N
3696	V	5	191.75	5	2026-09-25 23:35:27.679216	\N
3697	V	5	255.94	5	2026-09-25 23:35:27.679216	\N
3698	V	5	255.94	5	2026-09-25 23:35:27.679216	\N
3699	V	5	192.04	5	2026-09-25 23:35:27.679216	\N
3700	V	5	189.28	5	2026-09-25 23:35:27.679216	\N
3701	V	5	186.94	5	2026-09-25 23:35:27.679216	\N
3702	V	5	185.35	5	2026-09-25 23:35:27.679216	\N
3703	V	5	248.69	5	2026-09-25 23:35:27.679216	\N
3704	V	5	312.71	5	2026-09-25 23:35:27.679216	\N
3705	V	5	251.41	5	2026-09-25 23:35:27.679216	\N
3706	V	5	189.97	5	2026-09-25 23:35:27.679216	\N
3707	V	5	191.47	5	2026-09-25 23:35:27.679216	\N
3708	V	5	192.30	5	2026-09-25 23:35:27.679216	\N
3709	V	5	192.36	5	2026-09-25 23:35:27.679216	\N
3710	V	5	256.32	5	2026-09-25 23:35:27.679216	\N
3711	V	5	319.79	5	2026-09-25 23:35:27.679216	\N
3712	V	5	255.69	5	2026-09-25 23:35:27.679216	\N
3713	V	5	191.53	5	2026-09-25 23:35:27.679216	\N
3714	V	5	190.63	5	2026-09-25 23:35:27.679216	\N
3715	V	5	189.55	5	2026-09-25 23:35:27.679216	\N
3716	V	5	187.87	5	2026-09-25 23:35:27.679216	\N
3717	V	5	249.17	5	2026-09-25 23:35:27.679216	\N
3718	V	5	310.60	5	2026-09-25 23:35:27.679216	\N
3719	V	5	247.41	5	2026-09-25 23:35:27.679216	\N
3720	V	5	184.52	5	2026-09-25 23:35:27.679216	\N
3721	V	5	184.75	5	2026-09-25 23:35:27.679216	\N
3722	V	5	185.14	5	2026-09-25 23:35:27.679216	\N
3723	V	5	183.52	5	2026-09-25 23:35:27.679216	\N
3724	V	5	243.46	5	2026-09-25 23:35:27.679216	\N
3725	V	5	303.78	5	2026-09-25 23:35:27.679216	\N
3726	V	5	241.76	5	2026-09-25 23:35:27.679216	\N
3727	V	5	180.07	5	2026-09-25 23:35:27.679216	\N
3728	V	5	181.15	5	2026-09-25 23:35:27.679216	\N
3729	V	5	181.96	5	2026-09-25 23:35:27.679216	\N
3730	V	5	182.62	5	2026-09-25 23:35:27.679216	\N
3731	V	5	243.73	5	2026-09-25 23:35:27.679216	\N
3732	V	5	302.83	5	2026-09-25 23:35:27.679216	\N
3733	V	5	241.94	5	2026-09-25 23:35:27.679216	\N
3734	V	5	181.19	5	2026-09-25 23:35:27.679216	\N
3735	V	5	180.12	5	2026-09-25 23:35:27.679216	\N
3736	V	5	179.46	5	2026-09-25 23:35:27.679216	\N
3737	V	5	180.06	5	2026-09-25 23:35:27.679216	\N
3738	V	5	240.22	5	2026-09-25 23:35:27.679216	\N
3739	V	5	240.22	5	2026-09-25 23:35:27.679216	\N
3740	V	5	180.31	5	2026-09-25 23:35:27.679216	\N
3741	V	5	119.86	5	2026-09-25 23:35:27.679216	\N
3742	V	5	120.83	5	2026-09-25 23:35:27.679216	\N
3743	V	5	121.18	5	2026-09-25 23:35:27.679216	\N
3744	V	5	182.97	5	2026-09-25 23:35:27.679216	\N
3745	V	5	244.63	5	2026-09-25 23:35:27.679216	\N
3746	V	5	305.50	5	2026-09-25 23:35:27.679216	\N
3747	V	5	244.83	5	2026-09-25 23:35:27.679216	\N
3748	V	5	184.32	5	2026-09-25 23:35:27.679216	\N
3749	V	5	184.41	5	2026-09-25 23:35:27.679216	\N
3750	V	5	185.02	5	2026-09-25 23:35:27.679216	\N
3751	V	5	187.33	5	2026-09-25 23:35:27.679216	\N
3752	V	5	250.35	5	2026-09-25 23:35:27.679216	\N
3753	V	5	313.76	5	2026-09-25 23:35:27.679216	\N
3754	V	5	251.88	5	2026-09-25 23:35:27.679216	\N
3755	V	5	189.61	5	2026-09-25 23:35:27.679216	\N
3756	V	5	189.21	5	2026-09-25 23:35:27.679216	\N
3757	V	5	188.18	5	2026-09-25 23:35:27.679216	\N
3758	V	5	187.03	5	2026-09-25 23:35:27.679216	\N
3759	V	5	248.81	5	2026-09-25 23:35:27.679216	\N
3760	V	5	310.69	5	2026-09-25 23:35:27.679216	\N
3761	V	5	247.91	5	2026-09-25 23:35:27.679216	\N
3762	V	5	185.92	5	2026-09-25 23:35:27.679216	\N
3763	V	5	185.59	5	2026-09-25 23:35:27.679216	\N
3764	V	5	185.67	5	2026-09-25 23:35:27.679216	\N
3765	V	5	190.76	5	2026-09-25 23:35:27.679216	\N
3766	V	5	256.73	5	2026-09-25 23:35:27.679216	\N
3767	V	5	322.34	5	2026-09-25 23:35:27.679216	\N
3768	V	5	260.41	5	2026-09-25 23:35:27.679216	\N
3769	V	5	198.55	5	2026-09-25 23:35:27.679216	\N
3770	V	5	196.94	5	2026-09-25 23:35:27.679216	\N
3771	V	5	195.38	5	2026-09-25 23:35:27.679216	\N
3772	V	5	193.54	5	2026-09-25 23:35:27.679216	\N
3773	V	5	257.79	5	2026-09-25 23:35:27.679216	\N
3774	V	5	321.55	5	2026-09-25 23:35:27.679216	\N
3775	V	5	256.18	5	2026-09-25 23:35:27.679216	\N
3776	V	5	191.77	5	2026-09-25 23:35:27.679216	\N
3777	V	5	192.79	5	2026-09-25 23:35:27.679216	\N
3778	V	5	193.81	5	2026-09-25 23:35:27.679216	\N
3779	V	5	194.12	5	2026-09-25 23:35:27.679216	\N
3780	V	5	258.62	5	2026-09-25 23:35:27.679216	\N
3781	V	5	323.77	5	2026-09-25 23:35:27.679216	\N
3782	V	5	259.00	5	2026-09-25 23:35:27.679216	\N
3783	V	5	193.72	5	2026-09-25 23:35:27.679216	\N
3784	V	5	196.18	5	2026-09-25 23:35:27.679216	\N
3785	V	5	197.66	5	2026-09-25 23:35:27.679216	\N
3786	V	5	198.66	5	2026-09-25 23:35:27.679216	\N
3787	V	5	264.88	5	2026-09-25 23:35:27.679216	\N
3788	V	5	330.66	5	2026-09-25 23:35:27.679216	\N
3789	V	5	264.13	5	2026-09-25 23:35:27.679216	\N
3790	V	5	198.15	5	2026-09-25 23:35:27.679216	\N
3791	V	5	132.00	5	2026-09-25 23:35:27.679216	\N
3792	V	5	131.07	5	2026-09-25 23:35:27.679216	\N
3793	V	5	130.82	5	2026-09-25 23:35:27.679216	\N
3794	V	5	195.81	5	2026-09-25 23:35:27.679216	\N
3795	V	5	261.08	5	2026-09-25 23:35:27.679216	\N
3796	V	5	261.08	5	2026-09-25 23:35:27.679216	\N
3797	V	5	195.78	5	2026-09-25 23:35:27.679216	\N
3798	V	5	194.82	5	2026-09-25 23:35:27.679216	\N
3799	V	5	193.29	5	2026-09-25 23:35:27.679216	\N
3800	V	5	190.50	5	2026-09-25 23:35:27.679216	\N
3801	V	5	254.53	5	2026-09-25 23:35:27.679216	\N
3802	V	5	319.25	5	2026-09-25 23:35:27.679216	\N
3803	V	5	254.69	5	2026-09-25 23:35:27.679216	\N
3804	V	5	191.23	5	2026-09-25 23:35:27.679216	\N
3805	V	5	192.68	5	2026-09-25 23:35:27.679216	\N
3806	V	5	193.66	5	2026-09-25 23:35:27.679216	\N
3807	V	5	193.54	5	2026-09-25 23:35:27.679216	\N
3808	V	5	257.35	5	2026-09-25 23:35:27.679216	\N
3809	V	5	321.82	5	2026-09-25 23:35:27.679216	\N
3810	V	5	257.89	5	2026-09-25 23:35:27.679216	\N
3811	V	5	192.88	5	2026-09-25 23:35:27.679216	\N
3812	V	5	193.05	5	2026-09-25 23:35:27.679216	\N
3813	V	5	195.87	5	2026-09-25 23:35:27.679216	\N
3814	V	5	197.46	5	2026-09-25 23:35:27.679216	\N
3815	V	5	262.91	5	2026-09-25 23:35:27.679216	\N
3816	V	5	262.91	5	2026-09-25 23:35:27.679216	\N
3817	V	5	198.15	5	2026-09-25 23:35:27.679216	\N
3818	V	5	131.52	5	2026-09-25 23:35:27.679216	\N
3819	V	5	130.77	5	2026-09-25 23:35:27.679216	\N
3820	V	5	131.02	5	2026-09-25 23:35:27.679216	\N
3821	V	5	197.46	5	2026-09-25 23:35:27.679216	\N
3822	V	5	263.57	5	2026-09-25 23:35:27.679216	\N
3823	V	5	330.81	5	2026-09-25 23:35:27.679216	\N
3824	V	5	265.49	5	2026-09-25 23:35:27.679216	\N
3825	V	5	199.80	5	2026-09-25 23:35:27.679216	\N
3826	V	5	201.68	5	2026-09-25 23:35:27.679216	\N
3827	V	5	204.19	5	2026-09-25 23:35:27.679216	\N
3828	V	5	207.16	5	2026-09-25 23:35:27.679216	\N
3829	V	5	279.59	5	2026-09-25 23:35:27.679216	\N
3830	V	5	279.59	5	2026-09-25 23:35:27.679216	\N
3831	V	5	211.26	5	2026-09-25 23:35:27.679216	\N
3832	V	5	142.64	5	2026-09-25 23:35:27.679216	\N
3833	V	5	143.88	5	2026-09-25 23:35:27.679216	\N
3834	V	5	141.89	5	2026-09-25 23:35:27.679216	\N
3835	V	5	211.40	5	2026-09-25 23:35:27.679216	\N
3836	V	5	281.04	5	2026-09-25 23:35:27.679216	\N
3837	V	5	350.83	5	2026-09-25 23:35:27.679216	\N
3838	V	5	279.38	5	2026-09-25 23:35:27.679216	\N
3839	V	5	208.94	5	2026-09-25 23:35:27.679216	\N
3840	V	5	210.98	5	2026-09-25 23:35:27.679216	\N
3841	V	5	212.55	5	2026-09-25 23:35:27.679216	\N
3842	V	5	213.78	5	2026-09-25 23:35:27.679216	\N
3843	V	5	286.81	5	2026-09-25 23:35:27.679216	\N
3844	V	5	358.52	5	2026-09-25 23:35:27.679216	\N
3845	V	5	286.97	5	2026-09-25 23:35:27.679216	\N
3846	V	5	215.77	5	2026-09-25 23:35:27.679216	\N
3847	V	5	216.85	5	2026-09-25 23:35:27.679216	\N
3848	V	5	214.99	5	2026-09-25 23:35:27.679216	\N
3849	V	5	213.96	5	2026-09-25 23:35:27.679216	\N
3850	V	5	284.28	5	2026-09-25 23:35:27.679216	\N
3851	V	5	355.43	5	2026-09-25 23:35:27.679216	\N
3852	V	5	283.32	5	2026-09-25 23:35:27.679216	\N
3853	V	5	212.15	5	2026-09-25 23:35:27.679216	\N
3854	V	5	213.97	5	2026-09-25 23:35:27.679216	\N
3855	V	5	216.97	5	2026-09-25 23:35:27.679216	\N
3856	V	5	219.57	5	2026-09-25 23:35:27.679216	\N
3857	V	5	292.82	5	2026-09-25 23:35:27.679216	\N
3858	V	5	366.05	5	2026-09-25 23:35:27.679216	\N
3859	V	5	293.54	5	2026-09-25 23:35:27.679216	\N
3860	V	5	220.23	5	2026-09-25 23:35:27.679216	\N
3861	V	5	219.61	5	2026-09-25 23:35:27.679216	\N
3862	V	5	220.28	5	2026-09-25 23:35:27.679216	\N
3863	V	5	220.76	5	2026-09-25 23:35:27.679216	\N
3864	V	5	294.85	5	2026-09-25 23:35:27.679216	\N
3865	V	5	367.35	5	2026-09-25 23:35:27.679216	\N
3866	V	5	294.22	5	2026-09-25 23:35:27.679216	\N
3867	V	5	220.30	5	2026-09-25 23:35:27.679216	\N
3868	V	5	218.86	5	2026-09-25 23:35:27.679216	\N
3869	V	5	217.33	5	2026-09-25 23:35:27.679216	\N
3870	V	5	216.71	5	2026-09-25 23:35:27.679216	\N
3871	V	5	289.80	5	2026-09-25 23:35:27.679216	\N
3872	V	5	362.63	5	2026-09-25 23:35:27.679216	\N
3873	V	5	290.37	5	2026-09-25 23:35:27.679216	\N
3874	V	5	217.80	5	2026-09-25 23:35:27.679216	\N
3875	V	5	217.69	5	2026-09-25 23:35:27.679216	\N
3876	V	5	217.45	5	2026-09-25 23:35:27.679216	\N
3877	V	5	217.73	5	2026-09-25 23:35:27.679216	\N
3878	V	5	290.87	5	2026-09-25 23:35:27.679216	\N
3879	V	5	365.08	5	2026-09-25 23:35:27.679216	\N
3880	V	5	293.31	5	2026-09-25 23:35:27.679216	\N
3881	V	5	220.46	5	2026-09-25 23:35:27.679216	\N
3882	V	5	223.84	5	2026-09-25 23:35:27.679216	\N
3883	V	5	227.52	5	2026-09-25 23:35:27.679216	\N
3884	V	5	230.09	5	2026-09-25 23:35:27.679216	\N
3885	V	5	306.02	5	2026-09-25 23:35:27.679216	\N
3886	V	5	382.34	5	2026-09-25 23:35:27.679216	\N
3887	V	5	305.86	5	2026-09-25 23:35:27.679216	\N
3888	V	5	229.03	5	2026-09-25 23:35:27.679216	\N
3889	V	5	228.13	5	2026-09-25 23:35:27.679216	\N
3890	V	5	226.73	5	2026-09-25 23:35:27.679216	\N
3891	V	5	226.09	5	2026-09-25 23:35:27.679216	\N
3892	V	5	301.84	5	2026-09-25 23:35:27.679216	\N
3893	V	5	376.85	5	2026-09-25 23:35:27.679216	\N
3894	V	5	300.98	5	2026-09-25 23:35:27.679216	\N
3895	V	5	226.44	5	2026-09-25 23:35:27.679216	\N
3896	V	5	150.76	5	2026-09-25 23:35:27.679216	\N
3897	V	5	148.74	5	2026-09-25 23:35:27.679216	\N
3898	V	5	147.21	5	2026-09-25 23:35:27.679216	\N
3899	V	5	220.65	5	2026-09-25 23:35:27.679216	\N
3900	V	5	294.74	5	2026-09-25 23:35:27.679216	\N
3901	V	5	294.74	5	2026-09-25 23:35:27.679216	\N
3902	V	5	221.01	5	2026-09-25 23:35:27.679216	\N
3903	V	5	222.59	5	2026-09-25 23:35:27.679216	\N
3904	V	5	224.27	5	2026-09-25 23:35:27.679216	\N
3905	V	5	224.37	5	2026-09-25 23:35:27.679216	\N
3906	V	5	298.35	5	2026-09-25 23:35:27.679216	\N
3907	V	5	372.01	5	2026-09-25 23:35:27.679216	\N
3908	V	5	296.95	5	2026-09-25 23:35:27.679216	\N
3909	V	5	221.83	5	2026-09-25 23:35:27.679216	\N
3910	V	5	221.63	5	2026-09-25 23:35:27.679216	\N
3911	V	5	220.06	5	2026-09-25 23:35:27.679216	\N
3912	V	5	146.40	5	2026-09-25 23:35:27.679216	\N
3913	V	20	240.93	20	2026-09-25 23:35:27.723085	\N
3914	V	20	241.16	20	2026-09-25 23:35:27.723085	\N
3915	V	20	241.64	20	2026-09-25 23:35:27.723085	\N
3916	V	20	242.18	20	2026-09-25 23:35:27.723085	\N
3917	V	20	242.08	20	2026-09-25 23:35:27.723085	\N
3918	V	20	259.18	20	2026-09-25 23:35:27.723085	\N
3919	V	20	259.18	20	2026-09-25 23:35:27.723085	\N
3920	V	20	242.17	20	2026-09-25 23:35:27.723085	\N
3921	V	20	242.32	20	2026-09-25 23:35:27.723085	\N
3922	V	20	242.29	20	2026-09-25 23:35:27.723085	\N
3923	V	20	242.26	20	2026-09-25 23:35:27.723085	\N
3924	V	20	242.07	20	2026-09-25 23:35:27.723085	\N
3925	V	20	259.44	20	2026-09-25 23:35:27.723085	\N
3926	V	20	259.44	20	2026-09-25 23:35:27.723085	\N
3927	V	20	241.97	20	2026-09-25 23:35:27.723085	\N
3928	V	20	241.74	20	2026-09-25 23:35:27.723085	\N
3929	V	20	241.52	20	2026-09-25 23:35:27.723085	\N
3930	V	20	241.23	20	2026-09-25 23:35:27.723085	\N
3931	V	20	241.30	20	2026-09-25 23:35:27.723085	\N
3932	V	20	258.34	20	2026-09-25 23:35:27.723085	\N
3933	V	20	258.34	20	2026-09-25 23:35:27.723085	\N
3934	V	20	241.17	20	2026-09-25 23:35:27.723085	\N
3935	V	20	240.60	20	2026-09-25 23:35:27.723085	\N
3936	V	20	240.33	20	2026-09-25 23:35:27.723085	\N
3937	V	20	240.56	20	2026-09-25 23:35:27.723085	\N
3938	V	20	240.31	20	2026-09-25 23:35:27.723085	\N
3939	V	20	257.12	20	2026-09-25 23:35:27.723085	\N
3940	V	20	257.12	20	2026-09-25 23:35:27.723085	\N
3941	V	20	239.89	20	2026-09-25 23:35:27.723085	\N
3942	V	20	239.28	20	2026-09-25 23:35:27.723085	\N
3943	V	20	238.96	20	2026-09-25 23:35:27.723085	\N
3944	V	20	238.60	20	2026-09-25 23:35:27.723085	\N
3945	V	20	238.04	20	2026-09-25 23:35:27.723085	\N
3946	V	20	254.54	20	2026-09-25 23:35:27.723085	\N
3947	V	20	254.54	20	2026-09-25 23:35:27.723085	\N
3948	V	20	237.15	20	2026-09-25 23:35:27.723085	\N
3949	V	20	236.09	20	2026-09-25 23:35:27.723085	\N
3950	V	20	235.08	20	2026-09-25 23:35:27.723085	\N
3951	V	20	234.04	20	2026-09-25 23:35:27.723085	\N
3952	V	20	233.19	20	2026-09-25 23:35:27.723085	\N
3953	V	20	249.59	20	2026-09-25 23:35:27.723085	\N
3954	V	20	249.59	20	2026-09-25 23:35:27.723085	\N
3955	V	20	232.74	20	2026-09-25 23:35:27.723085	\N
3956	V	20	232.19	20	2026-09-25 23:35:27.723085	\N
3957	V	20	231.92	20	2026-09-25 23:35:27.723085	\N
3958	V	20	231.76	20	2026-09-25 23:35:27.723085	\N
3959	V	20	214.96	20	2026-09-25 23:35:27.723085	\N
3960	V	20	231.68	20	2026-09-25 23:35:27.723085	\N
3961	V	20	231.68	20	2026-09-25 23:35:27.723085	\N
3962	V	20	214.94	20	2026-09-25 23:35:27.723085	\N
3963	V	20	214.51	20	2026-09-25 23:35:27.723085	\N
3964	V	20	214.05	20	2026-09-25 23:35:27.723085	\N
3965	V	20	213.72	20	2026-09-25 23:35:27.723085	\N
3966	V	20	213.58	20	2026-09-25 23:35:27.723085	\N
3967	V	20	230.14	20	2026-09-25 23:35:27.723085	\N
3968	V	20	230.14	20	2026-09-25 23:35:27.723085	\N
3969	V	20	213.85	20	2026-09-25 23:35:27.723085	\N
3970	V	20	214.14	20	2026-09-25 23:35:27.723085	\N
3971	V	20	214.26	20	2026-09-25 23:35:27.723085	\N
3972	V	20	214.35	20	2026-09-25 23:35:27.723085	\N
3973	V	20	215.24	20	2026-09-25 23:35:27.723085	\N
3974	V	20	232.63	20	2026-09-25 23:35:27.723085	\N
3975	V	20	232.63	20	2026-09-25 23:35:27.723085	\N
3976	V	20	216.16	20	2026-09-25 23:35:27.723085	\N
3977	V	20	216.78	20	2026-09-25 23:35:27.723085	\N
3978	V	20	217.35	20	2026-09-25 23:35:27.723085	\N
3979	V	20	234.57	20	2026-09-25 23:35:27.723085	\N
3980	V	20	235.15	20	2026-09-25 23:35:27.723085	\N
3981	V	20	252.61	20	2026-09-25 23:35:27.723085	\N
3982	V	20	252.61	20	2026-09-25 23:35:27.723085	\N
3983	V	20	236.09	20	2026-09-25 23:35:27.723085	\N
3984	V	20	237.21	20	2026-09-25 23:35:27.723085	\N
3985	V	20	238.40	20	2026-09-25 23:35:27.723085	\N
3986	V	20	239.80	20	2026-09-25 23:35:27.723085	\N
3987	V	20	223.24	20	2026-09-25 23:35:27.723085	\N
3988	V	20	240.99	20	2026-09-25 23:35:27.723085	\N
3989	V	20	240.99	20	2026-09-25 23:35:27.723085	\N
3990	V	20	224.65	20	2026-09-25 23:35:27.723085	\N
3991	V	20	226.05	20	2026-09-25 23:35:27.723085	\N
3992	V	20	227.45	20	2026-09-25 23:35:27.723085	\N
3993	V	20	227.70	20	2026-09-25 23:35:27.723085	\N
3994	V	20	210.31	20	2026-09-25 23:35:27.723085	\N
3995	V	20	227.64	20	2026-09-25 23:35:27.723085	\N
3996	V	20	227.64	20	2026-09-25 23:35:27.723085	\N
3997	V	20	210.29	20	2026-09-25 23:35:27.723085	\N
3998	V	20	210.72	20	2026-09-25 23:35:27.723085	\N
3999	V	20	211.38	20	2026-09-25 23:35:27.723085	\N
4000	V	20	211.88	20	2026-09-25 23:35:27.723085	\N
4001	V	20	212.03	20	2026-09-25 23:35:27.723085	\N
4002	V	20	229.51	20	2026-09-25 23:35:27.723085	\N
4003	V	20	229.51	20	2026-09-25 23:35:27.723085	\N
4004	V	20	211.91	20	2026-09-25 23:35:27.723085	\N
4005	V	20	211.40	20	2026-09-25 23:35:27.723085	\N
4006	V	20	210.04	20	2026-09-25 23:35:27.723085	\N
4007	V	20	226.50	20	2026-09-25 23:35:27.723085	\N
4008	V	20	225.13	20	2026-09-25 23:35:27.723085	\N
4009	V	20	241.55	20	2026-09-25 23:35:27.723085	\N
4010	V	20	241.55	20	2026-09-25 23:35:27.723085	\N
4011	V	20	223.82	20	2026-09-25 23:35:27.723085	\N
4012	V	20	206.14	20	2026-09-25 23:35:27.723085	\N
4013	V	20	204.89	20	2026-09-25 23:35:27.723085	\N
4014	V	20	221.16	20	2026-09-25 23:35:27.723085	\N
4015	V	20	220.15	20	2026-09-25 23:35:27.723085	\N
4016	V	20	236.46	20	2026-09-25 23:35:27.723085	\N
4017	V	20	236.46	20	2026-09-25 23:35:27.723085	\N
4018	V	20	218.77	20	2026-09-25 23:35:27.723085	\N
4019	V	20	217.32	20	2026-09-25 23:35:27.723085	\N
4020	V	20	215.78	20	2026-09-25 23:35:27.723085	\N
4021	V	20	214.52	20	2026-09-25 23:35:27.723085	\N
4022	V	20	213.62	20	2026-09-25 23:35:27.723085	\N
4023	V	20	229.71	20	2026-09-25 23:35:27.723085	\N
4024	V	20	229.71	20	2026-09-25 23:35:27.723085	\N
4025	V	20	212.56	20	2026-09-25 23:35:27.723085	\N
4026	V	20	212.85	20	2026-09-25 23:35:27.723085	\N
4027	V	20	212.84	20	2026-09-25 23:35:27.723085	\N
4028	V	20	212.95	20	2026-09-25 23:35:27.723085	\N
4029	V	20	212.99	20	2026-09-25 23:35:27.723085	\N
4030	V	20	229.57	20	2026-09-25 23:35:27.723085	\N
4031	V	20	229.57	20	2026-09-25 23:35:27.723085	\N
4032	V	20	229.57	20	2026-09-25 23:35:27.723085	\N
4033	V	20	229.56	20	2026-09-25 23:35:27.723085	\N
4034	V	20	229.70	20	2026-09-25 23:35:27.723085	\N
4035	V	20	229.85	20	2026-09-25 23:35:27.723085	\N
4036	V	20	229.75	20	2026-09-25 23:35:27.723085	\N
4037	V	20	245.45	20	2026-09-25 23:35:27.723085	\N
4038	V	20	245.45	20	2026-09-25 23:35:27.723085	\N
4039	V	20	229.03	20	2026-09-25 23:35:27.723085	\N
4040	V	20	212.76	20	2026-09-25 23:35:27.723085	\N
4041	V	20	212.39	20	2026-09-25 23:35:27.723085	\N
4042	V	20	211.82	20	2026-09-25 23:35:27.723085	\N
4043	V	20	211.67	20	2026-09-25 23:35:27.723085	\N
4044	V	20	227.72	20	2026-09-25 23:35:27.723085	\N
4045	V	20	227.72	20	2026-09-25 23:35:27.723085	\N
4046	V	20	211.03	20	2026-09-25 23:35:27.723085	\N
4047	V	20	209.91	20	2026-09-25 23:35:27.723085	\N
4048	V	20	208.77	20	2026-09-25 23:35:27.723085	\N
4049	V	20	207.96	20	2026-09-25 23:35:27.723085	\N
4050	V	20	207.22	20	2026-09-25 23:35:27.723085	\N
4051	V	20	223.22	20	2026-09-25 23:35:27.723085	\N
4052	V	20	223.22	20	2026-09-25 23:35:27.723085	\N
4053	V	20	206.95	20	2026-09-25 23:35:27.723085	\N
4054	V	20	206.56	20	2026-09-25 23:35:27.723085	\N
4055	V	20	206.14	20	2026-09-25 23:35:27.723085	\N
4056	V	20	205.96	20	2026-09-25 23:35:27.723085	\N
4057	V	20	206.24	20	2026-09-25 23:35:27.723085	\N
4058	V	20	222.11	20	2026-09-25 23:35:27.723085	\N
4059	V	20	222.11	20	2026-09-25 23:35:27.723085	\N
4060	V	20	222.11	20	2026-09-25 23:35:27.723085	\N
4061	V	20	221.93	20	2026-09-25 23:35:27.723085	\N
4062	V	20	221.64	20	2026-09-25 23:35:27.723085	\N
4063	V	20	221.14	20	2026-09-25 23:35:27.723085	\N
4064	V	20	220.42	20	2026-09-25 23:35:27.723085	\N
4065	V	20	235.78	20	2026-09-25 23:35:27.723085	\N
4066	V	20	235.78	20	2026-09-25 23:35:27.723085	\N
4067	V	20	220.45	20	2026-09-25 23:35:27.723085	\N
4068	V	20	220.60	20	2026-09-25 23:35:27.723085	\N
4069	V	20	220.37	20	2026-09-25 23:35:27.723085	\N
4070	V	20	219.48	20	2026-09-25 23:35:27.723085	\N
4071	V	20	218.46	20	2026-09-25 23:35:27.723085	\N
4072	V	20	233.54	20	2026-09-25 23:35:27.723085	\N
4073	V	20	233.54	20	2026-09-25 23:35:27.723085	\N
4074	V	20	217.52	20	2026-09-25 23:35:27.723085	\N
4075	V	20	216.70	20	2026-09-25 23:35:27.723085	\N
4076	V	20	215.86	20	2026-09-25 23:35:27.723085	\N
4077	V	20	215.12	20	2026-09-25 23:35:27.723085	\N
4078	V	20	214.53	20	2026-09-25 23:35:27.723085	\N
4079	V	20	229.30	20	2026-09-25 23:35:27.723085	\N
4080	V	20	229.30	20	2026-09-25 23:35:27.723085	\N
4081	V	20	213.51	20	2026-09-25 23:35:27.723085	\N
4082	V	20	212.76	20	2026-09-25 23:35:27.723085	\N
4083	V	20	212.43	20	2026-09-25 23:35:27.723085	\N
4084	V	20	212.03	20	2026-09-25 23:35:27.723085	\N
4085	V	20	211.71	20	2026-09-25 23:35:27.723085	\N
4086	V	20	211.71	20	2026-09-25 23:35:27.723085	\N
4087	V	20	211.71	20	2026-09-25 23:35:27.723085	\N
4088	V	20	196.20	20	2026-09-25 23:35:27.723085	\N
4089	V	20	195.95	20	2026-09-25 23:35:27.723085	\N
4090	V	20	196.12	20	2026-09-25 23:35:27.723085	\N
4091	V	20	196.59	20	2026-09-25 23:35:27.723085	\N
4092	V	20	196.92	20	2026-09-25 23:35:27.723085	\N
4093	V	20	212.14	20	2026-09-25 23:35:27.723085	\N
4094	V	20	212.14	20	2026-09-25 23:35:27.723085	\N
4095	V	20	196.92	20	2026-09-25 23:35:27.723085	\N
4096	V	20	197.20	20	2026-09-25 23:35:27.723085	\N
4097	V	20	197.52	20	2026-09-25 23:35:27.723085	\N
4098	V	20	198.04	20	2026-09-25 23:35:27.723085	\N
4099	V	20	199.02	20	2026-09-25 23:35:27.723085	\N
4100	V	20	214.87	20	2026-09-25 23:35:27.723085	\N
4101	V	20	214.87	20	2026-09-25 23:35:27.723085	\N
4102	V	20	199.89	20	2026-09-25 23:35:27.723085	\N
4103	V	20	200.48	20	2026-09-25 23:35:27.723085	\N
4104	V	20	201.05	20	2026-09-25 23:35:27.723085	\N
4105	V	20	201.57	20	2026-09-25 23:35:27.723085	\N
4106	V	20	217.02	20	2026-09-25 23:35:27.723085	\N
4107	V	20	232.49	20	2026-09-25 23:35:27.723085	\N
4108	V	20	232.49	20	2026-09-25 23:35:27.723085	\N
4109	V	20	217.32	20	2026-09-25 23:35:27.723085	\N
4110	V	20	217.68	20	2026-09-25 23:35:27.723085	\N
4111	V	20	217.69	20	2026-09-25 23:35:27.723085	\N
4112	V	20	219.02	20	2026-09-25 23:35:27.723085	\N
4113	V	20	220.30	20	2026-09-25 23:35:27.723085	\N
4114	V	20	236.70	20	2026-09-25 23:35:27.723085	\N
4115	V	20	236.70	20	2026-09-25 23:35:27.723085	\N
4116	V	20	221.23	20	2026-09-25 23:35:27.723085	\N
4117	V	20	222.00	20	2026-09-25 23:35:27.723085	\N
4118	V	20	222.31	20	2026-09-25 23:35:27.723085	\N
4119	V	20	222.49	20	2026-09-25 23:35:27.723085	\N
4120	V	20	222.71	20	2026-09-25 23:35:27.723085	\N
4121	V	20	238.65	20	2026-09-25 23:35:27.723085	\N
4122	V	20	238.65	20	2026-09-25 23:35:27.723085	\N
4123	V	20	222.95	20	2026-09-25 23:35:27.723085	\N
4124	V	20	223.64	20	2026-09-25 23:35:27.723085	\N
4125	V	20	224.40	20	2026-09-25 23:35:27.723085	\N
4126	V	20	224.97	20	2026-09-25 23:35:27.723085	\N
4127	V	20	225.63	20	2026-09-25 23:35:27.723085	\N
4128	V	20	241.91	20	2026-09-25 23:35:27.723085	\N
4129	V	20	241.91	20	2026-09-25 23:35:27.723085	\N
4130	V	20	226.43	20	2026-09-25 23:35:27.723085	\N
4131	V	20	227.60	20	2026-09-25 23:35:27.723085	\N
4132	V	20	227.35	20	2026-09-25 23:35:27.723085	\N
4133	V	20	227.40	20	2026-09-25 23:35:27.723085	\N
4134	V	20	227.55	20	2026-09-25 23:35:27.723085	\N
4135	V	20	244.00	20	2026-09-25 23:35:27.723085	\N
4136	V	20	244.00	20	2026-09-25 23:35:27.723085	\N
4137	V	20	227.65	20	2026-09-25 23:35:27.723085	\N
4138	V	20	211.55	20	2026-09-25 23:35:27.723085	\N
4139	V	20	211.94	20	2026-09-25 23:35:27.723085	\N
4140	V	20	212.25	20	2026-09-25 23:35:27.723085	\N
4141	V	20	212.56	20	2026-09-25 23:35:27.723085	\N
4142	V	20	228.88	20	2026-09-25 23:35:27.723085	\N
4143	V	20	228.88	20	2026-09-25 23:35:27.723085	\N
4144	V	20	212.69	20	2026-09-25 23:35:27.723085	\N
4145	V	20	212.50	20	2026-09-25 23:35:27.723085	\N
4146	V	20	212.35	20	2026-09-25 23:35:27.723085	\N
4147	V	20	211.85	20	2026-09-25 23:35:27.723085	\N
4148	V	20	211.57	20	2026-09-25 23:35:27.723085	\N
4149	V	20	227.75	20	2026-09-25 23:35:27.723085	\N
4150	V	20	227.75	20	2026-09-25 23:35:27.723085	\N
4151	V	20	211.12	20	2026-09-25 23:35:27.723085	\N
4152	V	20	210.60	20	2026-09-25 23:35:27.723085	\N
4153	V	20	210.32	20	2026-09-25 23:35:27.723085	\N
4154	V	20	209.91	20	2026-09-25 23:35:27.723085	\N
4155	V	20	209.42	20	2026-09-25 23:35:27.723085	\N
4156	V	20	225.54	20	2026-09-25 23:35:27.723085	\N
4157	V	20	225.54	20	2026-09-25 23:35:27.723085	\N
4158	V	20	225.54	20	2026-09-25 23:35:27.723085	\N
4159	V	20	225.41	20	2026-09-25 23:35:27.723085	\N
4160	V	20	225.68	20	2026-09-25 23:35:27.723085	\N
4161	V	20	225.95	20	2026-09-25 23:35:27.723085	\N
4162	V	20	226.00	20	2026-09-25 23:35:27.723085	\N
4163	V	20	226.00	20	2026-09-25 23:35:27.723085	\N
4164	V	20	226.00	20	2026-09-25 23:35:27.723085	\N
4165	V	20	209.86	20	2026-09-25 23:35:27.723085	\N
4166	V	20	210.32	20	2026-09-25 23:35:27.723085	\N
4167	V	20	211.13	20	2026-09-25 23:35:27.723085	\N
4168	V	20	211.73	20	2026-09-25 23:35:27.723085	\N
4169	V	20	212.08	20	2026-09-25 23:35:27.723085	\N
4170	V	20	228.89	20	2026-09-25 23:35:27.723085	\N
4171	V	20	228.89	20	2026-09-25 23:35:27.723085	\N
4172	V	20	212.90	20	2026-09-25 23:35:27.723085	\N
4173	V	20	213.73	20	2026-09-25 23:35:27.723085	\N
4174	V	20	214.74	20	2026-09-25 23:35:27.723085	\N
4175	V	20	216.34	20	2026-09-25 23:35:27.723085	\N
4176	V	20	218.33	20	2026-09-25 23:35:27.723085	\N
4177	V	20	218.33	20	2026-09-25 23:35:27.723085	\N
4178	V	20	218.33	20	2026-09-25 23:35:27.723085	\N
4179	V	20	202.14	20	2026-09-25 23:35:27.723085	\N
4180	V	20	203.34	20	2026-09-25 23:35:27.723085	\N
4181	V	20	204.44	20	2026-09-25 23:35:27.723085	\N
4182	V	20	205.45	20	2026-09-25 23:35:27.723085	\N
4183	V	20	222.86	20	2026-09-25 23:35:27.723085	\N
4184	V	20	240.31	20	2026-09-25 23:35:27.723085	\N
4185	V	20	240.31	20	2026-09-25 23:35:27.723085	\N
4186	V	20	223.98	20	2026-09-25 23:35:27.723085	\N
4187	V	20	225.44	20	2026-09-25 23:35:27.723085	\N
4188	V	20	226.63	20	2026-09-25 23:35:27.723085	\N
4189	V	20	227.86	20	2026-09-25 23:35:27.723085	\N
4190	V	20	229.31	20	2026-09-25 23:35:27.723085	\N
4191	V	20	247.24	20	2026-09-25 23:35:27.723085	\N
4192	V	20	247.24	20	2026-09-25 23:35:27.723085	\N
4193	V	20	230.15	20	2026-09-25 23:35:27.723085	\N
4194	V	20	231.03	20	2026-09-25 23:35:27.723085	\N
4195	V	20	231.26	20	2026-09-25 23:35:27.723085	\N
4196	V	20	230.83	20	2026-09-25 23:35:27.723085	\N
4197	V	20	248.41	20	2026-09-25 23:35:27.723085	\N
4198	V	20	266.20	20	2026-09-25 23:35:27.723085	\N
4199	V	20	266.20	20	2026-09-25 23:35:27.723085	\N
4200	V	20	248.33	20	2026-09-25 23:35:27.723085	\N
4201	V	20	248.85	20	2026-09-25 23:35:27.723085	\N
4202	V	20	249.80	20	2026-09-25 23:35:27.723085	\N
4203	V	20	250.83	20	2026-09-25 23:35:27.723085	\N
4204	V	20	251.69	20	2026-09-25 23:35:27.723085	\N
4205	V	20	270.00	20	2026-09-25 23:35:27.723085	\N
4206	V	20	270.00	20	2026-09-25 23:35:27.723085	\N
4207	V	20	252.11	20	2026-09-25 23:35:27.723085	\N
4208	V	20	252.60	20	2026-09-25 23:35:27.723085	\N
4209	V	20	253.32	20	2026-09-25 23:35:27.723085	\N
4210	V	20	253.49	20	2026-09-25 23:35:27.723085	\N
4211	V	20	254.08	20	2026-09-25 23:35:27.723085	\N
4212	V	20	272.21	20	2026-09-25 23:35:27.723085	\N
4213	V	20	272.21	20	2026-09-25 23:35:27.723085	\N
4214	V	20	254.18	20	2026-09-25 23:35:27.723085	\N
4215	V	20	254.45	20	2026-09-25 23:35:27.723085	\N
4216	V	20	254.93	20	2026-09-25 23:35:27.723085	\N
4217	V	20	255.32	20	2026-09-25 23:35:27.723085	\N
4218	V	20	255.80	20	2026-09-25 23:35:27.723085	\N
4219	V	20	274.01	20	2026-09-25 23:35:27.723085	\N
4220	V	20	274.01	20	2026-09-25 23:35:27.723085	\N
4221	V	20	255.88	20	2026-09-25 23:35:27.723085	\N
4222	V	20	255.50	20	2026-09-25 23:35:27.723085	\N
4223	V	20	255.27	20	2026-09-25 23:35:27.723085	\N
4224	V	20	255.23	20	2026-09-25 23:35:27.723085	\N
4225	V	20	255.21	20	2026-09-25 23:35:27.723085	\N
4226	V	20	273.77	20	2026-09-25 23:35:27.723085	\N
4227	V	20	273.77	20	2026-09-25 23:35:27.723085	\N
4228	V	20	255.48	20	2026-09-25 23:35:27.723085	\N
4229	V	20	256.12	20	2026-09-25 23:35:27.723085	\N
4230	V	20	256.90	20	2026-09-25 23:35:27.723085	\N
4231	V	20	257.58	20	2026-09-25 23:35:27.723085	\N
4232	V	20	258.43	20	2026-09-25 23:35:27.723085	\N
4233	V	20	277.51	20	2026-09-25 23:35:27.723085	\N
4234	V	20	277.51	20	2026-09-25 23:35:27.723085	\N
4235	V	20	259.45	20	2026-09-25 23:35:27.723085	\N
4236	V	20	260.27	20	2026-09-25 23:35:27.723085	\N
4237	V	20	260.94	20	2026-09-25 23:35:27.723085	\N
4238	V	20	261.58	20	2026-09-25 23:35:27.723085	\N
4239	V	20	262.31	20	2026-09-25 23:35:27.723085	\N
4240	V	20	281.07	20	2026-09-25 23:35:27.723085	\N
4241	V	20	281.07	20	2026-09-25 23:35:27.723085	\N
4242	V	20	263.13	20	2026-09-25 23:35:27.723085	\N
4243	V	20	244.91	20	2026-09-25 23:35:27.723085	\N
4244	V	20	245.07	20	2026-09-25 23:35:27.723085	\N
4245	V	20	245.15	20	2026-09-25 23:35:27.723085	\N
4246	V	20	244.96	20	2026-09-25 23:35:27.723085	\N
4247	V	20	263.48	20	2026-09-25 23:35:27.723085	\N
4248	V	20	263.48	20	2026-09-25 23:35:27.723085	\N
4249	V	20	244.36	20	2026-09-25 23:35:27.723085	\N
4250	V	20	243.92	20	2026-09-25 23:35:27.723085	\N
4251	V	20	243.51	20	2026-09-25 23:35:27.723085	\N
4252	V	20	243.07	20	2026-09-25 23:35:27.723085	\N
4253	V	20	242.49	20	2026-09-25 23:35:27.723085	\N
4254	V	20	260.90	20	2026-09-25 23:35:27.723085	\N
4255	V	20	260.90	20	2026-09-25 23:35:27.723085	\N
4256	V	20	241.93	20	2026-09-25 23:35:27.723085	\N
4257	V	20	241.80	20	2026-09-25 23:35:27.723085	\N
4258	V	20	240.98	20	2026-09-25 23:35:27.723085	\N
4259	V	20	222.04	20	2026-09-25 23:35:27.723085	\N
4260	DIS	20	105.56	20	2026-10-01 21:52:45.930403	\N
4261	V	5	140.06	5	2026-10-01 21:52:50.544973	\N
4262	V	5	211.57	5	2026-10-01 21:52:50.544973	\N
4263	V	5	213.45	5	2026-10-01 21:52:50.544973	\N
4264	V	5	283.89	5	2026-10-01 21:52:50.544973	\N
4265	V	5	353.85	5	2026-10-01 21:52:50.544973	\N
4266	V	5	283.09	5	2026-10-01 21:52:50.544973	\N
4267	V	5	211.58	5	2026-10-01 21:52:50.544973	\N
4268	V	5	209.04	5	2026-10-01 21:52:50.544973	\N
4269	V	5	204.17	5	2026-10-01 21:52:50.544973	\N
4270	V	5	200.05	5	2026-10-01 21:52:50.544973	\N
4271	V	5	265.60	5	2026-10-01 21:52:50.544973	\N
4272	V	5	331.26	5	2026-10-01 21:52:50.544973	\N
4273	V	5	262.62	5	2026-10-01 21:52:50.544973	\N
4274	V	5	197.04	5	2026-10-01 21:52:50.544973	\N
4275	V	5	131.21	5	2026-10-01 21:52:50.544973	\N
4276	V	5	130.82	5	2026-10-01 21:52:50.544973	\N
4277	V	5	130.22	5	2026-10-01 21:52:50.544973	\N
4278	V	5	195.49	5	2026-10-01 21:52:50.544973	\N
4279	V	5	260.73	5	2026-10-01 21:52:50.544973	\N
4280	V	5	260.73	5	2026-10-01 21:52:50.544973	\N
4281	V	5	195.56	5	2026-10-01 21:52:50.544973	\N
4282	V	5	196.21	5	2026-10-01 21:52:50.544973	\N
4283	V	5	195.99	5	2026-10-01 21:52:50.544973	\N
4284	V	5	196.15	5	2026-10-01 21:52:50.544973	\N
4285	V	5	262.51	5	2026-10-01 21:52:50.544973	\N
4286	V	5	326.87	5	2026-10-01 21:52:50.544973	\N
4287	V	5	261.17	5	2026-10-01 21:52:50.544973	\N
4288	V	5	196.12	5	2026-10-01 21:52:50.544973	\N
4289	V	5	197.49	5	2026-10-01 21:52:50.544973	\N
4290	V	5	196.92	5	2026-10-01 21:52:50.544973	\N
4291	V	5	198.54	5	2026-10-01 21:52:50.544973	\N
4292	V	5	264.37	5	2026-10-01 21:52:50.544973	\N
4293	V	5	330.69	5	2026-10-01 21:52:50.544973	\N
4294	V	5	263.92	5	2026-10-01 21:52:50.544973	\N
4295	V	5	198.13	5	2026-10-01 21:52:50.544973	\N
4296	V	5	197.26	5	2026-10-01 21:52:50.544973	\N
4297	V	5	197.07	5	2026-10-01 21:52:50.544973	\N
4298	V	5	196.60	5	2026-10-01 21:52:50.544973	\N
4299	V	5	261.43	5	2026-10-01 21:52:50.544973	\N
4300	V	5	324.25	5	2026-10-01 21:52:50.544973	\N
4301	V	5	259.13	5	2026-10-01 21:52:50.544973	\N
4302	V	5	193.50	5	2026-10-01 21:52:50.544973	\N
4303	V	5	127.65	5	2026-10-01 21:52:50.544973	\N
4304	V	5	126.72	5	2026-10-01 21:52:50.544973	\N
4305	V	5	127.96	5	2026-10-01 21:52:50.544973	\N
4306	V	5	191.75	5	2026-10-01 21:52:50.544973	\N
4307	V	5	255.94	5	2026-10-01 21:52:50.544973	\N
4308	V	5	255.94	5	2026-10-01 21:52:50.544973	\N
4309	V	5	192.04	5	2026-10-01 21:52:50.544973	\N
4310	V	5	189.28	5	2026-10-01 21:52:50.544973	\N
4311	V	5	186.94	5	2026-10-01 21:52:50.544973	\N
4312	V	5	185.35	5	2026-10-01 21:52:50.544973	\N
4313	V	5	248.69	5	2026-10-01 21:52:50.544973	\N
4314	V	5	312.71	5	2026-10-01 21:52:50.544973	\N
4315	V	5	251.41	5	2026-10-01 21:52:50.544973	\N
4316	V	5	189.97	5	2026-10-01 21:52:50.544973	\N
4317	V	5	191.47	5	2026-10-01 21:52:50.544973	\N
4318	V	5	192.30	5	2026-10-01 21:52:50.544973	\N
4319	V	5	192.36	5	2026-10-01 21:52:50.544973	\N
4320	V	5	256.32	5	2026-10-01 21:52:50.544973	\N
4321	V	5	319.79	5	2026-10-01 21:52:50.544973	\N
4322	V	5	255.69	5	2026-10-01 21:52:50.544973	\N
4323	V	5	191.53	5	2026-10-01 21:52:50.544973	\N
4324	V	5	190.63	5	2026-10-01 21:52:50.544973	\N
4325	V	5	189.55	5	2026-10-01 21:52:50.544973	\N
4326	V	5	187.87	5	2026-10-01 21:52:50.544973	\N
4327	V	5	249.17	5	2026-10-01 21:52:50.544973	\N
4328	V	5	310.60	5	2026-10-01 21:52:50.544973	\N
4329	V	5	247.41	5	2026-10-01 21:52:50.544973	\N
4330	V	5	184.52	5	2026-10-01 21:52:50.544973	\N
4331	V	5	184.75	5	2026-10-01 21:52:50.544973	\N
4332	V	5	185.14	5	2026-10-01 21:52:50.544973	\N
4333	V	5	183.52	5	2026-10-01 21:52:50.544973	\N
4334	V	5	243.46	5	2026-10-01 21:52:50.544973	\N
4335	V	5	303.78	5	2026-10-01 21:52:50.544973	\N
4336	V	5	241.76	5	2026-10-01 21:52:50.544973	\N
4337	V	5	180.07	5	2026-10-01 21:52:50.544973	\N
4338	V	5	181.15	5	2026-10-01 21:52:50.544973	\N
4339	V	5	181.96	5	2026-10-01 21:52:50.544973	\N
4340	V	5	182.62	5	2026-10-01 21:52:50.544973	\N
4341	V	5	243.73	5	2026-10-01 21:52:50.544973	\N
4342	V	5	302.83	5	2026-10-01 21:52:50.544973	\N
4343	V	5	241.94	5	2026-10-01 21:52:50.544973	\N
4344	V	5	181.19	5	2026-10-01 21:52:50.544973	\N
4345	V	5	180.12	5	2026-10-01 21:52:50.544973	\N
4346	V	5	179.46	5	2026-10-01 21:52:50.544973	\N
4347	V	5	180.06	5	2026-10-01 21:52:50.544973	\N
4348	V	5	240.22	5	2026-10-01 21:52:50.544973	\N
4349	V	5	240.22	5	2026-10-01 21:52:50.544973	\N
4350	V	5	180.31	5	2026-10-01 21:52:50.544973	\N
4351	V	5	119.86	5	2026-10-01 21:52:50.544973	\N
4352	V	5	120.83	5	2026-10-01 21:52:50.544973	\N
4353	V	5	121.18	5	2026-10-01 21:52:50.544973	\N
4354	V	5	182.97	5	2026-10-01 21:52:50.544973	\N
4355	V	5	244.63	5	2026-10-01 21:52:50.544973	\N
4356	V	5	305.50	5	2026-10-01 21:52:50.544973	\N
4357	V	5	244.83	5	2026-10-01 21:52:50.544973	\N
4358	V	5	184.32	5	2026-10-01 21:52:50.544973	\N
4359	V	5	184.41	5	2026-10-01 21:52:50.544973	\N
4360	V	5	185.02	5	2026-10-01 21:52:50.544973	\N
4361	V	5	187.33	5	2026-10-01 21:52:50.544973	\N
4362	V	5	250.35	5	2026-10-01 21:52:50.544973	\N
4363	V	5	313.76	5	2026-10-01 21:52:50.544973	\N
4364	V	5	251.88	5	2026-10-01 21:52:50.544973	\N
4365	V	5	189.61	5	2026-10-01 21:52:50.544973	\N
4366	V	5	189.21	5	2026-10-01 21:52:50.544973	\N
4367	V	5	188.18	5	2026-10-01 21:52:50.544973	\N
4368	V	5	187.03	5	2026-10-01 21:52:50.544973	\N
4369	V	5	248.81	5	2026-10-01 21:52:50.544973	\N
4370	V	5	310.69	5	2026-10-01 21:52:50.544973	\N
4371	V	5	247.91	5	2026-10-01 21:52:50.544973	\N
4372	V	5	185.92	5	2026-10-01 21:52:50.544973	\N
4373	V	5	185.59	5	2026-10-01 21:52:50.544973	\N
4374	V	5	185.67	5	2026-10-01 21:52:50.544973	\N
4375	V	5	190.76	5	2026-10-01 21:52:50.544973	\N
4376	V	5	256.73	5	2026-10-01 21:52:50.544973	\N
4377	V	5	322.34	5	2026-10-01 21:52:50.544973	\N
4378	V	5	260.41	5	2026-10-01 21:52:50.544973	\N
4379	V	5	198.55	5	2026-10-01 21:52:50.544973	\N
4380	V	5	196.94	5	2026-10-01 21:52:50.544973	\N
4381	V	5	195.38	5	2026-10-01 21:52:50.544973	\N
4382	V	5	193.54	5	2026-10-01 21:52:50.544973	\N
4383	V	5	257.79	5	2026-10-01 21:52:50.544973	\N
4384	V	5	321.55	5	2026-10-01 21:52:50.544973	\N
4385	V	5	256.18	5	2026-10-01 21:52:50.544973	\N
4386	V	5	191.77	5	2026-10-01 21:52:50.544973	\N
4387	V	5	192.79	5	2026-10-01 21:52:50.544973	\N
4388	V	5	193.81	5	2026-10-01 21:52:50.544973	\N
4389	V	5	194.12	5	2026-10-01 21:52:50.544973	\N
4390	V	5	258.62	5	2026-10-01 21:52:50.544973	\N
4391	V	5	323.77	5	2026-10-01 21:52:50.544973	\N
4392	V	5	259.00	5	2026-10-01 21:52:50.544973	\N
4393	V	5	193.72	5	2026-10-01 21:52:50.544973	\N
4394	V	5	196.18	5	2026-10-01 21:52:50.544973	\N
4395	V	5	197.66	5	2026-10-01 21:52:50.544973	\N
4396	V	5	198.66	5	2026-10-01 21:52:50.544973	\N
4397	V	5	264.88	5	2026-10-01 21:52:50.544973	\N
4398	V	5	330.66	5	2026-10-01 21:52:50.544973	\N
4399	V	5	264.13	5	2026-10-01 21:52:50.544973	\N
4400	V	5	198.15	5	2026-10-01 21:52:50.544973	\N
4401	V	5	132.00	5	2026-10-01 21:52:50.544973	\N
4402	V	5	131.07	5	2026-10-01 21:52:50.544973	\N
4403	V	5	130.82	5	2026-10-01 21:52:50.544973	\N
4404	V	5	195.81	5	2026-10-01 21:52:50.544973	\N
4405	V	5	261.08	5	2026-10-01 21:52:50.544973	\N
4406	V	5	261.08	5	2026-10-01 21:52:50.544973	\N
4407	V	5	195.78	5	2026-10-01 21:52:50.544973	\N
4408	V	5	194.82	5	2026-10-01 21:52:50.544973	\N
4409	V	5	193.29	5	2026-10-01 21:52:50.544973	\N
4410	V	5	190.50	5	2026-10-01 21:52:50.544973	\N
4411	V	5	254.53	5	2026-10-01 21:52:50.544973	\N
4412	V	5	319.25	5	2026-10-01 21:52:50.544973	\N
4413	V	5	254.69	5	2026-10-01 21:52:50.544973	\N
4414	V	5	191.23	5	2026-10-01 21:52:50.544973	\N
4415	V	5	192.68	5	2026-10-01 21:52:50.544973	\N
4416	V	5	193.66	5	2026-10-01 21:52:50.544973	\N
4417	V	5	193.54	5	2026-10-01 21:52:50.544973	\N
4418	V	5	257.35	5	2026-10-01 21:52:50.544973	\N
4419	V	5	321.82	5	2026-10-01 21:52:50.544973	\N
4420	V	5	257.89	5	2026-10-01 21:52:50.544973	\N
4421	V	5	192.88	5	2026-10-01 21:52:50.544973	\N
4422	V	5	193.05	5	2026-10-01 21:52:50.544973	\N
4423	V	5	195.87	5	2026-10-01 21:52:50.544973	\N
4424	V	5	197.46	5	2026-10-01 21:52:50.544973	\N
4425	V	5	262.91	5	2026-10-01 21:52:50.544973	\N
4426	V	5	262.91	5	2026-10-01 21:52:50.544973	\N
4427	V	5	198.15	5	2026-10-01 21:52:50.544973	\N
4428	V	5	131.52	5	2026-10-01 21:52:50.544973	\N
4429	V	5	130.77	5	2026-10-01 21:52:50.544973	\N
4430	V	5	131.02	5	2026-10-01 21:52:50.544973	\N
4431	V	5	197.46	5	2026-10-01 21:52:50.544973	\N
4432	V	5	263.57	5	2026-10-01 21:52:50.544973	\N
4433	V	5	330.81	5	2026-10-01 21:52:50.544973	\N
4434	V	5	265.49	5	2026-10-01 21:52:50.544973	\N
4435	V	5	199.80	5	2026-10-01 21:52:50.544973	\N
4436	V	5	201.68	5	2026-10-01 21:52:50.544973	\N
4437	V	5	204.19	5	2026-10-01 21:52:50.544973	\N
4438	V	5	207.16	5	2026-10-01 21:52:50.544973	\N
4439	V	5	279.59	5	2026-10-01 21:52:50.544973	\N
4440	V	5	279.59	5	2026-10-01 21:52:50.544973	\N
4441	V	5	211.26	5	2026-10-01 21:52:50.544973	\N
4442	V	5	142.64	5	2026-10-01 21:52:50.544973	\N
4443	V	5	143.88	5	2026-10-01 21:52:50.544973	\N
4444	V	5	141.89	5	2026-10-01 21:52:50.544973	\N
4445	V	5	211.40	5	2026-10-01 21:52:50.544973	\N
4446	V	5	281.04	5	2026-10-01 21:52:50.544973	\N
4447	V	5	350.83	5	2026-10-01 21:52:50.544973	\N
4448	V	5	279.38	5	2026-10-01 21:52:50.544973	\N
4449	V	5	208.94	5	2026-10-01 21:52:50.544973	\N
4450	V	5	210.98	5	2026-10-01 21:52:50.544973	\N
4451	V	5	212.55	5	2026-10-01 21:52:50.544973	\N
4452	V	5	213.78	5	2026-10-01 21:52:50.544973	\N
4453	V	5	286.81	5	2026-10-01 21:52:50.544973	\N
4454	V	5	358.52	5	2026-10-01 21:52:50.544973	\N
4455	V	5	286.97	5	2026-10-01 21:52:50.544973	\N
4456	V	5	215.77	5	2026-10-01 21:52:50.544973	\N
4457	V	5	216.85	5	2026-10-01 21:52:50.544973	\N
4458	V	5	214.99	5	2026-10-01 21:52:50.544973	\N
4459	V	5	213.96	5	2026-10-01 21:52:50.544973	\N
4460	V	5	284.28	5	2026-10-01 21:52:50.544973	\N
4461	V	5	355.43	5	2026-10-01 21:52:50.544973	\N
4462	V	5	283.32	5	2026-10-01 21:52:50.544973	\N
4463	V	5	212.15	5	2026-10-01 21:52:50.544973	\N
4464	V	5	213.97	5	2026-10-01 21:52:50.544973	\N
4465	V	5	216.97	5	2026-10-01 21:52:50.544973	\N
4466	V	5	219.57	5	2026-10-01 21:52:50.544973	\N
4467	V	5	292.82	5	2026-10-01 21:52:50.544973	\N
4468	V	5	366.05	5	2026-10-01 21:52:50.544973	\N
4469	V	5	293.54	5	2026-10-01 21:52:50.544973	\N
4470	V	5	220.23	5	2026-10-01 21:52:50.544973	\N
4471	V	5	219.61	5	2026-10-01 21:52:50.544973	\N
4472	V	5	220.28	5	2026-10-01 21:52:50.544973	\N
4473	V	5	220.76	5	2026-10-01 21:52:50.544973	\N
4474	V	5	294.85	5	2026-10-01 21:52:50.544973	\N
4475	V	5	367.35	5	2026-10-01 21:52:50.544973	\N
4476	V	5	294.22	5	2026-10-01 21:52:50.544973	\N
4477	V	5	220.30	5	2026-10-01 21:52:50.544973	\N
4478	V	5	218.86	5	2026-10-01 21:52:50.544973	\N
4479	V	5	217.33	5	2026-10-01 21:52:50.544973	\N
4480	V	5	216.71	5	2026-10-01 21:52:50.544973	\N
4481	V	5	289.80	5	2026-10-01 21:52:50.544973	\N
4482	V	5	362.63	5	2026-10-01 21:52:50.544973	\N
4483	V	5	290.37	5	2026-10-01 21:52:50.544973	\N
4484	V	5	217.80	5	2026-10-01 21:52:50.544973	\N
4485	V	5	217.69	5	2026-10-01 21:52:50.544973	\N
4486	V	5	217.45	5	2026-10-01 21:52:50.544973	\N
4487	V	5	217.73	5	2026-10-01 21:52:50.544973	\N
4488	V	5	290.87	5	2026-10-01 21:52:50.544973	\N
4489	V	5	365.08	5	2026-10-01 21:52:50.544973	\N
4490	V	5	293.31	5	2026-10-01 21:52:50.544973	\N
4491	V	5	220.46	5	2026-10-01 21:52:50.544973	\N
4492	V	5	223.84	5	2026-10-01 21:52:50.544973	\N
4493	V	5	227.52	5	2026-10-01 21:52:50.544973	\N
4494	V	5	230.09	5	2026-10-01 21:52:50.544973	\N
4495	V	5	306.02	5	2026-10-01 21:52:50.544973	\N
4496	V	5	382.34	5	2026-10-01 21:52:50.544973	\N
4497	V	5	305.86	5	2026-10-01 21:52:50.544973	\N
4498	V	5	229.03	5	2026-10-01 21:52:50.544973	\N
4499	V	5	228.13	5	2026-10-01 21:52:50.544973	\N
4500	V	5	226.73	5	2026-10-01 21:52:50.544973	\N
4501	V	5	226.09	5	2026-10-01 21:52:50.544973	\N
4502	V	5	301.84	5	2026-10-01 21:52:50.544973	\N
4503	V	5	376.85	5	2026-10-01 21:52:50.544973	\N
4504	V	5	300.98	5	2026-10-01 21:52:50.544973	\N
4505	V	5	226.44	5	2026-10-01 21:52:50.544973	\N
4506	V	5	150.76	5	2026-10-01 21:52:50.544973	\N
4507	V	5	148.74	5	2026-10-01 21:52:50.544973	\N
4508	V	5	147.21	5	2026-10-01 21:52:50.544973	\N
4509	V	5	220.65	5	2026-10-01 21:52:50.544973	\N
4510	V	5	294.74	5	2026-10-01 21:52:50.544973	\N
4511	V	5	294.74	5	2026-10-01 21:52:50.544973	\N
4512	V	5	221.01	5	2026-10-01 21:52:50.544973	\N
4513	V	5	222.59	5	2026-10-01 21:52:50.544973	\N
4514	V	5	224.27	5	2026-10-01 21:52:50.544973	\N
4515	V	5	224.37	5	2026-10-01 21:52:50.544973	\N
4516	V	5	298.35	5	2026-10-01 21:52:50.544973	\N
4517	V	5	372.01	5	2026-10-01 21:52:50.544973	\N
4518	V	5	296.95	5	2026-10-01 21:52:50.544973	\N
4519	V	5	221.83	5	2026-10-01 21:52:50.544973	\N
4520	V	5	221.63	5	2026-10-01 21:52:50.544973	\N
4521	V	5	220.06	5	2026-10-01 21:52:50.544973	\N
4522	V	5	218.70	5	2026-10-01 21:52:50.544973	\N
4523	V	5	292.30	5	2026-10-01 21:52:50.544973	\N
4524	V	5	365.77	5	2026-10-01 21:52:50.544973	\N
4525	V	5	291.78	5	2026-10-01 21:52:50.544973	\N
4526	V	5	219.38	5	2026-10-01 21:52:50.544973	\N
4527	V	5	220.62	5	2026-10-01 21:52:50.544973	\N
4528	V	5	220.20	5	2026-10-01 21:52:50.544973	\N
4529	V	5	218.59	5	2026-10-01 21:52:50.544973	\N
4530	V	5	218.59	5	2026-10-01 21:52:50.544973	\N
4531	V	20	204.89	20	2026-10-01 21:52:50.581121	\N
4532	V	20	221.16	20	2026-10-01 21:52:50.581121	\N
4533	V	20	220.15	20	2026-10-01 21:52:50.581121	\N
4534	V	20	236.46	20	2026-10-01 21:52:50.581121	\N
4535	V	20	236.46	20	2026-10-01 21:52:50.581121	\N
4536	V	20	218.77	20	2026-10-01 21:52:50.581121	\N
4537	V	20	217.32	20	2026-10-01 21:52:50.581121	\N
4538	V	20	215.78	20	2026-10-01 21:52:50.581121	\N
4539	V	20	214.52	20	2026-10-01 21:52:50.581121	\N
4540	V	20	213.62	20	2026-10-01 21:52:50.581121	\N
4541	V	20	229.71	20	2026-10-01 21:52:50.581121	\N
4542	V	20	229.71	20	2026-10-01 21:52:50.581121	\N
4543	V	20	212.56	20	2026-10-01 21:52:50.581121	\N
4544	V	20	212.85	20	2026-10-01 21:52:50.581121	\N
4545	V	20	212.84	20	2026-10-01 21:52:50.581121	\N
4546	V	20	212.95	20	2026-10-01 21:52:50.581121	\N
4547	V	20	212.99	20	2026-10-01 21:52:50.581121	\N
4548	V	20	229.57	20	2026-10-01 21:52:50.581121	\N
4549	V	20	229.57	20	2026-10-01 21:52:50.581121	\N
4550	V	20	229.57	20	2026-10-01 21:52:50.581121	\N
4551	V	20	229.56	20	2026-10-01 21:52:50.581121	\N
4552	V	20	229.70	20	2026-10-01 21:52:50.581121	\N
4553	V	20	229.85	20	2026-10-01 21:52:50.581121	\N
4554	V	20	229.75	20	2026-10-01 21:52:50.581121	\N
4555	V	20	245.45	20	2026-10-01 21:52:50.581121	\N
4556	V	20	245.45	20	2026-10-01 21:52:50.581121	\N
4557	V	20	229.03	20	2026-10-01 21:52:50.581121	\N
4558	V	20	212.76	20	2026-10-01 21:52:50.581121	\N
4559	V	20	212.39	20	2026-10-01 21:52:50.581121	\N
4560	V	20	211.82	20	2026-10-01 21:52:50.581121	\N
4561	V	20	211.67	20	2026-10-01 21:52:50.581121	\N
4562	V	20	227.72	20	2026-10-01 21:52:50.581121	\N
4563	V	20	227.72	20	2026-10-01 21:52:50.581121	\N
4564	V	20	211.03	20	2026-10-01 21:52:50.581121	\N
4565	V	20	209.91	20	2026-10-01 21:52:50.581121	\N
4566	V	20	208.77	20	2026-10-01 21:52:50.581121	\N
4567	V	20	207.96	20	2026-10-01 21:52:50.581121	\N
4568	V	20	207.22	20	2026-10-01 21:52:50.581121	\N
4569	V	20	223.22	20	2026-10-01 21:52:50.581121	\N
4570	V	20	223.22	20	2026-10-01 21:52:50.581121	\N
4571	V	20	206.95	20	2026-10-01 21:52:50.581121	\N
4572	V	20	206.56	20	2026-10-01 21:52:50.581121	\N
4573	V	20	206.14	20	2026-10-01 21:52:50.581121	\N
4574	V	20	205.96	20	2026-10-01 21:52:50.581121	\N
4575	V	20	206.24	20	2026-10-01 21:52:50.581121	\N
4576	V	20	222.11	20	2026-10-01 21:52:50.581121	\N
4577	V	20	222.11	20	2026-10-01 21:52:50.581121	\N
4578	V	20	222.11	20	2026-10-01 21:52:50.581121	\N
4579	V	20	221.93	20	2026-10-01 21:52:50.581121	\N
4580	V	20	221.64	20	2026-10-01 21:52:50.581121	\N
4581	V	20	221.14	20	2026-10-01 21:52:50.581121	\N
4582	V	20	220.42	20	2026-10-01 21:52:50.581121	\N
4583	V	20	235.78	20	2026-10-01 21:52:50.581121	\N
4584	V	20	235.78	20	2026-10-01 21:52:50.581121	\N
4585	V	20	220.45	20	2026-10-01 21:52:50.581121	\N
4586	V	20	220.60	20	2026-10-01 21:52:50.581121	\N
4587	V	20	220.37	20	2026-10-01 21:52:50.581121	\N
4588	V	20	219.48	20	2026-10-01 21:52:50.581121	\N
4589	V	20	218.46	20	2026-10-01 21:52:50.581121	\N
4590	V	20	233.54	20	2026-10-01 21:52:50.581121	\N
4591	V	20	233.54	20	2026-10-01 21:52:50.581121	\N
4592	V	20	217.52	20	2026-10-01 21:52:50.581121	\N
4593	V	20	216.70	20	2026-10-01 21:52:50.581121	\N
4594	V	20	215.86	20	2026-10-01 21:52:50.581121	\N
4595	V	20	215.12	20	2026-10-01 21:52:50.581121	\N
4596	V	20	214.53	20	2026-10-01 21:52:50.581121	\N
4597	V	20	229.30	20	2026-10-01 21:52:50.581121	\N
4598	V	20	229.30	20	2026-10-01 21:52:50.581121	\N
4599	V	20	213.51	20	2026-10-01 21:52:50.581121	\N
4600	V	20	212.76	20	2026-10-01 21:52:50.581121	\N
4601	V	20	212.43	20	2026-10-01 21:52:50.581121	\N
4602	V	20	212.03	20	2026-10-01 21:52:50.581121	\N
4603	V	20	211.71	20	2026-10-01 21:52:50.581121	\N
4604	V	20	211.71	20	2026-10-01 21:52:50.581121	\N
4605	V	20	211.71	20	2026-10-01 21:52:50.581121	\N
4606	V	20	196.20	20	2026-10-01 21:52:50.581121	\N
4607	V	20	195.95	20	2026-10-01 21:52:50.581121	\N
4608	V	20	196.12	20	2026-10-01 21:52:50.581121	\N
4609	V	20	196.59	20	2026-10-01 21:52:50.581121	\N
4610	V	20	196.92	20	2026-10-01 21:52:50.581121	\N
4611	V	20	212.14	20	2026-10-01 21:52:50.581121	\N
4612	V	20	212.14	20	2026-10-01 21:52:50.581121	\N
4613	V	20	196.92	20	2026-10-01 21:52:50.581121	\N
4614	V	20	197.20	20	2026-10-01 21:52:50.581121	\N
4615	V	20	197.52	20	2026-10-01 21:52:50.581121	\N
4616	V	20	198.04	20	2026-10-01 21:52:50.581121	\N
4617	V	20	199.02	20	2026-10-01 21:52:50.581121	\N
4618	V	20	214.87	20	2026-10-01 21:52:50.581121	\N
4619	V	20	214.87	20	2026-10-01 21:52:50.581121	\N
4620	V	20	199.89	20	2026-10-01 21:52:50.581121	\N
4621	V	20	200.48	20	2026-10-01 21:52:50.581121	\N
4622	V	20	201.05	20	2026-10-01 21:52:50.581121	\N
4623	V	20	201.57	20	2026-10-01 21:52:50.581121	\N
4624	V	20	217.02	20	2026-10-01 21:52:50.581121	\N
4625	V	20	232.49	20	2026-10-01 21:52:50.581121	\N
4626	V	20	232.49	20	2026-10-01 21:52:50.581121	\N
4627	V	20	217.32	20	2026-10-01 21:52:50.581121	\N
4628	V	20	217.68	20	2026-10-01 21:52:50.581121	\N
4629	V	20	217.69	20	2026-10-01 21:52:50.581121	\N
4630	V	20	219.02	20	2026-10-01 21:52:50.581121	\N
4631	V	20	220.30	20	2026-10-01 21:52:50.581121	\N
4632	V	20	236.70	20	2026-10-01 21:52:50.581121	\N
4633	V	20	236.70	20	2026-10-01 21:52:50.581121	\N
4634	V	20	221.23	20	2026-10-01 21:52:50.581121	\N
4635	V	20	222.00	20	2026-10-01 21:52:50.581121	\N
4636	V	20	222.31	20	2026-10-01 21:52:50.581121	\N
4637	V	20	222.49	20	2026-10-01 21:52:50.581121	\N
4638	V	20	222.71	20	2026-10-01 21:52:50.581121	\N
4639	V	20	238.65	20	2026-10-01 21:52:50.581121	\N
4640	V	20	238.65	20	2026-10-01 21:52:50.581121	\N
4641	V	20	222.95	20	2026-10-01 21:52:50.581121	\N
4642	V	20	223.64	20	2026-10-01 21:52:50.581121	\N
4643	V	20	224.40	20	2026-10-01 21:52:50.581121	\N
4644	V	20	224.97	20	2026-10-01 21:52:50.581121	\N
4645	V	20	225.63	20	2026-10-01 21:52:50.581121	\N
4646	V	20	241.91	20	2026-10-01 21:52:50.581121	\N
4647	V	20	241.91	20	2026-10-01 21:52:50.581121	\N
4648	V	20	226.43	20	2026-10-01 21:52:50.581121	\N
4649	V	20	227.60	20	2026-10-01 21:52:50.581121	\N
4650	V	20	227.35	20	2026-10-01 21:52:50.581121	\N
4651	V	20	227.40	20	2026-10-01 21:52:50.581121	\N
4652	V	20	227.55	20	2026-10-01 21:52:50.581121	\N
4653	V	20	244.00	20	2026-10-01 21:52:50.581121	\N
4654	V	20	244.00	20	2026-10-01 21:52:50.581121	\N
4655	V	20	227.65	20	2026-10-01 21:52:50.581121	\N
4656	V	20	211.55	20	2026-10-01 21:52:50.581121	\N
4657	V	20	211.94	20	2026-10-01 21:52:50.581121	\N
4658	V	20	212.25	20	2026-10-01 21:52:50.581121	\N
4659	V	20	212.56	20	2026-10-01 21:52:50.581121	\N
4660	V	20	228.88	20	2026-10-01 21:52:50.581121	\N
4661	V	20	228.88	20	2026-10-01 21:52:50.581121	\N
4662	V	20	212.69	20	2026-10-01 21:52:50.581121	\N
4663	V	20	212.50	20	2026-10-01 21:52:50.581121	\N
4664	V	20	212.35	20	2026-10-01 21:52:50.581121	\N
4665	V	20	211.85	20	2026-10-01 21:52:50.581121	\N
4666	V	20	211.57	20	2026-10-01 21:52:50.581121	\N
4667	V	20	227.75	20	2026-10-01 21:52:50.581121	\N
4668	V	20	227.75	20	2026-10-01 21:52:50.581121	\N
4669	V	20	211.12	20	2026-10-01 21:52:50.581121	\N
4670	V	20	210.60	20	2026-10-01 21:52:50.581121	\N
4671	V	20	210.32	20	2026-10-01 21:52:50.581121	\N
4672	V	20	209.91	20	2026-10-01 21:52:50.581121	\N
4673	V	20	209.42	20	2026-10-01 21:52:50.581121	\N
4674	V	20	225.54	20	2026-10-01 21:52:50.581121	\N
4675	V	20	225.54	20	2026-10-01 21:52:50.581121	\N
4676	V	20	225.54	20	2026-10-01 21:52:50.581121	\N
4677	V	20	225.41	20	2026-10-01 21:52:50.581121	\N
4678	V	20	225.68	20	2026-10-01 21:52:50.581121	\N
4679	V	20	225.95	20	2026-10-01 21:52:50.581121	\N
4680	V	20	226.00	20	2026-10-01 21:52:50.581121	\N
4681	V	20	226.00	20	2026-10-01 21:52:50.581121	\N
4682	V	20	226.00	20	2026-10-01 21:52:50.581121	\N
4683	V	20	209.86	20	2026-10-01 21:52:50.581121	\N
4684	V	20	210.32	20	2026-10-01 21:52:50.581121	\N
4685	V	20	211.13	20	2026-10-01 21:52:50.581121	\N
4686	V	20	211.73	20	2026-10-01 21:52:50.581121	\N
4687	V	20	212.08	20	2026-10-01 21:52:50.581121	\N
4688	V	20	228.89	20	2026-10-01 21:52:50.581121	\N
4689	V	20	228.89	20	2026-10-01 21:52:50.581121	\N
4690	V	20	212.90	20	2026-10-01 21:52:50.581121	\N
4691	V	20	213.73	20	2026-10-01 21:52:50.581121	\N
4692	V	20	214.74	20	2026-10-01 21:52:50.581121	\N
4693	V	20	216.34	20	2026-10-01 21:52:50.581121	\N
4694	V	20	218.33	20	2026-10-01 21:52:50.581121	\N
4695	V	20	218.33	20	2026-10-01 21:52:50.581121	\N
4696	V	20	218.33	20	2026-10-01 21:52:50.581121	\N
4697	V	20	202.14	20	2026-10-01 21:52:50.581121	\N
4698	V	20	203.34	20	2026-10-01 21:52:50.581121	\N
4699	V	20	204.44	20	2026-10-01 21:52:50.581121	\N
4700	V	20	205.45	20	2026-10-01 21:52:50.581121	\N
4701	V	20	222.86	20	2026-10-01 21:52:50.581121	\N
4702	V	20	240.31	20	2026-10-01 21:52:50.581121	\N
4703	V	20	240.31	20	2026-10-01 21:52:50.581121	\N
4704	V	20	223.98	20	2026-10-01 21:52:50.581121	\N
4705	V	20	225.44	20	2026-10-01 21:52:50.581121	\N
4706	V	20	226.63	20	2026-10-01 21:52:50.581121	\N
4707	V	20	227.86	20	2026-10-01 21:52:50.581121	\N
4708	V	20	229.31	20	2026-10-01 21:52:50.581121	\N
4709	V	20	247.24	20	2026-10-01 21:52:50.581121	\N
4710	V	20	247.24	20	2026-10-01 21:52:50.581121	\N
4711	V	20	230.15	20	2026-10-01 21:52:50.581121	\N
4712	V	20	231.03	20	2026-10-01 21:52:50.581121	\N
4713	V	20	231.26	20	2026-10-01 21:52:50.581121	\N
4714	V	20	230.83	20	2026-10-01 21:52:50.581121	\N
4715	V	20	248.41	20	2026-10-01 21:52:50.581121	\N
4716	V	20	266.20	20	2026-10-01 21:52:50.581121	\N
4717	V	20	266.20	20	2026-10-01 21:52:50.581121	\N
4718	V	20	248.33	20	2026-10-01 21:52:50.581121	\N
4719	V	20	248.85	20	2026-10-01 21:52:50.581121	\N
4720	V	20	249.80	20	2026-10-01 21:52:50.581121	\N
4721	V	20	250.83	20	2026-10-01 21:52:50.581121	\N
4722	V	20	251.69	20	2026-10-01 21:52:50.581121	\N
4723	V	20	270.00	20	2026-10-01 21:52:50.581121	\N
4724	V	20	270.00	20	2026-10-01 21:52:50.581121	\N
4725	V	20	252.11	20	2026-10-01 21:52:50.581121	\N
4726	V	20	252.60	20	2026-10-01 21:52:50.581121	\N
4727	V	20	253.32	20	2026-10-01 21:52:50.581121	\N
4728	V	20	253.49	20	2026-10-01 21:52:50.581121	\N
4729	V	20	254.08	20	2026-10-01 21:52:50.581121	\N
4730	V	20	272.21	20	2026-10-01 21:52:50.581121	\N
4731	V	20	272.21	20	2026-10-01 21:52:50.581121	\N
4732	V	20	254.18	20	2026-10-01 21:52:50.581121	\N
4733	V	20	254.45	20	2026-10-01 21:52:50.581121	\N
4734	V	20	254.93	20	2026-10-01 21:52:50.581121	\N
4735	V	20	255.32	20	2026-10-01 21:52:50.581121	\N
4736	V	20	255.80	20	2026-10-01 21:52:50.581121	\N
4737	V	20	274.01	20	2026-10-01 21:52:50.581121	\N
4738	V	20	274.01	20	2026-10-01 21:52:50.581121	\N
4739	V	20	255.88	20	2026-10-01 21:52:50.581121	\N
4740	V	20	255.50	20	2026-10-01 21:52:50.581121	\N
4741	V	20	255.27	20	2026-10-01 21:52:50.581121	\N
4742	V	20	255.23	20	2026-10-01 21:52:50.581121	\N
4743	V	20	255.21	20	2026-10-01 21:52:50.581121	\N
4744	V	20	273.77	20	2026-10-01 21:52:50.581121	\N
4745	V	20	273.77	20	2026-10-01 21:52:50.581121	\N
4746	V	20	255.48	20	2026-10-01 21:52:50.581121	\N
4747	V	20	256.12	20	2026-10-01 21:52:50.581121	\N
4748	V	20	256.90	20	2026-10-01 21:52:50.581121	\N
4749	V	20	257.58	20	2026-10-01 21:52:50.581121	\N
4750	V	20	258.43	20	2026-10-01 21:52:50.581121	\N
4751	V	20	277.51	20	2026-10-01 21:52:50.581121	\N
4752	V	20	277.51	20	2026-10-01 21:52:50.581121	\N
4753	V	20	259.45	20	2026-10-01 21:52:50.581121	\N
4754	V	20	260.27	20	2026-10-01 21:52:50.581121	\N
4755	V	20	260.94	20	2026-10-01 21:52:50.581121	\N
4756	V	20	261.58	20	2026-10-01 21:52:50.581121	\N
4757	V	20	262.31	20	2026-10-01 21:52:50.581121	\N
4758	V	20	281.07	20	2026-10-01 21:52:50.581121	\N
4759	V	20	281.07	20	2026-10-01 21:52:50.581121	\N
4760	V	20	263.13	20	2026-10-01 21:52:50.581121	\N
4761	V	20	244.91	20	2026-10-01 21:52:50.581121	\N
4762	V	20	245.07	20	2026-10-01 21:52:50.581121	\N
4763	V	20	245.15	20	2026-10-01 21:52:50.581121	\N
4764	V	20	244.96	20	2026-10-01 21:52:50.581121	\N
4765	V	20	263.48	20	2026-10-01 21:52:50.581121	\N
4766	V	20	263.48	20	2026-10-01 21:52:50.581121	\N
4767	V	20	244.36	20	2026-10-01 21:52:50.581121	\N
4768	V	20	243.92	20	2026-10-01 21:52:50.581121	\N
4769	V	20	243.51	20	2026-10-01 21:52:50.581121	\N
4770	V	20	243.07	20	2026-10-01 21:52:50.581121	\N
4771	V	20	242.49	20	2026-10-01 21:52:50.581121	\N
4772	V	20	260.90	20	2026-10-01 21:52:50.581121	\N
4773	V	20	260.90	20	2026-10-01 21:52:50.581121	\N
4774	V	20	241.93	20	2026-10-01 21:52:50.581121	\N
4775	V	20	241.80	20	2026-10-01 21:52:50.581121	\N
4776	V	20	240.98	20	2026-10-01 21:52:50.581121	\N
4777	V	20	240.12	20	2026-10-01 21:52:50.581121	\N
4778	V	20	239.76	20	2026-10-01 21:52:50.581121	\N
4779	V	20	258.13	20	2026-10-01 21:52:50.581121	\N
4780	V	20	258.13	20	2026-10-01 21:52:50.581121	\N
4781	V	20	258.13	20	2026-10-01 21:52:50.581121	\N
4782	V	20	258.09	20	2026-10-01 21:52:50.581121	\N
4783	V	20	258.01	20	2026-10-01 21:52:50.581121	\N
4784	V	20	257.62	20	2026-10-01 21:52:50.581121	\N
4785	V	20	239.09	20	2026-10-01 21:52:50.581121	\N
4786	V	5	140.06	5	2026-10-02 20:52:31.479995	\N
4787	V	5	211.57	5	2026-10-02 20:52:31.479995	\N
4788	V	5	213.45	5	2026-10-02 20:52:31.479995	\N
4789	V	5	283.89	5	2026-10-02 20:52:31.479995	\N
4790	V	5	353.85	5	2026-10-02 20:52:31.479995	\N
4791	V	5	283.09	5	2026-10-02 20:52:31.479995	\N
4792	V	5	211.58	5	2026-10-02 20:52:31.479995	\N
4793	V	5	209.04	5	2026-10-02 20:52:31.479995	\N
4794	V	5	204.17	5	2026-10-02 20:52:31.479995	\N
4795	V	5	200.05	5	2026-10-02 20:52:31.479995	\N
4796	V	5	265.60	5	2026-10-02 20:52:31.479995	\N
4797	V	5	331.26	5	2026-10-02 20:52:31.479995	\N
4798	V	5	262.62	5	2026-10-02 20:52:31.479995	\N
4799	V	5	197.04	5	2026-10-02 20:52:31.479995	\N
4800	V	5	131.21	5	2026-10-02 20:52:31.479995	\N
4801	V	5	130.82	5	2026-10-02 20:52:31.479995	\N
4802	V	5	130.22	5	2026-10-02 20:52:31.479995	\N
4803	V	5	195.49	5	2026-10-02 20:52:31.479995	\N
4804	V	5	260.73	5	2026-10-02 20:52:31.479995	\N
4805	V	5	260.73	5	2026-10-02 20:52:31.479995	\N
4806	V	5	195.56	5	2026-10-02 20:52:31.479995	\N
4807	V	5	196.21	5	2026-10-02 20:52:31.479995	\N
4808	V	5	195.99	5	2026-10-02 20:52:31.479995	\N
4809	V	5	196.15	5	2026-10-02 20:52:31.479995	\N
4810	V	5	262.51	5	2026-10-02 20:52:31.479995	\N
4811	V	5	326.87	5	2026-10-02 20:52:31.479995	\N
4812	V	5	261.17	5	2026-10-02 20:52:31.479995	\N
4813	V	5	196.12	5	2026-10-02 20:52:31.479995	\N
4814	V	5	197.49	5	2026-10-02 20:52:31.479995	\N
4815	V	5	196.92	5	2026-10-02 20:52:31.479995	\N
4816	V	5	198.54	5	2026-10-02 20:52:31.479995	\N
4817	V	5	264.37	5	2026-10-02 20:52:31.479995	\N
4818	V	5	330.69	5	2026-10-02 20:52:31.479995	\N
4819	V	5	263.92	5	2026-10-02 20:52:31.479995	\N
4820	V	5	198.13	5	2026-10-02 20:52:31.479995	\N
4821	V	5	197.26	5	2026-10-02 20:52:31.479995	\N
4822	V	5	197.07	5	2026-10-02 20:52:31.479995	\N
4823	V	5	196.60	5	2026-10-02 20:52:31.479995	\N
4824	V	5	261.43	5	2026-10-02 20:52:31.479995	\N
4825	V	5	324.25	5	2026-10-02 20:52:31.479995	\N
4826	V	5	259.13	5	2026-10-02 20:52:31.479995	\N
4827	V	5	193.50	5	2026-10-02 20:52:31.479995	\N
4828	V	5	127.65	5	2026-10-02 20:52:31.479995	\N
4829	V	5	126.72	5	2026-10-02 20:52:31.479995	\N
4830	V	5	127.96	5	2026-10-02 20:52:31.479995	\N
4831	V	5	191.75	5	2026-10-02 20:52:31.479995	\N
4832	V	5	255.94	5	2026-10-02 20:52:31.479995	\N
4833	V	5	255.94	5	2026-10-02 20:52:31.479995	\N
4834	V	5	192.04	5	2026-10-02 20:52:31.479995	\N
4835	V	5	189.28	5	2026-10-02 20:52:31.479995	\N
4836	V	5	186.94	5	2026-10-02 20:52:31.479995	\N
4837	V	5	185.35	5	2026-10-02 20:52:31.479995	\N
4838	V	5	248.69	5	2026-10-02 20:52:31.479995	\N
4839	V	5	312.71	5	2026-10-02 20:52:31.479995	\N
4840	V	5	251.41	5	2026-10-02 20:52:31.479995	\N
4841	V	5	189.97	5	2026-10-02 20:52:31.479995	\N
4842	V	5	191.47	5	2026-10-02 20:52:31.479995	\N
4843	V	5	192.30	5	2026-10-02 20:52:31.479995	\N
4844	V	5	192.36	5	2026-10-02 20:52:31.479995	\N
4845	V	5	256.32	5	2026-10-02 20:52:31.479995	\N
4846	V	5	319.79	5	2026-10-02 20:52:31.479995	\N
4847	V	5	255.69	5	2026-10-02 20:52:31.479995	\N
4848	V	5	191.53	5	2026-10-02 20:52:31.479995	\N
4849	V	5	190.63	5	2026-10-02 20:52:31.479995	\N
4850	V	5	189.55	5	2026-10-02 20:52:31.479995	\N
4851	V	5	187.87	5	2026-10-02 20:52:31.479995	\N
4852	V	5	249.17	5	2026-10-02 20:52:31.479995	\N
4853	V	5	310.60	5	2026-10-02 20:52:31.479995	\N
4854	V	5	247.41	5	2026-10-02 20:52:31.479995	\N
4855	V	5	184.52	5	2026-10-02 20:52:31.479995	\N
4856	V	5	184.75	5	2026-10-02 20:52:31.479995	\N
4857	V	5	185.14	5	2026-10-02 20:52:31.479995	\N
4858	V	5	183.52	5	2026-10-02 20:52:31.479995	\N
4859	V	5	243.46	5	2026-10-02 20:52:31.479995	\N
4860	V	5	303.78	5	2026-10-02 20:52:31.479995	\N
4861	V	5	241.76	5	2026-10-02 20:52:31.479995	\N
4862	V	5	180.07	5	2026-10-02 20:52:31.479995	\N
4863	V	5	181.15	5	2026-10-02 20:52:31.479995	\N
4864	V	5	181.96	5	2026-10-02 20:52:31.479995	\N
4865	V	5	182.62	5	2026-10-02 20:52:31.479995	\N
4866	V	5	243.73	5	2026-10-02 20:52:31.479995	\N
4867	V	5	302.83	5	2026-10-02 20:52:31.479995	\N
4868	V	5	241.94	5	2026-10-02 20:52:31.479995	\N
4869	V	5	181.19	5	2026-10-02 20:52:31.479995	\N
4870	V	5	180.12	5	2026-10-02 20:52:31.479995	\N
4871	V	5	179.46	5	2026-10-02 20:52:31.479995	\N
4872	V	5	180.06	5	2026-10-02 20:52:31.479995	\N
4873	V	5	240.22	5	2026-10-02 20:52:31.479995	\N
4874	V	5	240.22	5	2026-10-02 20:52:31.479995	\N
4875	V	5	180.31	5	2026-10-02 20:52:31.479995	\N
4876	V	5	119.86	5	2026-10-02 20:52:31.479995	\N
4877	V	5	120.83	5	2026-10-02 20:52:31.479995	\N
4878	V	5	121.18	5	2026-10-02 20:52:31.479995	\N
4879	V	5	182.97	5	2026-10-02 20:52:31.479995	\N
4880	V	5	244.63	5	2026-10-02 20:52:31.479995	\N
4881	V	5	305.50	5	2026-10-02 20:52:31.479995	\N
4882	V	5	244.83	5	2026-10-02 20:52:31.479995	\N
4883	V	5	184.32	5	2026-10-02 20:52:31.479995	\N
4884	V	5	184.41	5	2026-10-02 20:52:31.479995	\N
4885	V	5	185.02	5	2026-10-02 20:52:31.479995	\N
4886	V	5	187.33	5	2026-10-02 20:52:31.479995	\N
4887	V	5	250.35	5	2026-10-02 20:52:31.479995	\N
4888	V	5	313.76	5	2026-10-02 20:52:31.479995	\N
4889	V	5	251.88	5	2026-10-02 20:52:31.479995	\N
4890	V	5	189.61	5	2026-10-02 20:52:31.479995	\N
4891	V	5	189.21	5	2026-10-02 20:52:31.479995	\N
4892	V	5	188.18	5	2026-10-02 20:52:31.479995	\N
4893	V	5	187.03	5	2026-10-02 20:52:31.479995	\N
4894	V	5	248.81	5	2026-10-02 20:52:31.479995	\N
4895	V	5	310.69	5	2026-10-02 20:52:31.479995	\N
4896	V	5	247.91	5	2026-10-02 20:52:31.479995	\N
4897	V	5	185.92	5	2026-10-02 20:52:31.479995	\N
4898	V	5	185.59	5	2026-10-02 20:52:31.479995	\N
4899	V	5	185.67	5	2026-10-02 20:52:31.479995	\N
4900	V	5	190.76	5	2026-10-02 20:52:31.479995	\N
4901	V	5	256.73	5	2026-10-02 20:52:31.479995	\N
4902	V	5	322.34	5	2026-10-02 20:52:31.479995	\N
4903	V	5	260.41	5	2026-10-02 20:52:31.479995	\N
4904	V	5	198.55	5	2026-10-02 20:52:31.479995	\N
4905	V	5	196.94	5	2026-10-02 20:52:31.479995	\N
4906	V	5	195.38	5	2026-10-02 20:52:31.479995	\N
4907	V	5	193.54	5	2026-10-02 20:52:31.479995	\N
4908	V	5	257.79	5	2026-10-02 20:52:31.479995	\N
4909	V	5	321.55	5	2026-10-02 20:52:31.479995	\N
4910	V	5	256.18	5	2026-10-02 20:52:31.479995	\N
4911	V	5	191.77	5	2026-10-02 20:52:31.479995	\N
4912	V	5	192.79	5	2026-10-02 20:52:31.479995	\N
4913	V	5	193.81	5	2026-10-02 20:52:31.479995	\N
4914	V	5	194.12	5	2026-10-02 20:52:31.479995	\N
4915	V	5	258.62	5	2026-10-02 20:52:31.479995	\N
4916	V	5	323.77	5	2026-10-02 20:52:31.479995	\N
4917	V	5	259.00	5	2026-10-02 20:52:31.479995	\N
4918	V	5	193.72	5	2026-10-02 20:52:31.479995	\N
4919	V	5	196.18	5	2026-10-02 20:52:31.479995	\N
4920	V	5	197.66	5	2026-10-02 20:52:31.479995	\N
4921	V	5	198.66	5	2026-10-02 20:52:31.479995	\N
4922	V	5	264.88	5	2026-10-02 20:52:31.479995	\N
4923	V	5	330.66	5	2026-10-02 20:52:31.479995	\N
4924	V	5	264.13	5	2026-10-02 20:52:31.479995	\N
4925	V	5	198.15	5	2026-10-02 20:52:31.479995	\N
4926	V	5	132.00	5	2026-10-02 20:52:31.479995	\N
4927	V	5	131.07	5	2026-10-02 20:52:31.479995	\N
4928	V	5	130.82	5	2026-10-02 20:52:31.479995	\N
4929	V	5	195.81	5	2026-10-02 20:52:31.479995	\N
4930	V	5	261.08	5	2026-10-02 20:52:31.479995	\N
4931	V	5	261.08	5	2026-10-02 20:52:31.479995	\N
4932	V	5	195.78	5	2026-10-02 20:52:31.479995	\N
4933	V	5	194.82	5	2026-10-02 20:52:31.479995	\N
4934	V	5	193.29	5	2026-10-02 20:52:31.479995	\N
4935	V	5	190.50	5	2026-10-02 20:52:31.479995	\N
4936	V	5	254.53	5	2026-10-02 20:52:31.479995	\N
4937	V	5	319.25	5	2026-10-02 20:52:31.479995	\N
4938	V	5	254.69	5	2026-10-02 20:52:31.479995	\N
4939	V	5	191.23	5	2026-10-02 20:52:31.479995	\N
4940	V	5	192.68	5	2026-10-02 20:52:31.479995	\N
4941	V	5	193.66	5	2026-10-02 20:52:31.479995	\N
4942	V	5	193.54	5	2026-10-02 20:52:31.479995	\N
4943	V	5	257.35	5	2026-10-02 20:52:31.479995	\N
4944	V	5	321.82	5	2026-10-02 20:52:31.479995	\N
4945	V	5	257.89	5	2026-10-02 20:52:31.479995	\N
4946	V	5	192.88	5	2026-10-02 20:52:31.479995	\N
4947	V	5	193.05	5	2026-10-02 20:52:31.479995	\N
4948	V	5	195.87	5	2026-10-02 20:52:31.479995	\N
4949	V	5	197.46	5	2026-10-02 20:52:31.479995	\N
4950	V	5	262.91	5	2026-10-02 20:52:31.479995	\N
4951	V	5	262.91	5	2026-10-02 20:52:31.479995	\N
4952	V	5	198.15	5	2026-10-02 20:52:31.479995	\N
4953	V	5	131.52	5	2026-10-02 20:52:31.479995	\N
4954	V	5	130.77	5	2026-10-02 20:52:31.479995	\N
4955	V	5	131.02	5	2026-10-02 20:52:31.479995	\N
4956	V	5	197.46	5	2026-10-02 20:52:31.479995	\N
4957	V	5	263.57	5	2026-10-02 20:52:31.479995	\N
4958	V	5	330.81	5	2026-10-02 20:52:31.479995	\N
4959	V	5	265.49	5	2026-10-02 20:52:31.479995	\N
4960	V	5	199.80	5	2026-10-02 20:52:31.479995	\N
4961	V	5	201.68	5	2026-10-02 20:52:31.479995	\N
4962	V	5	204.19	5	2026-10-02 20:52:31.479995	\N
4963	V	5	207.16	5	2026-10-02 20:52:31.479995	\N
4964	V	5	279.59	5	2026-10-02 20:52:31.479995	\N
4965	V	5	279.59	5	2026-10-02 20:52:31.479995	\N
4966	V	5	211.26	5	2026-10-02 20:52:31.479995	\N
4967	V	5	142.64	5	2026-10-02 20:52:31.479995	\N
4968	V	5	143.88	5	2026-10-02 20:52:31.479995	\N
4969	V	5	141.89	5	2026-10-02 20:52:31.479995	\N
4970	V	5	211.40	5	2026-10-02 20:52:31.479995	\N
4971	V	5	281.04	5	2026-10-02 20:52:31.479995	\N
4972	V	5	350.83	5	2026-10-02 20:52:31.479995	\N
4973	V	5	279.38	5	2026-10-02 20:52:31.479995	\N
4974	V	5	208.94	5	2026-10-02 20:52:31.479995	\N
4975	V	5	210.98	5	2026-10-02 20:52:31.479995	\N
4976	V	5	212.55	5	2026-10-02 20:52:31.479995	\N
4977	V	5	213.78	5	2026-10-02 20:52:31.479995	\N
4978	V	5	286.81	5	2026-10-02 20:52:31.479995	\N
4979	V	5	358.52	5	2026-10-02 20:52:31.479995	\N
4980	V	5	286.97	5	2026-10-02 20:52:31.479995	\N
4981	V	5	215.77	5	2026-10-02 20:52:31.479995	\N
4982	V	5	216.85	5	2026-10-02 20:52:31.479995	\N
4983	V	5	214.99	5	2026-10-02 20:52:31.479995	\N
4984	V	5	213.96	5	2026-10-02 20:52:31.479995	\N
4985	V	5	284.28	5	2026-10-02 20:52:31.479995	\N
4986	V	5	355.43	5	2026-10-02 20:52:31.479995	\N
4987	V	5	283.32	5	2026-10-02 20:52:31.479995	\N
4988	V	5	212.15	5	2026-10-02 20:52:31.479995	\N
4989	V	5	213.97	5	2026-10-02 20:52:31.479995	\N
4990	V	5	216.97	5	2026-10-02 20:52:31.479995	\N
4991	V	5	219.57	5	2026-10-02 20:52:31.479995	\N
4992	V	5	292.82	5	2026-10-02 20:52:31.479995	\N
4993	V	5	366.05	5	2026-10-02 20:52:31.479995	\N
4994	V	5	293.54	5	2026-10-02 20:52:31.479995	\N
4995	V	5	220.23	5	2026-10-02 20:52:31.479995	\N
4996	V	5	219.61	5	2026-10-02 20:52:31.479995	\N
4997	V	5	220.28	5	2026-10-02 20:52:31.479995	\N
4998	V	5	220.76	5	2026-10-02 20:52:31.479995	\N
4999	V	5	294.85	5	2026-10-02 20:52:31.479995	\N
5000	V	5	367.35	5	2026-10-02 20:52:31.479995	\N
5001	V	5	294.22	5	2026-10-02 20:52:31.479995	\N
5002	V	5	220.30	5	2026-10-02 20:52:31.479995	\N
5003	V	5	218.86	5	2026-10-02 20:52:31.479995	\N
5004	V	5	217.33	5	2026-10-02 20:52:31.479995	\N
5005	V	5	216.71	5	2026-10-02 20:52:31.479995	\N
5006	V	5	289.80	5	2026-10-02 20:52:31.479995	\N
5007	V	5	362.63	5	2026-10-02 20:52:31.479995	\N
5008	V	5	290.37	5	2026-10-02 20:52:31.479995	\N
5009	V	5	217.80	5	2026-10-02 20:52:31.479995	\N
5010	V	5	217.69	5	2026-10-02 20:52:31.479995	\N
5011	V	5	217.45	5	2026-10-02 20:52:31.479995	\N
5012	V	5	217.73	5	2026-10-02 20:52:31.479995	\N
5013	V	5	290.87	5	2026-10-02 20:52:31.479995	\N
5014	V	5	365.08	5	2026-10-02 20:52:31.479995	\N
5015	V	5	293.31	5	2026-10-02 20:52:31.479995	\N
5016	V	5	220.46	5	2026-10-02 20:52:31.479995	\N
5017	V	5	223.84	5	2026-10-02 20:52:31.479995	\N
5018	V	5	227.52	5	2026-10-02 20:52:31.479995	\N
5019	V	5	230.09	5	2026-10-02 20:52:31.479995	\N
5020	V	5	306.02	5	2026-10-02 20:52:31.479995	\N
5021	V	5	382.34	5	2026-10-02 20:52:31.479995	\N
5022	V	5	305.86	5	2026-10-02 20:52:31.479995	\N
5023	V	5	229.03	5	2026-10-02 20:52:31.479995	\N
5024	V	5	228.13	5	2026-10-02 20:52:31.479995	\N
5025	V	5	226.73	5	2026-10-02 20:52:31.479995	\N
5026	V	5	226.09	5	2026-10-02 20:52:31.479995	\N
5027	V	5	301.84	5	2026-10-02 20:52:31.479995	\N
5028	V	5	376.85	5	2026-10-02 20:52:31.479995	\N
5029	V	5	300.98	5	2026-10-02 20:52:31.479995	\N
5030	V	5	226.44	5	2026-10-02 20:52:31.479995	\N
5031	V	5	150.76	5	2026-10-02 20:52:31.479995	\N
5032	V	5	148.74	5	2026-10-02 20:52:31.479995	\N
5033	V	5	147.21	5	2026-10-02 20:52:31.479995	\N
5034	V	5	220.65	5	2026-10-02 20:52:31.479995	\N
5035	V	5	294.74	5	2026-10-02 20:52:31.479995	\N
5036	V	5	294.74	5	2026-10-02 20:52:31.479995	\N
5037	V	5	221.01	5	2026-10-02 20:52:31.479995	\N
5038	V	5	222.59	5	2026-10-02 20:52:31.479995	\N
5039	V	5	224.27	5	2026-10-02 20:52:31.479995	\N
5040	V	5	224.37	5	2026-10-02 20:52:31.479995	\N
5041	V	5	298.35	5	2026-10-02 20:52:31.479995	\N
5042	V	5	372.01	5	2026-10-02 20:52:31.479995	\N
5043	V	5	296.95	5	2026-10-02 20:52:31.479995	\N
5044	V	5	221.83	5	2026-10-02 20:52:31.479995	\N
5045	V	5	221.63	5	2026-10-02 20:52:31.479995	\N
5046	V	5	220.06	5	2026-10-02 20:52:31.479995	\N
5047	V	5	218.70	5	2026-10-02 20:52:31.479995	\N
5048	V	5	292.30	5	2026-10-02 20:52:31.479995	\N
5049	V	5	365.77	5	2026-10-02 20:52:31.479995	\N
5050	V	5	291.78	5	2026-10-02 20:52:31.479995	\N
5051	V	5	219.38	5	2026-10-02 20:52:31.479995	\N
5052	V	5	220.62	5	2026-10-02 20:52:31.479995	\N
5053	V	5	220.20	5	2026-10-02 20:52:31.479995	\N
5054	V	5	218.59	5	2026-10-02 20:52:31.479995	\N
5055	V	5	290.56	5	2026-10-02 20:52:31.479995	\N
5056	V	20	204.89	20	2026-10-02 20:52:31.56662	\N
5057	V	20	221.16	20	2026-10-02 20:52:31.56662	\N
5058	V	20	220.15	20	2026-10-02 20:52:31.56662	\N
5059	V	20	236.46	20	2026-10-02 20:52:31.56662	\N
5060	V	20	236.46	20	2026-10-02 20:52:31.56662	\N
5061	V	20	218.77	20	2026-10-02 20:52:31.56662	\N
5062	V	20	217.32	20	2026-10-02 20:52:31.56662	\N
5063	V	20	215.78	20	2026-10-02 20:52:31.56662	\N
5064	V	20	214.52	20	2026-10-02 20:52:31.56662	\N
5065	V	20	213.62	20	2026-10-02 20:52:31.56662	\N
5066	V	20	229.71	20	2026-10-02 20:52:31.56662	\N
5067	V	20	229.71	20	2026-10-02 20:52:31.56662	\N
5068	V	20	212.56	20	2026-10-02 20:52:31.56662	\N
5069	V	20	212.85	20	2026-10-02 20:52:31.56662	\N
5070	V	20	212.84	20	2026-10-02 20:52:31.56662	\N
5071	V	20	212.95	20	2026-10-02 20:52:31.56662	\N
5072	V	20	212.99	20	2026-10-02 20:52:31.56662	\N
5073	V	20	229.57	20	2026-10-02 20:52:31.56662	\N
5074	V	20	229.57	20	2026-10-02 20:52:31.56662	\N
5075	V	20	229.57	20	2026-10-02 20:52:31.56662	\N
5076	V	20	229.56	20	2026-10-02 20:52:31.56662	\N
5077	V	20	229.70	20	2026-10-02 20:52:31.56662	\N
5078	V	20	229.85	20	2026-10-02 20:52:31.56662	\N
5079	V	20	229.75	20	2026-10-02 20:52:31.56662	\N
5080	V	20	245.45	20	2026-10-02 20:52:31.56662	\N
5081	V	20	245.45	20	2026-10-02 20:52:31.56662	\N
5082	V	20	229.03	20	2026-10-02 20:52:31.56662	\N
5083	V	20	212.76	20	2026-10-02 20:52:31.56662	\N
5084	V	20	212.39	20	2026-10-02 20:52:31.56662	\N
5085	V	20	211.82	20	2026-10-02 20:52:31.56662	\N
5086	V	20	211.67	20	2026-10-02 20:52:31.56662	\N
5087	V	20	227.72	20	2026-10-02 20:52:31.56662	\N
5088	V	20	227.72	20	2026-10-02 20:52:31.56662	\N
5089	V	20	211.03	20	2026-10-02 20:52:31.56662	\N
5090	V	20	209.91	20	2026-10-02 20:52:31.56662	\N
5091	V	20	208.77	20	2026-10-02 20:52:31.56662	\N
5092	V	20	207.96	20	2026-10-02 20:52:31.56662	\N
5093	V	20	207.22	20	2026-10-02 20:52:31.56662	\N
5094	V	20	223.22	20	2026-10-02 20:52:31.56662	\N
5095	V	20	223.22	20	2026-10-02 20:52:31.56662	\N
5096	V	20	206.95	20	2026-10-02 20:52:31.56662	\N
5097	V	20	206.56	20	2026-10-02 20:52:31.56662	\N
5098	V	20	206.14	20	2026-10-02 20:52:31.56662	\N
5099	V	20	205.96	20	2026-10-02 20:52:31.56662	\N
5100	V	20	206.24	20	2026-10-02 20:52:31.56662	\N
5101	V	20	222.11	20	2026-10-02 20:52:31.56662	\N
5102	V	20	222.11	20	2026-10-02 20:52:31.56662	\N
5103	V	20	222.11	20	2026-10-02 20:52:31.56662	\N
5104	V	20	221.93	20	2026-10-02 20:52:31.56662	\N
5105	V	20	221.64	20	2026-10-02 20:52:31.56662	\N
5106	V	20	221.14	20	2026-10-02 20:52:31.56662	\N
5107	V	20	220.42	20	2026-10-02 20:52:31.56662	\N
5108	V	20	235.78	20	2026-10-02 20:52:31.56662	\N
5109	V	20	235.78	20	2026-10-02 20:52:31.56662	\N
5110	V	20	220.45	20	2026-10-02 20:52:31.56662	\N
5111	V	20	220.60	20	2026-10-02 20:52:31.56662	\N
5112	V	20	220.37	20	2026-10-02 20:52:31.56662	\N
5113	V	20	219.48	20	2026-10-02 20:52:31.56662	\N
5114	V	20	218.46	20	2026-10-02 20:52:31.56662	\N
5115	V	20	233.54	20	2026-10-02 20:52:31.56662	\N
5116	V	20	233.54	20	2026-10-02 20:52:31.56662	\N
5117	V	20	217.52	20	2026-10-02 20:52:31.56662	\N
5118	V	20	216.70	20	2026-10-02 20:52:31.56662	\N
5119	V	20	215.86	20	2026-10-02 20:52:31.56662	\N
5120	V	20	215.12	20	2026-10-02 20:52:31.56662	\N
5121	V	20	214.53	20	2026-10-02 20:52:31.56662	\N
5122	V	20	229.30	20	2026-10-02 20:52:31.56662	\N
5123	V	20	229.30	20	2026-10-02 20:52:31.56662	\N
5124	V	20	213.51	20	2026-10-02 20:52:31.56662	\N
5125	V	20	212.76	20	2026-10-02 20:52:31.56662	\N
5126	V	20	212.43	20	2026-10-02 20:52:31.56662	\N
5127	V	20	212.03	20	2026-10-02 20:52:31.56662	\N
5128	V	20	211.71	20	2026-10-02 20:52:31.56662	\N
5129	V	20	211.71	20	2026-10-02 20:52:31.56662	\N
5130	V	20	211.71	20	2026-10-02 20:52:31.56662	\N
5131	V	20	196.20	20	2026-10-02 20:52:31.56662	\N
5132	V	20	195.95	20	2026-10-02 20:52:31.56662	\N
5133	V	20	196.12	20	2026-10-02 20:52:31.56662	\N
5134	V	20	196.59	20	2026-10-02 20:52:31.56662	\N
5135	V	20	196.92	20	2026-10-02 20:52:31.56662	\N
5136	V	20	212.14	20	2026-10-02 20:52:31.56662	\N
5137	V	20	212.14	20	2026-10-02 20:52:31.56662	\N
5138	V	20	196.92	20	2026-10-02 20:52:31.56662	\N
5139	V	20	197.20	20	2026-10-02 20:52:31.56662	\N
5140	V	20	197.52	20	2026-10-02 20:52:31.56662	\N
5141	V	20	198.04	20	2026-10-02 20:52:31.56662	\N
5142	V	20	199.02	20	2026-10-02 20:52:31.56662	\N
5143	V	20	214.87	20	2026-10-02 20:52:31.56662	\N
5144	V	20	214.87	20	2026-10-02 20:52:31.56662	\N
5145	V	20	199.89	20	2026-10-02 20:52:31.56662	\N
5146	V	20	200.48	20	2026-10-02 20:52:31.56662	\N
5147	V	20	201.05	20	2026-10-02 20:52:31.56662	\N
5148	V	20	201.57	20	2026-10-02 20:52:31.56662	\N
5149	V	20	217.02	20	2026-10-02 20:52:31.56662	\N
5150	V	20	232.49	20	2026-10-02 20:52:31.56662	\N
5151	V	20	232.49	20	2026-10-02 20:52:31.56662	\N
5152	V	20	217.32	20	2026-10-02 20:52:31.56662	\N
5153	V	20	217.68	20	2026-10-02 20:52:31.56662	\N
5154	V	20	217.69	20	2026-10-02 20:52:31.56662	\N
5155	V	20	219.02	20	2026-10-02 20:52:31.56662	\N
5156	V	20	220.30	20	2026-10-02 20:52:31.56662	\N
5157	V	20	236.70	20	2026-10-02 20:52:31.56662	\N
5158	V	20	236.70	20	2026-10-02 20:52:31.56662	\N
5159	V	20	221.23	20	2026-10-02 20:52:31.56662	\N
5160	V	20	222.00	20	2026-10-02 20:52:31.56662	\N
5161	V	20	222.31	20	2026-10-02 20:52:31.56662	\N
5162	V	20	222.49	20	2026-10-02 20:52:31.56662	\N
5163	V	20	222.71	20	2026-10-02 20:52:31.56662	\N
5164	V	20	238.65	20	2026-10-02 20:52:31.56662	\N
5165	V	20	238.65	20	2026-10-02 20:52:31.56662	\N
5166	V	20	222.95	20	2026-10-02 20:52:31.56662	\N
5167	V	20	223.64	20	2026-10-02 20:52:31.56662	\N
5168	V	20	224.40	20	2026-10-02 20:52:31.56662	\N
5169	V	20	224.97	20	2026-10-02 20:52:31.56662	\N
5170	V	20	225.63	20	2026-10-02 20:52:31.56662	\N
5171	V	20	241.91	20	2026-10-02 20:52:31.56662	\N
5172	V	20	241.91	20	2026-10-02 20:52:31.56662	\N
5173	V	20	226.43	20	2026-10-02 20:52:31.56662	\N
5174	V	20	227.60	20	2026-10-02 20:52:31.56662	\N
5175	V	20	227.35	20	2026-10-02 20:52:31.56662	\N
5176	V	20	227.40	20	2026-10-02 20:52:31.56662	\N
5177	V	20	227.55	20	2026-10-02 20:52:31.56662	\N
5178	V	20	244.00	20	2026-10-02 20:52:31.56662	\N
5179	V	20	244.00	20	2026-10-02 20:52:31.56662	\N
5180	V	20	227.65	20	2026-10-02 20:52:31.56662	\N
5181	V	20	211.55	20	2026-10-02 20:52:31.56662	\N
5182	V	20	211.94	20	2026-10-02 20:52:31.56662	\N
5183	V	20	212.25	20	2026-10-02 20:52:31.56662	\N
5184	V	20	212.56	20	2026-10-02 20:52:31.56662	\N
5185	V	20	228.88	20	2026-10-02 20:52:31.56662	\N
5186	V	20	228.88	20	2026-10-02 20:52:31.56662	\N
5187	V	20	212.69	20	2026-10-02 20:52:31.56662	\N
5188	V	20	212.50	20	2026-10-02 20:52:31.56662	\N
5189	V	20	212.35	20	2026-10-02 20:52:31.56662	\N
5190	V	20	211.85	20	2026-10-02 20:52:31.56662	\N
5191	V	20	211.57	20	2026-10-02 20:52:31.56662	\N
5192	V	20	227.75	20	2026-10-02 20:52:31.56662	\N
5193	V	20	227.75	20	2026-10-02 20:52:31.56662	\N
5194	V	20	211.12	20	2026-10-02 20:52:31.56662	\N
5195	V	20	210.60	20	2026-10-02 20:52:31.56662	\N
5196	V	20	210.32	20	2026-10-02 20:52:31.56662	\N
5197	V	20	209.91	20	2026-10-02 20:52:31.56662	\N
5198	V	20	209.42	20	2026-10-02 20:52:31.56662	\N
5199	V	20	225.54	20	2026-10-02 20:52:31.56662	\N
5200	V	20	225.54	20	2026-10-02 20:52:31.56662	\N
5201	V	20	225.54	20	2026-10-02 20:52:31.56662	\N
5202	V	20	225.41	20	2026-10-02 20:52:31.56662	\N
5203	V	20	225.68	20	2026-10-02 20:52:31.56662	\N
5204	V	20	225.95	20	2026-10-02 20:52:31.56662	\N
5205	V	20	226.00	20	2026-10-02 20:52:31.56662	\N
5206	V	20	226.00	20	2026-10-02 20:52:31.56662	\N
5207	V	20	226.00	20	2026-10-02 20:52:31.56662	\N
5208	V	20	209.86	20	2026-10-02 20:52:31.56662	\N
5209	V	20	210.32	20	2026-10-02 20:52:31.56662	\N
5210	V	20	211.13	20	2026-10-02 20:52:31.56662	\N
5211	V	20	211.73	20	2026-10-02 20:52:31.56662	\N
5212	V	20	212.08	20	2026-10-02 20:52:31.56662	\N
5213	V	20	228.89	20	2026-10-02 20:52:31.56662	\N
5214	V	20	228.89	20	2026-10-02 20:52:31.56662	\N
5215	V	20	212.90	20	2026-10-02 20:52:31.56662	\N
5216	V	20	213.73	20	2026-10-02 20:52:31.56662	\N
5217	V	20	214.74	20	2026-10-02 20:52:31.56662	\N
5218	V	20	216.34	20	2026-10-02 20:52:31.56662	\N
5219	V	20	218.33	20	2026-10-02 20:52:31.56662	\N
5220	V	20	218.33	20	2026-10-02 20:52:31.56662	\N
5221	V	20	218.33	20	2026-10-02 20:52:31.56662	\N
5222	V	20	202.14	20	2026-10-02 20:52:31.56662	\N
5223	V	20	203.34	20	2026-10-02 20:52:31.56662	\N
5224	V	20	204.44	20	2026-10-02 20:52:31.56662	\N
5225	V	20	205.45	20	2026-10-02 20:52:31.56662	\N
5226	V	20	222.86	20	2026-10-02 20:52:31.56662	\N
5227	V	20	240.31	20	2026-10-02 20:52:31.56662	\N
5228	V	20	240.31	20	2026-10-02 20:52:31.56662	\N
5229	V	20	223.98	20	2026-10-02 20:52:31.56662	\N
5230	V	20	225.44	20	2026-10-02 20:52:31.56662	\N
5231	V	20	226.63	20	2026-10-02 20:52:31.56662	\N
5232	V	20	227.86	20	2026-10-02 20:52:31.56662	\N
5233	V	20	229.31	20	2026-10-02 20:52:31.56662	\N
5234	V	20	247.24	20	2026-10-02 20:52:31.56662	\N
5235	V	20	247.24	20	2026-10-02 20:52:31.56662	\N
5236	V	20	230.15	20	2026-10-02 20:52:31.56662	\N
5237	V	20	231.03	20	2026-10-02 20:52:31.56662	\N
5238	V	20	231.26	20	2026-10-02 20:52:31.56662	\N
5239	V	20	230.83	20	2026-10-02 20:52:31.56662	\N
5240	V	20	248.41	20	2026-10-02 20:52:31.56662	\N
5241	V	20	266.20	20	2026-10-02 20:52:31.56662	\N
5242	V	20	266.20	20	2026-10-02 20:52:31.56662	\N
5243	V	20	248.33	20	2026-10-02 20:52:31.56662	\N
5244	V	20	248.85	20	2026-10-02 20:52:31.56662	\N
5245	V	20	249.80	20	2026-10-02 20:52:31.56662	\N
5246	V	20	250.83	20	2026-10-02 20:52:31.56662	\N
5247	V	20	251.69	20	2026-10-02 20:52:31.56662	\N
5248	V	20	270.00	20	2026-10-02 20:52:31.56662	\N
5249	V	20	270.00	20	2026-10-02 20:52:31.56662	\N
5250	V	20	252.11	20	2026-10-02 20:52:31.56662	\N
5251	V	20	252.60	20	2026-10-02 20:52:31.56662	\N
5252	V	20	253.32	20	2026-10-02 20:52:31.56662	\N
5253	V	20	253.49	20	2026-10-02 20:52:31.56662	\N
5254	V	20	254.08	20	2026-10-02 20:52:31.56662	\N
5255	V	20	272.21	20	2026-10-02 20:52:31.56662	\N
5256	V	20	272.21	20	2026-10-02 20:52:31.56662	\N
5257	V	20	254.18	20	2026-10-02 20:52:31.56662	\N
5258	V	20	254.45	20	2026-10-02 20:52:31.56662	\N
5259	V	20	254.93	20	2026-10-02 20:52:31.56662	\N
5260	V	20	255.32	20	2026-10-02 20:52:31.56662	\N
5261	V	20	255.80	20	2026-10-02 20:52:31.56662	\N
5262	V	20	274.01	20	2026-10-02 20:52:31.56662	\N
5263	V	20	274.01	20	2026-10-02 20:52:31.56662	\N
5264	V	20	255.88	20	2026-10-02 20:52:31.56662	\N
5265	V	20	255.50	20	2026-10-02 20:52:31.56662	\N
5266	V	20	255.27	20	2026-10-02 20:52:31.56662	\N
5267	V	20	255.23	20	2026-10-02 20:52:31.56662	\N
5268	V	20	255.21	20	2026-10-02 20:52:31.56662	\N
5269	V	20	273.77	20	2026-10-02 20:52:31.56662	\N
5270	V	20	273.77	20	2026-10-02 20:52:31.56662	\N
5271	V	20	255.48	20	2026-10-02 20:52:31.56662	\N
5272	V	20	256.12	20	2026-10-02 20:52:31.56662	\N
5273	V	20	256.90	20	2026-10-02 20:52:31.56662	\N
5274	V	20	257.58	20	2026-10-02 20:52:31.56662	\N
5275	V	20	258.43	20	2026-10-02 20:52:31.56662	\N
5276	V	20	277.51	20	2026-10-02 20:52:31.56662	\N
5277	V	20	277.51	20	2026-10-02 20:52:31.56662	\N
5278	V	20	259.45	20	2026-10-02 20:52:31.56662	\N
5279	V	20	260.27	20	2026-10-02 20:52:31.56662	\N
5280	V	20	260.94	20	2026-10-02 20:52:31.56662	\N
5281	V	20	261.58	20	2026-10-02 20:52:31.56662	\N
5282	V	20	262.31	20	2026-10-02 20:52:31.56662	\N
5283	V	20	281.07	20	2026-10-02 20:52:31.56662	\N
5284	V	20	281.07	20	2026-10-02 20:52:31.56662	\N
5285	V	20	263.13	20	2026-10-02 20:52:31.56662	\N
5286	V	20	244.91	20	2026-10-02 20:52:31.56662	\N
5287	V	20	245.07	20	2026-10-02 20:52:31.56662	\N
5288	V	20	245.15	20	2026-10-02 20:52:31.56662	\N
5289	V	20	244.96	20	2026-10-02 20:52:31.56662	\N
5290	V	20	263.48	20	2026-10-02 20:52:31.56662	\N
5291	V	20	263.48	20	2026-10-02 20:52:31.56662	\N
5292	V	20	244.36	20	2026-10-02 20:52:31.56662	\N
5293	V	20	243.92	20	2026-10-02 20:52:31.56662	\N
5294	V	20	243.51	20	2026-10-02 20:52:31.56662	\N
5295	V	20	243.07	20	2026-10-02 20:52:31.56662	\N
5296	V	20	242.49	20	2026-10-02 20:52:31.56662	\N
5297	V	20	260.90	20	2026-10-02 20:52:31.56662	\N
5298	V	20	260.90	20	2026-10-02 20:52:31.56662	\N
5299	V	20	241.93	20	2026-10-02 20:52:31.56662	\N
5300	V	20	241.80	20	2026-10-02 20:52:31.56662	\N
5301	V	20	240.98	20	2026-10-02 20:52:31.56662	\N
5302	V	20	240.12	20	2026-10-02 20:52:31.56662	\N
5303	V	20	239.76	20	2026-10-02 20:52:31.56662	\N
5304	V	20	258.13	20	2026-10-02 20:52:31.56662	\N
5305	V	20	258.13	20	2026-10-02 20:52:31.56662	\N
5306	V	20	258.13	20	2026-10-02 20:52:31.56662	\N
5307	V	20	258.09	20	2026-10-02 20:52:31.56662	\N
5308	V	20	258.01	20	2026-10-02 20:52:31.56662	\N
5309	V	20	257.62	20	2026-10-02 20:52:31.56662	\N
5310	V	20	257.09	20	2026-10-02 20:52:31.56662	\N
5311	DIS	20	105.23	20	2026-10-02 20:53:20.372602	\N
5312	V	20	368.46	20	2026-10-02 20:53:33.356442	\N
5313	JPM	20	346.80	20	2026-10-02 15:35:35.897562	\N
5314	JPM	20	346.80	20	2026-10-02 15:35:42.8755	\N
5315	V	20	368.46	20	2026-10-02 15:37:02.984554	\N
5316	MSFT	50	487.72	50	2026-10-03 03:28:02.829309	\N
5317	NVDA	50	218.28	50	2026-10-03 03:28:02.936803	\N
5318	LLY	50	1176.79	50	2026-10-03 03:28:03.046404	\N
5319	JNJ	50	266.00	50	2026-10-03 03:28:03.130342	\N
5320	JPM	50	352.24	50	2026-10-03 03:28:03.211772	\N
5321	V	50	368.67	50	2026-10-03 03:28:03.312502	\N
5322	AMZN	50	256.54	50	2026-10-03 03:28:03.415172	\N
5323	DIS	50	104.30	50	2026-10-03 03:28:03.515838	\N
5324	XOM	50	160.54	50	2026-10-03 03:28:03.614536	\N
5325	CVX	50	202.55	50	2026-10-03 03:28:03.706633	\N
5326	V	5	140.06	5	2026-10-03 03:32:21.078475	\N
5327	V	5	211.57	5	2026-10-03 03:32:21.078475	\N
5328	V	5	213.45	5	2026-10-03 03:32:21.078475	\N
5329	V	5	283.89	5	2026-10-03 03:32:21.078475	\N
5330	V	5	353.85	5	2026-10-03 03:32:21.078475	\N
5331	V	5	283.09	5	2026-10-03 03:32:21.078475	\N
5332	V	5	211.58	5	2026-10-03 03:32:21.078475	\N
5333	V	5	209.04	5	2026-10-03 03:32:21.078475	\N
5334	V	5	204.17	5	2026-10-03 03:32:21.078475	\N
5335	V	5	200.05	5	2026-10-03 03:32:21.078475	\N
5336	V	5	265.60	5	2026-10-03 03:32:21.078475	\N
5337	V	5	331.26	5	2026-10-03 03:32:21.078475	\N
5338	V	5	262.62	5	2026-10-03 03:32:21.078475	\N
5339	V	5	197.04	5	2026-10-03 03:32:21.078475	\N
5340	V	5	131.21	5	2026-10-03 03:32:21.078475	\N
5341	V	5	130.82	5	2026-10-03 03:32:21.078475	\N
5342	V	5	130.22	5	2026-10-03 03:32:21.078475	\N
5343	V	5	195.49	5	2026-10-03 03:32:21.078475	\N
5344	V	5	260.73	5	2026-10-03 03:32:21.078475	\N
5345	V	5	260.73	5	2026-10-03 03:32:21.078475	\N
5346	V	5	195.56	5	2026-10-03 03:32:21.078475	\N
5347	V	5	196.21	5	2026-10-03 03:32:21.078475	\N
5348	V	5	195.99	5	2026-10-03 03:32:21.078475	\N
5349	V	5	196.15	5	2026-10-03 03:32:21.078475	\N
5350	V	5	262.51	5	2026-10-03 03:32:21.078475	\N
5351	V	5	326.87	5	2026-10-03 03:32:21.078475	\N
5352	V	5	261.17	5	2026-10-03 03:32:21.078475	\N
5353	V	5	196.12	5	2026-10-03 03:32:21.078475	\N
5354	V	5	197.49	5	2026-10-03 03:32:21.078475	\N
5355	V	5	196.92	5	2026-10-03 03:32:21.078475	\N
5356	V	5	198.54	5	2026-10-03 03:32:21.078475	\N
5357	V	5	264.37	5	2026-10-03 03:32:21.078475	\N
5358	V	5	330.69	5	2026-10-03 03:32:21.078475	\N
5359	V	5	263.92	5	2026-10-03 03:32:21.078475	\N
5360	V	5	198.13	5	2026-10-03 03:32:21.078475	\N
5361	V	5	197.26	5	2026-10-03 03:32:21.078475	\N
5362	V	5	197.07	5	2026-10-03 03:32:21.078475	\N
5363	V	5	196.60	5	2026-10-03 03:32:21.078475	\N
5364	V	5	261.43	5	2026-10-03 03:32:21.078475	\N
5365	V	5	324.25	5	2026-10-03 03:32:21.078475	\N
5366	V	5	259.13	5	2026-10-03 03:32:21.078475	\N
5367	V	5	193.50	5	2026-10-03 03:32:21.078475	\N
5368	V	5	127.65	5	2026-10-03 03:32:21.078475	\N
5369	V	5	126.72	5	2026-10-03 03:32:21.078475	\N
5370	V	5	127.96	5	2026-10-03 03:32:21.078475	\N
5371	V	5	191.75	5	2026-10-03 03:32:21.078475	\N
5372	V	5	255.94	5	2026-10-03 03:32:21.078475	\N
5373	V	5	255.94	5	2026-10-03 03:32:21.078475	\N
5374	V	5	192.04	5	2026-10-03 03:32:21.078475	\N
5375	V	5	189.28	5	2026-10-03 03:32:21.078475	\N
5376	V	5	186.94	5	2026-10-03 03:32:21.078475	\N
5377	V	5	185.35	5	2026-10-03 03:32:21.078475	\N
5378	V	5	248.69	5	2026-10-03 03:32:21.078475	\N
5379	V	5	312.71	5	2026-10-03 03:32:21.078475	\N
5380	V	5	251.41	5	2026-10-03 03:32:21.078475	\N
5381	V	5	189.97	5	2026-10-03 03:32:21.078475	\N
5382	V	5	191.47	5	2026-10-03 03:32:21.078475	\N
5383	V	5	192.30	5	2026-10-03 03:32:21.078475	\N
5384	V	5	192.36	5	2026-10-03 03:32:21.078475	\N
5385	V	5	256.32	5	2026-10-03 03:32:21.078475	\N
5386	V	5	319.79	5	2026-10-03 03:32:21.078475	\N
5387	V	5	255.69	5	2026-10-03 03:32:21.078475	\N
5388	V	5	191.53	5	2026-10-03 03:32:21.078475	\N
5389	V	5	190.63	5	2026-10-03 03:32:21.078475	\N
5390	V	5	189.55	5	2026-10-03 03:32:21.078475	\N
5391	V	5	187.87	5	2026-10-03 03:32:21.078475	\N
5392	V	5	249.17	5	2026-10-03 03:32:21.078475	\N
5393	V	5	310.60	5	2026-10-03 03:32:21.078475	\N
5394	V	5	247.41	5	2026-10-03 03:32:21.078475	\N
5395	V	5	184.52	5	2026-10-03 03:32:21.078475	\N
5396	V	5	184.75	5	2026-10-03 03:32:21.078475	\N
5397	V	5	185.14	5	2026-10-03 03:32:21.078475	\N
5398	V	5	183.52	5	2026-10-03 03:32:21.078475	\N
5399	V	5	243.46	5	2026-10-03 03:32:21.078475	\N
5400	V	5	303.78	5	2026-10-03 03:32:21.078475	\N
5401	V	5	241.76	5	2026-10-03 03:32:21.078475	\N
5402	V	5	180.07	5	2026-10-03 03:32:21.078475	\N
5403	V	5	181.15	5	2026-10-03 03:32:21.078475	\N
5404	V	5	181.96	5	2026-10-03 03:32:21.078475	\N
5405	V	5	182.62	5	2026-10-03 03:32:21.078475	\N
5406	V	5	243.73	5	2026-10-03 03:32:21.078475	\N
5407	V	5	302.83	5	2026-10-03 03:32:21.078475	\N
5408	V	5	241.94	5	2026-10-03 03:32:21.078475	\N
5409	V	5	181.19	5	2026-10-03 03:32:21.078475	\N
5410	V	5	180.12	5	2026-10-03 03:32:21.078475	\N
5411	V	5	179.46	5	2026-10-03 03:32:21.078475	\N
5412	V	5	180.06	5	2026-10-03 03:32:21.078475	\N
5413	V	5	240.22	5	2026-10-03 03:32:21.078475	\N
5414	V	5	240.22	5	2026-10-03 03:32:21.078475	\N
5415	V	5	180.31	5	2026-10-03 03:32:21.078475	\N
5416	V	5	119.86	5	2026-10-03 03:32:21.078475	\N
5417	V	5	120.83	5	2026-10-03 03:32:21.078475	\N
5418	V	5	121.18	5	2026-10-03 03:32:21.078475	\N
5419	V	5	182.97	5	2026-10-03 03:32:21.078475	\N
5420	V	5	244.63	5	2026-10-03 03:32:21.078475	\N
5421	V	5	305.50	5	2026-10-03 03:32:21.078475	\N
5422	V	5	244.83	5	2026-10-03 03:32:21.078475	\N
5423	V	5	184.32	5	2026-10-03 03:32:21.078475	\N
5424	V	5	184.41	5	2026-10-03 03:32:21.078475	\N
5425	V	5	185.02	5	2026-10-03 03:32:21.078475	\N
5426	V	5	187.33	5	2026-10-03 03:32:21.078475	\N
5427	V	5	250.35	5	2026-10-03 03:32:21.078475	\N
5428	V	5	313.76	5	2026-10-03 03:32:21.078475	\N
5429	V	5	251.88	5	2026-10-03 03:32:21.078475	\N
5430	V	5	189.61	5	2026-10-03 03:32:21.078475	\N
5431	V	5	189.21	5	2026-10-03 03:32:21.078475	\N
5432	V	5	188.18	5	2026-10-03 03:32:21.078475	\N
5433	V	5	187.03	5	2026-10-03 03:32:21.078475	\N
5434	V	5	248.81	5	2026-10-03 03:32:21.078475	\N
5435	V	5	310.69	5	2026-10-03 03:32:21.078475	\N
5436	V	5	247.91	5	2026-10-03 03:32:21.078475	\N
5437	V	5	185.92	5	2026-10-03 03:32:21.078475	\N
5438	V	5	185.59	5	2026-10-03 03:32:21.078475	\N
5439	V	5	185.67	5	2026-10-03 03:32:21.078475	\N
5440	V	5	190.76	5	2026-10-03 03:32:21.078475	\N
5441	V	5	256.73	5	2026-10-03 03:32:21.078475	\N
5442	V	5	322.34	5	2026-10-03 03:32:21.078475	\N
5443	V	5	260.41	5	2026-10-03 03:32:21.078475	\N
5444	V	5	198.55	5	2026-10-03 03:32:21.078475	\N
5445	V	5	196.94	5	2026-10-03 03:32:21.078475	\N
5446	V	5	195.38	5	2026-10-03 03:32:21.078475	\N
5447	V	5	193.54	5	2026-10-03 03:32:21.078475	\N
5448	V	5	257.79	5	2026-10-03 03:32:21.078475	\N
5449	V	5	321.55	5	2026-10-03 03:32:21.078475	\N
5450	V	5	256.18	5	2026-10-03 03:32:21.078475	\N
5451	V	5	191.77	5	2026-10-03 03:32:21.078475	\N
5452	V	5	192.79	5	2026-10-03 03:32:21.078475	\N
5453	V	5	193.81	5	2026-10-03 03:32:21.078475	\N
5454	V	5	194.12	5	2026-10-03 03:32:21.078475	\N
5455	V	5	258.62	5	2026-10-03 03:32:21.078475	\N
5456	V	5	323.77	5	2026-10-03 03:32:21.078475	\N
5457	V	5	259.00	5	2026-10-03 03:32:21.078475	\N
5458	V	5	193.72	5	2026-10-03 03:32:21.078475	\N
5459	V	5	196.18	5	2026-10-03 03:32:21.078475	\N
5460	V	5	197.66	5	2026-10-03 03:32:21.078475	\N
5461	V	5	198.66	5	2026-10-03 03:32:21.078475	\N
5462	V	5	264.88	5	2026-10-03 03:32:21.078475	\N
5463	V	5	330.66	5	2026-10-03 03:32:21.078475	\N
5464	V	5	264.13	5	2026-10-03 03:32:21.078475	\N
5465	V	5	198.15	5	2026-10-03 03:32:21.078475	\N
5466	V	5	132.00	5	2026-10-03 03:32:21.078475	\N
5467	V	5	131.07	5	2026-10-03 03:32:21.078475	\N
5468	V	5	130.82	5	2026-10-03 03:32:21.078475	\N
5469	V	5	195.81	5	2026-10-03 03:32:21.078475	\N
5470	V	5	261.08	5	2026-10-03 03:32:21.078475	\N
5471	V	5	261.08	5	2026-10-03 03:32:21.078475	\N
5472	V	5	195.78	5	2026-10-03 03:32:21.078475	\N
5473	V	5	194.82	5	2026-10-03 03:32:21.078475	\N
5474	V	5	193.29	5	2026-10-03 03:32:21.078475	\N
5475	V	5	190.50	5	2026-10-03 03:32:21.078475	\N
5476	V	5	254.53	5	2026-10-03 03:32:21.078475	\N
5477	V	5	319.25	5	2026-10-03 03:32:21.078475	\N
5478	V	5	254.69	5	2026-10-03 03:32:21.078475	\N
5479	V	5	191.23	5	2026-10-03 03:32:21.078475	\N
5480	V	5	192.68	5	2026-10-03 03:32:21.078475	\N
5481	V	5	193.66	5	2026-10-03 03:32:21.078475	\N
5482	V	5	193.54	5	2026-10-03 03:32:21.078475	\N
5483	V	5	257.35	5	2026-10-03 03:32:21.078475	\N
5484	V	5	321.82	5	2026-10-03 03:32:21.078475	\N
5485	V	5	257.89	5	2026-10-03 03:32:21.078475	\N
5486	V	5	192.88	5	2026-10-03 03:32:21.078475	\N
5487	V	5	193.05	5	2026-10-03 03:32:21.078475	\N
5488	V	5	195.87	5	2026-10-03 03:32:21.078475	\N
5489	V	5	197.46	5	2026-10-03 03:32:21.078475	\N
5490	V	5	262.91	5	2026-10-03 03:32:21.078475	\N
5491	V	5	262.91	5	2026-10-03 03:32:21.078475	\N
5492	V	5	198.15	5	2026-10-03 03:32:21.078475	\N
5493	V	5	131.52	5	2026-10-03 03:32:21.078475	\N
5494	V	5	130.77	5	2026-10-03 03:32:21.078475	\N
5495	V	5	131.02	5	2026-10-03 03:32:21.078475	\N
5496	V	5	197.46	5	2026-10-03 03:32:21.078475	\N
5497	V	5	263.57	5	2026-10-03 03:32:21.078475	\N
5498	V	5	330.81	5	2026-10-03 03:32:21.078475	\N
5499	V	5	265.49	5	2026-10-03 03:32:21.078475	\N
5500	V	5	199.80	5	2026-10-03 03:32:21.078475	\N
5501	V	5	201.68	5	2026-10-03 03:32:21.078475	\N
5502	V	5	204.19	5	2026-10-03 03:32:21.078475	\N
5503	V	5	207.16	5	2026-10-03 03:32:21.078475	\N
5504	V	5	279.59	5	2026-10-03 03:32:21.078475	\N
5505	V	5	279.59	5	2026-10-03 03:32:21.078475	\N
5506	V	5	211.26	5	2026-10-03 03:32:21.078475	\N
5507	V	5	142.64	5	2026-10-03 03:32:21.078475	\N
5508	V	5	143.88	5	2026-10-03 03:32:21.078475	\N
5509	V	5	141.89	5	2026-10-03 03:32:21.078475	\N
5510	V	5	211.40	5	2026-10-03 03:32:21.078475	\N
5511	V	5	281.04	5	2026-10-03 03:32:21.078475	\N
5512	V	5	350.83	5	2026-10-03 03:32:21.078475	\N
5513	V	5	279.38	5	2026-10-03 03:32:21.078475	\N
5514	V	5	208.94	5	2026-10-03 03:32:21.078475	\N
5515	V	5	210.98	5	2026-10-03 03:32:21.078475	\N
5516	V	5	212.55	5	2026-10-03 03:32:21.078475	\N
5517	V	5	213.78	5	2026-10-03 03:32:21.078475	\N
5518	V	5	286.81	5	2026-10-03 03:32:21.078475	\N
5519	V	5	358.52	5	2026-10-03 03:32:21.078475	\N
5520	V	5	286.97	5	2026-10-03 03:32:21.078475	\N
5521	V	5	215.77	5	2026-10-03 03:32:21.078475	\N
5522	V	5	216.85	5	2026-10-03 03:32:21.078475	\N
5523	V	5	214.99	5	2026-10-03 03:32:21.078475	\N
5524	V	5	213.96	5	2026-10-03 03:32:21.078475	\N
5525	V	5	284.28	5	2026-10-03 03:32:21.078475	\N
5526	V	5	355.43	5	2026-10-03 03:32:21.078475	\N
5527	V	5	283.32	5	2026-10-03 03:32:21.078475	\N
5528	V	5	212.15	5	2026-10-03 03:32:21.078475	\N
5529	V	5	213.97	5	2026-10-03 03:32:21.078475	\N
5530	V	5	216.97	5	2026-10-03 03:32:21.078475	\N
5531	V	5	219.57	5	2026-10-03 03:32:21.078475	\N
5532	V	5	292.82	5	2026-10-03 03:32:21.078475	\N
5533	V	5	366.05	5	2026-10-03 03:32:21.078475	\N
5534	V	5	293.54	5	2026-10-03 03:32:21.078475	\N
5535	V	5	220.23	5	2026-10-03 03:32:21.078475	\N
5536	V	5	219.61	5	2026-10-03 03:32:21.078475	\N
5537	V	5	220.28	5	2026-10-03 03:32:21.078475	\N
5538	V	5	220.76	5	2026-10-03 03:32:21.078475	\N
5539	V	5	294.85	5	2026-10-03 03:32:21.078475	\N
5540	V	5	367.35	5	2026-10-03 03:32:21.078475	\N
5541	V	5	294.22	5	2026-10-03 03:32:21.078475	\N
5542	V	5	220.30	5	2026-10-03 03:32:21.078475	\N
5543	V	5	218.86	5	2026-10-03 03:32:21.078475	\N
5544	V	5	217.33	5	2026-10-03 03:32:21.078475	\N
5545	V	5	216.71	5	2026-10-03 03:32:21.078475	\N
5546	V	5	289.80	5	2026-10-03 03:32:21.078475	\N
5547	V	5	362.63	5	2026-10-03 03:32:21.078475	\N
5548	V	5	290.37	5	2026-10-03 03:32:21.078475	\N
5549	V	5	217.80	5	2026-10-03 03:32:21.078475	\N
5550	V	5	217.69	5	2026-10-03 03:32:21.078475	\N
5551	V	5	217.45	5	2026-10-03 03:32:21.078475	\N
5552	V	5	217.73	5	2026-10-03 03:32:21.078475	\N
5553	V	5	290.87	5	2026-10-03 03:32:21.078475	\N
5554	V	5	365.08	5	2026-10-03 03:32:21.078475	\N
5555	V	5	293.31	5	2026-10-03 03:32:21.078475	\N
5556	V	5	220.46	5	2026-10-03 03:32:21.078475	\N
5557	V	5	223.84	5	2026-10-03 03:32:21.078475	\N
5558	V	5	227.52	5	2026-10-03 03:32:21.078475	\N
5559	V	5	230.09	5	2026-10-03 03:32:21.078475	\N
5560	V	5	306.02	5	2026-10-03 03:32:21.078475	\N
5561	V	5	382.34	5	2026-10-03 03:32:21.078475	\N
5562	V	5	305.86	5	2026-10-03 03:32:21.078475	\N
5563	V	5	229.03	5	2026-10-03 03:32:21.078475	\N
5564	V	5	228.13	5	2026-10-03 03:32:21.078475	\N
5565	V	5	226.73	5	2026-10-03 03:32:21.078475	\N
5566	V	5	226.09	5	2026-10-03 03:32:21.078475	\N
5567	V	5	301.84	5	2026-10-03 03:32:21.078475	\N
5568	V	5	376.85	5	2026-10-03 03:32:21.078475	\N
5569	V	5	300.98	5	2026-10-03 03:32:21.078475	\N
5570	V	5	226.44	5	2026-10-03 03:32:21.078475	\N
5571	V	5	150.76	5	2026-10-03 03:32:21.078475	\N
5572	V	5	148.74	5	2026-10-03 03:32:21.078475	\N
5573	V	5	147.21	5	2026-10-03 03:32:21.078475	\N
5574	V	5	220.65	5	2026-10-03 03:32:21.078475	\N
5575	V	5	294.74	5	2026-10-03 03:32:21.078475	\N
5576	V	5	294.74	5	2026-10-03 03:32:21.078475	\N
5577	V	5	221.01	5	2026-10-03 03:32:21.078475	\N
5578	V	5	222.59	5	2026-10-03 03:32:21.078475	\N
5579	V	5	224.27	5	2026-10-03 03:32:21.078475	\N
5580	V	5	224.37	5	2026-10-03 03:32:21.078475	\N
5581	V	5	298.35	5	2026-10-03 03:32:21.078475	\N
5582	V	5	372.01	5	2026-10-03 03:32:21.078475	\N
5583	V	5	296.95	5	2026-10-03 03:32:21.078475	\N
5584	V	5	221.83	5	2026-10-03 03:32:21.078475	\N
5585	V	5	221.63	5	2026-10-03 03:32:21.078475	\N
5586	V	5	220.06	5	2026-10-03 03:32:21.078475	\N
5587	V	5	218.70	5	2026-10-03 03:32:21.078475	\N
5588	V	5	292.30	5	2026-10-03 03:32:21.078475	\N
5589	V	5	365.77	5	2026-10-03 03:32:21.078475	\N
5590	V	5	291.78	5	2026-10-03 03:32:21.078475	\N
5591	V	5	219.38	5	2026-10-03 03:32:21.078475	\N
5592	V	5	220.62	5	2026-10-03 03:32:21.078475	\N
5593	V	5	220.20	5	2026-10-03 03:32:21.078475	\N
5594	V	5	218.59	5	2026-10-03 03:32:21.078475	\N
5595	V	5	290.56	5	2026-10-03 03:32:21.078475	\N
5596	V	5	362.69	5	2026-10-03 03:32:21.078475	\N
5597	V	20	204.89	20	2026-10-03 03:32:21.170781	\N
5598	V	20	221.16	20	2026-10-03 03:32:21.170781	\N
5599	V	20	220.15	20	2026-10-03 03:32:21.170781	\N
5600	V	20	236.46	20	2026-10-03 03:32:21.170781	\N
5601	V	20	236.46	20	2026-10-03 03:32:21.170781	\N
5602	V	20	218.77	20	2026-10-03 03:32:21.170781	\N
5603	V	20	217.32	20	2026-10-03 03:32:21.170781	\N
5604	V	20	215.78	20	2026-10-03 03:32:21.170781	\N
5605	V	20	214.52	20	2026-10-03 03:32:21.170781	\N
5606	V	20	213.62	20	2026-10-03 03:32:21.170781	\N
5607	V	20	229.71	20	2026-10-03 03:32:21.170781	\N
5608	V	20	229.71	20	2026-10-03 03:32:21.170781	\N
5609	V	20	212.56	20	2026-10-03 03:32:21.170781	\N
5610	V	20	212.85	20	2026-10-03 03:32:21.170781	\N
5611	V	20	212.84	20	2026-10-03 03:32:21.170781	\N
5612	V	20	212.95	20	2026-10-03 03:32:21.170781	\N
5613	V	20	212.99	20	2026-10-03 03:32:21.170781	\N
5614	V	20	229.57	20	2026-10-03 03:32:21.170781	\N
5615	V	20	229.57	20	2026-10-03 03:32:21.170781	\N
5616	V	20	229.57	20	2026-10-03 03:32:21.170781	\N
5617	V	20	229.56	20	2026-10-03 03:32:21.170781	\N
5618	V	20	229.70	20	2026-10-03 03:32:21.170781	\N
5619	V	20	229.85	20	2026-10-03 03:32:21.170781	\N
5620	V	20	229.75	20	2026-10-03 03:32:21.170781	\N
5621	V	20	245.45	20	2026-10-03 03:32:21.170781	\N
5622	V	20	245.45	20	2026-10-03 03:32:21.170781	\N
5623	V	20	229.03	20	2026-10-03 03:32:21.170781	\N
5624	V	20	212.76	20	2026-10-03 03:32:21.170781	\N
5625	V	20	212.39	20	2026-10-03 03:32:21.170781	\N
5626	V	20	211.82	20	2026-10-03 03:32:21.170781	\N
5627	V	20	211.67	20	2026-10-03 03:32:21.170781	\N
5628	V	20	227.72	20	2026-10-03 03:32:21.170781	\N
5629	V	20	227.72	20	2026-10-03 03:32:21.170781	\N
5630	V	20	211.03	20	2026-10-03 03:32:21.170781	\N
5631	V	20	209.91	20	2026-10-03 03:32:21.170781	\N
5632	V	20	208.77	20	2026-10-03 03:32:21.170781	\N
5633	V	20	207.96	20	2026-10-03 03:32:21.170781	\N
5634	V	20	207.22	20	2026-10-03 03:32:21.170781	\N
5635	V	20	223.22	20	2026-10-03 03:32:21.170781	\N
5636	V	20	223.22	20	2026-10-03 03:32:21.170781	\N
5637	V	20	206.95	20	2026-10-03 03:32:21.170781	\N
5638	V	20	206.56	20	2026-10-03 03:32:21.170781	\N
5639	V	20	206.14	20	2026-10-03 03:32:21.170781	\N
5640	V	20	205.96	20	2026-10-03 03:32:21.170781	\N
5641	V	20	206.24	20	2026-10-03 03:32:21.170781	\N
5642	V	20	222.11	20	2026-10-03 03:32:21.170781	\N
5643	V	20	222.11	20	2026-10-03 03:32:21.170781	\N
5644	V	20	222.11	20	2026-10-03 03:32:21.170781	\N
5645	V	20	221.93	20	2026-10-03 03:32:21.170781	\N
5646	V	20	221.64	20	2026-10-03 03:32:21.170781	\N
5647	V	20	221.14	20	2026-10-03 03:32:21.170781	\N
5648	V	20	220.42	20	2026-10-03 03:32:21.170781	\N
5649	V	20	235.78	20	2026-10-03 03:32:21.170781	\N
5650	V	20	235.78	20	2026-10-03 03:32:21.170781	\N
5651	V	20	220.45	20	2026-10-03 03:32:21.170781	\N
5652	V	20	220.60	20	2026-10-03 03:32:21.170781	\N
5653	V	20	220.37	20	2026-10-03 03:32:21.170781	\N
5654	V	20	219.48	20	2026-10-03 03:32:21.170781	\N
5655	V	20	218.46	20	2026-10-03 03:32:21.170781	\N
5656	V	20	233.54	20	2026-10-03 03:32:21.170781	\N
5657	V	20	233.54	20	2026-10-03 03:32:21.170781	\N
5658	V	20	217.52	20	2026-10-03 03:32:21.170781	\N
5659	V	20	216.70	20	2026-10-03 03:32:21.170781	\N
5660	V	20	215.86	20	2026-10-03 03:32:21.170781	\N
5661	V	20	215.12	20	2026-10-03 03:32:21.170781	\N
5662	V	20	214.53	20	2026-10-03 03:32:21.170781	\N
5663	V	20	229.30	20	2026-10-03 03:32:21.170781	\N
5664	V	20	229.30	20	2026-10-03 03:32:21.170781	\N
5665	V	20	213.51	20	2026-10-03 03:32:21.170781	\N
5666	V	20	212.76	20	2026-10-03 03:32:21.170781	\N
5667	V	20	212.43	20	2026-10-03 03:32:21.170781	\N
5668	V	20	212.03	20	2026-10-03 03:32:21.170781	\N
5669	V	20	211.71	20	2026-10-03 03:32:21.170781	\N
5670	V	20	211.71	20	2026-10-03 03:32:21.170781	\N
5671	V	20	211.71	20	2026-10-03 03:32:21.170781	\N
5672	V	20	196.20	20	2026-10-03 03:32:21.170781	\N
5673	V	20	195.95	20	2026-10-03 03:32:21.170781	\N
5674	V	20	196.12	20	2026-10-03 03:32:21.170781	\N
5675	V	20	196.59	20	2026-10-03 03:32:21.170781	\N
5676	V	20	196.92	20	2026-10-03 03:32:21.170781	\N
5677	V	20	212.14	20	2026-10-03 03:32:21.170781	\N
5678	V	20	212.14	20	2026-10-03 03:32:21.170781	\N
5679	V	20	196.92	20	2026-10-03 03:32:21.170781	\N
5680	V	20	197.20	20	2026-10-03 03:32:21.170781	\N
5681	V	20	197.52	20	2026-10-03 03:32:21.170781	\N
5682	V	20	198.04	20	2026-10-03 03:32:21.170781	\N
5683	V	20	199.02	20	2026-10-03 03:32:21.170781	\N
5684	V	20	214.87	20	2026-10-03 03:32:21.170781	\N
5685	V	20	214.87	20	2026-10-03 03:32:21.170781	\N
5686	V	20	199.89	20	2026-10-03 03:32:21.170781	\N
5687	V	20	200.48	20	2026-10-03 03:32:21.170781	\N
5688	V	20	201.05	20	2026-10-03 03:32:21.170781	\N
5689	V	20	201.57	20	2026-10-03 03:32:21.170781	\N
5690	V	20	217.02	20	2026-10-03 03:32:21.170781	\N
5691	V	20	232.49	20	2026-10-03 03:32:21.170781	\N
5692	V	20	232.49	20	2026-10-03 03:32:21.170781	\N
5693	V	20	217.32	20	2026-10-03 03:32:21.170781	\N
5694	V	20	217.68	20	2026-10-03 03:32:21.170781	\N
5695	V	20	217.69	20	2026-10-03 03:32:21.170781	\N
5696	V	20	219.02	20	2026-10-03 03:32:21.170781	\N
5697	V	20	220.30	20	2026-10-03 03:32:21.170781	\N
5698	V	20	236.70	20	2026-10-03 03:32:21.170781	\N
5699	V	20	236.70	20	2026-10-03 03:32:21.170781	\N
5700	V	20	221.23	20	2026-10-03 03:32:21.170781	\N
5701	V	20	222.00	20	2026-10-03 03:32:21.170781	\N
5702	V	20	222.31	20	2026-10-03 03:32:21.170781	\N
5703	V	20	222.49	20	2026-10-03 03:32:21.170781	\N
5704	V	20	222.71	20	2026-10-03 03:32:21.170781	\N
5705	V	20	238.65	20	2026-10-03 03:32:21.170781	\N
5706	V	20	238.65	20	2026-10-03 03:32:21.170781	\N
5707	V	20	222.95	20	2026-10-03 03:32:21.170781	\N
5708	V	20	223.64	20	2026-10-03 03:32:21.170781	\N
5709	V	20	224.40	20	2026-10-03 03:32:21.170781	\N
5710	V	20	224.97	20	2026-10-03 03:32:21.170781	\N
5711	V	20	225.63	20	2026-10-03 03:32:21.170781	\N
5712	V	20	241.91	20	2026-10-03 03:32:21.170781	\N
5713	V	20	241.91	20	2026-10-03 03:32:21.170781	\N
5714	V	20	226.43	20	2026-10-03 03:32:21.170781	\N
5715	V	20	227.60	20	2026-10-03 03:32:21.170781	\N
5716	V	20	227.35	20	2026-10-03 03:32:21.170781	\N
5717	V	20	227.40	20	2026-10-03 03:32:21.170781	\N
5718	V	20	227.55	20	2026-10-03 03:32:21.170781	\N
5719	V	20	244.00	20	2026-10-03 03:32:21.170781	\N
5720	V	20	244.00	20	2026-10-03 03:32:21.170781	\N
5721	V	20	227.65	20	2026-10-03 03:32:21.170781	\N
5722	V	20	211.55	20	2026-10-03 03:32:21.170781	\N
5723	V	20	211.94	20	2026-10-03 03:32:21.170781	\N
5724	V	20	212.25	20	2026-10-03 03:32:21.170781	\N
5725	V	20	212.56	20	2026-10-03 03:32:21.170781	\N
5726	V	20	228.88	20	2026-10-03 03:32:21.170781	\N
5727	V	20	228.88	20	2026-10-03 03:32:21.170781	\N
5728	V	20	212.69	20	2026-10-03 03:32:21.170781	\N
5729	V	20	212.50	20	2026-10-03 03:32:21.170781	\N
5730	V	20	212.35	20	2026-10-03 03:32:21.170781	\N
5731	V	20	211.85	20	2026-10-03 03:32:21.170781	\N
5732	V	20	211.57	20	2026-10-03 03:32:21.170781	\N
5733	V	20	227.75	20	2026-10-03 03:32:21.170781	\N
5734	V	20	227.75	20	2026-10-03 03:32:21.170781	\N
5735	V	20	211.12	20	2026-10-03 03:32:21.170781	\N
5736	V	20	210.60	20	2026-10-03 03:32:21.170781	\N
5737	V	20	210.32	20	2026-10-03 03:32:21.170781	\N
5738	V	20	209.91	20	2026-10-03 03:32:21.170781	\N
5739	V	20	209.42	20	2026-10-03 03:32:21.170781	\N
5740	V	20	225.54	20	2026-10-03 03:32:21.170781	\N
5741	V	20	225.54	20	2026-10-03 03:32:21.170781	\N
5742	V	20	225.54	20	2026-10-03 03:32:21.170781	\N
5743	V	20	225.41	20	2026-10-03 03:32:21.170781	\N
5744	V	20	225.68	20	2026-10-03 03:32:21.170781	\N
5745	V	20	225.95	20	2026-10-03 03:32:21.170781	\N
5746	V	20	226.00	20	2026-10-03 03:32:21.170781	\N
5747	V	20	226.00	20	2026-10-03 03:32:21.170781	\N
5748	V	20	226.00	20	2026-10-03 03:32:21.170781	\N
5749	V	20	209.86	20	2026-10-03 03:32:21.170781	\N
5750	V	20	210.32	20	2026-10-03 03:32:21.170781	\N
5751	V	20	211.13	20	2026-10-03 03:32:21.170781	\N
5752	V	20	211.73	20	2026-10-03 03:32:21.170781	\N
5753	V	20	212.08	20	2026-10-03 03:32:21.170781	\N
5754	V	20	228.89	20	2026-10-03 03:32:21.170781	\N
5755	V	20	228.89	20	2026-10-03 03:32:21.170781	\N
5756	V	20	212.90	20	2026-10-03 03:32:21.170781	\N
5757	V	20	213.73	20	2026-10-03 03:32:21.170781	\N
5758	V	20	214.74	20	2026-10-03 03:32:21.170781	\N
5759	V	20	216.34	20	2026-10-03 03:32:21.170781	\N
5760	V	20	218.33	20	2026-10-03 03:32:21.170781	\N
5761	V	20	218.33	20	2026-10-03 03:32:21.170781	\N
5762	V	20	218.33	20	2026-10-03 03:32:21.170781	\N
5763	V	20	202.14	20	2026-10-03 03:32:21.170781	\N
5764	V	20	203.34	20	2026-10-03 03:32:21.170781	\N
5765	V	20	204.44	20	2026-10-03 03:32:21.170781	\N
5766	V	20	205.45	20	2026-10-03 03:32:21.170781	\N
5767	V	20	222.86	20	2026-10-03 03:32:21.170781	\N
5768	V	20	240.31	20	2026-10-03 03:32:21.170781	\N
5769	V	20	240.31	20	2026-10-03 03:32:21.170781	\N
5770	V	20	223.98	20	2026-10-03 03:32:21.170781	\N
5771	V	20	225.44	20	2026-10-03 03:32:21.170781	\N
5772	V	20	226.63	20	2026-10-03 03:32:21.170781	\N
5773	V	20	227.86	20	2026-10-03 03:32:21.170781	\N
5774	V	20	229.31	20	2026-10-03 03:32:21.170781	\N
5775	V	20	247.24	20	2026-10-03 03:32:21.170781	\N
5776	V	20	247.24	20	2026-10-03 03:32:21.170781	\N
5777	V	20	230.15	20	2026-10-03 03:32:21.170781	\N
5778	V	20	231.03	20	2026-10-03 03:32:21.170781	\N
5779	V	20	231.26	20	2026-10-03 03:32:21.170781	\N
5780	V	20	230.83	20	2026-10-03 03:32:21.170781	\N
5781	V	20	248.41	20	2026-10-03 03:32:21.170781	\N
5782	V	20	266.20	20	2026-10-03 03:32:21.170781	\N
5783	V	20	266.20	20	2026-10-03 03:32:21.170781	\N
5784	V	20	248.33	20	2026-10-03 03:32:21.170781	\N
5785	V	20	248.85	20	2026-10-03 03:32:21.170781	\N
5786	V	20	249.80	20	2026-10-03 03:32:21.170781	\N
5787	V	20	250.83	20	2026-10-03 03:32:21.170781	\N
5788	V	20	251.69	20	2026-10-03 03:32:21.170781	\N
5789	V	20	270.00	20	2026-10-03 03:32:21.170781	\N
5790	V	20	270.00	20	2026-10-03 03:32:21.170781	\N
5791	V	20	252.11	20	2026-10-03 03:32:21.170781	\N
5792	V	20	252.60	20	2026-10-03 03:32:21.170781	\N
5793	V	20	253.32	20	2026-10-03 03:32:21.170781	\N
5794	V	20	253.49	20	2026-10-03 03:32:21.170781	\N
5795	V	20	254.08	20	2026-10-03 03:32:21.170781	\N
5796	V	20	272.21	20	2026-10-03 03:32:21.170781	\N
5797	V	20	272.21	20	2026-10-03 03:32:21.170781	\N
5798	V	20	254.18	20	2026-10-03 03:32:21.170781	\N
5799	V	20	254.45	20	2026-10-03 03:32:21.170781	\N
5800	V	20	254.93	20	2026-10-03 03:32:21.170781	\N
5801	V	20	255.32	20	2026-10-03 03:32:21.170781	\N
5802	V	20	255.80	20	2026-10-03 03:32:21.170781	\N
5803	V	20	274.01	20	2026-10-03 03:32:21.170781	\N
5804	V	20	274.01	20	2026-10-03 03:32:21.170781	\N
5805	V	20	255.88	20	2026-10-03 03:32:21.170781	\N
5806	V	20	255.50	20	2026-10-03 03:32:21.170781	\N
5807	V	20	255.27	20	2026-10-03 03:32:21.170781	\N
5808	V	20	255.23	20	2026-10-03 03:32:21.170781	\N
5809	V	20	255.21	20	2026-10-03 03:32:21.170781	\N
5810	V	20	273.77	20	2026-10-03 03:32:21.170781	\N
5811	V	20	273.77	20	2026-10-03 03:32:21.170781	\N
5812	V	20	255.48	20	2026-10-03 03:32:21.170781	\N
5813	V	20	256.12	20	2026-10-03 03:32:21.170781	\N
5814	V	20	256.90	20	2026-10-03 03:32:21.170781	\N
5815	V	20	257.58	20	2026-10-03 03:32:21.170781	\N
5816	V	20	258.43	20	2026-10-03 03:32:21.170781	\N
5817	V	20	277.51	20	2026-10-03 03:32:21.170781	\N
5818	V	20	277.51	20	2026-10-03 03:32:21.170781	\N
5819	V	20	259.45	20	2026-10-03 03:32:21.170781	\N
5820	V	20	260.27	20	2026-10-03 03:32:21.170781	\N
5821	V	20	260.94	20	2026-10-03 03:32:21.170781	\N
5822	V	20	261.58	20	2026-10-03 03:32:21.170781	\N
5823	V	20	262.31	20	2026-10-03 03:32:21.170781	\N
5824	V	20	281.07	20	2026-10-03 03:32:21.170781	\N
5825	V	20	281.07	20	2026-10-03 03:32:21.170781	\N
5826	V	20	263.13	20	2026-10-03 03:32:21.170781	\N
5827	V	20	244.91	20	2026-10-03 03:32:21.170781	\N
5828	V	20	245.07	20	2026-10-03 03:32:21.170781	\N
5829	V	20	245.15	20	2026-10-03 03:32:21.170781	\N
5830	V	20	244.96	20	2026-10-03 03:32:21.170781	\N
5831	V	20	263.48	20	2026-10-03 03:32:21.170781	\N
5832	V	20	263.48	20	2026-10-03 03:32:21.170781	\N
5833	V	20	244.36	20	2026-10-03 03:32:21.170781	\N
5834	V	20	243.92	20	2026-10-03 03:32:21.170781	\N
5835	V	20	243.51	20	2026-10-03 03:32:21.170781	\N
5836	V	20	243.07	20	2026-10-03 03:32:21.170781	\N
5837	V	20	242.49	20	2026-10-03 03:32:21.170781	\N
5838	V	20	260.90	20	2026-10-03 03:32:21.170781	\N
5839	V	20	260.90	20	2026-10-03 03:32:21.170781	\N
5840	V	20	241.93	20	2026-10-03 03:32:21.170781	\N
5841	V	20	241.80	20	2026-10-03 03:32:21.170781	\N
5842	V	20	240.98	20	2026-10-03 03:32:21.170781	\N
5843	V	20	240.12	20	2026-10-03 03:32:21.170781	\N
5844	V	20	239.76	20	2026-10-03 03:32:21.170781	\N
5845	V	20	258.13	20	2026-10-03 03:32:21.170781	\N
5846	V	20	258.13	20	2026-10-03 03:32:21.170781	\N
5847	V	20	258.13	20	2026-10-03 03:32:21.170781	\N
5848	V	20	258.09	20	2026-10-03 03:32:21.170781	\N
5849	V	20	258.01	20	2026-10-03 03:32:21.170781	\N
5850	V	20	257.62	20	2026-10-03 03:32:21.170781	\N
5851	V	20	257.09	20	2026-10-03 03:32:21.170781	\N
5852	V	20	275.12	20	2026-10-03 03:32:21.170781	\N
5853	V	20	367.56	20	2026-10-03 03:32:51.689845	\N
5854	MSFT	50	487.72	50	2026-10-03 03:48:49.002096	\N
5855	NVDA	50	218.28	50	2026-10-03 03:48:49.136431	\N
5856	LLY	50	1176.79	50	2026-10-03 03:48:49.230924	\N
5857	JNJ	50	266.00	50	2026-10-03 03:48:49.332365	\N
5858	JPM	50	352.24	50	2026-10-03 03:48:49.437787	\N
5859	V	50	368.67	50	2026-10-03 03:48:49.547219	\N
5860	AMZN	50	256.54	50	2026-10-03 03:48:49.652402	\N
5861	DIS	50	104.30	50	2026-10-03 03:48:49.757077	\N
5862	XOM	50	160.54	50	2026-10-03 03:48:49.858336	\N
5863	CVX	50	202.55	50	2026-10-03 03:48:49.967075	\N
5864	MSFT	50	487.72	50	2026-10-03 04:00:08.952163	\N
5865	NVDA	50	218.28	50	2026-10-03 04:00:09.063152	\N
5866	LLY	50	1176.79	50	2026-10-03 04:00:09.208336	\N
5867	JNJ	50	266.00	50	2026-10-03 04:00:09.307747	\N
5868	JPM	50	352.24	50	2026-10-03 04:00:09.427587	\N
5869	V	50	368.67	50	2026-10-03 04:00:09.563845	\N
5870	AMZN	50	256.54	50	2026-10-03 04:00:09.712069	\N
5871	DIS	50	104.30	50	2026-10-03 04:00:09.828193	\N
5872	XOM	50	160.54	50	2026-10-03 04:00:09.948481	\N
5873	CVX	50	202.55	50	2026-10-03 04:00:10.046337	\N
5874	V	20	367.62	20	2026-10-08 14:21:53.063189	\N
5875	V	5	140.06	5	2026-10-08 14:22:24.408683	\N
5876	V	5	211.57	5	2026-10-08 14:22:24.408683	\N
5877	V	5	213.45	5	2026-10-08 14:22:24.408683	\N
5878	V	5	283.89	5	2026-10-08 14:22:24.408683	\N
5879	V	5	353.85	5	2026-10-08 14:22:24.408683	\N
5880	V	5	283.09	5	2026-10-08 14:22:24.408683	\N
5881	V	5	211.58	5	2026-10-08 14:22:24.408683	\N
5882	V	5	209.04	5	2026-10-08 14:22:24.408683	\N
5883	V	5	204.17	5	2026-10-08 14:22:24.408683	\N
5884	V	5	200.05	5	2026-10-08 14:22:24.408683	\N
5885	V	5	265.60	5	2026-10-08 14:22:24.408683	\N
5886	V	5	331.26	5	2026-10-08 14:22:24.408683	\N
5887	V	5	262.62	5	2026-10-08 14:22:24.408683	\N
5888	V	5	197.04	5	2026-10-08 14:22:24.408683	\N
5889	V	5	131.21	5	2026-10-08 14:22:24.408683	\N
5890	V	5	130.82	5	2026-10-08 14:22:24.408683	\N
5891	V	5	130.22	5	2026-10-08 14:22:24.408683	\N
5892	V	5	195.49	5	2026-10-08 14:22:24.408683	\N
5893	V	5	260.73	5	2026-10-08 14:22:24.408683	\N
5894	V	5	260.73	5	2026-10-08 14:22:24.408683	\N
5895	V	5	195.56	5	2026-10-08 14:22:24.408683	\N
5896	V	5	196.21	5	2026-10-08 14:22:24.408683	\N
5897	V	5	195.99	5	2026-10-08 14:22:24.408683	\N
5898	V	5	196.15	5	2026-10-08 14:22:24.408683	\N
5899	V	5	262.51	5	2026-10-08 14:22:24.408683	\N
5900	V	5	326.87	5	2026-10-08 14:22:24.408683	\N
5901	V	5	261.17	5	2026-10-08 14:22:24.408683	\N
5902	V	5	196.12	5	2026-10-08 14:22:24.408683	\N
5903	V	5	197.49	5	2026-10-08 14:22:24.408683	\N
5904	V	5	196.92	5	2026-10-08 14:22:24.408683	\N
5905	V	5	198.54	5	2026-10-08 14:22:24.408683	\N
5906	V	5	264.37	5	2026-10-08 14:22:24.408683	\N
5907	V	5	330.69	5	2026-10-08 14:22:24.408683	\N
5908	V	5	263.92	5	2026-10-08 14:22:24.408683	\N
5909	V	5	198.13	5	2026-10-08 14:22:24.408683	\N
5910	V	5	197.26	5	2026-10-08 14:22:24.408683	\N
5911	V	5	197.07	5	2026-10-08 14:22:24.408683	\N
5912	V	5	196.60	5	2026-10-08 14:22:24.408683	\N
5913	V	5	261.43	5	2026-10-08 14:22:24.408683	\N
5914	V	5	324.25	5	2026-10-08 14:22:24.408683	\N
5915	V	5	259.13	5	2026-10-08 14:22:24.408683	\N
5916	V	5	193.50	5	2026-10-08 14:22:24.408683	\N
5917	V	5	127.65	5	2026-10-08 14:22:24.408683	\N
5918	V	5	126.72	5	2026-10-08 14:22:24.408683	\N
5919	V	5	127.96	5	2026-10-08 14:22:24.408683	\N
5920	V	5	191.75	5	2026-10-08 14:22:24.408683	\N
5921	V	5	255.94	5	2026-10-08 14:22:24.408683	\N
5922	V	5	255.94	5	2026-10-08 14:22:24.408683	\N
5923	V	5	192.04	5	2026-10-08 14:22:24.408683	\N
5924	V	5	189.28	5	2026-10-08 14:22:24.408683	\N
5925	V	5	186.94	5	2026-10-08 14:22:24.408683	\N
5926	V	5	185.35	5	2026-10-08 14:22:24.408683	\N
5927	V	5	248.69	5	2026-10-08 14:22:24.408683	\N
5928	V	5	312.71	5	2026-10-08 14:22:24.408683	\N
5929	V	5	251.41	5	2026-10-08 14:22:24.408683	\N
5930	V	5	189.97	5	2026-10-08 14:22:24.408683	\N
5931	V	5	191.47	5	2026-10-08 14:22:24.408683	\N
5932	V	5	192.30	5	2026-10-08 14:22:24.408683	\N
5933	V	5	192.36	5	2026-10-08 14:22:24.408683	\N
5934	V	5	256.32	5	2026-10-08 14:22:24.408683	\N
5935	V	5	319.79	5	2026-10-08 14:22:24.408683	\N
5936	V	5	255.69	5	2026-10-08 14:22:24.408683	\N
5937	V	5	191.53	5	2026-10-08 14:22:24.408683	\N
5938	V	5	190.63	5	2026-10-08 14:22:24.408683	\N
5939	V	5	189.55	5	2026-10-08 14:22:24.408683	\N
5940	V	5	187.87	5	2026-10-08 14:22:24.408683	\N
5941	V	5	249.17	5	2026-10-08 14:22:24.408683	\N
5942	V	5	310.60	5	2026-10-08 14:22:24.408683	\N
5943	V	5	247.41	5	2026-10-08 14:22:24.408683	\N
5944	V	5	184.52	5	2026-10-08 14:22:24.408683	\N
5945	V	5	184.75	5	2026-10-08 14:22:24.408683	\N
5946	V	5	185.14	5	2026-10-08 14:22:24.408683	\N
5947	V	5	183.52	5	2026-10-08 14:22:24.408683	\N
5948	V	5	243.46	5	2026-10-08 14:22:24.408683	\N
5949	V	5	303.78	5	2026-10-08 14:22:24.408683	\N
5950	V	5	241.76	5	2026-10-08 14:22:24.408683	\N
5951	V	5	180.07	5	2026-10-08 14:22:24.408683	\N
5952	V	5	181.15	5	2026-10-08 14:22:24.408683	\N
5953	V	5	181.96	5	2026-10-08 14:22:24.408683	\N
5954	V	5	182.62	5	2026-10-08 14:22:24.408683	\N
5955	V	5	243.73	5	2026-10-08 14:22:24.408683	\N
5956	V	5	302.83	5	2026-10-08 14:22:24.408683	\N
5957	V	5	241.94	5	2026-10-08 14:22:24.408683	\N
5958	V	5	181.19	5	2026-10-08 14:22:24.408683	\N
5959	V	5	180.12	5	2026-10-08 14:22:24.408683	\N
5960	V	5	179.46	5	2026-10-08 14:22:24.408683	\N
5961	V	5	180.06	5	2026-10-08 14:22:24.408683	\N
5962	V	5	240.22	5	2026-10-08 14:22:24.408683	\N
5963	V	5	240.22	5	2026-10-08 14:22:24.408683	\N
5964	V	5	180.31	5	2026-10-08 14:22:24.408683	\N
5965	V	5	119.86	5	2026-10-08 14:22:24.408683	\N
5966	V	5	120.83	5	2026-10-08 14:22:24.408683	\N
5967	V	5	121.18	5	2026-10-08 14:22:24.408683	\N
5968	V	5	182.97	5	2026-10-08 14:22:24.408683	\N
5969	V	5	244.63	5	2026-10-08 14:22:24.408683	\N
5970	V	5	305.50	5	2026-10-08 14:22:24.408683	\N
5971	V	5	244.83	5	2026-10-08 14:22:24.408683	\N
5972	V	5	184.32	5	2026-10-08 14:22:24.408683	\N
5973	V	5	184.41	5	2026-10-08 14:22:24.408683	\N
5974	V	5	185.02	5	2026-10-08 14:22:24.408683	\N
5975	V	5	187.33	5	2026-10-08 14:22:24.408683	\N
5976	V	5	250.35	5	2026-10-08 14:22:24.408683	\N
5977	V	5	313.76	5	2026-10-08 14:22:24.408683	\N
5978	V	5	251.88	5	2026-10-08 14:22:24.408683	\N
5979	V	5	189.61	5	2026-10-08 14:22:24.408683	\N
5980	V	5	189.21	5	2026-10-08 14:22:24.408683	\N
5981	V	5	188.18	5	2026-10-08 14:22:24.408683	\N
5982	V	5	187.03	5	2026-10-08 14:22:24.408683	\N
5983	V	5	248.81	5	2026-10-08 14:22:24.408683	\N
5984	V	5	310.69	5	2026-10-08 14:22:24.408683	\N
5985	V	5	247.91	5	2026-10-08 14:22:24.408683	\N
5986	V	5	185.92	5	2026-10-08 14:22:24.408683	\N
5987	V	5	185.59	5	2026-10-08 14:22:24.408683	\N
5988	V	5	185.67	5	2026-10-08 14:22:24.408683	\N
5989	V	5	190.76	5	2026-10-08 14:22:24.408683	\N
5990	V	5	256.73	5	2026-10-08 14:22:24.408683	\N
5991	V	5	322.34	5	2026-10-08 14:22:24.408683	\N
5992	V	5	260.41	5	2026-10-08 14:22:24.408683	\N
5993	V	5	198.55	5	2026-10-08 14:22:24.408683	\N
5994	V	5	196.94	5	2026-10-08 14:22:24.408683	\N
5995	V	5	195.38	5	2026-10-08 14:22:24.408683	\N
5996	V	5	193.54	5	2026-10-08 14:22:24.408683	\N
5997	V	5	257.79	5	2026-10-08 14:22:24.408683	\N
5998	V	5	321.55	5	2026-10-08 14:22:24.408683	\N
5999	V	5	256.18	5	2026-10-08 14:22:24.408683	\N
6000	V	5	191.77	5	2026-10-08 14:22:24.408683	\N
6001	V	5	192.79	5	2026-10-08 14:22:24.408683	\N
6002	V	5	193.81	5	2026-10-08 14:22:24.408683	\N
6003	V	5	194.12	5	2026-10-08 14:22:24.408683	\N
6004	V	5	258.62	5	2026-10-08 14:22:24.408683	\N
6005	V	5	323.77	5	2026-10-08 14:22:24.408683	\N
6006	V	5	259.00	5	2026-10-08 14:22:24.408683	\N
6007	V	5	193.72	5	2026-10-08 14:22:24.408683	\N
6008	V	5	196.18	5	2026-10-08 14:22:24.408683	\N
6009	V	5	197.66	5	2026-10-08 14:22:24.408683	\N
6010	V	5	198.66	5	2026-10-08 14:22:24.408683	\N
6011	V	5	264.88	5	2026-10-08 14:22:24.408683	\N
6012	V	5	330.66	5	2026-10-08 14:22:24.408683	\N
6013	V	5	264.13	5	2026-10-08 14:22:24.408683	\N
6014	V	5	198.15	5	2026-10-08 14:22:24.408683	\N
6015	V	5	132.00	5	2026-10-08 14:22:24.408683	\N
6016	V	5	131.07	5	2026-10-08 14:22:24.408683	\N
6017	V	5	130.82	5	2026-10-08 14:22:24.408683	\N
6018	V	5	195.81	5	2026-10-08 14:22:24.408683	\N
6019	V	5	261.08	5	2026-10-08 14:22:24.408683	\N
6020	V	5	261.08	5	2026-10-08 14:22:24.408683	\N
6021	V	5	195.78	5	2026-10-08 14:22:24.408683	\N
6022	V	5	194.82	5	2026-10-08 14:22:24.408683	\N
6023	V	5	193.29	5	2026-10-08 14:22:24.408683	\N
6024	V	5	190.50	5	2026-10-08 14:22:24.408683	\N
6025	V	5	254.53	5	2026-10-08 14:22:24.408683	\N
6026	V	5	319.25	5	2026-10-08 14:22:24.408683	\N
6027	V	5	254.69	5	2026-10-08 14:22:24.408683	\N
6028	V	5	191.23	5	2026-10-08 14:22:24.408683	\N
6029	V	5	192.68	5	2026-10-08 14:22:24.408683	\N
6030	V	5	193.66	5	2026-10-08 14:22:24.408683	\N
6031	V	5	193.54	5	2026-10-08 14:22:24.408683	\N
6032	V	5	257.35	5	2026-10-08 14:22:24.408683	\N
6033	V	5	321.82	5	2026-10-08 14:22:24.408683	\N
6034	V	5	257.89	5	2026-10-08 14:22:24.408683	\N
6035	V	5	192.88	5	2026-10-08 14:22:24.408683	\N
6036	V	5	193.05	5	2026-10-08 14:22:24.408683	\N
6037	V	5	195.87	5	2026-10-08 14:22:24.408683	\N
6038	V	5	197.46	5	2026-10-08 14:22:24.408683	\N
6039	V	5	262.91	5	2026-10-08 14:22:24.408683	\N
6040	V	5	262.91	5	2026-10-08 14:22:24.408683	\N
6041	V	5	198.15	5	2026-10-08 14:22:24.408683	\N
6042	V	5	131.52	5	2026-10-08 14:22:24.408683	\N
6043	V	5	130.77	5	2026-10-08 14:22:24.408683	\N
6044	V	5	131.02	5	2026-10-08 14:22:24.408683	\N
6045	V	5	197.46	5	2026-10-08 14:22:24.408683	\N
6046	V	5	263.57	5	2026-10-08 14:22:24.408683	\N
6047	V	5	330.81	5	2026-10-08 14:22:24.408683	\N
6048	V	5	265.49	5	2026-10-08 14:22:24.408683	\N
6049	V	5	199.80	5	2026-10-08 14:22:24.408683	\N
6050	V	5	201.68	5	2026-10-08 14:22:24.408683	\N
6051	V	5	204.19	5	2026-10-08 14:22:24.408683	\N
6052	V	5	207.16	5	2026-10-08 14:22:24.408683	\N
6053	V	5	279.59	5	2026-10-08 14:22:24.408683	\N
6054	V	5	279.59	5	2026-10-08 14:22:24.408683	\N
6055	V	5	211.26	5	2026-10-08 14:22:24.408683	\N
6056	V	5	142.64	5	2026-10-08 14:22:24.408683	\N
6057	V	5	143.88	5	2026-10-08 14:22:24.408683	\N
6058	V	5	141.89	5	2026-10-08 14:22:24.408683	\N
6059	V	5	211.40	5	2026-10-08 14:22:24.408683	\N
6060	V	5	281.04	5	2026-10-08 14:22:24.408683	\N
6061	V	5	350.83	5	2026-10-08 14:22:24.408683	\N
6062	V	5	279.38	5	2026-10-08 14:22:24.408683	\N
6063	V	5	208.94	5	2026-10-08 14:22:24.408683	\N
6064	V	5	210.98	5	2026-10-08 14:22:24.408683	\N
6065	V	5	212.55	5	2026-10-08 14:22:24.408683	\N
6066	V	5	213.78	5	2026-10-08 14:22:24.408683	\N
6067	V	5	286.81	5	2026-10-08 14:22:24.408683	\N
6068	V	5	358.52	5	2026-10-08 14:22:24.408683	\N
6069	V	5	286.97	5	2026-10-08 14:22:24.408683	\N
6070	V	5	215.77	5	2026-10-08 14:22:24.408683	\N
6071	V	5	216.85	5	2026-10-08 14:22:24.408683	\N
6072	V	5	214.99	5	2026-10-08 14:22:24.408683	\N
6073	V	5	213.96	5	2026-10-08 14:22:24.408683	\N
6074	V	5	284.28	5	2026-10-08 14:22:24.408683	\N
6075	V	5	355.43	5	2026-10-08 14:22:24.408683	\N
6076	V	5	283.32	5	2026-10-08 14:22:24.408683	\N
6077	V	5	212.15	5	2026-10-08 14:22:24.408683	\N
6078	V	5	213.97	5	2026-10-08 14:22:24.408683	\N
6079	V	5	216.97	5	2026-10-08 14:22:24.408683	\N
6080	V	5	219.57	5	2026-10-08 14:22:24.408683	\N
6081	V	5	292.82	5	2026-10-08 14:22:24.408683	\N
6082	V	5	366.05	5	2026-10-08 14:22:24.408683	\N
6083	V	5	293.54	5	2026-10-08 14:22:24.408683	\N
6084	V	5	220.23	5	2026-10-08 14:22:24.408683	\N
6085	V	5	219.61	5	2026-10-08 14:22:24.408683	\N
6086	V	5	220.28	5	2026-10-08 14:22:24.408683	\N
6087	V	5	220.76	5	2026-10-08 14:22:24.408683	\N
6088	V	5	294.85	5	2026-10-08 14:22:24.408683	\N
6089	V	5	367.35	5	2026-10-08 14:22:24.408683	\N
6090	V	5	294.22	5	2026-10-08 14:22:24.408683	\N
6091	V	5	220.30	5	2026-10-08 14:22:24.408683	\N
6092	V	5	218.86	5	2026-10-08 14:22:24.408683	\N
6093	V	5	217.33	5	2026-10-08 14:22:24.408683	\N
6094	V	5	216.71	5	2026-10-08 14:22:24.408683	\N
6095	V	5	289.80	5	2026-10-08 14:22:24.408683	\N
6096	V	5	362.63	5	2026-10-08 14:22:24.408683	\N
6097	V	5	290.37	5	2026-10-08 14:22:24.408683	\N
6098	V	5	217.80	5	2026-10-08 14:22:24.408683	\N
6099	V	5	217.69	5	2026-10-08 14:22:24.408683	\N
6100	V	5	217.45	5	2026-10-08 14:22:24.408683	\N
6101	V	5	217.73	5	2026-10-08 14:22:24.408683	\N
6102	V	5	290.87	5	2026-10-08 14:22:24.408683	\N
6103	V	5	365.08	5	2026-10-08 14:22:24.408683	\N
6104	V	5	293.31	5	2026-10-08 14:22:24.408683	\N
6105	V	5	220.46	5	2026-10-08 14:22:24.408683	\N
6106	V	5	223.84	5	2026-10-08 14:22:24.408683	\N
6107	V	5	227.52	5	2026-10-08 14:22:24.408683	\N
6108	V	5	230.09	5	2026-10-08 14:22:24.408683	\N
6109	V	5	306.02	5	2026-10-08 14:22:24.408683	\N
6110	V	5	382.34	5	2026-10-08 14:22:24.408683	\N
6111	V	5	305.86	5	2026-10-08 14:22:24.408683	\N
6112	V	5	229.03	5	2026-10-08 14:22:24.408683	\N
6113	V	5	228.13	5	2026-10-08 14:22:24.408683	\N
6114	V	5	226.73	5	2026-10-08 14:22:24.408683	\N
6115	V	5	226.09	5	2026-10-08 14:22:24.408683	\N
6116	V	5	301.84	5	2026-10-08 14:22:24.408683	\N
6117	V	5	376.85	5	2026-10-08 14:22:24.408683	\N
6118	V	5	300.98	5	2026-10-08 14:22:24.408683	\N
6119	V	5	226.44	5	2026-10-08 14:22:24.408683	\N
6120	V	5	150.76	5	2026-10-08 14:22:24.408683	\N
6121	V	5	148.74	5	2026-10-08 14:22:24.408683	\N
6122	V	5	147.21	5	2026-10-08 14:22:24.408683	\N
6123	V	5	220.65	5	2026-10-08 14:22:24.408683	\N
6124	V	5	294.74	5	2026-10-08 14:22:24.408683	\N
6125	V	5	294.74	5	2026-10-08 14:22:24.408683	\N
6126	V	5	221.01	5	2026-10-08 14:22:24.408683	\N
6127	V	5	222.59	5	2026-10-08 14:22:24.408683	\N
6128	V	5	224.27	5	2026-10-08 14:22:24.408683	\N
6129	V	5	224.37	5	2026-10-08 14:22:24.408683	\N
6130	V	5	298.35	5	2026-10-08 14:22:24.408683	\N
6131	V	5	372.01	5	2026-10-08 14:22:24.408683	\N
6132	V	5	296.95	5	2026-10-08 14:22:24.408683	\N
6133	V	5	221.83	5	2026-10-08 14:22:24.408683	\N
6134	V	5	221.63	5	2026-10-08 14:22:24.408683	\N
6135	V	5	220.06	5	2026-10-08 14:22:24.408683	\N
6136	V	5	218.70	5	2026-10-08 14:22:24.408683	\N
6137	V	5	292.30	5	2026-10-08 14:22:24.408683	\N
6138	V	5	365.77	5	2026-10-08 14:22:24.408683	\N
6139	V	5	291.78	5	2026-10-08 14:22:24.408683	\N
6140	V	5	219.38	5	2026-10-08 14:22:24.408683	\N
6141	V	5	220.62	5	2026-10-08 14:22:24.408683	\N
6142	V	5	220.20	5	2026-10-08 14:22:24.408683	\N
6143	V	5	218.59	5	2026-10-08 14:22:24.408683	\N
6144	V	5	290.56	5	2026-10-08 14:22:24.408683	\N
6145	V	5	362.69	5	2026-10-08 14:22:24.408683	\N
6146	V	5	289.14	5	2026-10-08 14:22:24.408683	\N
6147	V	5	215.97	5	2026-10-08 14:22:24.408683	\N
6148	V	5	218.04	5	2026-10-08 14:22:24.408683	\N
6149	V	5	220.20	5	2026-10-08 14:22:24.408683	\N
6150	V	5	222.49	5	2026-10-08 14:22:24.408683	\N
6151	V	5	222.49	5	2026-10-08 14:22:24.408683	\N
6152	V	20	204.89	20	2026-10-08 14:22:24.523865	\N
6153	V	20	221.16	20	2026-10-08 14:22:24.523865	\N
6154	V	20	220.15	20	2026-10-08 14:22:24.523865	\N
6155	V	20	236.46	20	2026-10-08 14:22:24.523865	\N
6156	V	20	236.46	20	2026-10-08 14:22:24.523865	\N
6157	V	20	218.77	20	2026-10-08 14:22:24.523865	\N
6158	V	20	217.32	20	2026-10-08 14:22:24.523865	\N
6159	V	20	215.78	20	2026-10-08 14:22:24.523865	\N
6160	V	20	214.52	20	2026-10-08 14:22:24.523865	\N
6161	V	20	213.62	20	2026-10-08 14:22:24.523865	\N
6162	V	20	229.71	20	2026-10-08 14:22:24.523865	\N
6163	V	20	229.71	20	2026-10-08 14:22:24.523865	\N
6164	V	20	212.56	20	2026-10-08 14:22:24.523865	\N
6165	V	20	212.85	20	2026-10-08 14:22:24.523865	\N
6166	V	20	212.84	20	2026-10-08 14:22:24.523865	\N
6167	V	20	212.95	20	2026-10-08 14:22:24.523865	\N
6168	V	20	212.99	20	2026-10-08 14:22:24.523865	\N
6169	V	20	229.57	20	2026-10-08 14:22:24.523865	\N
6170	V	20	229.57	20	2026-10-08 14:22:24.523865	\N
6171	V	20	229.57	20	2026-10-08 14:22:24.523865	\N
6172	V	20	229.56	20	2026-10-08 14:22:24.523865	\N
6173	V	20	229.70	20	2026-10-08 14:22:24.523865	\N
6174	V	20	229.85	20	2026-10-08 14:22:24.523865	\N
6175	V	20	229.75	20	2026-10-08 14:22:24.523865	\N
6176	V	20	245.45	20	2026-10-08 14:22:24.523865	\N
6177	V	20	245.45	20	2026-10-08 14:22:24.523865	\N
6178	V	20	229.03	20	2026-10-08 14:22:24.523865	\N
6179	V	20	212.76	20	2026-10-08 14:22:24.523865	\N
6180	V	20	212.39	20	2026-10-08 14:22:24.523865	\N
6181	V	20	211.82	20	2026-10-08 14:22:24.523865	\N
6182	V	20	211.67	20	2026-10-08 14:22:24.523865	\N
6183	V	20	227.72	20	2026-10-08 14:22:24.523865	\N
6184	V	20	227.72	20	2026-10-08 14:22:24.523865	\N
6185	V	20	211.03	20	2026-10-08 14:22:24.523865	\N
6186	V	20	209.91	20	2026-10-08 14:22:24.523865	\N
6187	V	20	208.77	20	2026-10-08 14:22:24.523865	\N
6188	V	20	207.96	20	2026-10-08 14:22:24.523865	\N
6189	V	20	207.22	20	2026-10-08 14:22:24.523865	\N
6190	V	20	223.22	20	2026-10-08 14:22:24.523865	\N
6191	V	20	223.22	20	2026-10-08 14:22:24.523865	\N
6192	V	20	206.95	20	2026-10-08 14:22:24.523865	\N
6193	V	20	206.56	20	2026-10-08 14:22:24.523865	\N
6194	V	20	206.14	20	2026-10-08 14:22:24.523865	\N
6195	V	20	205.96	20	2026-10-08 14:22:24.523865	\N
6196	V	20	206.24	20	2026-10-08 14:22:24.523865	\N
6197	V	20	222.11	20	2026-10-08 14:22:24.523865	\N
6198	V	20	222.11	20	2026-10-08 14:22:24.523865	\N
6199	V	20	222.11	20	2026-10-08 14:22:24.523865	\N
6200	V	20	221.93	20	2026-10-08 14:22:24.523865	\N
6201	V	20	221.64	20	2026-10-08 14:22:24.523865	\N
6202	V	20	221.14	20	2026-10-08 14:22:24.523865	\N
6203	V	20	220.42	20	2026-10-08 14:22:24.523865	\N
6204	V	20	235.78	20	2026-10-08 14:22:24.523865	\N
6205	V	20	235.78	20	2026-10-08 14:22:24.523865	\N
6206	V	20	220.45	20	2026-10-08 14:22:24.523865	\N
6207	V	20	220.60	20	2026-10-08 14:22:24.523865	\N
6208	V	20	220.37	20	2026-10-08 14:22:24.523865	\N
6209	V	20	219.48	20	2026-10-08 14:22:24.523865	\N
6210	V	20	218.46	20	2026-10-08 14:22:24.523865	\N
6211	V	20	233.54	20	2026-10-08 14:22:24.523865	\N
6212	V	20	233.54	20	2026-10-08 14:22:24.523865	\N
6213	V	20	217.52	20	2026-10-08 14:22:24.523865	\N
6214	V	20	216.70	20	2026-10-08 14:22:24.523865	\N
6215	V	20	215.86	20	2026-10-08 14:22:24.523865	\N
6216	V	20	215.12	20	2026-10-08 14:22:24.523865	\N
6217	V	20	214.53	20	2026-10-08 14:22:24.523865	\N
6218	V	20	229.30	20	2026-10-08 14:22:24.523865	\N
6219	V	20	229.30	20	2026-10-08 14:22:24.523865	\N
6220	V	20	213.51	20	2026-10-08 14:22:24.523865	\N
6221	V	20	212.76	20	2026-10-08 14:22:24.523865	\N
6222	V	20	212.43	20	2026-10-08 14:22:24.523865	\N
6223	V	20	212.03	20	2026-10-08 14:22:24.523865	\N
6224	V	20	211.71	20	2026-10-08 14:22:24.523865	\N
6225	V	20	211.71	20	2026-10-08 14:22:24.523865	\N
6226	V	20	211.71	20	2026-10-08 14:22:24.523865	\N
6227	V	20	196.20	20	2026-10-08 14:22:24.523865	\N
6228	V	20	195.95	20	2026-10-08 14:22:24.523865	\N
6229	V	20	196.12	20	2026-10-08 14:22:24.523865	\N
6230	V	20	196.59	20	2026-10-08 14:22:24.523865	\N
6231	V	20	196.92	20	2026-10-08 14:22:24.523865	\N
6232	V	20	212.14	20	2026-10-08 14:22:24.523865	\N
6233	V	20	212.14	20	2026-10-08 14:22:24.523865	\N
6234	V	20	196.92	20	2026-10-08 14:22:24.523865	\N
6235	V	20	197.20	20	2026-10-08 14:22:24.523865	\N
6236	V	20	197.52	20	2026-10-08 14:22:24.523865	\N
6237	V	20	198.04	20	2026-10-08 14:22:24.523865	\N
6238	V	20	199.02	20	2026-10-08 14:22:24.523865	\N
6239	V	20	214.87	20	2026-10-08 14:22:24.523865	\N
6240	V	20	214.87	20	2026-10-08 14:22:24.523865	\N
6241	V	20	199.89	20	2026-10-08 14:22:24.523865	\N
6242	V	20	200.48	20	2026-10-08 14:22:24.523865	\N
6243	V	20	201.05	20	2026-10-08 14:22:24.523865	\N
6244	V	20	201.57	20	2026-10-08 14:22:24.523865	\N
6245	V	20	217.02	20	2026-10-08 14:22:24.523865	\N
6246	V	20	232.49	20	2026-10-08 14:22:24.523865	\N
6247	V	20	232.49	20	2026-10-08 14:22:24.523865	\N
6248	V	20	217.32	20	2026-10-08 14:22:24.523865	\N
6249	V	20	217.68	20	2026-10-08 14:22:24.523865	\N
6250	V	20	217.69	20	2026-10-08 14:22:24.523865	\N
6251	V	20	219.02	20	2026-10-08 14:22:24.523865	\N
6252	V	20	220.30	20	2026-10-08 14:22:24.523865	\N
6253	V	20	236.70	20	2026-10-08 14:22:24.523865	\N
6254	V	20	236.70	20	2026-10-08 14:22:24.523865	\N
6255	V	20	221.23	20	2026-10-08 14:22:24.523865	\N
6256	V	20	222.00	20	2026-10-08 14:22:24.523865	\N
6257	V	20	222.31	20	2026-10-08 14:22:24.523865	\N
6258	V	20	222.49	20	2026-10-08 14:22:24.523865	\N
6259	V	20	222.71	20	2026-10-08 14:22:24.523865	\N
6260	V	20	238.65	20	2026-10-08 14:22:24.523865	\N
6261	V	20	238.65	20	2026-10-08 14:22:24.523865	\N
6262	V	20	222.95	20	2026-10-08 14:22:24.523865	\N
6263	V	20	223.64	20	2026-10-08 14:22:24.523865	\N
6264	V	20	224.40	20	2026-10-08 14:22:24.523865	\N
6265	V	20	224.97	20	2026-10-08 14:22:24.523865	\N
6266	V	20	225.63	20	2026-10-08 14:22:24.523865	\N
6267	V	20	241.91	20	2026-10-08 14:22:24.523865	\N
6268	V	20	241.91	20	2026-10-08 14:22:24.523865	\N
6269	V	20	226.43	20	2026-10-08 14:22:24.523865	\N
6270	V	20	227.60	20	2026-10-08 14:22:24.523865	\N
6271	V	20	227.35	20	2026-10-08 14:22:24.523865	\N
6272	V	20	227.40	20	2026-10-08 14:22:24.523865	\N
6273	V	20	227.55	20	2026-10-08 14:22:24.523865	\N
6274	V	20	244.00	20	2026-10-08 14:22:24.523865	\N
6275	V	20	244.00	20	2026-10-08 14:22:24.523865	\N
6276	V	20	227.65	20	2026-10-08 14:22:24.523865	\N
6277	V	20	211.55	20	2026-10-08 14:22:24.523865	\N
6278	V	20	211.94	20	2026-10-08 14:22:24.523865	\N
6279	V	20	212.25	20	2026-10-08 14:22:24.523865	\N
6280	V	20	212.56	20	2026-10-08 14:22:24.523865	\N
6281	V	20	228.88	20	2026-10-08 14:22:24.523865	\N
6282	V	20	228.88	20	2026-10-08 14:22:24.523865	\N
6283	V	20	212.69	20	2026-10-08 14:22:24.523865	\N
6284	V	20	212.50	20	2026-10-08 14:22:24.523865	\N
6285	V	20	212.35	20	2026-10-08 14:22:24.523865	\N
6286	V	20	211.85	20	2026-10-08 14:22:24.523865	\N
6287	V	20	211.57	20	2026-10-08 14:22:24.523865	\N
6288	V	20	227.75	20	2026-10-08 14:22:24.523865	\N
6289	V	20	227.75	20	2026-10-08 14:22:24.523865	\N
6290	V	20	211.12	20	2026-10-08 14:22:24.523865	\N
6291	V	20	210.60	20	2026-10-08 14:22:24.523865	\N
6292	V	20	210.32	20	2026-10-08 14:22:24.523865	\N
6293	V	20	209.91	20	2026-10-08 14:22:24.523865	\N
6294	V	20	209.42	20	2026-10-08 14:22:24.523865	\N
6295	V	20	225.54	20	2026-10-08 14:22:24.523865	\N
6296	V	20	225.54	20	2026-10-08 14:22:24.523865	\N
6297	V	20	225.54	20	2026-10-08 14:22:24.523865	\N
6298	V	20	225.41	20	2026-10-08 14:22:24.523865	\N
6299	V	20	225.68	20	2026-10-08 14:22:24.523865	\N
6300	V	20	225.95	20	2026-10-08 14:22:24.523865	\N
6301	V	20	226.00	20	2026-10-08 14:22:24.523865	\N
6302	V	20	226.00	20	2026-10-08 14:22:24.523865	\N
6303	V	20	226.00	20	2026-10-08 14:22:24.523865	\N
6304	V	20	209.86	20	2026-10-08 14:22:24.523865	\N
6305	V	20	210.32	20	2026-10-08 14:22:24.523865	\N
6306	V	20	211.13	20	2026-10-08 14:22:24.523865	\N
6307	V	20	211.73	20	2026-10-08 14:22:24.523865	\N
6308	V	20	212.08	20	2026-10-08 14:22:24.523865	\N
6309	V	20	228.89	20	2026-10-08 14:22:24.523865	\N
6310	V	20	228.89	20	2026-10-08 14:22:24.523865	\N
6311	V	20	212.90	20	2026-10-08 14:22:24.523865	\N
6312	V	20	213.73	20	2026-10-08 14:22:24.523865	\N
6313	V	20	214.74	20	2026-10-08 14:22:24.523865	\N
6314	V	20	216.34	20	2026-10-08 14:22:24.523865	\N
6315	V	20	218.33	20	2026-10-08 14:22:24.523865	\N
6316	V	20	218.33	20	2026-10-08 14:22:24.523865	\N
6317	V	20	218.33	20	2026-10-08 14:22:24.523865	\N
6318	V	20	202.14	20	2026-10-08 14:22:24.523865	\N
6319	V	20	203.34	20	2026-10-08 14:22:24.523865	\N
6320	V	20	204.44	20	2026-10-08 14:22:24.523865	\N
6321	V	20	205.45	20	2026-10-08 14:22:24.523865	\N
6322	V	20	222.86	20	2026-10-08 14:22:24.523865	\N
6323	V	20	240.31	20	2026-10-08 14:22:24.523865	\N
6324	V	20	240.31	20	2026-10-08 14:22:24.523865	\N
6325	V	20	223.98	20	2026-10-08 14:22:24.523865	\N
6326	V	20	225.44	20	2026-10-08 14:22:24.523865	\N
6327	V	20	226.63	20	2026-10-08 14:22:24.523865	\N
6328	V	20	227.86	20	2026-10-08 14:22:24.523865	\N
6329	V	20	229.31	20	2026-10-08 14:22:24.523865	\N
6330	V	20	247.24	20	2026-10-08 14:22:24.523865	\N
6331	V	20	247.24	20	2026-10-08 14:22:24.523865	\N
6332	V	20	230.15	20	2026-10-08 14:22:24.523865	\N
6333	V	20	231.03	20	2026-10-08 14:22:24.523865	\N
6334	V	20	231.26	20	2026-10-08 14:22:24.523865	\N
6335	V	20	230.83	20	2026-10-08 14:22:24.523865	\N
6336	V	20	248.41	20	2026-10-08 14:22:24.523865	\N
6337	V	20	266.20	20	2026-10-08 14:22:24.523865	\N
6338	V	20	266.20	20	2026-10-08 14:22:24.523865	\N
6339	V	20	248.33	20	2026-10-08 14:22:24.523865	\N
6340	V	20	248.85	20	2026-10-08 14:22:24.523865	\N
6341	V	20	249.80	20	2026-10-08 14:22:24.523865	\N
6342	V	20	250.83	20	2026-10-08 14:22:24.523865	\N
6343	V	20	251.69	20	2026-10-08 14:22:24.523865	\N
6344	V	20	270.00	20	2026-10-08 14:22:24.523865	\N
6345	V	20	270.00	20	2026-10-08 14:22:24.523865	\N
6346	V	20	252.11	20	2026-10-08 14:22:24.523865	\N
6347	V	20	252.60	20	2026-10-08 14:22:24.523865	\N
6348	V	20	253.32	20	2026-10-08 14:22:24.523865	\N
6349	V	20	253.49	20	2026-10-08 14:22:24.523865	\N
6350	V	20	254.08	20	2026-10-08 14:22:24.523865	\N
6351	V	20	272.21	20	2026-10-08 14:22:24.523865	\N
6352	V	20	272.21	20	2026-10-08 14:22:24.523865	\N
6353	V	20	254.18	20	2026-10-08 14:22:24.523865	\N
6354	V	20	254.45	20	2026-10-08 14:22:24.523865	\N
6355	V	20	254.93	20	2026-10-08 14:22:24.523865	\N
6356	V	20	255.32	20	2026-10-08 14:22:24.523865	\N
6357	V	20	255.80	20	2026-10-08 14:22:24.523865	\N
6358	V	20	274.01	20	2026-10-08 14:22:24.523865	\N
6359	V	20	274.01	20	2026-10-08 14:22:24.523865	\N
6360	V	20	255.88	20	2026-10-08 14:22:24.523865	\N
6361	V	20	255.50	20	2026-10-08 14:22:24.523865	\N
6362	V	20	255.27	20	2026-10-08 14:22:24.523865	\N
6363	V	20	255.23	20	2026-10-08 14:22:24.523865	\N
6364	V	20	255.21	20	2026-10-08 14:22:24.523865	\N
6365	V	20	273.77	20	2026-10-08 14:22:24.523865	\N
6366	V	20	273.77	20	2026-10-08 14:22:24.523865	\N
6367	V	20	255.48	20	2026-10-08 14:22:24.523865	\N
6368	V	20	256.12	20	2026-10-08 14:22:24.523865	\N
6369	V	20	256.90	20	2026-10-08 14:22:24.523865	\N
6370	V	20	257.58	20	2026-10-08 14:22:24.523865	\N
6371	V	20	258.43	20	2026-10-08 14:22:24.523865	\N
6372	V	20	277.51	20	2026-10-08 14:22:24.523865	\N
6373	V	20	277.51	20	2026-10-08 14:22:24.523865	\N
6374	V	20	259.45	20	2026-10-08 14:22:24.523865	\N
6375	V	20	260.27	20	2026-10-08 14:22:24.523865	\N
6376	V	20	260.94	20	2026-10-08 14:22:24.523865	\N
6377	V	20	261.58	20	2026-10-08 14:22:24.523865	\N
6378	V	20	262.31	20	2026-10-08 14:22:24.523865	\N
6379	V	20	281.07	20	2026-10-08 14:22:24.523865	\N
6380	V	20	281.07	20	2026-10-08 14:22:24.523865	\N
6381	V	20	263.13	20	2026-10-08 14:22:24.523865	\N
6382	V	20	244.91	20	2026-10-08 14:22:24.523865	\N
6383	V	20	245.07	20	2026-10-08 14:22:24.523865	\N
6384	V	20	245.15	20	2026-10-08 14:22:24.523865	\N
6385	V	20	244.96	20	2026-10-08 14:22:24.523865	\N
6386	V	20	263.48	20	2026-10-08 14:22:24.523865	\N
6387	V	20	263.48	20	2026-10-08 14:22:24.523865	\N
6388	V	20	244.36	20	2026-10-08 14:22:24.523865	\N
6389	V	20	243.92	20	2026-10-08 14:22:24.523865	\N
6390	V	20	243.51	20	2026-10-08 14:22:24.523865	\N
6391	V	20	243.07	20	2026-10-08 14:22:24.523865	\N
6392	V	20	242.49	20	2026-10-08 14:22:24.523865	\N
6393	V	20	260.90	20	2026-10-08 14:22:24.523865	\N
6394	V	20	260.90	20	2026-10-08 14:22:24.523865	\N
6395	V	20	241.93	20	2026-10-08 14:22:24.523865	\N
6396	V	20	241.80	20	2026-10-08 14:22:24.523865	\N
6397	V	20	240.98	20	2026-10-08 14:22:24.523865	\N
6398	V	20	240.12	20	2026-10-08 14:22:24.523865	\N
6399	V	20	239.76	20	2026-10-08 14:22:24.523865	\N
6400	V	20	258.13	20	2026-10-08 14:22:24.523865	\N
6401	V	20	258.13	20	2026-10-08 14:22:24.523865	\N
6402	V	20	258.13	20	2026-10-08 14:22:24.523865	\N
6403	V	20	258.09	20	2026-10-08 14:22:24.523865	\N
6404	V	20	258.01	20	2026-10-08 14:22:24.523865	\N
6405	V	20	257.62	20	2026-10-08 14:22:24.523865	\N
6406	V	20	257.09	20	2026-10-08 14:22:24.523865	\N
6407	V	20	275.12	20	2026-10-08 14:22:24.523865	\N
6408	V	20	275.12	20	2026-10-08 14:22:24.523865	\N
6409	V	20	256.36	20	2026-10-08 14:22:24.523865	\N
6410	V	20	256.06	20	2026-10-08 14:22:24.523865	\N
6411	V	20	256.05	20	2026-10-08 14:22:24.523865	\N
6412	V	20	237.74	20	2026-10-08 14:22:24.523865	\N
6413	MSFT	50	496.13	50	2026-10-08 14:25:25.708913	\N
6414	NVDA	50	220.58	50	2026-10-08 14:25:25.812855	\N
6415	LLY	50	1174.29	50	2026-10-08 14:25:25.887979	\N
6416	JNJ	50	265.40	50	2026-10-08 14:25:25.954941	\N
6417	JPM	50	350.77	50	2026-10-08 14:25:26.057171	\N
6418	V	50	369.22	50	2026-10-08 14:25:26.12393	\N
6419	AMZN	50	258.01	50	2026-10-08 14:25:26.210031	\N
6420	DIS	50	104.74	50	2026-10-08 14:25:26.27827	\N
6421	XOM	50	161.09	50	2026-10-08 14:25:26.356018	\N
6422	CVX	50	203.48	50	2026-10-08 14:25:26.422022	\N
6423	V	20	368.77	20	2026-10-10 14:29:40.607184	\N
6424	V	5	140.06	5	2026-10-10 14:29:43.502285	\N
6425	V	5	211.57	5	2026-10-10 14:29:43.502285	\N
6426	V	5	213.45	5	2026-10-10 14:29:43.502285	\N
6427	V	5	283.89	5	2026-10-10 14:29:43.502285	\N
6428	V	5	353.85	5	2026-10-10 14:29:43.502285	\N
6429	V	5	283.09	5	2026-10-10 14:29:43.502285	\N
6430	V	5	211.58	5	2026-10-10 14:29:43.502285	\N
6431	V	5	209.04	5	2026-10-10 14:29:43.502285	\N
6432	V	5	204.17	5	2026-10-10 14:29:43.502285	\N
6433	V	5	200.05	5	2026-10-10 14:29:43.502285	\N
6434	V	5	265.60	5	2026-10-10 14:29:43.502285	\N
6435	V	5	331.26	5	2026-10-10 14:29:43.502285	\N
6436	V	5	262.62	5	2026-10-10 14:29:43.502285	\N
6437	V	5	197.04	5	2026-10-10 14:29:43.502285	\N
6438	V	5	131.21	5	2026-10-10 14:29:43.502285	\N
6439	V	5	130.82	5	2026-10-10 14:29:43.502285	\N
6440	V	5	130.22	5	2026-10-10 14:29:43.502285	\N
6441	V	5	195.49	5	2026-10-10 14:29:43.502285	\N
6442	V	5	260.73	5	2026-10-10 14:29:43.502285	\N
6443	V	5	260.73	5	2026-10-10 14:29:43.502285	\N
6444	V	5	195.56	5	2026-10-10 14:29:43.502285	\N
6445	V	5	196.21	5	2026-10-10 14:29:43.502285	\N
6446	V	5	195.99	5	2026-10-10 14:29:43.502285	\N
6447	V	5	196.15	5	2026-10-10 14:29:43.502285	\N
6448	V	5	262.51	5	2026-10-10 14:29:43.502285	\N
6449	V	5	326.87	5	2026-10-10 14:29:43.502285	\N
6450	V	5	261.17	5	2026-10-10 14:29:43.502285	\N
6451	V	5	196.12	5	2026-10-10 14:29:43.502285	\N
6452	V	5	197.49	5	2026-10-10 14:29:43.502285	\N
6453	V	5	196.92	5	2026-10-10 14:29:43.502285	\N
6454	V	5	198.54	5	2026-10-10 14:29:43.502285	\N
6455	V	5	264.37	5	2026-10-10 14:29:43.502285	\N
6456	V	5	330.69	5	2026-10-10 14:29:43.502285	\N
6457	V	5	263.92	5	2026-10-10 14:29:43.502285	\N
6458	V	5	198.13	5	2026-10-10 14:29:43.502285	\N
6459	V	5	197.26	5	2026-10-10 14:29:43.502285	\N
6460	V	5	197.07	5	2026-10-10 14:29:43.502285	\N
6461	V	5	196.60	5	2026-10-10 14:29:43.502285	\N
6462	V	5	261.43	5	2026-10-10 14:29:43.502285	\N
6463	V	5	324.25	5	2026-10-10 14:29:43.502285	\N
6464	V	5	259.13	5	2026-10-10 14:29:43.502285	\N
6465	V	5	193.50	5	2026-10-10 14:29:43.502285	\N
6466	V	5	127.65	5	2026-10-10 14:29:43.502285	\N
6467	V	5	126.72	5	2026-10-10 14:29:43.502285	\N
6468	V	5	127.96	5	2026-10-10 14:29:43.502285	\N
6469	V	5	191.75	5	2026-10-10 14:29:43.502285	\N
6470	V	5	255.94	5	2026-10-10 14:29:43.502285	\N
6471	V	5	255.94	5	2026-10-10 14:29:43.502285	\N
6472	V	5	192.04	5	2026-10-10 14:29:43.502285	\N
6473	V	5	189.28	5	2026-10-10 14:29:43.502285	\N
6474	V	5	186.94	5	2026-10-10 14:29:43.502285	\N
6475	V	5	185.35	5	2026-10-10 14:29:43.502285	\N
6476	V	5	248.69	5	2026-10-10 14:29:43.502285	\N
6477	V	5	312.71	5	2026-10-10 14:29:43.502285	\N
6478	V	5	251.41	5	2026-10-10 14:29:43.502285	\N
6479	V	5	189.97	5	2026-10-10 14:29:43.502285	\N
6480	V	5	191.47	5	2026-10-10 14:29:43.502285	\N
6481	V	5	192.30	5	2026-10-10 14:29:43.502285	\N
6482	V	5	192.36	5	2026-10-10 14:29:43.502285	\N
6483	V	5	256.32	5	2026-10-10 14:29:43.502285	\N
6484	V	5	319.79	5	2026-10-10 14:29:43.502285	\N
6485	V	5	255.69	5	2026-10-10 14:29:43.502285	\N
6486	V	5	191.53	5	2026-10-10 14:29:43.502285	\N
6487	V	5	190.63	5	2026-10-10 14:29:43.502285	\N
6488	V	5	189.55	5	2026-10-10 14:29:43.502285	\N
6489	V	5	187.87	5	2026-10-10 14:29:43.502285	\N
6490	V	5	249.17	5	2026-10-10 14:29:43.502285	\N
6491	V	5	310.60	5	2026-10-10 14:29:43.502285	\N
6492	V	5	247.41	5	2026-10-10 14:29:43.502285	\N
6493	V	5	184.52	5	2026-10-10 14:29:43.502285	\N
6494	V	5	184.75	5	2026-10-10 14:29:43.502285	\N
6495	V	5	185.14	5	2026-10-10 14:29:43.502285	\N
6496	V	5	183.52	5	2026-10-10 14:29:43.502285	\N
6497	V	5	243.46	5	2026-10-10 14:29:43.502285	\N
6498	V	5	303.78	5	2026-10-10 14:29:43.502285	\N
6499	V	5	241.76	5	2026-10-10 14:29:43.502285	\N
6500	V	5	180.07	5	2026-10-10 14:29:43.502285	\N
6501	V	5	181.15	5	2026-10-10 14:29:43.502285	\N
6502	V	5	181.96	5	2026-10-10 14:29:43.502285	\N
6503	V	5	182.62	5	2026-10-10 14:29:43.502285	\N
6504	V	5	243.73	5	2026-10-10 14:29:43.502285	\N
6505	V	5	302.83	5	2026-10-10 14:29:43.502285	\N
6506	V	5	241.94	5	2026-10-10 14:29:43.502285	\N
6507	V	5	181.19	5	2026-10-10 14:29:43.502285	\N
6508	V	5	180.12	5	2026-10-10 14:29:43.502285	\N
6509	V	5	179.46	5	2026-10-10 14:29:43.502285	\N
6510	V	5	180.06	5	2026-10-10 14:29:43.502285	\N
6511	V	5	240.22	5	2026-10-10 14:29:43.502285	\N
6512	V	5	240.22	5	2026-10-10 14:29:43.502285	\N
6513	V	5	180.31	5	2026-10-10 14:29:43.502285	\N
6514	V	5	119.86	5	2026-10-10 14:29:43.502285	\N
6515	V	5	120.83	5	2026-10-10 14:29:43.502285	\N
6516	V	5	121.18	5	2026-10-10 14:29:43.502285	\N
6517	V	5	182.97	5	2026-10-10 14:29:43.502285	\N
6518	V	5	244.63	5	2026-10-10 14:29:43.502285	\N
6519	V	5	305.50	5	2026-10-10 14:29:43.502285	\N
6520	V	5	244.83	5	2026-10-10 14:29:43.502285	\N
6521	V	5	184.32	5	2026-10-10 14:29:43.502285	\N
6522	V	5	184.41	5	2026-10-10 14:29:43.502285	\N
6523	V	5	185.02	5	2026-10-10 14:29:43.502285	\N
6524	V	5	187.33	5	2026-10-10 14:29:43.502285	\N
6525	V	5	250.35	5	2026-10-10 14:29:43.502285	\N
6526	V	5	313.76	5	2026-10-10 14:29:43.502285	\N
6527	V	5	251.88	5	2026-10-10 14:29:43.502285	\N
6528	V	5	189.61	5	2026-10-10 14:29:43.502285	\N
6529	V	5	189.21	5	2026-10-10 14:29:43.502285	\N
6530	V	5	188.18	5	2026-10-10 14:29:43.502285	\N
6531	V	5	187.03	5	2026-10-10 14:29:43.502285	\N
6532	V	5	248.81	5	2026-10-10 14:29:43.502285	\N
6533	V	5	310.69	5	2026-10-10 14:29:43.502285	\N
6534	V	5	247.91	5	2026-10-10 14:29:43.502285	\N
6535	V	5	185.92	5	2026-10-10 14:29:43.502285	\N
6536	V	5	185.59	5	2026-10-10 14:29:43.502285	\N
6537	V	5	185.67	5	2026-10-10 14:29:43.502285	\N
6538	V	5	190.76	5	2026-10-10 14:29:43.502285	\N
6539	V	5	256.73	5	2026-10-10 14:29:43.502285	\N
6540	V	5	322.34	5	2026-10-10 14:29:43.502285	\N
6541	V	5	260.41	5	2026-10-10 14:29:43.502285	\N
6542	V	5	198.55	5	2026-10-10 14:29:43.502285	\N
6543	V	5	196.94	5	2026-10-10 14:29:43.502285	\N
6544	V	5	195.38	5	2026-10-10 14:29:43.502285	\N
6545	V	5	193.54	5	2026-10-10 14:29:43.502285	\N
6546	V	5	257.79	5	2026-10-10 14:29:43.502285	\N
6547	V	5	321.55	5	2026-10-10 14:29:43.502285	\N
6548	V	5	256.18	5	2026-10-10 14:29:43.502285	\N
6549	V	5	191.77	5	2026-10-10 14:29:43.502285	\N
6550	V	5	192.79	5	2026-10-10 14:29:43.502285	\N
6551	V	5	193.81	5	2026-10-10 14:29:43.502285	\N
6552	V	5	194.12	5	2026-10-10 14:29:43.502285	\N
6553	V	5	258.62	5	2026-10-10 14:29:43.502285	\N
6554	V	5	323.77	5	2026-10-10 14:29:43.502285	\N
6555	V	5	259.00	5	2026-10-10 14:29:43.502285	\N
6556	V	5	193.72	5	2026-10-10 14:29:43.502285	\N
6557	V	5	196.18	5	2026-10-10 14:29:43.502285	\N
6558	V	5	197.66	5	2026-10-10 14:29:43.502285	\N
6559	V	5	198.66	5	2026-10-10 14:29:43.502285	\N
6560	V	5	264.88	5	2026-10-10 14:29:43.502285	\N
6561	V	5	330.66	5	2026-10-10 14:29:43.502285	\N
6562	V	5	264.13	5	2026-10-10 14:29:43.502285	\N
6563	V	5	198.15	5	2026-10-10 14:29:43.502285	\N
6564	V	5	132.00	5	2026-10-10 14:29:43.502285	\N
6565	V	5	131.07	5	2026-10-10 14:29:43.502285	\N
6566	V	5	130.82	5	2026-10-10 14:29:43.502285	\N
6567	V	5	195.81	5	2026-10-10 14:29:43.502285	\N
6568	V	5	261.08	5	2026-10-10 14:29:43.502285	\N
6569	V	5	261.08	5	2026-10-10 14:29:43.502285	\N
6570	V	5	195.78	5	2026-10-10 14:29:43.502285	\N
6571	V	5	194.82	5	2026-10-10 14:29:43.502285	\N
6572	V	5	193.29	5	2026-10-10 14:29:43.502285	\N
6573	V	5	190.50	5	2026-10-10 14:29:43.502285	\N
6574	V	5	254.53	5	2026-10-10 14:29:43.502285	\N
6575	V	5	319.25	5	2026-10-10 14:29:43.502285	\N
6576	V	5	254.69	5	2026-10-10 14:29:43.502285	\N
6577	V	5	191.23	5	2026-10-10 14:29:43.502285	\N
6578	V	5	192.68	5	2026-10-10 14:29:43.502285	\N
6579	V	5	193.66	5	2026-10-10 14:29:43.502285	\N
6580	V	5	193.54	5	2026-10-10 14:29:43.502285	\N
6581	V	5	257.35	5	2026-10-10 14:29:43.502285	\N
6582	V	5	321.82	5	2026-10-10 14:29:43.502285	\N
6583	V	5	257.89	5	2026-10-10 14:29:43.502285	\N
6584	V	5	192.88	5	2026-10-10 14:29:43.502285	\N
6585	V	5	193.05	5	2026-10-10 14:29:43.502285	\N
6586	V	5	195.87	5	2026-10-10 14:29:43.502285	\N
6587	V	5	197.46	5	2026-10-10 14:29:43.502285	\N
6588	V	5	262.91	5	2026-10-10 14:29:43.502285	\N
6589	V	5	262.91	5	2026-10-10 14:29:43.502285	\N
6590	V	5	198.15	5	2026-10-10 14:29:43.502285	\N
6591	V	5	131.52	5	2026-10-10 14:29:43.502285	\N
6592	V	5	130.77	5	2026-10-10 14:29:43.502285	\N
6593	V	5	131.02	5	2026-10-10 14:29:43.502285	\N
6594	V	5	197.46	5	2026-10-10 14:29:43.502285	\N
6595	V	5	263.57	5	2026-10-10 14:29:43.502285	\N
6596	V	5	330.81	5	2026-10-10 14:29:43.502285	\N
6597	V	5	265.49	5	2026-10-10 14:29:43.502285	\N
6598	V	5	199.80	5	2026-10-10 14:29:43.502285	\N
6599	V	5	201.68	5	2026-10-10 14:29:43.502285	\N
6600	V	5	204.19	5	2026-10-10 14:29:43.502285	\N
6601	V	5	207.16	5	2026-10-10 14:29:43.502285	\N
6602	V	5	279.59	5	2026-10-10 14:29:43.502285	\N
6603	V	5	279.59	5	2026-10-10 14:29:43.502285	\N
6604	V	5	211.26	5	2026-10-10 14:29:43.502285	\N
6605	V	5	142.64	5	2026-10-10 14:29:43.502285	\N
6606	V	5	143.88	5	2026-10-10 14:29:43.502285	\N
6607	V	5	141.89	5	2026-10-10 14:29:43.502285	\N
6608	V	5	211.40	5	2026-10-10 14:29:43.502285	\N
6609	V	5	281.04	5	2026-10-10 14:29:43.502285	\N
6610	V	5	350.83	5	2026-10-10 14:29:43.502285	\N
6611	V	5	279.38	5	2026-10-10 14:29:43.502285	\N
6612	V	5	208.94	5	2026-10-10 14:29:43.502285	\N
6613	V	5	210.98	5	2026-10-10 14:29:43.502285	\N
6614	V	5	212.55	5	2026-10-10 14:29:43.502285	\N
6615	V	5	213.78	5	2026-10-10 14:29:43.502285	\N
6616	V	5	286.81	5	2026-10-10 14:29:43.502285	\N
6617	V	5	358.52	5	2026-10-10 14:29:43.502285	\N
6618	V	5	286.97	5	2026-10-10 14:29:43.502285	\N
6619	V	5	215.77	5	2026-10-10 14:29:43.502285	\N
6620	V	5	216.85	5	2026-10-10 14:29:43.502285	\N
6621	V	5	214.99	5	2026-10-10 14:29:43.502285	\N
6622	V	5	213.96	5	2026-10-10 14:29:43.502285	\N
6623	V	5	284.28	5	2026-10-10 14:29:43.502285	\N
6624	V	5	355.43	5	2026-10-10 14:29:43.502285	\N
6625	V	5	283.32	5	2026-10-10 14:29:43.502285	\N
6626	V	5	212.15	5	2026-10-10 14:29:43.502285	\N
6627	V	5	213.97	5	2026-10-10 14:29:43.502285	\N
6628	V	5	216.97	5	2026-10-10 14:29:43.502285	\N
6629	V	5	219.57	5	2026-10-10 14:29:43.502285	\N
6630	V	5	292.82	5	2026-10-10 14:29:43.502285	\N
6631	V	5	366.05	5	2026-10-10 14:29:43.502285	\N
6632	V	5	293.54	5	2026-10-10 14:29:43.502285	\N
6633	V	5	220.23	5	2026-10-10 14:29:43.502285	\N
6634	V	5	219.61	5	2026-10-10 14:29:43.502285	\N
6635	V	5	220.28	5	2026-10-10 14:29:43.502285	\N
6636	V	5	220.76	5	2026-10-10 14:29:43.502285	\N
6637	V	5	294.85	5	2026-10-10 14:29:43.502285	\N
6638	V	5	367.35	5	2026-10-10 14:29:43.502285	\N
6639	V	5	294.22	5	2026-10-10 14:29:43.502285	\N
6640	V	5	220.30	5	2026-10-10 14:29:43.502285	\N
6641	V	5	218.86	5	2026-10-10 14:29:43.502285	\N
6642	V	5	217.33	5	2026-10-10 14:29:43.502285	\N
6643	V	5	216.71	5	2026-10-10 14:29:43.502285	\N
6644	V	5	289.80	5	2026-10-10 14:29:43.502285	\N
6645	V	5	362.63	5	2026-10-10 14:29:43.502285	\N
6646	V	5	290.37	5	2026-10-10 14:29:43.502285	\N
6647	V	5	217.80	5	2026-10-10 14:29:43.502285	\N
6648	V	5	217.69	5	2026-10-10 14:29:43.502285	\N
6649	V	5	217.45	5	2026-10-10 14:29:43.502285	\N
6650	V	5	217.73	5	2026-10-10 14:29:43.502285	\N
6651	V	5	290.87	5	2026-10-10 14:29:43.502285	\N
6652	V	5	365.08	5	2026-10-10 14:29:43.502285	\N
6653	V	5	293.31	5	2026-10-10 14:29:43.502285	\N
6654	V	5	220.46	5	2026-10-10 14:29:43.502285	\N
6655	V	5	223.84	5	2026-10-10 14:29:43.502285	\N
6656	V	5	227.52	5	2026-10-10 14:29:43.502285	\N
6657	V	5	230.09	5	2026-10-10 14:29:43.502285	\N
6658	V	5	306.02	5	2026-10-10 14:29:43.502285	\N
6659	V	5	382.34	5	2026-10-10 14:29:43.502285	\N
6660	V	5	305.86	5	2026-10-10 14:29:43.502285	\N
6661	V	5	229.03	5	2026-10-10 14:29:43.502285	\N
6662	V	5	228.13	5	2026-10-10 14:29:43.502285	\N
6663	V	5	226.73	5	2026-10-10 14:29:43.502285	\N
6664	V	5	226.09	5	2026-10-10 14:29:43.502285	\N
6665	V	5	301.84	5	2026-10-10 14:29:43.502285	\N
6666	V	5	376.85	5	2026-10-10 14:29:43.502285	\N
6667	V	5	300.98	5	2026-10-10 14:29:43.502285	\N
6668	V	5	226.44	5	2026-10-10 14:29:43.502285	\N
6669	V	5	150.76	5	2026-10-10 14:29:43.502285	\N
6670	V	5	148.74	5	2026-10-10 14:29:43.502285	\N
6671	V	5	147.21	5	2026-10-10 14:29:43.502285	\N
6672	V	5	220.65	5	2026-10-10 14:29:43.502285	\N
6673	V	5	294.74	5	2026-10-10 14:29:43.502285	\N
6674	V	5	294.74	5	2026-10-10 14:29:43.502285	\N
6675	V	5	221.01	5	2026-10-10 14:29:43.502285	\N
6676	V	5	222.59	5	2026-10-10 14:29:43.502285	\N
6677	V	5	224.27	5	2026-10-10 14:29:43.502285	\N
6678	V	5	224.37	5	2026-10-10 14:29:43.502285	\N
6679	V	5	298.35	5	2026-10-10 14:29:43.502285	\N
6680	V	5	372.01	5	2026-10-10 14:29:43.502285	\N
6681	V	5	296.95	5	2026-10-10 14:29:43.502285	\N
6682	V	5	221.83	5	2026-10-10 14:29:43.502285	\N
6683	V	5	221.63	5	2026-10-10 14:29:43.502285	\N
6684	V	5	220.06	5	2026-10-10 14:29:43.502285	\N
6685	V	5	218.70	5	2026-10-10 14:29:43.502285	\N
6686	V	5	292.30	5	2026-10-10 14:29:43.502285	\N
6687	V	5	365.77	5	2026-10-10 14:29:43.502285	\N
6688	V	5	291.78	5	2026-10-10 14:29:43.502285	\N
6689	V	5	219.38	5	2026-10-10 14:29:43.502285	\N
6690	V	5	220.62	5	2026-10-10 14:29:43.502285	\N
6691	V	5	220.20	5	2026-10-10 14:29:43.502285	\N
6692	V	5	218.59	5	2026-10-10 14:29:43.502285	\N
6693	V	5	290.56	5	2026-10-10 14:29:43.502285	\N
6694	V	5	362.69	5	2026-10-10 14:29:43.502285	\N
6695	V	5	289.14	5	2026-10-10 14:29:43.502285	\N
6696	V	5	215.97	5	2026-10-10 14:29:43.502285	\N
6697	V	5	218.04	5	2026-10-10 14:29:43.502285	\N
6698	V	5	220.20	5	2026-10-10 14:29:43.502285	\N
6699	V	5	222.49	5	2026-10-10 14:29:43.502285	\N
6700	V	5	297.51	5	2026-10-10 14:29:43.502285	\N
6701	V	5	374.60	5	2026-10-10 14:29:43.502285	\N
6702	V	20	204.89	20	2026-10-10 14:29:43.634102	\N
6703	V	20	221.16	20	2026-10-10 14:29:43.634102	\N
6704	V	20	220.15	20	2026-10-10 14:29:43.634102	\N
6705	V	20	236.46	20	2026-10-10 14:29:43.634102	\N
6706	V	20	236.46	20	2026-10-10 14:29:43.634102	\N
6707	V	20	218.77	20	2026-10-10 14:29:43.634102	\N
6708	V	20	217.32	20	2026-10-10 14:29:43.634102	\N
6709	V	20	215.78	20	2026-10-10 14:29:43.634102	\N
6710	V	20	214.52	20	2026-10-10 14:29:43.634102	\N
6711	V	20	213.62	20	2026-10-10 14:29:43.634102	\N
6712	V	20	229.71	20	2026-10-10 14:29:43.634102	\N
6713	V	20	229.71	20	2026-10-10 14:29:43.634102	\N
6714	V	20	212.56	20	2026-10-10 14:29:43.634102	\N
6715	V	20	212.85	20	2026-10-10 14:29:43.634102	\N
6716	V	20	212.84	20	2026-10-10 14:29:43.634102	\N
6717	V	20	212.95	20	2026-10-10 14:29:43.634102	\N
6718	V	20	212.99	20	2026-10-10 14:29:43.634102	\N
6719	V	20	229.57	20	2026-10-10 14:29:43.634102	\N
6720	V	20	229.57	20	2026-10-10 14:29:43.634102	\N
6721	V	20	229.57	20	2026-10-10 14:29:43.634102	\N
6722	V	20	229.56	20	2026-10-10 14:29:43.634102	\N
6723	V	20	229.70	20	2026-10-10 14:29:43.634102	\N
6724	V	20	229.85	20	2026-10-10 14:29:43.634102	\N
6725	V	20	229.75	20	2026-10-10 14:29:43.634102	\N
6726	V	20	245.45	20	2026-10-10 14:29:43.634102	\N
6727	V	20	245.45	20	2026-10-10 14:29:43.634102	\N
6728	V	20	229.03	20	2026-10-10 14:29:43.634102	\N
6729	V	20	212.76	20	2026-10-10 14:29:43.634102	\N
6730	V	20	212.39	20	2026-10-10 14:29:43.634102	\N
6731	V	20	211.82	20	2026-10-10 14:29:43.634102	\N
6732	V	20	211.67	20	2026-10-10 14:29:43.634102	\N
6733	V	20	227.72	20	2026-10-10 14:29:43.634102	\N
6734	V	20	227.72	20	2026-10-10 14:29:43.634102	\N
6735	V	20	211.03	20	2026-10-10 14:29:43.634102	\N
6736	V	20	209.91	20	2026-10-10 14:29:43.634102	\N
6737	V	20	208.77	20	2026-10-10 14:29:43.634102	\N
6738	V	20	207.96	20	2026-10-10 14:29:43.634102	\N
6739	V	20	207.22	20	2026-10-10 14:29:43.634102	\N
6740	V	20	223.22	20	2026-10-10 14:29:43.634102	\N
6741	V	20	223.22	20	2026-10-10 14:29:43.634102	\N
6742	V	20	206.95	20	2026-10-10 14:29:43.634102	\N
6743	V	20	206.56	20	2026-10-10 14:29:43.634102	\N
6744	V	20	206.14	20	2026-10-10 14:29:43.634102	\N
6745	V	20	205.96	20	2026-10-10 14:29:43.634102	\N
6746	V	20	206.24	20	2026-10-10 14:29:43.634102	\N
6747	V	20	222.11	20	2026-10-10 14:29:43.634102	\N
6748	V	20	222.11	20	2026-10-10 14:29:43.634102	\N
6749	V	20	222.11	20	2026-10-10 14:29:43.634102	\N
6750	V	20	221.93	20	2026-10-10 14:29:43.634102	\N
6751	V	20	221.64	20	2026-10-10 14:29:43.634102	\N
6752	V	20	221.14	20	2026-10-10 14:29:43.634102	\N
6753	V	20	220.42	20	2026-10-10 14:29:43.634102	\N
6754	V	20	235.78	20	2026-10-10 14:29:43.634102	\N
6755	V	20	235.78	20	2026-10-10 14:29:43.634102	\N
6756	V	20	220.45	20	2026-10-10 14:29:43.634102	\N
6757	V	20	220.60	20	2026-10-10 14:29:43.634102	\N
6758	V	20	220.37	20	2026-10-10 14:29:43.634102	\N
6759	V	20	219.48	20	2026-10-10 14:29:43.634102	\N
6760	V	20	218.46	20	2026-10-10 14:29:43.634102	\N
6761	V	20	233.54	20	2026-10-10 14:29:43.634102	\N
6762	V	20	233.54	20	2026-10-10 14:29:43.634102	\N
6763	V	20	217.52	20	2026-10-10 14:29:43.634102	\N
6764	V	20	216.70	20	2026-10-10 14:29:43.634102	\N
6765	V	20	215.86	20	2026-10-10 14:29:43.634102	\N
6766	V	20	215.12	20	2026-10-10 14:29:43.634102	\N
6767	V	20	214.53	20	2026-10-10 14:29:43.634102	\N
6768	V	20	229.30	20	2026-10-10 14:29:43.634102	\N
6769	V	20	229.30	20	2026-10-10 14:29:43.634102	\N
6770	V	20	213.51	20	2026-10-10 14:29:43.634102	\N
6771	V	20	212.76	20	2026-10-10 14:29:43.634102	\N
6772	V	20	212.43	20	2026-10-10 14:29:43.634102	\N
6773	V	20	212.03	20	2026-10-10 14:29:43.634102	\N
6774	V	20	211.71	20	2026-10-10 14:29:43.634102	\N
6775	V	20	211.71	20	2026-10-10 14:29:43.634102	\N
6776	V	20	211.71	20	2026-10-10 14:29:43.634102	\N
6777	V	20	196.20	20	2026-10-10 14:29:43.634102	\N
6778	V	20	195.95	20	2026-10-10 14:29:43.634102	\N
6779	V	20	196.12	20	2026-10-10 14:29:43.634102	\N
6780	V	20	196.59	20	2026-10-10 14:29:43.634102	\N
6781	V	20	196.92	20	2026-10-10 14:29:43.634102	\N
6782	V	20	212.14	20	2026-10-10 14:29:43.634102	\N
6783	V	20	212.14	20	2026-10-10 14:29:43.634102	\N
6784	V	20	196.92	20	2026-10-10 14:29:43.634102	\N
6785	V	20	197.20	20	2026-10-10 14:29:43.634102	\N
6786	V	20	197.52	20	2026-10-10 14:29:43.634102	\N
6787	V	20	198.04	20	2026-10-10 14:29:43.634102	\N
6788	V	20	199.02	20	2026-10-10 14:29:43.634102	\N
6789	V	20	214.87	20	2026-10-10 14:29:43.634102	\N
6790	V	20	214.87	20	2026-10-10 14:29:43.634102	\N
6791	V	20	199.89	20	2026-10-10 14:29:43.634102	\N
6792	V	20	200.48	20	2026-10-10 14:29:43.634102	\N
6793	V	20	201.05	20	2026-10-10 14:29:43.634102	\N
6794	V	20	201.57	20	2026-10-10 14:29:43.634102	\N
6795	V	20	217.02	20	2026-10-10 14:29:43.634102	\N
6796	V	20	232.49	20	2026-10-10 14:29:43.634102	\N
6797	V	20	232.49	20	2026-10-10 14:29:43.634102	\N
6798	V	20	217.32	20	2026-10-10 14:29:43.634102	\N
6799	V	20	217.68	20	2026-10-10 14:29:43.634102	\N
6800	V	20	217.69	20	2026-10-10 14:29:43.634102	\N
6801	V	20	219.02	20	2026-10-10 14:29:43.634102	\N
6802	V	20	220.30	20	2026-10-10 14:29:43.634102	\N
6803	V	20	236.70	20	2026-10-10 14:29:43.634102	\N
6804	V	20	236.70	20	2026-10-10 14:29:43.634102	\N
6805	V	20	221.23	20	2026-10-10 14:29:43.634102	\N
6806	V	20	222.00	20	2026-10-10 14:29:43.634102	\N
6807	V	20	222.31	20	2026-10-10 14:29:43.634102	\N
6808	V	20	222.49	20	2026-10-10 14:29:43.634102	\N
6809	V	20	222.71	20	2026-10-10 14:29:43.634102	\N
6810	V	20	238.65	20	2026-10-10 14:29:43.634102	\N
6811	V	20	238.65	20	2026-10-10 14:29:43.634102	\N
6812	V	20	222.95	20	2026-10-10 14:29:43.634102	\N
6813	V	20	223.64	20	2026-10-10 14:29:43.634102	\N
6814	V	20	224.40	20	2026-10-10 14:29:43.634102	\N
6815	V	20	224.97	20	2026-10-10 14:29:43.634102	\N
6816	V	20	225.63	20	2026-10-10 14:29:43.634102	\N
6817	V	20	241.91	20	2026-10-10 14:29:43.634102	\N
6818	V	20	241.91	20	2026-10-10 14:29:43.634102	\N
6819	V	20	226.43	20	2026-10-10 14:29:43.634102	\N
6820	V	20	227.60	20	2026-10-10 14:29:43.634102	\N
6821	V	20	227.35	20	2026-10-10 14:29:43.634102	\N
6822	V	20	227.40	20	2026-10-10 14:29:43.634102	\N
6823	V	20	227.55	20	2026-10-10 14:29:43.634102	\N
6824	V	20	244.00	20	2026-10-10 14:29:43.634102	\N
6825	V	20	244.00	20	2026-10-10 14:29:43.634102	\N
6826	V	20	227.65	20	2026-10-10 14:29:43.634102	\N
6827	V	20	211.55	20	2026-10-10 14:29:43.634102	\N
6828	V	20	211.94	20	2026-10-10 14:29:43.634102	\N
6829	V	20	212.25	20	2026-10-10 14:29:43.634102	\N
6830	V	20	212.56	20	2026-10-10 14:29:43.634102	\N
6831	V	20	228.88	20	2026-10-10 14:29:43.634102	\N
6832	V	20	228.88	20	2026-10-10 14:29:43.634102	\N
6833	V	20	212.69	20	2026-10-10 14:29:43.634102	\N
6834	V	20	212.50	20	2026-10-10 14:29:43.634102	\N
6835	V	20	212.35	20	2026-10-10 14:29:43.634102	\N
6836	V	20	211.85	20	2026-10-10 14:29:43.634102	\N
6837	V	20	211.57	20	2026-10-10 14:29:43.634102	\N
6838	V	20	227.75	20	2026-10-10 14:29:43.634102	\N
6839	V	20	227.75	20	2026-10-10 14:29:43.634102	\N
6840	V	20	211.12	20	2026-10-10 14:29:43.634102	\N
6841	V	20	210.60	20	2026-10-10 14:29:43.634102	\N
6842	V	20	210.32	20	2026-10-10 14:29:43.634102	\N
6843	V	20	209.91	20	2026-10-10 14:29:43.634102	\N
6844	V	20	209.42	20	2026-10-10 14:29:43.634102	\N
6845	V	20	225.54	20	2026-10-10 14:29:43.634102	\N
6846	V	20	225.54	20	2026-10-10 14:29:43.634102	\N
6847	V	20	225.54	20	2026-10-10 14:29:43.634102	\N
6848	V	20	225.41	20	2026-10-10 14:29:43.634102	\N
6849	V	20	225.68	20	2026-10-10 14:29:43.634102	\N
6850	V	20	225.95	20	2026-10-10 14:29:43.634102	\N
6851	V	20	226.00	20	2026-10-10 14:29:43.634102	\N
6852	V	20	226.00	20	2026-10-10 14:29:43.634102	\N
6853	V	20	226.00	20	2026-10-10 14:29:43.634102	\N
6854	V	20	209.86	20	2026-10-10 14:29:43.634102	\N
6855	V	20	210.32	20	2026-10-10 14:29:43.634102	\N
6856	V	20	211.13	20	2026-10-10 14:29:43.634102	\N
6857	V	20	211.73	20	2026-10-10 14:29:43.634102	\N
6858	V	20	212.08	20	2026-10-10 14:29:43.634102	\N
6859	V	20	228.89	20	2026-10-10 14:29:43.634102	\N
6860	V	20	228.89	20	2026-10-10 14:29:43.634102	\N
6861	V	20	212.90	20	2026-10-10 14:29:43.634102	\N
6862	V	20	213.73	20	2026-10-10 14:29:43.634102	\N
6863	V	20	214.74	20	2026-10-10 14:29:43.634102	\N
6864	V	20	216.34	20	2026-10-10 14:29:43.634102	\N
6865	V	20	218.33	20	2026-10-10 14:29:43.634102	\N
6866	V	20	218.33	20	2026-10-10 14:29:43.634102	\N
6867	V	20	218.33	20	2026-10-10 14:29:43.634102	\N
6868	V	20	202.14	20	2026-10-10 14:29:43.634102	\N
6869	V	20	203.34	20	2026-10-10 14:29:43.634102	\N
6870	V	20	204.44	20	2026-10-10 14:29:43.634102	\N
6871	V	20	205.45	20	2026-10-10 14:29:43.634102	\N
6872	V	20	222.86	20	2026-10-10 14:29:43.634102	\N
6873	V	20	240.31	20	2026-10-10 14:29:43.634102	\N
6874	V	20	240.31	20	2026-10-10 14:29:43.634102	\N
6875	V	20	223.98	20	2026-10-10 14:29:43.634102	\N
6876	V	20	225.44	20	2026-10-10 14:29:43.634102	\N
6877	V	20	226.63	20	2026-10-10 14:29:43.634102	\N
6878	V	20	227.86	20	2026-10-10 14:29:43.634102	\N
6879	V	20	229.31	20	2026-10-10 14:29:43.634102	\N
6880	V	20	247.24	20	2026-10-10 14:29:43.634102	\N
6881	V	20	247.24	20	2026-10-10 14:29:43.634102	\N
6882	V	20	230.15	20	2026-10-10 14:29:43.634102	\N
6883	V	20	231.03	20	2026-10-10 14:29:43.634102	\N
6884	V	20	231.26	20	2026-10-10 14:29:43.634102	\N
6885	V	20	230.83	20	2026-10-10 14:29:43.634102	\N
6886	V	20	248.41	20	2026-10-10 14:29:43.634102	\N
6887	V	20	266.20	20	2026-10-10 14:29:43.634102	\N
6888	V	20	266.20	20	2026-10-10 14:29:43.634102	\N
6889	V	20	248.33	20	2026-10-10 14:29:43.634102	\N
6890	V	20	248.85	20	2026-10-10 14:29:43.634102	\N
6891	V	20	249.80	20	2026-10-10 14:29:43.634102	\N
6892	V	20	250.83	20	2026-10-10 14:29:43.634102	\N
6893	V	20	251.69	20	2026-10-10 14:29:43.634102	\N
6894	V	20	270.00	20	2026-10-10 14:29:43.634102	\N
6895	V	20	270.00	20	2026-10-10 14:29:43.634102	\N
6896	V	20	252.11	20	2026-10-10 14:29:43.634102	\N
6897	V	20	252.60	20	2026-10-10 14:29:43.634102	\N
6898	V	20	253.32	20	2026-10-10 14:29:43.634102	\N
6899	V	20	253.49	20	2026-10-10 14:29:43.634102	\N
6900	V	20	254.08	20	2026-10-10 14:29:43.634102	\N
6901	V	20	272.21	20	2026-10-10 14:29:43.634102	\N
6902	V	20	272.21	20	2026-10-10 14:29:43.634102	\N
6903	V	20	254.18	20	2026-10-10 14:29:43.634102	\N
6904	V	20	254.45	20	2026-10-10 14:29:43.634102	\N
6905	V	20	254.93	20	2026-10-10 14:29:43.634102	\N
6906	V	20	255.32	20	2026-10-10 14:29:43.634102	\N
6907	V	20	255.80	20	2026-10-10 14:29:43.634102	\N
6908	V	20	274.01	20	2026-10-10 14:29:43.634102	\N
6909	V	20	274.01	20	2026-10-10 14:29:43.634102	\N
6910	V	20	255.88	20	2026-10-10 14:29:43.634102	\N
6911	V	20	255.50	20	2026-10-10 14:29:43.634102	\N
6912	V	20	255.27	20	2026-10-10 14:29:43.634102	\N
6913	V	20	255.23	20	2026-10-10 14:29:43.634102	\N
6914	V	20	255.21	20	2026-10-10 14:29:43.634102	\N
6915	V	20	273.77	20	2026-10-10 14:29:43.634102	\N
6916	V	20	273.77	20	2026-10-10 14:29:43.634102	\N
6917	V	20	255.48	20	2026-10-10 14:29:43.634102	\N
6918	V	20	256.12	20	2026-10-10 14:29:43.634102	\N
6919	V	20	256.90	20	2026-10-10 14:29:43.634102	\N
6920	V	20	257.58	20	2026-10-10 14:29:43.634102	\N
6921	V	20	258.43	20	2026-10-10 14:29:43.634102	\N
6922	V	20	277.51	20	2026-10-10 14:29:43.634102	\N
6923	V	20	277.51	20	2026-10-10 14:29:43.634102	\N
6924	V	20	259.45	20	2026-10-10 14:29:43.634102	\N
6925	V	20	260.27	20	2026-10-10 14:29:43.634102	\N
6926	V	20	260.94	20	2026-10-10 14:29:43.634102	\N
6927	V	20	261.58	20	2026-10-10 14:29:43.634102	\N
6928	V	20	262.31	20	2026-10-10 14:29:43.634102	\N
6929	V	20	281.07	20	2026-10-10 14:29:43.634102	\N
6930	V	20	281.07	20	2026-10-10 14:29:43.634102	\N
6931	V	20	263.13	20	2026-10-10 14:29:43.634102	\N
6932	V	20	244.91	20	2026-10-10 14:29:43.634102	\N
6933	V	20	245.07	20	2026-10-10 14:29:43.634102	\N
6934	V	20	245.15	20	2026-10-10 14:29:43.634102	\N
6935	V	20	244.96	20	2026-10-10 14:29:43.634102	\N
6936	V	20	263.48	20	2026-10-10 14:29:43.634102	\N
6937	V	20	263.48	20	2026-10-10 14:29:43.634102	\N
6938	V	20	244.36	20	2026-10-10 14:29:43.634102	\N
6939	V	20	243.92	20	2026-10-10 14:29:43.634102	\N
6940	V	20	243.51	20	2026-10-10 14:29:43.634102	\N
6941	V	20	243.07	20	2026-10-10 14:29:43.634102	\N
6942	V	20	242.49	20	2026-10-10 14:29:43.634102	\N
6943	V	20	260.90	20	2026-10-10 14:29:43.634102	\N
6944	V	20	260.90	20	2026-10-10 14:29:43.634102	\N
6945	V	20	241.93	20	2026-10-10 14:29:43.634102	\N
6946	V	20	241.80	20	2026-10-10 14:29:43.634102	\N
6947	V	20	240.98	20	2026-10-10 14:29:43.634102	\N
6948	V	20	240.12	20	2026-10-10 14:29:43.634102	\N
6949	V	20	239.76	20	2026-10-10 14:29:43.634102	\N
6950	V	20	258.13	20	2026-10-10 14:29:43.634102	\N
6951	V	20	258.13	20	2026-10-10 14:29:43.634102	\N
6952	V	20	258.13	20	2026-10-10 14:29:43.634102	\N
6953	V	20	258.09	20	2026-10-10 14:29:43.634102	\N
6954	V	20	258.01	20	2026-10-10 14:29:43.634102	\N
6955	V	20	257.62	20	2026-10-10 14:29:43.634102	\N
6956	V	20	257.09	20	2026-10-10 14:29:43.634102	\N
6957	V	20	275.12	20	2026-10-10 14:29:43.634102	\N
6958	V	20	275.12	20	2026-10-10 14:29:43.634102	\N
6959	V	20	256.36	20	2026-10-10 14:29:43.634102	\N
6960	V	20	256.06	20	2026-10-10 14:29:43.634102	\N
6961	V	20	256.05	20	2026-10-10 14:29:43.634102	\N
6962	V	20	256.15	20	2026-10-10 14:29:43.634102	\N
6963	V	20	256.49	20	2026-10-10 14:29:43.634102	\N
6964	V	20	368.77	20	2026-10-11 13:38:39.235887	2026-10-09
6965	V	5	140.06	5	2026-10-11 13:42:08.9142	2026-01-05
6966	V	5	211.57	5	2026-10-11 13:42:08.9142	2026-01-06
6967	V	5	213.45	5	2026-10-11 13:42:08.9142	2026-01-07
6968	V	5	283.89	5	2026-10-11 13:42:08.9142	2026-01-08
6969	V	5	353.85	5	2026-10-11 13:42:08.9142	2026-01-09
6970	V	5	283.09	5	2026-10-11 13:42:08.9142	2026-01-10
6971	V	5	211.58	5	2026-10-11 13:42:08.9142	2026-01-11
6972	V	5	209.04	5	2026-10-11 13:42:08.9142	2026-01-12
6973	V	5	204.17	5	2026-10-11 13:42:08.9142	2026-01-13
6974	V	5	200.05	5	2026-10-11 13:42:08.9142	2026-01-14
6975	V	5	265.60	5	2026-10-11 13:42:08.9142	2026-01-15
6976	V	5	331.26	5	2026-10-11 13:42:08.9142	2026-01-16
6977	V	5	262.62	5	2026-10-11 13:42:08.9142	2026-01-17
6978	V	5	197.04	5	2026-10-11 13:42:08.9142	2026-01-18
6979	V	5	131.21	5	2026-10-11 13:42:08.9142	2026-01-19
6980	V	5	130.82	5	2026-10-11 13:42:08.9142	2026-01-20
6981	V	5	130.22	5	2026-10-11 13:42:08.9142	2026-01-21
6982	V	5	195.49	5	2026-10-11 13:42:08.9142	2026-01-22
6983	V	5	260.73	5	2026-10-11 13:42:08.9142	2026-01-23
6984	V	5	260.73	5	2026-10-11 13:42:08.9142	2026-01-24
6985	V	5	195.56	5	2026-10-11 13:42:08.9142	2026-01-25
6986	V	5	196.21	5	2026-10-11 13:42:08.9142	2026-01-26
6987	V	5	195.99	5	2026-10-11 13:42:08.9142	2026-01-27
6988	V	5	196.15	5	2026-10-11 13:42:08.9142	2026-01-28
6989	V	5	262.51	5	2026-10-11 13:42:08.9142	2026-01-29
6990	V	5	326.87	5	2026-10-11 13:42:08.9142	2026-01-30
6991	V	5	261.17	5	2026-10-11 13:42:08.9142	2026-01-31
6992	V	5	196.12	5	2026-10-11 13:42:08.9142	2026-02-01
6993	V	5	197.49	5	2026-10-11 13:42:08.9142	2026-02-02
6994	V	5	196.92	5	2026-10-11 13:42:08.9142	2026-02-03
6995	V	5	198.54	5	2026-10-11 13:42:08.9142	2026-02-04
6996	V	5	264.37	5	2026-10-11 13:42:08.9142	2026-02-05
6997	V	5	330.69	5	2026-10-11 13:42:08.9142	2026-02-06
6998	V	5	263.92	5	2026-10-11 13:42:08.9142	2026-02-07
6999	V	5	198.13	5	2026-10-11 13:42:08.9142	2026-02-08
7000	V	5	197.26	5	2026-10-11 13:42:08.9142	2026-02-09
7001	V	5	197.07	5	2026-10-11 13:42:08.9142	2026-02-10
7002	V	5	196.60	5	2026-10-11 13:42:08.9142	2026-02-11
7003	V	5	261.43	5	2026-10-11 13:42:08.9142	2026-02-12
7004	V	5	324.25	5	2026-10-11 13:42:08.9142	2026-02-13
7005	V	5	259.13	5	2026-10-11 13:42:08.9142	2026-02-14
7006	V	5	193.50	5	2026-10-11 13:42:08.9142	2026-02-15
7007	V	5	127.65	5	2026-10-11 13:42:08.9142	2026-02-16
7008	V	5	126.72	5	2026-10-11 13:42:08.9142	2026-02-17
7009	V	5	127.96	5	2026-10-11 13:42:08.9142	2026-02-18
7010	V	5	191.75	5	2026-10-11 13:42:08.9142	2026-02-19
7011	V	5	255.94	5	2026-10-11 13:42:08.9142	2026-02-20
7012	V	5	255.94	5	2026-10-11 13:42:08.9142	2026-02-21
7013	V	5	192.04	5	2026-10-11 13:42:08.9142	2026-02-22
7014	V	5	189.28	5	2026-10-11 13:42:08.9142	2026-02-23
7015	V	5	186.94	5	2026-10-11 13:42:08.9142	2026-02-24
7016	V	5	185.35	5	2026-10-11 13:42:08.9142	2026-02-25
7017	V	5	248.69	5	2026-10-11 13:42:08.9142	2026-02-26
7018	V	5	312.71	5	2026-10-11 13:42:08.9142	2026-02-27
7019	V	5	251.41	5	2026-10-11 13:42:08.9142	2026-02-28
7020	V	5	189.97	5	2026-10-11 13:42:08.9142	2026-03-01
7021	V	5	191.47	5	2026-10-11 13:42:08.9142	2026-03-02
7022	V	5	192.30	5	2026-10-11 13:42:08.9142	2026-03-03
7023	V	5	192.36	5	2026-10-11 13:42:08.9142	2026-03-04
7024	V	5	256.32	5	2026-10-11 13:42:08.9142	2026-03-05
7025	V	5	319.79	5	2026-10-11 13:42:08.9142	2026-03-06
7026	V	5	255.69	5	2026-10-11 13:42:08.9142	2026-03-07
7027	V	5	191.53	5	2026-10-11 13:42:08.9142	2026-03-08
7028	V	5	190.63	5	2026-10-11 13:42:08.9142	2026-03-09
7029	V	5	189.55	5	2026-10-11 13:42:08.9142	2026-03-10
7030	V	5	187.87	5	2026-10-11 13:42:08.9142	2026-03-11
7031	V	5	249.17	5	2026-10-11 13:42:08.9142	2026-03-12
7032	V	5	310.60	5	2026-10-11 13:42:08.9142	2026-03-13
7033	V	5	247.41	5	2026-10-11 13:42:08.9142	2026-03-14
7034	V	5	184.52	5	2026-10-11 13:42:08.9142	2026-03-15
7035	V	5	184.75	5	2026-10-11 13:42:08.9142	2026-03-16
7036	V	5	185.14	5	2026-10-11 13:42:08.9142	2026-03-17
7037	V	5	183.52	5	2026-10-11 13:42:08.9142	2026-03-18
7038	V	5	243.46	5	2026-10-11 13:42:08.9142	2026-03-19
7039	V	5	303.78	5	2026-10-11 13:42:08.9142	2026-03-20
7040	V	5	241.76	5	2026-10-11 13:42:08.9142	2026-03-21
7041	V	5	180.07	5	2026-10-11 13:42:08.9142	2026-03-22
7042	V	5	181.15	5	2026-10-11 13:42:08.9142	2026-03-23
7043	V	5	181.96	5	2026-10-11 13:42:08.9142	2026-03-24
7044	V	5	182.62	5	2026-10-11 13:42:08.9142	2026-03-25
7045	V	5	243.73	5	2026-10-11 13:42:08.9142	2026-03-26
7046	V	5	302.83	5	2026-10-11 13:42:08.9142	2026-03-27
7047	V	5	241.94	5	2026-10-11 13:42:08.9142	2026-03-28
7048	V	5	181.19	5	2026-10-11 13:42:08.9142	2026-03-29
7049	V	5	180.12	5	2026-10-11 13:42:08.9142	2026-03-30
7050	V	5	179.46	5	2026-10-11 13:42:08.9142	2026-03-31
7051	V	5	180.06	5	2026-10-11 13:42:08.9142	2026-04-01
7052	V	5	240.22	5	2026-10-11 13:42:08.9142	2026-04-02
7053	V	5	240.22	5	2026-10-11 13:42:08.9142	2026-04-03
7054	V	5	180.31	5	2026-10-11 13:42:08.9142	2026-04-04
7055	V	5	119.86	5	2026-10-11 13:42:08.9142	2026-04-05
7056	V	5	120.83	5	2026-10-11 13:42:08.9142	2026-04-06
7057	V	5	121.18	5	2026-10-11 13:42:08.9142	2026-04-07
7058	V	5	182.97	5	2026-10-11 13:42:08.9142	2026-04-08
7059	V	5	244.63	5	2026-10-11 13:42:08.9142	2026-04-09
7060	V	5	305.50	5	2026-10-11 13:42:08.9142	2026-04-10
7061	V	5	244.83	5	2026-10-11 13:42:08.9142	2026-04-11
7062	V	5	184.32	5	2026-10-11 13:42:08.9142	2026-04-12
7063	V	5	184.41	5	2026-10-11 13:42:08.9142	2026-04-13
7064	V	5	185.02	5	2026-10-11 13:42:08.9142	2026-04-14
7065	V	5	187.33	5	2026-10-11 13:42:08.9142	2026-04-15
7066	V	5	250.35	5	2026-10-11 13:42:08.9142	2026-04-16
7067	V	5	313.76	5	2026-10-11 13:42:08.9142	2026-04-17
7068	V	5	251.88	5	2026-10-11 13:42:08.9142	2026-04-18
7069	V	5	189.61	5	2026-10-11 13:42:08.9142	2026-04-19
7070	V	5	189.21	5	2026-10-11 13:42:08.9142	2026-04-20
7071	V	5	188.18	5	2026-10-11 13:42:08.9142	2026-04-21
7072	V	5	187.03	5	2026-10-11 13:42:08.9142	2026-04-22
7073	V	5	248.81	5	2026-10-11 13:42:08.9142	2026-04-23
7074	V	5	310.69	5	2026-10-11 13:42:08.9142	2026-04-24
7075	V	5	247.91	5	2026-10-11 13:42:08.9142	2026-04-25
7076	V	5	185.92	5	2026-10-11 13:42:08.9142	2026-04-26
7077	V	5	185.59	5	2026-10-11 13:42:08.9142	2026-04-27
7078	V	5	185.67	5	2026-10-11 13:42:08.9142	2026-04-28
7079	V	5	190.76	5	2026-10-11 13:42:08.9142	2026-04-29
7080	V	5	256.73	5	2026-10-11 13:42:08.9142	2026-04-30
7081	V	5	322.34	5	2026-10-11 13:42:08.9142	2026-05-01
7082	V	5	260.41	5	2026-10-11 13:42:08.9142	2026-05-02
7083	V	5	198.55	5	2026-10-11 13:42:08.9142	2026-05-03
7084	V	5	196.94	5	2026-10-11 13:42:08.9142	2026-05-04
7085	V	5	195.38	5	2026-10-11 13:42:08.9142	2026-05-05
7086	V	5	193.54	5	2026-10-11 13:42:08.9142	2026-05-06
7087	V	5	257.79	5	2026-10-11 13:42:08.9142	2026-05-07
7088	V	5	321.55	5	2026-10-11 13:42:08.9142	2026-05-08
7089	V	5	256.18	5	2026-10-11 13:42:08.9142	2026-05-09
7090	V	5	191.77	5	2026-10-11 13:42:08.9142	2026-05-10
7091	V	5	192.79	5	2026-10-11 13:42:08.9142	2026-05-11
7092	V	5	193.81	5	2026-10-11 13:42:08.9142	2026-05-12
7093	V	5	194.12	5	2026-10-11 13:42:08.9142	2026-05-13
7094	V	5	258.62	5	2026-10-11 13:42:08.9142	2026-05-14
7095	V	5	323.77	5	2026-10-11 13:42:08.9142	2026-05-15
7096	V	5	259.00	5	2026-10-11 13:42:08.9142	2026-05-16
7097	V	5	193.72	5	2026-10-11 13:42:08.9142	2026-05-17
7098	V	5	196.18	5	2026-10-11 13:42:08.9142	2026-05-18
7099	V	5	197.66	5	2026-10-11 13:42:08.9142	2026-05-19
7100	V	5	198.66	5	2026-10-11 13:42:08.9142	2026-05-20
7101	V	5	264.88	5	2026-10-11 13:42:08.9142	2026-05-21
7102	V	5	330.66	5	2026-10-11 13:42:08.9142	2026-05-22
7103	V	5	264.13	5	2026-10-11 13:42:08.9142	2026-05-23
7104	V	5	198.15	5	2026-10-11 13:42:08.9142	2026-05-24
7105	V	5	132.00	5	2026-10-11 13:42:08.9142	2026-05-25
7106	V	5	131.07	5	2026-10-11 13:42:08.9142	2026-05-26
7107	V	5	130.82	5	2026-10-11 13:42:08.9142	2026-05-27
7108	V	5	195.81	5	2026-10-11 13:42:08.9142	2026-05-28
7109	V	5	261.08	5	2026-10-11 13:42:08.9142	2026-05-29
7110	V	5	261.08	5	2026-10-11 13:42:08.9142	2026-05-30
7111	V	5	195.78	5	2026-10-11 13:42:08.9142	2026-05-31
7112	V	5	194.82	5	2026-10-11 13:42:08.9142	2026-06-01
7113	V	5	193.29	5	2026-10-11 13:42:08.9142	2026-06-02
7114	V	5	190.50	5	2026-10-11 13:42:08.9142	2026-06-03
7115	V	5	254.53	5	2026-10-11 13:42:08.9142	2026-06-04
7116	V	5	319.25	5	2026-10-11 13:42:08.9142	2026-06-05
7117	V	5	254.69	5	2026-10-11 13:42:08.9142	2026-06-06
7118	V	5	191.23	5	2026-10-11 13:42:08.9142	2026-06-07
7119	V	5	192.68	5	2026-10-11 13:42:08.9142	2026-06-08
7120	V	5	193.66	5	2026-10-11 13:42:08.9142	2026-06-09
7121	V	5	193.54	5	2026-10-11 13:42:08.9142	2026-06-10
7122	V	5	257.35	5	2026-10-11 13:42:08.9142	2026-06-11
7123	V	5	321.82	5	2026-10-11 13:42:08.9142	2026-06-12
7124	V	5	257.89	5	2026-10-11 13:42:08.9142	2026-06-13
7125	V	5	192.88	5	2026-10-11 13:42:08.9142	2026-06-14
7126	V	5	193.05	5	2026-10-11 13:42:08.9142	2026-06-15
7127	V	5	195.87	5	2026-10-11 13:42:08.9142	2026-06-16
7128	V	5	197.46	5	2026-10-11 13:42:08.9142	2026-06-17
7129	V	5	262.91	5	2026-10-11 13:42:08.9142	2026-06-18
7130	V	5	262.91	5	2026-10-11 13:42:08.9142	2026-06-19
7131	V	5	198.15	5	2026-10-11 13:42:08.9142	2026-06-20
7132	V	5	131.52	5	2026-10-11 13:42:08.9142	2026-06-21
7133	V	5	130.77	5	2026-10-11 13:42:08.9142	2026-06-22
7134	V	5	131.02	5	2026-10-11 13:42:08.9142	2026-06-23
7135	V	5	197.46	5	2026-10-11 13:42:08.9142	2026-06-24
7136	V	5	263.57	5	2026-10-11 13:42:08.9142	2026-06-25
7137	V	5	330.81	5	2026-10-11 13:42:08.9142	2026-06-26
7138	V	5	265.49	5	2026-10-11 13:42:08.9142	2026-06-27
7139	V	5	199.80	5	2026-10-11 13:42:08.9142	2026-06-28
7140	V	5	201.68	5	2026-10-11 13:42:08.9142	2026-06-29
7141	V	5	204.19	5	2026-10-11 13:42:08.9142	2026-06-30
7142	V	5	207.16	5	2026-10-11 13:42:08.9142	2026-07-01
7143	V	5	279.59	5	2026-10-11 13:42:08.9142	2026-07-02
7144	V	5	279.59	5	2026-10-11 13:42:08.9142	2026-07-03
7145	V	5	211.26	5	2026-10-11 13:42:08.9142	2026-07-04
7146	V	5	142.64	5	2026-10-11 13:42:08.9142	2026-07-05
7147	V	5	143.88	5	2026-10-11 13:42:08.9142	2026-07-06
7148	V	5	141.89	5	2026-10-11 13:42:08.9142	2026-07-07
7149	V	5	211.40	5	2026-10-11 13:42:08.9142	2026-07-08
7150	V	5	281.04	5	2026-10-11 13:42:08.9142	2026-07-09
7151	V	5	350.83	5	2026-10-11 13:42:08.9142	2026-07-10
7152	V	5	279.38	5	2026-10-11 13:42:08.9142	2026-07-11
7153	V	5	208.94	5	2026-10-11 13:42:08.9142	2026-07-12
7154	V	5	210.98	5	2026-10-11 13:42:08.9142	2026-07-13
7155	V	5	212.55	5	2026-10-11 13:42:08.9142	2026-07-14
7156	V	5	213.78	5	2026-10-11 13:42:08.9142	2026-07-15
7157	V	5	286.81	5	2026-10-11 13:42:08.9142	2026-07-16
7158	V	5	358.52	5	2026-10-11 13:42:08.9142	2026-07-17
7159	V	5	286.97	5	2026-10-11 13:42:08.9142	2026-07-18
7160	V	5	215.77	5	2026-10-11 13:42:08.9142	2026-07-19
7161	V	5	216.85	5	2026-10-11 13:42:08.9142	2026-07-20
7162	V	5	214.99	5	2026-10-11 13:42:08.9142	2026-07-21
7163	V	5	213.96	5	2026-10-11 13:42:08.9142	2026-07-22
7164	V	5	284.28	5	2026-10-11 13:42:08.9142	2026-07-23
7165	V	5	355.43	5	2026-10-11 13:42:08.9142	2026-07-24
7166	V	5	283.32	5	2026-10-11 13:42:08.9142	2026-07-25
7167	V	5	212.15	5	2026-10-11 13:42:08.9142	2026-07-26
7168	V	5	213.97	5	2026-10-11 13:42:08.9142	2026-07-27
7169	V	5	216.97	5	2026-10-11 13:42:08.9142	2026-07-28
7170	V	5	219.57	5	2026-10-11 13:42:08.9142	2026-07-29
7171	V	5	292.82	5	2026-10-11 13:42:08.9142	2026-07-30
7172	V	5	366.05	5	2026-10-11 13:42:08.9142	2026-07-31
7173	V	5	293.54	5	2026-10-11 13:42:08.9142	2026-08-01
7174	V	5	220.23	5	2026-10-11 13:42:08.9142	2026-08-02
7175	V	5	219.61	5	2026-10-11 13:42:08.9142	2026-08-03
7176	V	5	220.28	5	2026-10-11 13:42:08.9142	2026-08-04
7177	V	5	220.76	5	2026-10-11 13:42:08.9142	2026-08-05
7178	V	5	294.85	5	2026-10-11 13:42:08.9142	2026-08-06
7179	V	5	367.35	5	2026-10-11 13:42:08.9142	2026-08-07
7180	V	5	294.22	5	2026-10-11 13:42:08.9142	2026-08-08
7181	V	5	220.30	5	2026-10-11 13:42:08.9142	2026-08-09
7182	V	5	218.86	5	2026-10-11 13:42:08.9142	2026-08-10
7183	V	5	217.33	5	2026-10-11 13:42:08.9142	2026-08-11
7184	V	5	216.71	5	2026-10-11 13:42:08.9142	2026-08-12
7185	V	5	289.80	5	2026-10-11 13:42:08.9142	2026-08-13
7186	V	5	362.63	5	2026-10-11 13:42:08.9142	2026-08-14
7187	V	5	290.37	5	2026-10-11 13:42:08.9142	2026-08-15
7188	V	5	217.80	5	2026-10-11 13:42:08.9142	2026-08-16
7189	V	5	217.69	5	2026-10-11 13:42:08.9142	2026-08-17
7190	V	5	217.45	5	2026-10-11 13:42:08.9142	2026-08-18
7191	V	5	217.73	5	2026-10-11 13:42:08.9142	2026-08-19
7192	V	5	290.87	5	2026-10-11 13:42:08.9142	2026-08-20
7193	V	5	365.08	5	2026-10-11 13:42:08.9142	2026-08-21
7194	V	5	293.31	5	2026-10-11 13:42:08.9142	2026-08-22
7195	V	5	220.46	5	2026-10-11 13:42:08.9142	2026-08-23
7196	V	5	223.84	5	2026-10-11 13:42:08.9142	2026-08-24
7197	V	5	227.52	5	2026-10-11 13:42:08.9142	2026-08-25
7198	V	5	230.09	5	2026-10-11 13:42:08.9142	2026-08-26
7199	V	5	306.02	5	2026-10-11 13:42:08.9142	2026-08-27
7200	V	5	382.34	5	2026-10-11 13:42:08.9142	2026-08-28
7201	V	5	305.86	5	2026-10-11 13:42:08.9142	2026-08-29
7202	V	5	229.03	5	2026-10-11 13:42:08.9142	2026-08-30
7203	V	5	228.13	5	2026-10-11 13:42:08.9142	2026-08-31
7204	V	5	226.73	5	2026-10-11 13:42:08.9142	2026-09-01
7205	V	5	226.09	5	2026-10-11 13:42:08.9142	2026-09-02
7206	V	5	301.84	5	2026-10-11 13:42:08.9142	2026-09-03
7207	V	5	376.85	5	2026-10-11 13:42:08.9142	2026-09-04
7208	V	5	300.98	5	2026-10-11 13:42:08.9142	2026-09-05
7209	V	5	226.44	5	2026-10-11 13:42:08.9142	2026-09-06
7210	V	5	150.76	5	2026-10-11 13:42:08.9142	2026-09-07
7211	V	5	148.74	5	2026-10-11 13:42:08.9142	2026-09-08
7212	V	5	147.21	5	2026-10-11 13:42:08.9142	2026-09-09
7213	V	5	220.65	5	2026-10-11 13:42:08.9142	2026-09-10
7214	V	5	294.74	5	2026-10-11 13:42:08.9142	2026-09-11
7215	V	5	294.74	5	2026-10-11 13:42:08.9142	2026-09-12
7216	V	5	221.01	5	2026-10-11 13:42:08.9142	2026-09-13
7217	V	5	222.59	5	2026-10-11 13:42:08.9142	2026-09-14
7218	V	5	224.27	5	2026-10-11 13:42:08.9142	2026-09-15
7219	V	5	224.37	5	2026-10-11 13:42:08.9142	2026-09-16
7220	V	5	298.35	5	2026-10-11 13:42:08.9142	2026-09-17
7221	V	5	372.01	5	2026-10-11 13:42:08.9142	2026-09-18
7222	V	5	296.95	5	2026-10-11 13:42:08.9142	2026-09-19
7223	V	5	221.83	5	2026-10-11 13:42:08.9142	2026-09-20
7224	V	5	221.63	5	2026-10-11 13:42:08.9142	2026-09-21
7225	V	5	220.06	5	2026-10-11 13:42:08.9142	2026-09-22
7226	V	5	218.70	5	2026-10-11 13:42:08.9142	2026-09-23
7227	V	5	292.30	5	2026-10-11 13:42:08.9142	2026-09-24
7228	V	5	365.77	5	2026-10-11 13:42:08.9142	2026-09-25
7229	V	5	291.78	5	2026-10-11 13:42:08.9142	2026-09-26
7230	V	5	219.38	5	2026-10-11 13:42:08.9142	2026-09-27
7231	V	5	220.62	5	2026-10-11 13:42:08.9142	2026-09-28
7232	V	5	220.20	5	2026-10-11 13:42:08.9142	2026-09-29
7233	V	5	218.59	5	2026-10-11 13:42:08.9142	2026-09-30
7234	V	5	290.56	5	2026-10-11 13:42:08.9142	2026-10-01
7235	V	5	362.69	5	2026-10-11 13:42:08.9142	2026-10-02
7236	V	5	289.14	5	2026-10-11 13:42:08.9142	2026-10-03
7237	V	5	215.97	5	2026-10-11 13:42:08.9142	2026-10-04
7238	V	5	218.04	5	2026-10-11 13:42:08.9142	2026-10-05
7239	V	5	220.20	5	2026-10-11 13:42:08.9142	2026-10-06
7240	V	5	222.49	5	2026-10-11 13:42:08.9142	2026-10-07
7241	V	5	297.51	5	2026-10-11 13:42:08.9142	2026-10-08
7242	V	5	374.60	5	2026-10-11 13:42:08.9142	2026-10-09
7243	V	20	204.89	20	2026-10-11 13:42:09.056336	2026-01-20
7244	V	20	221.16	20	2026-10-11 13:42:09.056336	2026-01-21
7245	V	20	220.15	20	2026-10-11 13:42:09.056336	2026-01-22
7246	V	20	236.46	20	2026-10-11 13:42:09.056336	2026-01-23
7247	V	20	236.46	20	2026-10-11 13:42:09.056336	2026-01-24
7248	V	20	218.77	20	2026-10-11 13:42:09.056336	2026-01-25
7249	V	20	217.32	20	2026-10-11 13:42:09.056336	2026-01-26
7250	V	20	215.78	20	2026-10-11 13:42:09.056336	2026-01-27
7251	V	20	214.52	20	2026-10-11 13:42:09.056336	2026-01-28
7252	V	20	213.62	20	2026-10-11 13:42:09.056336	2026-01-29
7253	V	20	229.71	20	2026-10-11 13:42:09.056336	2026-01-30
7254	V	20	229.71	20	2026-10-11 13:42:09.056336	2026-01-31
7255	V	20	212.56	20	2026-10-11 13:42:09.056336	2026-02-01
7256	V	20	212.85	20	2026-10-11 13:42:09.056336	2026-02-02
7257	V	20	212.84	20	2026-10-11 13:42:09.056336	2026-02-03
7258	V	20	212.95	20	2026-10-11 13:42:09.056336	2026-02-04
7259	V	20	212.99	20	2026-10-11 13:42:09.056336	2026-02-05
7260	V	20	229.57	20	2026-10-11 13:42:09.056336	2026-02-06
7261	V	20	229.57	20	2026-10-11 13:42:09.056336	2026-02-07
7262	V	20	229.57	20	2026-10-11 13:42:09.056336	2026-02-08
7263	V	20	229.56	20	2026-10-11 13:42:09.056336	2026-02-09
7264	V	20	229.70	20	2026-10-11 13:42:09.056336	2026-02-10
7265	V	20	229.85	20	2026-10-11 13:42:09.056336	2026-02-11
7266	V	20	229.75	20	2026-10-11 13:42:09.056336	2026-02-12
7267	V	20	245.45	20	2026-10-11 13:42:09.056336	2026-02-13
7268	V	20	245.45	20	2026-10-11 13:42:09.056336	2026-02-14
7269	V	20	229.03	20	2026-10-11 13:42:09.056336	2026-02-15
7270	V	20	212.76	20	2026-10-11 13:42:09.056336	2026-02-16
7271	V	20	212.39	20	2026-10-11 13:42:09.056336	2026-02-17
7272	V	20	211.82	20	2026-10-11 13:42:09.056336	2026-02-18
7273	V	20	211.67	20	2026-10-11 13:42:09.056336	2026-02-19
7274	V	20	227.72	20	2026-10-11 13:42:09.056336	2026-02-20
7275	V	20	227.72	20	2026-10-11 13:42:09.056336	2026-02-21
7276	V	20	211.03	20	2026-10-11 13:42:09.056336	2026-02-22
7277	V	20	209.91	20	2026-10-11 13:42:09.056336	2026-02-23
7278	V	20	208.77	20	2026-10-11 13:42:09.056336	2026-02-24
7279	V	20	207.96	20	2026-10-11 13:42:09.056336	2026-02-25
7280	V	20	207.22	20	2026-10-11 13:42:09.056336	2026-02-26
7281	V	20	223.22	20	2026-10-11 13:42:09.056336	2026-02-27
7282	V	20	223.22	20	2026-10-11 13:42:09.056336	2026-02-28
7283	V	20	206.95	20	2026-10-11 13:42:09.056336	2026-03-01
7284	V	20	206.56	20	2026-10-11 13:42:09.056336	2026-03-02
7285	V	20	206.14	20	2026-10-11 13:42:09.056336	2026-03-03
7286	V	20	205.96	20	2026-10-11 13:42:09.056336	2026-03-04
7287	V	20	206.24	20	2026-10-11 13:42:09.056336	2026-03-05
7288	V	20	222.11	20	2026-10-11 13:42:09.056336	2026-03-06
7289	V	20	222.11	20	2026-10-11 13:42:09.056336	2026-03-07
7290	V	20	222.11	20	2026-10-11 13:42:09.056336	2026-03-08
7291	V	20	221.93	20	2026-10-11 13:42:09.056336	2026-03-09
7292	V	20	221.64	20	2026-10-11 13:42:09.056336	2026-03-10
7293	V	20	221.14	20	2026-10-11 13:42:09.056336	2026-03-11
7294	V	20	220.42	20	2026-10-11 13:42:09.056336	2026-03-12
7295	V	20	235.78	20	2026-10-11 13:42:09.056336	2026-03-13
7296	V	20	235.78	20	2026-10-11 13:42:09.056336	2026-03-14
7297	V	20	220.45	20	2026-10-11 13:42:09.056336	2026-03-15
7298	V	20	220.60	20	2026-10-11 13:42:09.056336	2026-03-16
7299	V	20	220.37	20	2026-10-11 13:42:09.056336	2026-03-17
7300	V	20	219.48	20	2026-10-11 13:42:09.056336	2026-03-18
7301	V	20	218.46	20	2026-10-11 13:42:09.056336	2026-03-19
7302	V	20	233.54	20	2026-10-11 13:42:09.056336	2026-03-20
7303	V	20	233.54	20	2026-10-11 13:42:09.056336	2026-03-21
7304	V	20	217.52	20	2026-10-11 13:42:09.056336	2026-03-22
7305	V	20	216.70	20	2026-10-11 13:42:09.056336	2026-03-23
7306	V	20	215.86	20	2026-10-11 13:42:09.056336	2026-03-24
7307	V	20	215.12	20	2026-10-11 13:42:09.056336	2026-03-25
7308	V	20	214.53	20	2026-10-11 13:42:09.056336	2026-03-26
7309	V	20	229.30	20	2026-10-11 13:42:09.056336	2026-03-27
7310	V	20	229.30	20	2026-10-11 13:42:09.056336	2026-03-28
7311	V	20	213.51	20	2026-10-11 13:42:09.056336	2026-03-29
7312	V	20	212.76	20	2026-10-11 13:42:09.056336	2026-03-30
7313	V	20	212.43	20	2026-10-11 13:42:09.056336	2026-03-31
7314	V	20	212.03	20	2026-10-11 13:42:09.056336	2026-04-01
7315	V	20	211.71	20	2026-10-11 13:42:09.056336	2026-04-02
7316	V	20	211.71	20	2026-10-11 13:42:09.056336	2026-04-03
7317	V	20	211.71	20	2026-10-11 13:42:09.056336	2026-04-04
7318	V	20	196.20	20	2026-10-11 13:42:09.056336	2026-04-05
7319	V	20	195.95	20	2026-10-11 13:42:09.056336	2026-04-06
7320	V	20	196.12	20	2026-10-11 13:42:09.056336	2026-04-07
7321	V	20	196.59	20	2026-10-11 13:42:09.056336	2026-04-08
7322	V	20	196.92	20	2026-10-11 13:42:09.056336	2026-04-09
7323	V	20	212.14	20	2026-10-11 13:42:09.056336	2026-04-10
7324	V	20	212.14	20	2026-10-11 13:42:09.056336	2026-04-11
7325	V	20	196.92	20	2026-10-11 13:42:09.056336	2026-04-12
7326	V	20	197.20	20	2026-10-11 13:42:09.056336	2026-04-13
7327	V	20	197.52	20	2026-10-11 13:42:09.056336	2026-04-14
7328	V	20	198.04	20	2026-10-11 13:42:09.056336	2026-04-15
7329	V	20	199.02	20	2026-10-11 13:42:09.056336	2026-04-16
7330	V	20	214.87	20	2026-10-11 13:42:09.056336	2026-04-17
7331	V	20	214.87	20	2026-10-11 13:42:09.056336	2026-04-18
7332	V	20	199.89	20	2026-10-11 13:42:09.056336	2026-04-19
7333	V	20	200.48	20	2026-10-11 13:42:09.056336	2026-04-20
7334	V	20	201.05	20	2026-10-11 13:42:09.056336	2026-04-21
7335	V	20	201.57	20	2026-10-11 13:42:09.056336	2026-04-22
7336	V	20	217.02	20	2026-10-11 13:42:09.056336	2026-04-23
7337	V	20	232.49	20	2026-10-11 13:42:09.056336	2026-04-24
7338	V	20	232.49	20	2026-10-11 13:42:09.056336	2026-04-25
7339	V	20	217.32	20	2026-10-11 13:42:09.056336	2026-04-26
7340	V	20	217.68	20	2026-10-11 13:42:09.056336	2026-04-27
7341	V	20	217.69	20	2026-10-11 13:42:09.056336	2026-04-28
7342	V	20	219.02	20	2026-10-11 13:42:09.056336	2026-04-29
7343	V	20	220.30	20	2026-10-11 13:42:09.056336	2026-04-30
7344	V	20	236.70	20	2026-10-11 13:42:09.056336	2026-05-01
7345	V	20	236.70	20	2026-10-11 13:42:09.056336	2026-05-02
7346	V	20	221.23	20	2026-10-11 13:42:09.056336	2026-05-03
7347	V	20	222.00	20	2026-10-11 13:42:09.056336	2026-05-04
7348	V	20	222.31	20	2026-10-11 13:42:09.056336	2026-05-05
7349	V	20	222.49	20	2026-10-11 13:42:09.056336	2026-05-06
7350	V	20	222.71	20	2026-10-11 13:42:09.056336	2026-05-07
7351	V	20	238.65	20	2026-10-11 13:42:09.056336	2026-05-08
7352	V	20	238.65	20	2026-10-11 13:42:09.056336	2026-05-09
7353	V	20	222.95	20	2026-10-11 13:42:09.056336	2026-05-10
7354	V	20	223.64	20	2026-10-11 13:42:09.056336	2026-05-11
7355	V	20	224.40	20	2026-10-11 13:42:09.056336	2026-05-12
7356	V	20	224.97	20	2026-10-11 13:42:09.056336	2026-05-13
7357	V	20	225.63	20	2026-10-11 13:42:09.056336	2026-05-14
7358	V	20	241.91	20	2026-10-11 13:42:09.056336	2026-05-15
7359	V	20	241.91	20	2026-10-11 13:42:09.056336	2026-05-16
7360	V	20	226.43	20	2026-10-11 13:42:09.056336	2026-05-17
7361	V	20	227.60	20	2026-10-11 13:42:09.056336	2026-05-18
7362	V	20	227.35	20	2026-10-11 13:42:09.056336	2026-05-19
7363	V	20	227.40	20	2026-10-11 13:42:09.056336	2026-05-20
7364	V	20	227.55	20	2026-10-11 13:42:09.056336	2026-05-21
7365	V	20	244.00	20	2026-10-11 13:42:09.056336	2026-05-22
7366	V	20	244.00	20	2026-10-11 13:42:09.056336	2026-05-23
7367	V	20	227.65	20	2026-10-11 13:42:09.056336	2026-05-24
7368	V	20	211.55	20	2026-10-11 13:42:09.056336	2026-05-25
7369	V	20	211.94	20	2026-10-11 13:42:09.056336	2026-05-26
7370	V	20	212.25	20	2026-10-11 13:42:09.056336	2026-05-27
7371	V	20	212.56	20	2026-10-11 13:42:09.056336	2026-05-28
7372	V	20	228.88	20	2026-10-11 13:42:09.056336	2026-05-29
7373	V	20	228.88	20	2026-10-11 13:42:09.056336	2026-05-30
7374	V	20	212.69	20	2026-10-11 13:42:09.056336	2026-05-31
7375	V	20	212.50	20	2026-10-11 13:42:09.056336	2026-06-01
7376	V	20	212.35	20	2026-10-11 13:42:09.056336	2026-06-02
7377	V	20	211.85	20	2026-10-11 13:42:09.056336	2026-06-03
7378	V	20	211.57	20	2026-10-11 13:42:09.056336	2026-06-04
7379	V	20	227.75	20	2026-10-11 13:42:09.056336	2026-06-05
7380	V	20	227.75	20	2026-10-11 13:42:09.056336	2026-06-06
7381	V	20	211.12	20	2026-10-11 13:42:09.056336	2026-06-07
7382	V	20	210.60	20	2026-10-11 13:42:09.056336	2026-06-08
7383	V	20	210.32	20	2026-10-11 13:42:09.056336	2026-06-09
7384	V	20	209.91	20	2026-10-11 13:42:09.056336	2026-06-10
7385	V	20	209.42	20	2026-10-11 13:42:09.056336	2026-06-11
7386	V	20	225.54	20	2026-10-11 13:42:09.056336	2026-06-12
7387	V	20	225.54	20	2026-10-11 13:42:09.056336	2026-06-13
7388	V	20	225.54	20	2026-10-11 13:42:09.056336	2026-06-14
7389	V	20	225.41	20	2026-10-11 13:42:09.056336	2026-06-15
7390	V	20	225.68	20	2026-10-11 13:42:09.056336	2026-06-16
7391	V	20	225.95	20	2026-10-11 13:42:09.056336	2026-06-17
7392	V	20	226.00	20	2026-10-11 13:42:09.056336	2026-06-18
7393	V	20	226.00	20	2026-10-11 13:42:09.056336	2026-06-19
7394	V	20	226.00	20	2026-10-11 13:42:09.056336	2026-06-20
7395	V	20	209.86	20	2026-10-11 13:42:09.056336	2026-06-21
7396	V	20	210.32	20	2026-10-11 13:42:09.056336	2026-06-22
7397	V	20	211.13	20	2026-10-11 13:42:09.056336	2026-06-23
7398	V	20	211.73	20	2026-10-11 13:42:09.056336	2026-06-24
7399	V	20	212.08	20	2026-10-11 13:42:09.056336	2026-06-25
7400	V	20	228.89	20	2026-10-11 13:42:09.056336	2026-06-26
7401	V	20	228.89	20	2026-10-11 13:42:09.056336	2026-06-27
7402	V	20	212.90	20	2026-10-11 13:42:09.056336	2026-06-28
7403	V	20	213.73	20	2026-10-11 13:42:09.056336	2026-06-29
7404	V	20	214.74	20	2026-10-11 13:42:09.056336	2026-06-30
7405	V	20	216.34	20	2026-10-11 13:42:09.056336	2026-07-01
7406	V	20	218.33	20	2026-10-11 13:42:09.056336	2026-07-02
7407	V	20	218.33	20	2026-10-11 13:42:09.056336	2026-07-03
7408	V	20	218.33	20	2026-10-11 13:42:09.056336	2026-07-04
7409	V	20	202.14	20	2026-10-11 13:42:09.056336	2026-07-05
7410	V	20	203.34	20	2026-10-11 13:42:09.056336	2026-07-06
7411	V	20	204.44	20	2026-10-11 13:42:09.056336	2026-07-07
7412	V	20	205.45	20	2026-10-11 13:42:09.056336	2026-07-08
7413	V	20	222.86	20	2026-10-11 13:42:09.056336	2026-07-09
7414	V	20	240.31	20	2026-10-11 13:42:09.056336	2026-07-10
7415	V	20	240.31	20	2026-10-11 13:42:09.056336	2026-07-11
7416	V	20	223.98	20	2026-10-11 13:42:09.056336	2026-07-12
7417	V	20	225.44	20	2026-10-11 13:42:09.056336	2026-07-13
7418	V	20	226.63	20	2026-10-11 13:42:09.056336	2026-07-14
7419	V	20	227.86	20	2026-10-11 13:42:09.056336	2026-07-15
7420	V	20	229.31	20	2026-10-11 13:42:09.056336	2026-07-16
7421	V	20	247.24	20	2026-10-11 13:42:09.056336	2026-07-17
7422	V	20	247.24	20	2026-10-11 13:42:09.056336	2026-07-18
7423	V	20	230.15	20	2026-10-11 13:42:09.056336	2026-07-19
7424	V	20	231.03	20	2026-10-11 13:42:09.056336	2026-07-20
7425	V	20	231.26	20	2026-10-11 13:42:09.056336	2026-07-21
7426	V	20	230.83	20	2026-10-11 13:42:09.056336	2026-07-22
7427	V	20	248.41	20	2026-10-11 13:42:09.056336	2026-07-23
7428	V	20	266.20	20	2026-10-11 13:42:09.056336	2026-07-24
7429	V	20	266.20	20	2026-10-11 13:42:09.056336	2026-07-25
7430	V	20	248.33	20	2026-10-11 13:42:09.056336	2026-07-26
7431	V	20	248.85	20	2026-10-11 13:42:09.056336	2026-07-27
7432	V	20	249.80	20	2026-10-11 13:42:09.056336	2026-07-28
7433	V	20	250.83	20	2026-10-11 13:42:09.056336	2026-07-29
7434	V	20	251.69	20	2026-10-11 13:42:09.056336	2026-07-30
7435	V	20	270.00	20	2026-10-11 13:42:09.056336	2026-07-31
7436	V	20	270.00	20	2026-10-11 13:42:09.056336	2026-08-01
7437	V	20	252.11	20	2026-10-11 13:42:09.056336	2026-08-02
7438	V	20	252.60	20	2026-10-11 13:42:09.056336	2026-08-03
7439	V	20	253.32	20	2026-10-11 13:42:09.056336	2026-08-04
7440	V	20	253.49	20	2026-10-11 13:42:09.056336	2026-08-05
7441	V	20	254.08	20	2026-10-11 13:42:09.056336	2026-08-06
7442	V	20	272.21	20	2026-10-11 13:42:09.056336	2026-08-07
7443	V	20	272.21	20	2026-10-11 13:42:09.056336	2026-08-08
7444	V	20	254.18	20	2026-10-11 13:42:09.056336	2026-08-09
7445	V	20	254.45	20	2026-10-11 13:42:09.056336	2026-08-10
7446	V	20	254.93	20	2026-10-11 13:42:09.056336	2026-08-11
7447	V	20	255.32	20	2026-10-11 13:42:09.056336	2026-08-12
7448	V	20	255.80	20	2026-10-11 13:42:09.056336	2026-08-13
7449	V	20	274.01	20	2026-10-11 13:42:09.056336	2026-08-14
7450	V	20	274.01	20	2026-10-11 13:42:09.056336	2026-08-15
7451	V	20	255.88	20	2026-10-11 13:42:09.056336	2026-08-16
7452	V	20	255.50	20	2026-10-11 13:42:09.056336	2026-08-17
7453	V	20	255.27	20	2026-10-11 13:42:09.056336	2026-08-18
7454	V	20	255.23	20	2026-10-11 13:42:09.056336	2026-08-19
7455	V	20	255.21	20	2026-10-11 13:42:09.056336	2026-08-20
7456	V	20	273.77	20	2026-10-11 13:42:09.056336	2026-08-21
7457	V	20	273.77	20	2026-10-11 13:42:09.056336	2026-08-22
7458	V	20	255.48	20	2026-10-11 13:42:09.056336	2026-08-23
7459	V	20	256.12	20	2026-10-11 13:42:09.056336	2026-08-24
7460	V	20	256.90	20	2026-10-11 13:42:09.056336	2026-08-25
7461	V	20	257.58	20	2026-10-11 13:42:09.056336	2026-08-26
7462	V	20	258.43	20	2026-10-11 13:42:09.056336	2026-08-27
7463	V	20	277.51	20	2026-10-11 13:42:09.056336	2026-08-28
7464	V	20	277.51	20	2026-10-11 13:42:09.056336	2026-08-29
7465	V	20	259.45	20	2026-10-11 13:42:09.056336	2026-08-30
7466	V	20	260.27	20	2026-10-11 13:42:09.056336	2026-08-31
7467	V	20	260.94	20	2026-10-11 13:42:09.056336	2026-09-01
7468	V	20	261.58	20	2026-10-11 13:42:09.056336	2026-09-02
7469	V	20	262.31	20	2026-10-11 13:42:09.056336	2026-09-03
7470	V	20	281.07	20	2026-10-11 13:42:09.056336	2026-09-04
7471	V	20	281.07	20	2026-10-11 13:42:09.056336	2026-09-05
7472	V	20	263.13	20	2026-10-11 13:42:09.056336	2026-09-06
7473	V	20	244.91	20	2026-10-11 13:42:09.056336	2026-09-07
7474	V	20	245.07	20	2026-10-11 13:42:09.056336	2026-09-08
7475	V	20	245.15	20	2026-10-11 13:42:09.056336	2026-09-09
7476	V	20	244.96	20	2026-10-11 13:42:09.056336	2026-09-10
7477	V	20	263.48	20	2026-10-11 13:42:09.056336	2026-09-11
7478	V	20	263.48	20	2026-10-11 13:42:09.056336	2026-09-12
7479	V	20	244.36	20	2026-10-11 13:42:09.056336	2026-09-13
7480	V	20	243.92	20	2026-10-11 13:42:09.056336	2026-09-14
7481	V	20	243.51	20	2026-10-11 13:42:09.056336	2026-09-15
7482	V	20	243.07	20	2026-10-11 13:42:09.056336	2026-09-16
7483	V	20	242.49	20	2026-10-11 13:42:09.056336	2026-09-17
7484	V	20	260.90	20	2026-10-11 13:42:09.056336	2026-09-18
7485	V	20	260.90	20	2026-10-11 13:42:09.056336	2026-09-19
7486	V	20	241.93	20	2026-10-11 13:42:09.056336	2026-09-20
7487	V	20	241.80	20	2026-10-11 13:42:09.056336	2026-09-21
7488	V	20	240.98	20	2026-10-11 13:42:09.056336	2026-09-22
7489	V	20	240.12	20	2026-10-11 13:42:09.056336	2026-09-23
7490	V	20	239.76	20	2026-10-11 13:42:09.056336	2026-09-24
7491	V	20	258.13	20	2026-10-11 13:42:09.056336	2026-09-25
7492	V	20	258.13	20	2026-10-11 13:42:09.056336	2026-09-26
7493	V	20	258.13	20	2026-10-11 13:42:09.056336	2026-09-27
7494	V	20	258.09	20	2026-10-11 13:42:09.056336	2026-09-28
7495	V	20	258.01	20	2026-10-11 13:42:09.056336	2026-09-29
7496	V	20	257.62	20	2026-10-11 13:42:09.056336	2026-09-30
7497	V	20	257.09	20	2026-10-11 13:42:09.056336	2026-10-01
7498	V	20	275.12	20	2026-10-11 13:42:09.056336	2026-10-02
7499	V	20	275.12	20	2026-10-11 13:42:09.056336	2026-10-03
7500	V	20	256.36	20	2026-10-11 13:42:09.056336	2026-10-04
7501	V	20	256.06	20	2026-10-11 13:42:09.056336	2026-10-05
7502	V	20	256.05	20	2026-10-11 13:42:09.056336	2026-10-06
7503	V	20	256.15	20	2026-10-11 13:42:09.056336	2026-10-07
7504	V	20	256.49	20	2026-10-11 13:42:09.056336	2026-10-08
7505	V	20	368.77	20	2026-10-11 13:42:10.948552	2026-10-09
\.


--
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock (symbol, company_name) FROM stdin;
\.


--
-- Data for Name: stock_analysis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_analysis (id, symbol, date, "volumeSurgeRatio", "crowdedScore", "reversalSignal", "riskRewardRatio", "closePrice", "percentileRank", "colorZone", status, volume, "createdAt") FROM stdin;
3	AMZN	2026-09-30	0.9	45.6	NEUTRAL	2	249.15	47.8%	YELLOW	NORMAL	41913111	2026-10-02 20:53:42.115242
4	AMZN	2026-09-30	0.9	45.6	NEUTRAL	2	249.15	47.8%	YELLOW	NORMAL	41913111	2026-10-02 20:54:33.826118
5	AMZN	2026-10-02	0.72	42	NEUTRAL	2	248.23	38%	YELLOW	NORMAL	33243918.41	2026-10-02 20:54:54.382124
6	AMZN	2026-10-02	0.72	42	NEUTRAL	2	248.23	38%	YELLOW	NORMAL	33243918.41	2026-10-03 03:32:43.868803
7	AMZN	2026-10-02	0.72	28.9	NEUTRAL	4	251.52	7.7%	GREEN	LOW	33433392.11	2026-10-08 14:22:16.923835
8	AMZN	2026-10-02	0.72	28.9	NEUTRAL	4	251.52	7.7%	GREEN	LOW	33433392.11	2026-10-09 14:36:18.605897
9	AMZN	2026-10-02	0.72	28.9	NEUTRAL	4	251.52	7.7%	GREEN	LOW	33433392.11	2026-10-10 14:30:07.090259
10	AMZN	2026-10-02	0.72	28.9	NEUTRAL	4	251.52	7.7%	GREEN	LOW	33433392.11	2026-10-11 13:42:05.660947
\.


--
-- Data for Name: stock_price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_price (id, symbol, industry, date, open, high, low, close, volume) FROM stdin;
\.


--
-- Data for Name: stock_prices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_prices (id, symbol, price_date, close_price) FROM stdin;
81	MSFT	2026-09-30	512.9000
82	CVX	2026-09-30	204.2100
83	AMZN	2026-09-30	249.1500
84	NVDA	2026-09-30	228.3800
85	DIS	2026-09-30	104.9000
86	LLY	2026-09-30	1157.0800
87	V	2026-09-30	359.3300
88	JNJ	2026-09-30	264.7400
89	JPM	2026-09-30	330.8300
90	XOM	2026-09-30	162.7500
91	XOM	2026-09-23	161.2300
92	V	2026-09-23	361.5200
93	MSFT	2026-09-23	500.5900
94	NVDA	2026-09-23	225.5100
95	AMZN	2026-09-23	249.2700
96	DIS	2026-09-23	103.4600
97	CVX	2026-09-23	205.5100
98	LLY	2026-09-23	1150.9900
99	JNJ	2026-09-23	269.1700
100	JPM	2026-09-23	337.5300
1	XOM	2026-09-22	158.7100
2	AMZN	2026-09-22	254.9800
3	MSFT	2026-09-22	498.0000
4	NVDA	2026-09-22	228.8700
5	V	2026-09-22	362.0400
6	LLY	2026-09-22	1170.1400
7	DIS	2026-09-22	103.8200
9	JNJ	2026-09-22	269.1900
8	CVX	2026-09-22	202.4100
10	JPM	2026-09-22	340.0000
11	V	2026-09-15	375.6200
12	CVX	2026-09-15	217.7700
13	DIS	2026-09-15	106.4200
14	JPM	2026-09-15	352.4900
15	AMZN	2026-09-15	248.4200
17	NVDA	2026-09-15	212.1700
16	MSFT	2026-09-15	497.1200
18	LLY	2026-09-15	1136.1100
19	JNJ	2026-09-15	267.2000
20	XOM	2026-09-15	169.3200
\.


--
-- Data for Name: stocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stocks (id, eod_price, price_date, company_name, symbol) FROM stdin;
\.


--
-- Data for Name: trade_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trade_records (id, symbol, timeframe, "initialCapital", "finalBalance", profit, "winRate", status, "createdAt") FROM stdin;
1	V	1d	10000	10023.39	23.39	43.48	PROFIT	2026-09-19 10:54:47.115173
2	V	1d	10000	10023.39	23.39	43.48	PROFIT	2026-09-19 10:56:40.925484
3	V	1d	10000	10023.39	23.39	43.48	PROFIT	2026-09-19 10:57:17.575849
4	V	1d	10000	10023.39	23.39	43.48	PROFIT	2026-09-19 10:57:32.371033
5	V	1d	10000	10023.39	23.39	43.48	PROFIT	2026-09-22 20:09:40.372949
6	V	1d	10000	9999.46	-0.54	46.94	LOSS	2026-09-23 22:06:08.199495
7	V	1d	10000	9999.46	-0.54	46.94	LOSS	2026-09-23 23:29:52.630877
8	V	1d	10000	9999.46	-0.54	46.94	LOSS	2026-09-25 22:26:16.360089
9	V	1d	10000	9999.46	-0.54	46.94	LOSS	2026-09-25 23:25:02.657948
10	V	1d	10000	9999.46	-0.54	46.94	LOSS	2026-09-25 23:35:27.7467
11	V	1d	10000	10009.72	9.72	47.22	PROFIT	2026-10-01 21:52:50.610609
12	V	1d	10000	10009.72	9.72	47.22	PROFIT	2026-10-02 20:52:31.588442
13	V	1d	10000	10009.72	9.72	47.22	PROFIT	2026-10-03 03:32:21.229357
14	V	1d	10000	10009.72	9.72	47.22	PROFIT	2026-10-03 03:32:34.480109
15	V	1d	10000	10019.58	19.58	48.65	PROFIT	2026-10-08 14:22:24.592252
16	V	1d	10000	10000	0	0	PROFIT	2026-10-10 14:29:43.687202
17	V	1d	10000	10000	0	0	PROFIT	2026-10-11 13:42:09.110591
\.


--
-- Data for Name: user_price_alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_price_alerts (id, user_id, symbol, target_price, is_triggered, created_at) FROM stdin;
3	12345	AAPL	150.50	f	2026-09-19 11:44:14.45173
5	12345	AAPL	150.50	f	2026-09-22 20:10:35.070552
6	12345	AAPL	150.50	f	2026-09-23 21:37:42.956179
1	user01	JPM	200.00	t	2026-09-19 11:01:25.540916
2	user01	JPM	200.00	t	2026-09-19 11:01:38.345312
4	user01	JPM	200.00	t	2026-09-22 20:09:42.842542
7	12345	V	150.50	t	2026-09-23 21:38:02.786293
8	user01	JPM	200.00	t	2026-09-23 22:06:20.232216
9	12345	V	150.50	t	2026-09-23 22:07:56.767912
10	user01	JPM	200.00	f	2026-09-23 23:29:55.531421
11	12345	V	150.50	f	2026-09-23 23:30:33.697144
12	user01	JPM	200.00	f	2026-09-25 22:26:22.479327
13	12345	V	150.50	f	2026-09-25 22:26:33.127217
14	user01	JPM	200.00	f	2026-09-25 23:34:27.185365
15	user01	JPM	200.00	f	2026-09-25 23:35:02.314962
16	12345	V	150.50	f	2026-09-25 23:35:05.928731
\.


--
-- Data for Name: watchlists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.watchlists (id, user_id, symbols, comparison_period, report_fields, created_at, updated_at) FROM stdin;
62c63a21-87aa-472a-b1ad-fef23a5ccf25	user2	MSFT,NVDA	3DAY	price,volume,RSI	2026-09-19 11:10:30.378297	2026-09-22 20:03:06.531949
9a0e01ec-58fc-4d68-b0d2-532d40d56cda	user3	MSFT,NVDA	3DAY	price,volume,RSI	2026-09-19 12:42:30.49678	2026-09-22 20:03:06.531949
47a34add-d0ab-46d3-af6f-b77498b3d40e	user4	MSFT,NVDA	1DAY	price,volume,RSI	2026-09-19 12:44:20.374496	2026-09-22 20:03:06.531949
4c5fcd1e-a55f-4576-977a-896091b05eb9	user5	MSFT,NVDA	7DAY	price,volume,RSI	2026-09-19 12:44:59.566686	2026-09-22 20:03:06.531949
d797710a-b568-47df-9f1b-59b856525949	user01	AMZN	7DAY	price,RSI	2026-09-19 11:01:38.341112	2026-10-03 03:36:40.43198
dcf5cef0-861f-4a73-beaf-2c1589a27bd7	user1	MSFT,NVDA	7DAY	price,volume,RSI	2026-09-19 11:06:54.279672	2026-10-03 04:27:59.753759
\.


--
-- Name: comparison_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comparison_history_id_seq', 1, false);


--
-- Name: eod_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eod_data_id_seq', 1, false);


--
-- Name: mover_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mover_results_id_seq', 80, true);


--
-- Name: price_alert_stocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.price_alert_stocks_id_seq', 5601, true);


--
-- Name: price_alert_stocks_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.price_alert_stocks_id_seq1', 5572, false);


--
-- Name: price_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.price_histories_id_seq', 1, false);


--
-- Name: recovery_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recovery_results_id_seq', 80, true);


--
-- Name: sma_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sma_records_id_seq', 7505, true);


--
-- Name: stock_analysis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_analysis_id_seq', 10, true);


--
-- Name: stock_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_price_id_seq', 1, false);


--
-- Name: stock_prices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_prices_id_seq', 100, true);


--
-- Name: stocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stocks_id_seq', 1, false);


--
-- Name: stocks_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stocks_id_seq1', 1, false);


--
-- Name: trade_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trade_records_id_seq', 17, true);


--
-- Name: user_price_alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_price_alerts_id_seq', 17, false);


--
-- Name: price_alert_stocks PK_11c074fca6ca9f745575127272d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_alert_stocks
    ADD CONSTRAINT "PK_11c074fca6ca9f745575127272d" PRIMARY KEY (id);


--
-- Name: trade_records PK_25288e99734da584d50029d7b2d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trade_records
    ADD CONSTRAINT "PK_25288e99734da584d50029d7b2d" PRIMARY KEY (id);


--
-- Name: economic_event PK_76b12b388783a523db03248ddbb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.economic_event
    ADD CONSTRAINT "PK_76b12b388783a523db03248ddbb" PRIMARY KEY (id);


--
-- Name: sma_records PK_7c04b5e0c3036045decdad63aac; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sma_records
    ADD CONSTRAINT "PK_7c04b5e0c3036045decdad63aac" PRIMARY KEY (id);


--
-- Name: stock PK_8216f0ad859c53c0706e1e1f05f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT "PK_8216f0ad859c53c0706e1e1f05f" PRIMARY KEY (symbol);


--
-- Name: user_price_alerts PK_88ff4eb0321220a4acf1e86da56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_price_alerts
    ADD CONSTRAINT "PK_88ff4eb0321220a4acf1e86da56" PRIMARY KEY (id);


--
-- Name: stocks PK_8deec318a0b05f7764ca5acd4ee; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks
    ADD CONSTRAINT "PK_8deec318a0b05f7764ca5acd4ee" PRIMARY KEY (id, symbol);


--
-- Name: mover_results PK_99dae8df85b710b0a22030b279d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mover_results
    ADD CONSTRAINT "PK_99dae8df85b710b0a22030b279d" PRIMARY KEY (id);


--
-- Name: stock_prices PK_9b3a97c06a1226bb506d5f7998e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_prices
    ADD CONSTRAINT "PK_9b3a97c06a1226bb506d5f7998e" PRIMARY KEY (id);


--
-- Name: stock_analysis PK_a6ac31d5da79b958c82c28d585b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_analysis
    ADD CONSTRAINT "PK_a6ac31d5da79b958c82c28d585b" PRIMARY KEY (id);


--
-- Name: watchlists PK_aa3c717b50a10f7a435c65eda5a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.watchlists
    ADD CONSTRAINT "PK_aa3c717b50a10f7a435c65eda5a" PRIMARY KEY (id);


--
-- Name: comparison_history PK_c97c6c5da416d3792191b739829; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comparison_history
    ADD CONSTRAINT "PK_c97c6c5da416d3792191b739829" PRIMARY KEY (id);


--
-- Name: recovery_results PK_ca96bf0e7eacf6acb60e7ee1fc8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recovery_results
    ADD CONSTRAINT "PK_ca96bf0e7eacf6acb60e7ee1fc8" PRIMARY KEY (id);


--
-- Name: market_close_reports PK_e866e121ec9f8e6c6f83725c4d0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.market_close_reports
    ADD CONSTRAINT "PK_e866e121ec9f8e6c6f83725c4d0" PRIMARY KEY (id);


--
-- Name: price_alert_stocks UQ_667ce66aa52d6afe856efb91db3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_alert_stocks
    ADD CONSTRAINT "UQ_667ce66aa52d6afe856efb91db3" UNIQUE (symbol, price_date);


--
-- Name: IDX_3646935cf8138ccb49b20f8038; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_3646935cf8138ccb49b20f8038" ON public.market_close_reports USING btree (user_id);


--
-- Name: IDX_abdd997b009437486baf753185; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_abdd997b009437486baf753185" ON public.stocks USING btree (symbol);


--
-- Name: IDX_b95d18136f983b90aa442eeef9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_b95d18136f983b90aa442eeef9" ON public.stock_prices USING btree (symbol, price_date);


--
-- PostgreSQL database dump complete
--

\unrestrict 5CU8iZylRgiFSZQvibClw9PztGqhvyRFaXfzbOfFUQHePL5LdDlnr7wBat5iJqJ

