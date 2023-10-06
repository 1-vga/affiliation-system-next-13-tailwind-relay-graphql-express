
DROP TABLE IF EXISTS base.affiliate_customer;

CREATE TABLE base.affiliate_customer
  (
     affiliate_customer_guid UUID NOT NULL,
     affiliate_guid          UUID NOT NULL,
     customer_guid           UUID NOT NULL,
     created_at              TIMESTAMP NOT NULL,-- auto-populated by trigger
     modified_at             TIMESTAMP NULL, -- auto-populated when the record is created or modified
     PRIMARY KEY(affiliate_customer_guid)
  ); 

ALTER TABLE base.affiliate_customer 
  ADD CONSTRAINT uq__affiliate_customer_guid UNIQUE (affiliate_customer_guid);

ALTER TABLE base.affiliate_customer
  ADD CONSTRAINT fk__affiliate_customer__affiliate FOREIGN KEY (affiliate_guid) REFERENCES base.affiliate(affiliate_guid);

ALTER TABLE base.affiliate_customer
  ADD CONSTRAINT fk__affiliate_customer__customer FOREIGN KEY (customer_guid) REFERENCES base.customer(customer_guid);

ALTER TABLE base.affiliate_customer
  ALTER COLUMN affiliate_customer_guid set DEFAULT md5(random()::text || clock_timestamp()::text)::uuid;


-- Auto-assign dates. _01 suffix to ensure correct trigger firing order.
DROP TRIGGER IF EXISTS trig_base_affiliate_customer_insert_01 on base.affiliate_customer;
CREATE TRIGGER trig_base_affiliate_customer_insert_01 BEFORE INSERT
	ON base.affiliate_customer FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();

DROP TRIGGER IF EXISTS trig_base_affiliate_customer_update_01 on base.affiliate_customer;
CREATE TRIGGER trig_base_affiliate_customer_update_01 BEFORE UPDATE
	ON base.affiliate_customer FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();
