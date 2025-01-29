select c.CustomerID, c.CustomerName, c.Email, c.Gender, c.Age, g.City, g.Country
	from PortfolioProject_MarketingAnalytics.dbo.customers as c
left join
	PortfolioProject_MarketingAnalytics.dbo.geography as g
on 
	c.GeographyID = g.GeographyID