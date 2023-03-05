-- Let's start our query by selecting everything in different forms

select *
from Credit_project..credit_SQL$ --That's one way of doing it

-- different way
select *
from Credit_project.dbo.credit_SQL$
order by 3,4

-- Selecting the data to use
Select member_id, loan_amnt, loan_status, term, int_rate, installment, grade, emp_length, home_ownership, annual_inc, purpose, addr_state, total_pymnt, last_pymnt_amnt
from Credit_project.dbo.credit_SQL$
order by 1,2

-- Let's find the % of loan in relation to income
Select member_id, loan_amnt, loan_status, term, int_rate, installment, purpose, annual_inc, addr_state, total_pymnt, last_pymnt_amnt, (loan_amnt/annual_inc)*100 as Loan_percent_Income
from Credit_project.dbo.credit_SQL$
where annual_inc <> 0
order by 2,3

-- Percentage received in retaltion to total loan amount 
Select member_id, loan_amnt, loan_status, term, int_rate, installment, purpose, annual_inc, addr_state, total_pymnt, total_rec_prncp, (total_rec_prncp/loan_amnt)*100 as Loan_perc_received
from Credit_project.dbo.credit_SQL$
where total_rec_prncp < loan_amnt
order by 2,3

-- Max payment received 
Select loan_amnt, loan_status, term, total_pymnt, total_rec_prncp, MAX(total_rec_prncp) as Max_Loan_received
from Credit_project.dbo.credit_SQL$
Group by loan_amnt, loan_status, term, total_pymnt, total_rec_prncp
order by total_rec_prncp desc

-- Max payment received in percentage 
Select loan_amnt, loan_status, term, total_pymnt, total_rec_prncp, MAX((total_rec_prncp/loan_amnt))*100 as Max_percentage_LoanReceived
from Credit_project.dbo.credit_SQL$
where total_rec_prncp < loan_amnt
Group by loan_amnt, loan_status, term, total_pymnt, total_rec_prncp
order by total_rec_prncp desc

-- Sum rows where Fully Paid 
Select SUM(loan_amnt) as TotalAmountReceived
from Credit_project.dbo.credit_SQL$
where loan_status = 'Fully Paid' -- equals 2,772,344,050 Bi

-- Considered lost
Select SUM(loan_amnt) as TotalWrittenOff
from Credit_project.dbo.credit_SQL$
where loan_status = 'Charged Off' -- equals 658,643,150 Mi

-- Considered current
Select SUM(loan_amnt) as Current_Loan
from Credit_project.dbo.credit_SQL$
where loan_status = 'Current' -- equals  £9,172,243,450.00 Bi

-- Total amount lent by the bank
Select SUM(loan_amnt) as Total_Lent
from Credit_project.dbo.credit_SQL$

-- Average interest rate charged by the bank
Select member_id, loan_amnt, loan_status, term, int_rate, AVG(cast(int_rate as int)) as average_int_rate
from Credit_project.dbo.credit_SQL$
group by member_id, loan_amnt, loan_status, term, int_rate
order by 1, 2

-- Average interest rate charged is 12%
Select AVG(cast(int_rate as int)) as ave_int_rate
from Credit_project.dbo.credit_SQL$
--group by int_rate
order by 1

Select AVG(term) as ave_term
from Credit_project.dbo.credit_SQL$
--group by int_rate
order by 1

-- USE CTE to create a column/variable
-- Let's find the % of installment payment in relation to income -- USE CTE to create a column/variable (This is the CTE (used to create a new column for the dataset)) 
With Perc_Inst (loan_amnt, loan_status, term, int_rate, installment, purpose, annual_inc, PercInstall_ann_Income)
as
(
Select loan_amnt, loan_status, term, int_rate, installment, purpose, annual_inc, (installment/annual_inc)*100 as PercInstall_ann_Income
from Credit_project.dbo.credit_SQL$
where annual_inc <> 0
)
Select *
from Perc_Inst

-------------------------
-- Getting the average interest rate charged in relation to income
With Perc_Inst (loan_amnt, loan_status, term, int_rate, installment, purpose, annual_inc, PercInstall_ann_Income)
as
(
Select loan_amnt, loan_status, term, int_rate, installment, purpose, annual_inc, (installment/annual_inc)*100 as PercInstall_ann_Income
from Credit_project.dbo.credit_SQL$
where annual_inc <> 0
)
Select AVG(PercInstall_ann_Income) as aver_percentage_int_charged_by_income
from Perc_Inst

-- Sum of total loans to tenents   £4,583,431,900.00 
Select home_ownership,
SUM(loan_amnt) as Loan_to_tenents
from Credit_project.dbo.credit_SQL$
where home_ownership like 'RENT'
Group by home_ownership
--order by home_ownership

-- Sum of total loans to Owners  £1,244,070,050.00 
Select home_ownership,
SUM(loan_amnt) as Loan_to_owners
from Credit_project.dbo.credit_SQL$
where home_ownership like 'OWN'
Group by home_ownership
--order by home_ownership

-- Sum of total loans to Mortgage  £7,263,305,275.00 
Select home_ownership,
SUM(loan_amnt) as Loan_to_Mortgage
from Credit_project.dbo.credit_SQL$
where home_ownership like 'MORTGAGE'
Group by home_ownership
--order by home_ownership

-- Sum of total loans to NONE  £673,975.00 
Select home_ownership,
SUM(loan_amnt) as Loan_to_NONE
from Credit_project.dbo.credit_SQL$
where home_ownership like 'NONE'
Group by home_ownership
--order by home_ownership

-- Interest rate charged for A - 7.24%
Select grade,
AVG(int_rate) as rate_for_A
from Credit_project.dbo.credit_SQL$
where grade like 'A'
Group by grade

-- Interest rate charged for B - 10.83%
Select grade,
AVG(int_rate) as rate_for_B
from Credit_project.dbo.credit_SQL$
where grade like 'B'
Group by grade

-- Interest rate charged for C - 13.98%
Select grade,
AVG(int_rate) as rate_for_C
from Credit_project.dbo.credit_SQL$
where grade like 'C'
Group by grade

-- Interest rate charged for D - 17.18%
Select grade,
AVG(int_rate) as rate_for_D
from Credit_project.dbo.credit_SQL$
where grade like 'D'
Group by grade

-- Interest rate charged for E - 19.90%
Select grade,
AVG(int_rate) as rate_for_E
from Credit_project.dbo.credit_SQL$
where grade like 'E'
Group by grade

-- Interest rate charged for F - 23.58% 
Select grade,
AVG(int_rate) as rate_for_F
from Credit_project.dbo.credit_SQL$
where grade like 'F'
Group by grade

-- Interest rate charged for G - 25.63% 
Select grade,
AVG(int_rate) as rate_for_G
from Credit_project.dbo.credit_SQL$
where grade like 'G'
Group by grade

-- It is interesting to see that interest rate changes given the customer's grade. This is called the risk premium. 