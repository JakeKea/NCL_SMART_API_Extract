USE [Data_Lab_NCL_Dev]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [JakeK].[smart_api_data_vw]
AS

--CTE to list text based indicators
WITH TextIndicators (indicatorKeyName) AS (
	SELECT 'issues_risks_today' UNION ALL
	SELECT 'reason_for_deterioration_yesterday' UNION ALL
	SELECT 'infection_control_issues' UNION ALL
	SELECT 'staffing_issues' UNION ALL
	SELECT 'mitigating_actions_today' UNION ALL
	SELECT 'actions_review' UNION ALL
	SELECT 'opel_level'
)
		
--Query to generate view
SELECT
	[responseChildId] --Unique id
	,[indicatorName] --Front end name for indicator
	,[indicatorKeyName] --Key name for indicator

	--Numerical values (Can be cast as a float data type)
	,CAST (
		CASE 
			WHEN [value] IN ('', '-') THEN NULL
			WHEN [indicatorKeyName] IN (SELECT indicatorKeyName FROM TextIndicators) THEN NULL
			ELSE [value]
		END
		AS FLOAT) AS [value_numeric]

	--Text values
	,CASE
		WHEN [indicatorKeyName] IN (SELECT indicatorKeyName FROM TextIndicators) THEN [value]
		ELSE NULL
	END AS [value_text]

	--Flag to id if an indicator is numeric based or text based
	,CASE
		WHEN [indicatorKeyName] IN (SELECT indicatorKeyName FROM TextIndicators) THEN 0
		ELSE 1
	END AS [indicator_numeric]

	,[additionalComments]
	--Cast date related columns to date types
    ,CAST ([reportDate] AS DATE) AS [reportDate]
    ,CAST([timestamp] AS DATETIME) AS [timestamp]

    ,[siteName]
    ,[customerName]
        
FROM [Data_Lab_NCL_Dev].[JakeK].[smart_api_data]

GO;