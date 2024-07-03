USE cbn_ecm;

ALTER TABLE [dbo].[ecm_cash_advance_zone] ALTER COLUMN [ecm_cash_advance_zone69] varchar(200);

update [dbo].[ecm_cash_advance_zone] set ecm_cash_advance_zone69 = 'zone_b';
update [dbo].[ecm_cash_advance_zone] set ecm_cash_advance_zone69 = 'zone_a' WHERE id IN ( 'abuja-fct', 'ikeja-lagos', 'portharcourt-rivers' );

delete from [dbo].[list_box_options]
GO

SET IDENTITY_INSERT [dbo].[list_box_options] ON

GO
INSERT [dbo].[list_box_options] ([id], [list_box_options50330], [list_box_options50329], [list_box_options50331], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [device_id], [record_status]) VALUES (N'802b74c1b4babae610fd8af9f82de194', N'workflow_category', N'ECM PROCESS CATEGORY', N'{"options":{"career_and_training":"CAREER AND TRAINING","cash_advance":"CASH ADVANCE",
"fiaps":"FIAPS",
"litigation_support":"LITIGATION SUPPORT","meeting":"MEETING CO-ORDINATION","physical_records":"PHYSICAL RECORDS ARCHIVE REQUEST","request_for_a_file":"REQUEST FOR A FILE AND RETURN REQUEST","others":"OTHERS"}}', 14, N'1300130013', N'users', N'35991362173a', 1627644277, N'users', N'system', 1650861102, N'::1', N'undefined', N'1')
GO
INSERT [dbo].[list_box_options] ([id], [list_box_options50330], [list_box_options50329], [list_box_options50331], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [device_id], [record_status]) VALUES (N'a1b301bfe082844a752a9daf84bb4a5b', N'ecm_status', N'ECM Process Status', N'{\"options\":{\"draft\":\"Draft\",\"submitted\":\"Submitted\",\"completed\":\"Completed\",\"returned\":\"Returned\",\"cancelled\":\"Cancelled\"}}', 15, N'1300130013', N'users', N'35991362173a', 1627644513, N'users', N'35991362173a', 1627845687, N'::1', N'undefined', N'1')
GO
INSERT [dbo].[list_box_options] ([id], [list_box_options50330], [list_box_options50329], [list_box_options50331], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [device_id], [record_status]) VALUES (N'6ac73bfd9630382e82c3733d3a065543', N'ecm_approval_status', N'ECM Approval Status', N'{\"options\":{\"approved\":\"Approved\",\"queried\":\"Queried\",\"rejected\":\"Rejected\",\"cancelled\":\"Cancelled\"}}', 16, N'1300130013', N'users', N'35991362173a', 1627644551, N'users', N'35991362173a', 1627845701, N'::1', N'undefined', N'1')
GO
INSERT [dbo].[list_box_options] ([id], [list_box_options50330], [list_box_options50329], [list_box_options50331], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [device_id], [record_status]) VALUES (N'904b54fa2e904a7256292754429402c5', N'ecm_priority_levels', N'ECM Process Priority Levels', N'{\"options\":{\"1\":\"Low\",\"2\":\"Medium\",\"3\":\"High\",\"4\":\"Urgent\",\"5\":\"ASAP\"}}', 17, N'1300130013', N'users', N'35991362173a', 1627644668, N'users', N'35991362173a', 1627644668, N'::1', N'undefined', N'1')
GO
INSERT [dbo].[list_box_options] ([id], [list_box_options50330], [list_box_options50329], [list_box_options50331], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [device_id], [record_status]) VALUES (N'48a479db8fffddf3317070a33e3c614b', N'get_flag_types', N'Flags', N'{\"options\":{\"none\":\"None\",\"normal\":\"Normal\",\"important\":\"Important\"}}', 18, N'1300130013', N'users', N'35991362173a', 1627837015, N'users', N'35991362173a', 1627842349, N'::1', N'undefined', N'1')
GO
INSERT [dbo].[list_box_options] ([id], [list_box_options50330], [list_box_options50329], [list_box_options50331], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [device_id], [record_status]) VALUES (N'fd1ad97a9c9b6260cec20736c9ad8d09', N'ecm_group', N'ECM GROUPS', N'{\"options\":{\"group_1\":\"Group 1\",\"group_2\":\"Group 2\"}}', 19, N'1300130013', N'users', N'35991362173a', 1628048250, N'users', N'35991362173a', 1628048250, N'::1', N'undefined', N'1')
GO
INSERT [dbo].[list_box_options] ([id], [list_box_options50330], [list_box_options50329], [list_box_options50331], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [device_id], [record_status]) VALUES (N'06b40b109d044c9799b103f2c774f369', N'ecm_team', N'ECM TEAMS', N'{\"options\":{\"team_a\":\"Team A\",\"team_b\":\"Team B\"}}', 20, N'1300130013', N'users', N'35991362173a', 1628048276, N'users', N'35991362173a', 1628048276, N'::1', N'undefined', N'1')
GO
INSERT [dbo].[list_box_options] ([id], [list_box_options50330], [list_box_options50329], [list_box_options50331], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [device_id], [record_status]) VALUES (N'1lns1693137466815', N'cash_advance_zones', N'Cash Advance Zones', N'{
  "options": {
    "zone_a": "ZONE A",
    "zone_b": "ZONE B"
  }
}', 21, NULL, NULL, N'', 1693137466, NULL, N'', 1693141174, NULL, NULL, N'1')
GO
SET IDENTITY_INSERT [dbo].[list_box_options] OFF
GO

