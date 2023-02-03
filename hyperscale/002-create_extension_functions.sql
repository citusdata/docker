CREATE OR REPLACE FUNCTION public.create_extension(extname text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$ BEGIN
IF extname NOT IN (
'address_standardizer',
'address_standardizer_data_us',
'amcheck',
'autoinc',
'bloom',
'dict_int',
'dict_xsyn',
'insert_username',
'intagg',
'isn',
'lo',
'moddatetime',
'mysql_fdw',
'pageinspect',
'pgcrypto',
'pgrowlocks',
'pg_trgm',
'pg_visibility',
'postgis',
'postgis_raster',
'postgis_sfcgal',
'postgis_tiger_geocoder',
'postgis_topology',
'postgres_fdw',
'refint',
'seg',
'tcn',
'tsm_system_rows',
'tsm_system_time') THEN raise 'not allowed to create this extension';
END IF;
EXECUTE pg_catalog.format('CREATE EXTENSION %I;', extname);
IF extname IN ('mysql_fdw', 'postgres_fdw') THEN EXECUTE pg_catalog.format('GRANT USAGE ON FOREIGN DATA WRAPPER %I TO citus WITH GRANT OPTION', extname);
END IF;
END; $function$;

CREATE OR REPLACE FUNCTION public.drop_extension(extname text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'pg_temp'
AS $function$ BEGIN
IF extname NOT IN (
'address_standardizer',
'address_standardizer_data_us',
'amcheck',
'autoinc',
'bloom',
'dict_int',
'dict_xsyn',
'insert_username',
'intagg',
'isn',
'lo',
'moddatetime',
'mysql_fdw',
'pageinspect',
'pgcrypto',
'pgrowlocks',
'pg_trgm',
'pg_visibility',
'postgis',
'postgis_raster',
'postgis_sfcgal',
'postgis_tiger_geocoder',
'postgis_topology',
'postgres_fdw',
'refint',
'seg',
'tcn',
'tsm_system_rows',
'tsm_system_time') THEN raise 'not allowed to drop this extension';
END IF;
EXECUTE pg_catalog.format('DROP EXTENSION %I;', extname);
END; $function$;
