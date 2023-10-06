DROP TABLE IF EXISTS base.product;

CREATE TABLE base.product
  (
     product_guid UUID NOT NULL,
     company_guid UUID NOT NULL,
     title           VARCHAR NOT NULL,
     product_url     VARCHAR NOT NULL,
     price INT NOT NULL,
     created_at      TIMESTAMP NOT NULL,-- auto-populated by trigger
     modified_by     INT NULL,
     modified_at     TIMESTAMP NULL, -- auto-populated when the record is created or modified
     PRIMARY KEY(product_guid)
  ); 

ALTER TABLE base.product 
  ADD CONSTRAINT uq__product__product_guid UNIQUE (product_guid);

ALTER TABLE base.product
  ALTER COLUMN product_guid set DEFAULT md5(random()::text || clock_timestamp()::text)::uuid;


ALTER TABLE base.product
  ADD CONSTRAINT fk__product__company FOREIGN KEY (company_guid) REFERENCES base.company(company_guid);

-- Auto-assign dates. _01 suffix to ensure correct trigger firing order.
DROP TRIGGER IF EXISTS trig_base_product_insert_01 on base.product;
CREATE TRIGGER trig_base_product_insert_01 BEFORE INSERT
	ON base.product FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();

DROP TRIGGER IF EXISTS trig_base_product_update_01 on base.product;
CREATE TRIGGER trig_base_product_update_01 BEFORE UPDATE
	ON base.product FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();


  
INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('1674311a-6f33-46a7-8762-04f6ca24e50d', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Aircode', '/product', 4599);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('24eab295-0c6d-4b08-8695-d19c37f72fa1', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Overvolt', '/product', 3399);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('37a60b72-afd6-4331-8dd7-a66ac29bdfbc', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Crosshill', '/product', 3899);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('4db05ece-247f-4d8c-a5d9-158a3eee4bc0', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Shaper', '/product', 2399);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('5674311a-6f33-46a7-8762-04f6ca24e50d', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Aircode A', '/product', 4599);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('64eab295-0c6d-4b08-8695-d19c37f72fa1', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Overvolt A', '/product', 3399);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('77a60b72-afd6-4331-8dd7-a66ac29bdfbc', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Crosshill A', '/product', 3899);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('8db05ece-247f-4d8c-a5d9-158a3eee4bc0', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Shaper A', '/product', 2399);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('1174311a-6f33-46a7-8762-04f6ca24e50d', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Aircode B', '/product', 4599);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('22eab295-0c6d-4b08-8695-d19c37f72fa1', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Overvolt B', '/product', 3399);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('33a60b72-afd6-4331-8dd7-a66ac29bdfbc', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Crosshill B', '/product', 3899);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('44b05ece-247f-4d8c-a5d9-158a3eee4bc0', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Shaper B', '/product', 2399);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('5574311a-6f33-46a7-8762-04f6ca24e50d', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Aircode C', '/product', 4599);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('66eab295-0c6d-4b08-8695-d19c37f72fa1', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Overvolt C', '/product', 3399);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('77060b72-afd6-4331-8dd7-a66ac29bdfbc', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Crosshill C', '/product', 3899);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('88b05ece-247f-4d8c-a5d9-158a3eee4bc0', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Shaper C', '/product', 2399);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('1114311a-6f33-46a7-8762-04f6ca24e50d', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Aircode D', '/product', 4599);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('222ab295-0c6d-4b08-8695-d19c37f72fa1', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Overvolt D', '/product', 3399);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('33360b72-afd6-4331-8dd7-a66ac29bdfbc', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Crosshill D', '/product', 3899);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('44405ece-247f-4d8c-a5d9-158a3eee4bc0', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Shaper D', '/product', 2399);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('1154311a-6f33-46a7-8762-04f6ca24e50d', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Aircode E', '/product', 4599);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('225ab295-0c6d-4b08-8695-d19c37f72fa1', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre Overvolt E', '/product', 3399);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('33560b72-afd6-4331-8dd7-a66ac29bdfbc', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Crosshill E', '/product', 3899);

INSERT INTO base.product(
	product_guid, company_guid, title, product_url, price)
	VALUES ('44505ece-247f-4d8c-a5d9-158a3eee4bc0', '674e836a-0616-4f87-80be-6cb7249ce438', 'Lapierre e-Shaper E', '/product', 2399);