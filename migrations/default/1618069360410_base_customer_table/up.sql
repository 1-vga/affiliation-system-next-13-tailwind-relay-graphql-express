DROP TABLE IF EXISTS base.customer;

CREATE TABLE base.customer
  (
     customer_guid UUID NOT NULL,
     username      VARCHAR NOT NULL,
     created_at    TIMESTAMP NOT NULL,-- auto-populated by trigger
     modified_by   INT NULL,
     modified_at   TIMESTAMP NULL, -- auto-populated when the record is created or modified
     PRIMARY KEY(customer_guid)
  ); 

ALTER TABLE base.customer 
  ADD CONSTRAINT uq__customer__customer_guid UNIQUE (customer_guid);

ALTER TABLE base.customer
  ALTER COLUMN customer_guid set DEFAULT md5(random()::text || clock_timestamp()::text)::uuid;

-- Auto-assign dates. _01 suffix to ensure correct trigger firing order.
DROP TRIGGER IF EXISTS trig_base_customer_insert_01 on base.customer;
CREATE TRIGGER trig_base_customer_insert_01 BEFORE INSERT
	ON base.customer FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();

DROP TRIGGER IF EXISTS trig_base_customer_update_01 on base.customer;
CREATE TRIGGER trig_base_customer_update_01 BEFORE UPDATE
	ON base.customer FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();