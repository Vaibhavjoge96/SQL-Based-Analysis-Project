SELECT * FROM uk_train_rides.uk_trains_shedule;
use  uk_train_rides;
DESCRIBE uk_train_rides.uk_trains_shedule;

#Querry-find the depatrure station proceed from London
SELECT Ticket_Class,Ticket_Type,Ticket_Price,Departure_Station,Arrival_Destination FROM uk_train_rides.uk_trains_shedule
where Departure_Station like "London%";

#Querry-purchase type categories
select purchase_type,count(purchase_type) as Type_Of_Purchase from
uk_train_rides.uk_trains_shedule 
group by purchase_type;

#Querry-Calculate those customer Apply for Refund request
select Journey_status,count(refund_request) as Apply_for_refund
from uk_train_rides.uk_trains_shedule 
group by Journey_status;

#Querry-customer categories based on aging
select railcard,Count(transaction_id) as Customers_of_the_UK_train
from uk_train_rides.uk_trains_shedule 
group by railcard
order by Customers_of_the_UK_train desc limit 1,5;

#Querry-find the list of exact(on Time)depatrure & arrival station time
SELECT * FROM uk_train_rides.uk_trains_shedule;
select date_of_purchase,Departure_Station,
Arrival_Destination,Journey_Status,Departure_Time,Actual_Arrival_Time 
from uk_train_rides.uk_trains_shedule 
where Journey_Status="on time";

#Querry -find the max delay reason
SELECT reason_for_delay, count(transaction_id) as count_
FROm uk_train_rides.uk_trains_shedule
group by reason_for_delay
order by count_ desc 
limit 1,10;
   
#Querry--Max ratio of those  dept & arrival station delay of trains. 
select Departure_Station,Arrival_Destination,COUNT(Reason_for_Delay) as total_reason_count
FROM uk_train_rides.uk_trains_shedule
GROUP BY Departure_Station,Arrival_Destination
having total_reason_count >10
order by total_reason_count desc;

#Querry-high price of ticket baseed on Dept & arrivatl station (cost upto 100)
select Ticket_Class,Departure_Station,Arrival_Destination,Ticket_Price
from uk_train_rides.uk_trains_shedule 
where Ticket_Price>=100
order by Ticket_Class,Ticket_Price
desc;

#.Querry-Identified Rank Wise Which tickets are sailed on high cost depends on Dept & arrival station & ticket Class (cost up to < 100).
select Ticket_Class,Departure_Station,Arrival_Destination,Ticket_Price,
row_number () over ( partition by Ticket_Class order by ticket_price desc) as Row_Wise_Ticket_Price,
rank () over ( partition by Ticket_Class order by ticket_price desc) as Rank_Wise_Ticket_Price,
dense_rank() over (partition by Ticket_Class order by ticket_price desc) as dense_Rank_Wise_Ticket_Price,
ntile(10) over(partition by Ticket_Class order by ticket_price desc) as Ntile_In_10_Categories
 from uk_train_rides.uk_trains_shedule
 where ticket_price>=100;

#Querry -max sales on day wise
select 
date_of_purchase,sum(Ticket_Price) as  total_sales
from uk_train_rides.uk_trains_shedule
group by date_of_purchase
having total_sales>=1000
order by total_sales
desc;

#querry- max sales on dept station
select 
Departure_Station,sum(Ticket_Price) as Total_price
from uk_train_rides.uk_trains_shedule
group by Departure_Station
order by total_price desc;

#Querry-uper case of dept & arrival station.
select upper(Departure_Station) as Dept_stn,upper( Arrival_Destination) as Arri_stn  
from uk_train_rides.uk_trains_shedule;