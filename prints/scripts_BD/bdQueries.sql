CREATE SEQUENCE xmldata_id_seq;

CREATE TABLE IF NOT EXISTS public.xmldata(
	id integer NOT NULL DEFAULT nextval ('xmldata_id_seq'),
	filename character varying (255) COLLATE pg_catalog. "default" NOT NULL,
	xml xml NOT NULL,
	date date NOT NULL,
CONSTRAINT id_pkey PRIMARY KEY (id)
	)

SELECT * FROM xmldata;

--trigger
CREATE TRIGGER movedeleted
	BEFORE DELETE ON public.xmldata
	FOR EACH ROW
	EXECUTE FUNCTION moveDeleted();
	
--Procedure
--PROCEDURE: public.delete_xmlfile(integer)
--DROP PROCEDURE IF EXISTS public.delete_xmlfile(integer);

CREATE OR REPLACE PROCEDURE public.delete_xmlfile(
	IN _id integer)
LANGUAGE 'sql'
AS $BODY$
DELETE FROM public.xmldata WHERE id = _id
$BODY$;

--Procedure 2
-- PROCEDURE: public.insert_xmlfile(character varying, xml, date)

--DROP PROCEDURE IF EXISTS public.insert_xmlfile(character varying, xml, date);

CREATE OR REPLACE PROCEDURE public.insert_xmlfile(
	IN filename character varying,
	IN xmlfile xml,
	IN datetime date)
LANGUAGE 'sql'
AS $BODY$
INSERT INTO public.xmldata(filename, xml, date) VALUES (filename, xmlfile, datetime);
$BODY$;


--duplica a tabela original sem dados
CREATE TABLE Deleted_xmldata AS TABLE public.xmldata WITH NO DATA;

--funcao que insere os dados da tabela original na tabela criada anteriormente
CREATE FUNCTION moveDeleted() RETURNS trigger AS $$
	BEGIN
		INSERT INTO Deleted_xmldata VALUES ((OLD).*); 
		RETURN OLD;
	END;
$$ LANGUAGE plpgsql;

--Trigger que executa a função anterior antes de eliminar da tabela original
CREATE TRIGGER moveDeleted
BEFORE DELETE ON public.xmldata 
FOR EACH ROW
EXECUTE PROCEDURE moveDeleted();

--DELETE FROM xmldata where id= 1

--SELECT * FROM xmldata;

SELECT * FROM xmldata;
