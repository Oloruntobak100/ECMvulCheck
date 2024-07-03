USE cbn_ecm;

delete from users;
delete from ecm2;
delete from workflow;
delete from departments;
delete from workflow_trail;
delete from files;
delete from comments;
delete from locked_files;
delete from logged_in_users;
delete from notifications;
delete from workflow_items;
delete from share;
delete from tags;
delete from tags_item;

-- Correct department fields
ALTER TABLE departments ALTER COLUMN departments006 varchar(100) NULL;
ALTER TABLE departments ALTER COLUMN departments007 varchar(200) NULL;

-- drop table ecm_cash_advance;
CREATE TABLE ecm_cash_advance (
  id varchar(100) NOT NULL,
  ecm_cash_advance51 BIGINT NULL,
  ecm_cash_advance48 varchar(100) NULL,
  ecm_cash_advance49 varchar(100) NULL,
  ecm_cash_advance50 varchar(100) NULL,
  ecm_cash_advance52 varchar(200) NULL,
  ecm_cash_advance53 varchar(200) NULL,
  ecm_cash_advance58 varchar(200) NULL,
  ecm_cash_advance59 varchar(200) NULL,
  ecm_cash_advance54 varchar(4000) NULL,
  ecm_cash_advance55 decimal(20,4) NULL,
  ecm_cash_advance85 decimal(20,4) NULL,
  ecm_cash_advance86 decimal(20,4) NULL,
  ecm_cash_advance56 decimal(20,4) NULL,
  ecm_cash_advance57 decimal(20,4) NULL,
  ecm_cash_advance81 varchar(4000) NULL,
  ecm_cash_advance82 varchar(100) NULL,
  ecm_cash_advance87 varchar(4000) NULL,
  ecm_cash_advance83 varchar(100) NULL,
  ecm_cash_advance84 BIGINT NULL,
  serial_num BIGINT IDENTITY(1,1) PRIMARY KEY,
  creator_role varchar(100) NULL,
  created_source varchar(100) NULL,
  created_by varchar(100) NULL,
  creation_date BIGINT NULL,
  modified_source varchar(100) NULL,
  modified_by varchar(100) NULL,
  modification_date BIGINT NULL,
  ip_address varchar(100) NULL,
  device_id text NULL,
  record_status varchar(1) NULL
);

ALTER TABLE ecm_cash_advance
ADD CONSTRAINT ecm_cash_advance_id UNIQUE (id);

CREATE INDEX ecm_cash_advance_idx
ON ecm_cash_advance (ecm_cash_advance48, ecm_cash_advance49, ecm_cash_advance50, ecm_cash_advance82, ecm_cash_advance83);

-- drop table ecm_cash_advance_trip;
CREATE TABLE ecm_cash_advance_trip (
  id varchar(100) NOT NULL,
  ecm_cash_advance_trip60 varchar(200) NULL,
  ecm_cash_advance_trip61 BIGINT NULL,
  ecm_cash_advance_trip62 BIGINT NULL,
  ecm_cash_advance_trip64 varchar(100) NULL,
  ecm_cash_advance_trip63 BIGINT NULL,
  ecm_cash_advance_trip65 varchar(100) NULL,
  ecm_cash_advance_trip70 varchar(100) NULL,
  ecm_cash_advance_trip66 decimal(20,4) NULL,
  ecm_cash_advance_trip88 decimal(20,4) NULL,
  ecm_cash_advance_trip89 decimal(20,4) NULL,
  ecm_cash_advance_trip67 varchar(4000) NULL,
  ecm_cash_advance_trip90 varchar(100) NULL,
  ecm_cash_advance_trip92 BIGINT NULL,
  ecm_cash_advance_trip91 varchar(4000) NULL,
  serial_num BIGINT IDENTITY(1,1) PRIMARY KEY,
  creator_role varchar(100) NULL,
  created_source varchar(100) NULL,
  created_by varchar(100) NULL,
  creation_date BIGINT NULL,
  modified_source varchar(100) NULL,
  modified_by varchar(100) NULL,
  modification_date BIGINT NULL,
  ip_address varchar(100) NULL,
  device_id text NULL,
  record_status varchar(1) NULL
);


ALTER TABLE ecm_cash_advance_trip
ADD CONSTRAINT ecm_cash_advance_trip_id UNIQUE (id);

CREATE INDEX ecm_cash_advance_trip_idx
ON ecm_cash_advance_trip (ecm_cash_advance_trip64, ecm_cash_advance_trip65, ecm_cash_advance_trip70, ecm_cash_advance_trip90);
-- --------------------------------------------------------

--
-- Table structure for table ecm_cash_advance_rate
--

CREATE TABLE ecm_cash_advance_rate (
  id varchar(100) NOT NULL,
  ecm_cash_advance_rate71 varchar(100) NULL,
  ecm_cash_advance_rate72 varchar(100) NULL,
  ecm_cash_advance_rate73 decimal(20,4) NULL,
  ecm_cash_advance_rate74 decimal(20,4) NULL,
  ecm_cash_advance_rate75 decimal(20,4) NULL,
  ecm_cash_advance_rate76 decimal(20,4) NULL,
  ecm_cash_advance_rate77 decimal(20,4) NULL,
  ecm_cash_advance_rate78 decimal(20,4) NULL,
  ecm_cash_advance_rate79 decimal(20,4) NULL,
  ecm_cash_advance_rate80 varchar(4000) NULL,
  serial_num BIGINT IDENTITY(1,1) PRIMARY KEY,
  creator_role varchar(100) NULL,
  created_source varchar(100) NULL,
  created_by varchar(100) NULL,
  creation_date BIGINT NULL,
  modified_source varchar(100) NULL,
  modified_by varchar(100) NULL,
  modification_date BIGINT NULL,
  ip_address varchar(100) NULL,
  device_id text NULL,
  record_status varchar(1) NULL
);

-- --------------------------------------------------------

--
-- Table structure for table ecm_cash_advance_trip
--

-- --------------------------------------------------------

--
-- Table structure for table ecm_cash_advance_zone
--

CREATE TABLE ecm_cash_advance_zone (
  id varchar(100) NOT NULL,
  ecm_cash_advance_zone68 varchar(200) NULL,
  ecm_cash_advance_zone69 varchar(4000) NULL,
  serial_num BIGINT IDENTITY(1,1) PRIMARY KEY,
  creator_role varchar(100) NULL,
  created_source varchar(100) NULL,
  created_by varchar(100) NULL,
  creation_date BIGINT NULL,
  modified_source varchar(100) NULL,
  modified_by varchar(100) NULL,
  modification_date BIGINT NULL,
  ip_address varchar(100) NULL,
  device_id text NULL,
  record_status varchar(1) NULL
);

ALTER TABLE ecm_cash_advance
ADD CONSTRAINT ecm_cash_advance_id UNIQUE (id);

CREATE INDEX ecm_cash_advance_idx
ON ecm_cash_advance (ecm_cash_advance48, ecm_cash_advance49, ecm_cash_advance50, ecm_cash_advance82, ecm_cash_advance83);

ALTER TABLE ecm_cash_advance_rate
ADD CONSTRAINT ecm_cash_advance_rate_id UNIQUE (id);

CREATE INDEX ecm_cash_advance_rate_idx
ON ecm_cash_advance_rate (ecm_cash_advance_rate71, ecm_cash_advance_rate72);

ALTER TABLE ecm_cash_advance_zone
ADD CONSTRAINT ecm_cash_advance_zone_id UNIQUE (id);
