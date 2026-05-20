## SALES PERFORMANCE AND REVENUE ANALYSIS

### 📌Project Overview
This project is a part of business intelligence case study designed to analyse company sales performance, customer behaviour, product trends, and operational insights. It demonstrates advanced use of BI tools such as **Microsoft Excel, Power BI, DAX, SQL, Python** to build a board room ready dashboard.
The report is structured into multiple pages, each focusing on a different aspect of sales performance, with visuals optimized for storytelling and executive decision making.

### 🏢 Company Context 
**Client Name:** Samudra Marine Supplies Pvt Ltd


The Company is a Thane-based distributor of **Marine products**, including chemicals, water treatment solutions, fuel oil, mooring ropes, and maintenance supplies. Through its strong global supply network, the company serves a wide range of customer segments such as ship owners, managers, chandlers, and offshore operators across India & subcontinent.

The Company set a strategic goal of reaching ₹50 Million in revenue by 2025. However, it lacked centralized Business Intelligence(BI) system to effectively monitor performance and support data-driven decision-making.
Recent performance data(2020-2025) indicated a decline in sales after 2023, with year-on-year growth turning negative in 2025, raising concerns about business sustainability and growth momentum.
****

### 🎯 Project Objective
The objective of this project is to analyze historical sales and revenue data to:
- Identify key trends and inflection point where growth began to decline
- Highlight performance gaps against ₹50M target
- Diagnose the root causes of revenue drop across customers, products, and regions
- Uncover key business risks and inefficiencies affecting profitability
- Provide data-driven insights and recommendations to support strategic decision-making

### 🛠️ Tools & Technologies
- ERP- Source Data
- Excel- Extract source data 
- Excel Power Query – Data cleaning and transformation.
- Python - to Load data into PostgreSQL
- PostgreSQL - creating measures and views
- DAX – Custom measures and calculations.
- Power BI Desktop – Data modeling, visualization, and report building.

### Data Preparation & Confidentiality

- Imported data in Excel from the database
- Cleaned,prepared data in excel power query
- Analysed data and Created views in PostgreSQL
- Loaded data and SQL views in Power BI
- Constructed a snowflake schema tailored for the data model
- Built interactive dashboards with clear KPIs.
- Applied DAX measures and calculations for advanced analytics
- Delivered insights into sales, profit, customers, products etc.
-	Original dataset contained customer, vessel, port, product, and order details in a single table.
-	Separated into normalized 11 tables (Orders, Customers, Customers Segment, Vessels, Products, Product Category, Ports, Port Zone, Sales Region, Sales Representative, Country Code) and saved in CSV file to load tables in PostgreSQL
-	Anonymized sensitive fields (names, codes) while preserving structure and relationships.
-	Ensured confidentiality without losing analytical value


### Loading into PostgreSQL
-	Each table created in excel saved as separate CSV files 
-	Python script was used to load data into Postgre to avoid manually creating tables
-	Connection setup with SQLAlchemy
-	Loop to load multiple CSVs
-	Verification in pgAdmin

 ### Schema Design
-	Table relationships:
-	orders.Customer ID → customers.Customer ID
-	orders.Product Code → products.Product ID
-	orders.Port Code → ports.Port Code
-	orders.Vessel Code → vessels.Vessel Code
-	orders.SR Code → sales_representative.SR Code
-   orders.Order Date → dim_date.Date *(Date table created in Power Bi)*
-	customers.Customers Segment ID → customers_segment.Segment ID
-	customers.Sales Region ID → sales_region.Region ID
-	customers.Sales Region ID → sales_region.Region ID
-   customers.Customer ID → kpi_customer_revenue.Customer ID
-   customers.Customer ID → kpi_above_avg_sales.Customer ID
-   customers.Customer ID → kpi_customer_vs_port_zone.Customer ID
-	products.Product Category ID → product_category.Product Category ID
-	ports.Zone ID → port_zone.Zone ID
-	ports.port country code → country_code.Port Country Code
-   dim_date.Year → Sales_Target.Year *(Target table created in Power BI)*
-   dim_date.YearMonth → kpi_monthly_revenue_analysis.month 
![Snowflake Schema.PNG](<attachment:Snowflake Schema.PNG>)


### 📊 Key Features of the Report

#### Page 1: Summary
Provides a high-level overview of the company's performance against its strategic goal.
- Company Profile and business context
- Gauge visual to track **50M revenue target vs actual achievement**
- KPI cards highlighting key metrics such as revenue performance, customer activity, orders, and operational scale
- Navigation Panel for seamless report exploration

