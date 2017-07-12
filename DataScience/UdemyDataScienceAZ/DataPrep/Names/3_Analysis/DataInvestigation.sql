/****** Script for SelectTopNRows command from SSMS  ******/
SELECT * FROM [udemyDataScienceAZ].[dbo].[RAW_Names_20170622]

-- get 50,004, should only have 50k

SELECT * FROM [udemyDataScienceAZ].[dbo].[RAW_Names_20170622]
WHERE [Column 46] NOT LIKE '' -- rows shifted to the right
	OR [Longitude] NOT LIKE '%.%' --rows shifted to the left

-- 14 rows, some corrupt, some missing data