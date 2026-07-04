create database bank_analysis;
use bank_analysis;


# Total_accounts
select count(*) as Total_Accounts from accounts;
#Total_customer
select count(*) as Total_customers from customers;
#Total_loan_amount
select sum(Loan_Amount) as Total_loan_amount from loan;
#Total_transactions
select count(*) as total_transactions from transactions;
#Total_account_balance
select sum(Balance) as Total_balance from accounts;


# No of Customers in Each City
select count(*) as No_of_customers,City
from customers
group by City
order by No_of_customers desc;

# Number of Accounts by Account Type
select count(*) as Total_accounts,Account_Type
from accounts
group by Account_Type
order by Total_accounts desc;

# Total Balance by Account Type
select sum(Balance) as Total_balance,Account_Type
from accounts
group by Account_Type
order by Total_balance desc;

#Transactions by Channel
select Channel,count(*) as Total_transactions
from transactions
group by Channel
order by Total_transactions desc;

#Total Transaction Amount by Transaction Type
select Transaction_Type,sum(Amount) as Total_Transaction_Amount
from transactions
group by Transaction_Type
order by Total_Transaction_Amount desc;

#Total Loan Amount by Loan Type
select Loan_Type,sum(Loan_Amount) as Total_loan_amount
from loan
group by Loan_Type
order by Total_loan_amount desc;

# Customer Name with Account Details
select c.ï»¿Customer_ID,c.Customer_Name,a.Account_ID,a.Account_Type,a.Balance
from customers c
join accounts a
on c.ï»¿Customer_ID=a.Customer_ID;

# Customer Loan Details
select c.ï»¿Customer_ID,l.Loan_Type,l.Loan_Amount,l.Interest_Rate,l.Loan_Status
from loan l
join customers c
on c.ï»¿Customer_ID=l.Customer_ID;

# Customer Transaction Details
select c.Customer_Name,t.Transaction_Type,t.Channel,t.Amount,t.Status
from customers c
join accounts a
on c.ï»¿Customer_ID=a.Customer_ID
join transactions t
on a.Account_ID=t.Account_ID;

# Top 10 Customers by Total Transaction Amount
select c.ï»¿Customer_ID,c.Customer_Name,sum(t.Amount) as Total_transaction_amount
from customers c
join accounts a
on c.ï»¿Customer_ID=a.Customer_ID
join transactions t
on a.Account_ID=t.Account_ID
group by c.ï»¿Customer_ID,c.Customer_Name
order by Total_transaction_amount desc
limit 10;

#Top 10 Customers by Account Balance
select c.Customer_Name,sum(a.Balance) as account_balance
from customers c
join accounts a
on c.ï»¿Customer_ID=a.Customer_ID
group by c.Customer_Name
order by account_balance desc
limit 10;

#Customers with Both Loan and Account
select c.Customer_Name,a.Customer_ID,l.Loan_Type,l.Loan_Amount
from customers c
join accounts a
on c.ï»¿Customer_ID=a.Customer_ID
join loan l
on c.ï»¿Customer_ID=l.Customer_ID;


# top 3 customers by account balance in every city
with rankedcustomers as (select c.Customer_Name,c.City,a.Account_Type,a.Balance,
	row_number() over(partition by c.City order by a.Balance desc) as Top_3
from customers c 
join accounts a
on a.Customer_ID=c.ï»¿Customer_ID)
select * from rankedcustomers
where Top_3 <=3;

# Top 5 Customers by Total Account Balance
select c.Customer_Name,sum(a.Balance) as total_balance
from customers c
join accounts a
on c.ï»¿Customer_ID=a.Customer_ID
group by c.Customer_Name
order by total_balance desc
limit 5;

