select * 
from PortfolioProject_MarketingAnalytics.dbo.customer_journey

--create a cte to check for duplicates

WITH DuplicateRecords AS (
	select *,
		ROW_NUMBER() over (
		partition by customerid, productid, visitdate, stage, action
		order by journeyid
		) as row_num
	from 
		PortfolioProject_MarketingAnalytics.dbo.customer_journey
)
--get duplcate rows
select * 
from DuplicateRecords
where row_num > 1

--clean duplicates and null values
select JourneyID, CustomerID,ProductID, VisitDate, Action,
coalesce(duration, avg_duration) as duration -- if nil replace duration with avaerage
from 
	(
		select JourneyID, CustomerID,ProductID, VisitDate,
		UPPER(Stage) as Stage,
		Action, Duration,
		Avg(Duration) over (partition by visitdate) as avg_duration,
		ROW_NUMBER() over(
			partition by customerid, productid, visitdate, upper(stage), action
			order by JourneyID
		) as row_num
		from dbo.customer_journey
) as subquery
where 
	row_num = 1;