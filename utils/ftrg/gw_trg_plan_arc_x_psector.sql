/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/

--FUNCTION CODE: 1130

CREATE OR REPLACE FUNCTION "SCHEMA_NAME".gw_trg_plan_psector_x_arc()
  RETURNS trigger AS
$BODY$
DECLARE 

v_stateaux smallint;

BEGIN 

	EXECUTE 'SET search_path TO '||quote_literal(TG_TABLE_SCHEMA)||', public';

	SELECT arc.state INTO v_stateaux FROM arc WHERE arc_id=NEW.arc_id;
	IF v_stateaux=1	THEN 
		NEW.state=0;
		NEW.doable=false;
	ELSIF v_stateaux=2 THEN
		NEW.state=1;
		NEW.doable=true;
	END IF;

	RETURN NEW;

END;  
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;