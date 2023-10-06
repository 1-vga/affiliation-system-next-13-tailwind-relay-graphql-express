
DROP TABLE IF EXISTS base.product_affiliate;

CREATE TABLE base.product_affiliate
  (
     product_affiliate_guid UUID NOT NULL,
     product_guid           UUID NOT NULL,
     affiliate_guid         UUID NOT NULL,
     created_at             TIMESTAMP NOT NULL,-- auto-populated by trigger
     modified_at            TIMESTAMP NULL, -- auto-populated when the record is created or modified
     PRIMARY KEY(product_affiliate_guid)
  ); 

ALTER TABLE base.product_affiliate 
  ADD CONSTRAINT uq__product_affiliate_guid UNIQUE (product_affiliate_guid);

ALTER TABLE base.product_affiliate 
  ADD CONSTRAINT uq__product_guid__affiliate_guid UNIQUE (product_guid, affiliate_guid);

ALTER TABLE base.product_affiliate
  ADD CONSTRAINT fk__product_affiliate__affiliate FOREIGN KEY (affiliate_guid) REFERENCES base.affiliate(affiliate_guid);

ALTER TABLE base.product_affiliate
  ADD CONSTRAINT fk__product_affiliate__product FOREIGN KEY (product_guid) REFERENCES base.product(product_guid);

ALTER TABLE base.product_affiliate
  ALTER COLUMN product_affiliate_guid set DEFAULT md5(random()::text || clock_timestamp()::text)::uuid;


-- Auto-assign dates. _01 suffix to ensure correct trigger firing order.
DROP TRIGGER IF EXISTS trig_base_product_affiliate_insert_01 on base.product_affiliate;
CREATE TRIGGER trig_base_product_affiliate_insert_01 BEFORE INSERT
	ON base.product_affiliate FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();

DROP TRIGGER IF EXISTS trig_base_product_affiliate_update_01 on base.product_affiliate;
CREATE TRIGGER trig_base_product_affiliate_update_01 BEFORE UPDATE
	ON base.product_affiliate FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();


INSERT INTO base.product_affiliate(product_guid, affiliate_guid) VALUES ('1674311a-6f33-46a7-8762-04f6ca24e50d','02db1fac-3445-49f3-92b9-283d45a6093f');
INSERT INTO base.product_affiliate(product_guid, affiliate_guid) VALUES ('24eab295-0c6d-4b08-8695-d19c37f72fa1','f8bee486-20f9-415a-8b57-8a9733bc2408');
INSERT INTO base.product_affiliate(product_guid, affiliate_guid) VALUES ('33360b72-afd6-4331-8dd7-a66ac29bdfbc','7a824ba9-15f0-4db6-881f-580769d74687');
INSERT INTO base.product_affiliate(product_guid, affiliate_guid) VALUES ('1154311a-6f33-46a7-8762-04f6ca24e50d','56039473-29e4-4fc4-8f7f-4716aa1db997');
INSERT INTO base.product_affiliate(product_guid, affiliate_guid) VALUES ('66eab295-0c6d-4b08-8695-d19c37f72fa1','236a3af0-cb23-469d-807d-9fb690d0b289');
INSERT INTO base.product_affiliate(product_guid, affiliate_guid) VALUES ('44505ece-247f-4d8c-a5d9-158a3eee4bc0','c3e2c29e-48bf-4df9-9fd5-f719f600595c');
INSERT INTO base.product_affiliate(product_guid, affiliate_guid) VALUES ('77060b72-afd6-4331-8dd7-a66ac29bdfbc','dec8e83a-d8e3-43bd-9475-fb3e52c34285');
