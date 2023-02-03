CREATE OR REPLACE FUNCTION public.pg_replication_origin_create(text) RETURNS oid
LANGUAGE SQL
SECURITY DEFINER
SET search_path TO pg_catalog,pg_temp
AS $$ SELECT pg_catalog.pg_replication_origin_create($1) $$;

CREATE OR REPLACE FUNCTION public.pg_replication_origin_session_progress(bool) RETURNS pg_lsn
LANGUAGE SQL
SECURITY DEFINER
SET search_path TO pg_catalog,pg_temp
AS $$ SELECT pg_catalog.pg_replication_origin_session_progress($1) $$;

CREATE OR REPLACE FUNCTION public.pg_replication_origin_progress(text, bool) RETURNS pg_lsn
LANGUAGE SQL
SECURITY DEFINER
SET search_path TO pg_catalog,pg_temp
AS $$ SELECT pg_catalog.pg_replication_origin_progress($1, $2) $$;

CREATE OR REPLACE FUNCTION public.pg_replication_origin_drop(text) RETURNS void
LANGUAGE SQL
SECURITY DEFINER
SET search_path TO pg_catalog,pg_temp
AS $$ SELECT pg_catalog.pg_replication_origin_drop($1) $$;

CREATE OR REPLACE FUNCTION public.pg_replication_origin_xact_setup(pg_lsn, timestamptz) RETURNS void
LANGUAGE SQL
SECURITY DEFINER
SET search_path TO pg_catalog,pg_temp
AS $$ SELECT pg_catalog.pg_replication_origin_xact_setup($1, $2) $$;

CREATE OR REPLACE FUNCTION public.pg_replication_origin_session_setup(text) RETURNS void
LANGUAGE SQL
SECURITY DEFINER
SET search_path TO pg_catalog,pg_temp
AS $$ SELECT pg_catalog.pg_replication_origin_session_setup($1) $$;

REVOKE ALL ON FUNCTION public.pg_replication_origin_create(text) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.pg_replication_origin_session_progress(bool) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.pg_replication_origin_progress(text, bool) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.pg_replication_origin_drop(text) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.pg_replication_origin_xact_setup(pg_lsn, timestamptz) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.pg_replication_origin_session_setup(text) FROM PUBLIC;

GRANT EXECUTE ON FUNCTION public.pg_replication_origin_create(text) TO citus;
GRANT EXECUTE ON FUNCTION public.pg_replication_origin_session_progress(bool) TO citus;
GRANT EXECUTE ON FUNCTION public.pg_replication_origin_progress(text, bool) TO citus;
GRANT EXECUTE ON FUNCTION public.pg_replication_origin_drop(text) TO citus;
GRANT EXECUTE ON FUNCTION public.pg_replication_origin_xact_setup(pg_lsn, timestamptz) TO citus;
GRANT EXECUTE ON FUNCTION public.pg_replication_origin_session_setup(text) TO citus;