#### Page 2: Executive Overview
Focuses on revenue performance and growth trends over time.
- KPI comparison of **Actual vs Target sales**, Target achievement%, and YoY Growth
- Trend analysis of revenue against targets  
- Combined view of **Sales vs Net Revenue %**
- Waterfall analysis to **highlight year-on-year growth drivers and declines**

#### Page 3: Sales Trends
Tracks short-term and long-term sales patterns.
- Monthly, quarterly, and rolling average sales trends
- Growth indicators such as **MoM and QoQ performance**
- Visuals to detect **seasonality and volatility in sales**

#### Page 4: Customers Drilldown
Analyzes customer contribution and behavior.
- Customer-level KPIs Including sales, order valuem, and engagement
- Pareto analysis to identify **top revenue-contributing customers**
- Segment-viz contribution to understand dependency risks
- Year-vize customer sales trends
 
#### Page 5: Products Drilldown
Evaluates product-level contribution and profitability.
- Category-viz and product-viz sales distribution
- Identification of **top-performing and underperforming products**
- Profitability analysis through **sales vs net revenue relationship**

#### Page 6: Regional & Sales Team Performance
- Regional sales distribution through map visuals
- Performance tracking of **sales representative over time**
- Contribution analysis by region and team members

#### Page 7: Operational Insights
Provides visibility into operational scale and logistics.
- Port-level activity and vessel movement insights
- Order distribution across port zones
- Customer purchase patterns by location

### Dataset 
22K orders
1381 vessels
590 ports
49 customers

### **📈 Business Insights**
1. **Revenue & Growth Performance**
- Post Covid, Revenue grew consistently through 2022, reaching peak business performance with 45.32% YoY growth.
- Growth momentum weakened post-2022, resulting in a -14.5% decline by 2025, signaling changing customer demand and reduced repeat business.
- Despite revenue pressure, net revenue margin remained stable at ~65%, reflecting effective COGS control.

2. **Customer Risk & Retention**
- Revenue concentration risk is significant, with top 4 customers contributing nearly 50% of total revenue.
- Reduced engagement from key accounts appears to be a primary driver of recent sales decline.
- Heavy dependence on ship owners and ship managers (85% revenue share) limits diversification and business resilience.

3. **Product & Profitability Analysis**
- Revenue contribution is heavily concentrated in Chemicals, Water Solutions, and Maintenance categories.
- Cryogen 504 generated the highest net revenue (~₹2.8M), followed by Ecoscale Chemical (~₹2.0M).
- Higher sales volumes did not consistently improve profitability, indicating potential pricing inefficiencies or discount pressure.

4. **Regional & Sales Performance**
- India contributed ~92% of total revenue, supported by concentration of core customer accounts.
- Low-performing regions were primarily impacted by limited operational presence and geopolitical instability.
- Sales performance remained relatively balanced across the team, with Vijay Bansal contributing ~40% of overall revenue.

5. **Operational & Seasonal Insights**
- Revenue patterns show strong seasonality, with Q1 consistently outperforming and Q4 experiencing sharp decline indicating customer budget cycle and spending behaviour.
- Time-series analysis revealed high monthly volatility, suggesting gaps in forecasting accuracy and seasonal sales planning.
- High vessel activity ports such as Singapore, Fujairah, and Rotterdam generated high order volumes but did not always translate into proportional revenue opportunities.


### Key Drivers Behind Revenue Decline (2024–2025)
Over-reliance on limited customers and product categories
Decline in repeat business from new clients
Lack of early detection of negative growth trends (pre-BI adoption)
Possible inefficiencies in regional sales execution and product marketing strategy in low budget seasons

### **Strategic Recommendations**
- Set a realistic target for 2026 at a level comparable to 2025 to ensure revenue stability first, and then focus on sustainable growth.
- Diversify customer base to reduce dependency risk
- Strengthen customer retention strategies for high-value clients
- Explore opportunities for targeted customers, networking, sales strategies and resource optimization.
- Focus on high-performing regions while improving low-performing areas
- Motivate low performing sales rep to achieve sales targets
- Conduct a detailed analysis of low-performing products to assess market demand and identify products for discontinuation. Prioritize   marketing efforts on products with strong consumer demand and growth potential.
- Review product pricing and profitability management
- Leverage BI dashboards for proactively monitoring KPIs on Daily, monthly, quarterly basis.

