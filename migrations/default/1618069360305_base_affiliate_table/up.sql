DROP TABLE IF EXISTS base.affiliate;

CREATE TABLE base.affiliate
  (
     affiliate_guid UUID NOT NULL,
     username           VARCHAR NOT NULL,
     commission INT NULL,
     created_at      TIMESTAMP NOT NULL,-- auto-populated by trigger
     modified_at     TIMESTAMP NULL, -- auto-populated when the record is created or modified
     PRIMARY KEY(affiliate_guid)
  ); 

ALTER TABLE base.affiliate 
  ADD CONSTRAINT uq__affiliate__affiliate_guid UNIQUE (affiliate_guid);

ALTER TABLE base.affiliate
  ALTER COLUMN affiliate_guid set DEFAULT md5(random()::text || clock_timestamp()::text)::uuid;

-- Auto-assign dates. _01 suffix to ensure correct trigger firing order.
DROP TRIGGER IF EXISTS trig_base_affiliate_insert_01 on base.affiliate;
CREATE TRIGGER trig_base_affiliate_insert_01 BEFORE INSERT
	ON base.affiliate FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();

DROP TRIGGER IF EXISTS trig_base_affiliate_update_01 on base.affiliate;
CREATE TRIGGER trig_base_affiliate_update_01 BEFORE UPDATE
	ON base.affiliate FOR EACH ROW 
  EXECUTE PROCEDURE base.tf_set_defaults();

INSERT INTO base.affiliate(affiliate_guid, username,commission) VALUES ('02db1fac-3445-49f3-92b9-283d45a6093f','CashCowConnection',0);
INSERT INTO base.affiliate(affiliate_guid, username,commission) VALUES ('f8bee486-20f9-415a-8b57-8a9733bc2408','ClickEarningsPro',0);
INSERT INTO base.affiliate(affiliate_guid, username,commission) VALUES ('7a824ba9-15f0-4db6-881f-580769d74687','PartnerPayouts',0);
INSERT INTO base.affiliate(affiliate_guid, username,commission) VALUES ('56039473-29e4-4fc4-8f7f-4716aa1db997','AffiliateAce',0);
INSERT INTO base.affiliate(affiliate_guid, username,commission) VALUES ('236a3af0-cb23-469d-807d-9fb690d0b289','RevenueRover',0);
INSERT INTO base.affiliate(affiliate_guid, username,commission) VALUES ('c3e2c29e-48bf-4df9-9fd5-f719f600595c','ReferralRoyalty',0);
INSERT INTO base.affiliate(affiliate_guid, username,commission) VALUES ('dec8e83a-d8e3-43bd-9475-fb3e52c34285','CommissionsChamp',0);