drop table ecm_cash_advance_rate;

CREATE TABLE ecm_cash_advance_rate (
	 id varchar(100) NOT NULL,
	 ecm_cash_advance_rate117 varchar(100) NULL,
	 ecm_cash_advance_rate71 varchar(100) NULL,
	 ecm_cash_advance_rate72 varchar(100) NULL,
	 ecm_cash_advance_rate73 decimal(20,4) NULL,
	 ecm_cash_advance_rate74 decimal(20,4) NULL,
	 ecm_cash_advance_rate119 decimal(20,4) NULL,
	 ecm_cash_advance_rate75 decimal(20,4) NULL,
	 ecm_cash_advance_rate97 decimal(20,4) NULL,
	 ecm_cash_advance_rate76 decimal(20,4) NULL,
	 ecm_cash_advance_rate77 decimal(20,4) NULL,
	 ecm_cash_advance_rate98 decimal(20,4) NULL,
	 ecm_cash_advance_rate78 decimal(20,4) NULL,
	 ecm_cash_advance_rate118 decimal(20,4) NULL,
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

 ALTER TABLE ecm_cash_advance_rate
ADD CONSTRAINT ecm_cash_advance_rate_id UNIQUE (id);

CREATE INDEX ecm_cash_advance_ratex
ON ecm_cash_advance_rate (ecm_cash_advance_rate71, ecm_cash_advance_rate72, ecm_cash_advance_rate117);

drop table ecm_cash_advance_trip;

CREATE TABLE ecm_cash_advance_trip(
	[id] [varchar](100) NOT NULL,
	[ecm_cash_advance_trip120] [varchar](100) NULL,
	[ecm_cash_advance_trip60] [varchar](200) NULL,
	[ecm_cash_advance_trip93] [varchar](100) NULL,
	[ecm_cash_advance_trip108] [varchar](100) NULL,
	[ecm_cash_advance_trip109] [varchar](100) NULL,
	[ecm_cash_advance_trip61] [bigint] NULL,
	[ecm_cash_advance_trip62] [bigint] NULL,
	[ecm_cash_advance_trip121] [varchar](100) NULL,
	[ecm_cash_advance_trip64] [varchar](100) NULL,
	[ecm_cash_advance_trip63] [bigint] NULL,
	[ecm_cash_advance_trip122] [varchar](100) NULL,
	[ecm_cash_advance_trip65] [varchar](100) NULL,
	[ecm_cash_advance_trip110] [int] NULL,
	[ecm_cash_advance_trip70] [varchar](100) NULL,
	[ecm_cash_advance_trip127] [int] NULL,
	[ecm_cash_advance_trip126] [int] NULL,
	[ecm_cash_advance_trip123] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip124] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip125] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip128] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip129] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip130] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip131] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip132] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip133] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip134] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip66] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip88] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip89] [decimal](20, 4) NULL,
	[ecm_cash_advance_trip67] [varchar](4000) NULL,
	[ecm_cash_advance_trip90] [varchar](100) NULL,
	[ecm_cash_advance_trip92] [bigint] NULL,
	[ecm_cash_advance_trip91] [varchar](4000) NULL,
	[serial_num] BIGINT IDENTITY(1,1) PRIMARY KEY,
	[creator_role] [varchar](100) NULL,
	[created_source] [varchar](100) NULL,
	[created_by] [varchar](100) NULL,
	[creation_date] [bigint] NULL,
	[modified_source] [varchar](100) NULL,
	[modified_by] [varchar](100) NULL,
	[modification_date] [bigint] NULL,
	[ip_address] [varchar](100) NULL,
	[device_id] [text] NULL,
	[record_status] [varchar](1) NULL
);

ALTER TABLE ecm_cash_advance_trip
ADD CONSTRAINT ecm_cash_advance_trip_id UNIQUE (id);

CREATE INDEX ecm_cash_advance_tripx
ON ecm_cash_advance_trip (ecm_cash_advance_trip60, ecm_cash_advance_trip93, ecm_cash_advance_trip108, ecm_cash_advance_trip109 );
CREATE INDEX ecm_cash_advance_tripy
ON ecm_cash_advance_trip (ecm_cash_advance_trip64, ecm_cash_advance_trip65, ecm_cash_advance_trip70, ecm_cash_advance_trip90 );
CREATE INDEX ecm_cash_advance_tripz
ON ecm_cash_advance_trip (ecm_cash_advance_trip120, ecm_cash_advance_trip121, ecm_cash_advance_trip122 );


