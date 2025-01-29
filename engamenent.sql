select *
from PortfolioProject_MarketingAnalytics.dbo.engagement_data

select 
	UPPER(Replace(ContentType, 'Socialmedia', 'Social Media')) as ContentType,  --replac the socialmedia text in the content type col to social media
	--break up the views and clicks to separate columns
	LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) -1) as Views,
	RIGHT(ViewsClicksCombined, len(ViewsClicksCombined) -  CHARINDEX('-', ViewsClicksCombined)) as Clicks,
	--change date format
	FORMAT(convert(date, EngagementDate), 'dd.MM.yyy') as EngagementDate

from PortfolioProject_MarketingAnalytics.dbo.engagement_data
where ContentType != 'newsletter'