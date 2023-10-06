
DROP TABLE IF EXISTS base.company;

CREATE TABLE base.company
  (
     company_guid UUID NOT NULL,
     title VARCHAR(100) NOT NULL,
     created_at              TIMESTAMP NOT NULL,-- auto-populated by trigger
     modified_at             TIMESTAMP NULL, -- auto-populated when the record is created or modified
     PRIMARY KEY(company_guid)
  ); 

ALTER TABLE base.company 
  ADD CONSTRAINT uq__company_guid UNIQUE (company_guid);

ALTER TABLE base.company
  ALTER COLUMN company_guid set DEFAULT md5(random()::text || clock_timestamp()::text)::uuid;


-- Auto-assign dates. _01 suffix to ensure correct trigger firing order.
DROP TRIGGER IF EXISTS trig_base_company_insert_01 on base.company;
CREATE TRIGGER trig_base_company_insert_01 BEFORE INSERT
	ON base.company FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();

DROP TRIGGER IF EXISTS trig_base_company_update_01 on base.company;
CREATE TRIGGER trig_base_company_update_01 BEFORE UPDATE
	ON base.company FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();


INSERT INTO base.company
	VALUES ('674e836a-0616-4f87-80be-6cb7249ce438', 'Bastille Velo');