drop table general_settings;
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[general_settings](
    [id] [varchar](100) NULL,
    [general_settings001] [varchar](200) NULL,
    [general_settings002] [varchar](6000) NULL,
    [general_settings003] [varchar](6000) NULL,
    [general_settings004] [varchar](200) NULL,
    [general_settings005] [varchar](200) NULL,
    [general_settings006] [varchar](400) NULL,
    [general_settings007] [bigint] NULL,
    [general_settings008] [bigint] NULL,
    [general_settings009] [varchar](400) NULL,
    [general_settings010] [varchar](400) NULL,
    [serial_num] [bigint] IDENTITY(1,1) NOT NULL,
    [creator_role] [varchar](200) NULL,
    [created_source] [varchar](100) NULL,
    [created_by] [varchar](200) NULL,
    [creation_date] [bigint] NULL,
    [modified_source] [varchar](100) NULL,
    [modified_by] [varchar](200) NULL,
    [modification_date] [bigint] NULL,
    [ip_address] [varchar](200) NULL,
    [record_status] [varchar](100) NULL,
    PRIMARY KEY CLUSTERED
(
[serial_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]

    GO
    SET ANSI_PADDING OFF
    GO
    SET IDENTITY_INSERT [dbo].[general_settings] ON

    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693235605016', N'flight_fare', N'50000', N'Default Flight Fare for Cash Advance in NGN', N'decimal', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1148, NULL, NULL, N'', 1693235605, NULL, N'', 1693235605, NULL, N'1')
    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693235680676', N'flight_taxi', N'2500', N'Default Flight Taxi Fare for Cash Advance', N'decimal', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1149, NULL, NULL, N'', 1693235680, NULL, N'', 1693235680, NULL, N'1')
    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693235773893', N'duration_increment', N'-1', N'Increment or Decrement that is added to the No of Days for a Trip during Cash Advance Process', N'number', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1150, NULL, NULL, N'', 1693235773, NULL, N'', 1693235773, NULL, N'1')
    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693235913485', N'lunch', N'', N'Default Lunch Amount in NGN for Cash Advance', N'decimal', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1151, NULL, NULL, N'', 1693235913, NULL, N'', 1693235913, NULL, N'1')
    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693235997764', N'incidence_flight', N'', N'Default Flight Incidence amount in NGN', N'decimal', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1152, NULL, NULL, N'', 1693235997, NULL, N'', 1693235997, NULL, N'1')
    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693236029612', N'incidence', N'', N'Default Land Incidence Amount in NGN', N'decimal', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1153, NULL, NULL, N'', 1693236029, NULL, N'', 1693236029, NULL, N'1')
    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693236074030', N'per_diem', N'', N'Default Per Diem in NGN for Cash Advance', N'decimal', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1154, NULL, NULL, N'', 1693236074, NULL, N'', 1693236074, NULL, N'1')
    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693236116423', N'local_runs_multiplier', N'0.05', N'Default Local Runs Multiplier Value', N'decimal', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1155, NULL, NULL, N'', 1693236116, NULL, N'', 1693236116, NULL, N'1')
    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693236218213', N'land_fare', N'1800', N'Default Land Fare per KM in NGN for Cash Advance', N'decimal', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1156, NULL, NULL, N'', 1693236218, NULL, N'', 1693239931, NULL, N'1')
    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693236218214', N'accommodation', N'1800', N'Default Accommodation in NGN for Cash Advance', N'decimal', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1157, NULL, NULL, N'', 1693236218, NULL, N'', 1693239931, NULL, N'1')
    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693236218215', N'lunch_intransit', N'1800', N'Default Lunch In-transit in NGN for Cash Advance', N'decimal', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1158, NULL, NULL, N'', 1693236218, NULL, N'', 1693239931, NULL, N'1')
    GO
    INSERT [dbo].[general_settings] ([id], [general_settings001], [general_settings002], [general_settings003], [general_settings004], [general_settings005], [general_settings006], [general_settings007], [general_settings008], [general_settings009], [general_settings010], [serial_num], [creator_role], [created_source], [created_by], [creation_date], [modified_source], [modified_by], [modification_date], [ip_address], [record_status]) VALUES (N'1ggs1693236218216', N'others', N'1800', N'Default Others in NGN for Cash Advance', N'decimal', N'cash_advance', NULL, NULL, NULL, NULL, NULL, 1159, NULL, NULL, N'', 1693236218, NULL, N'', 1693239931, NULL, N'1')
    GO
    SET IDENTITY_INSERT [dbo].[general_settings] OFF
    GO
    SET ANSI_PADDING ON

    GO
/****** Object:  Index [id_general_settings]    Script Date: 8/28/2023 5:42:52 PM ******/
ALTER TABLE [dbo].[general_settings] ADD  CONSTRAINT [id_general_settings] UNIQUE NONCLUSTERED
    (
    [id] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    GO


CREATE INDEX general_settingsa
    ON general_settings (general_settings001, general_settings005);