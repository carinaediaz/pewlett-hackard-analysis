# Pewlett Hackard Analysis  
## Overview
##### Pewlett Hackard has been primarily using Excel in the past to store and access their HR data, but have decided to update to SQL. We were tasked with assisting them with not only building a new database in SQL, but also analyzing their employee's ages, tenure, and titles to determine who will be retiring soon and how many positions will need to be filled. By determining who is eligible for retirement, we can see what their titles are to determine what positions will be vacant and what current employees may be eligible for a mentorship program to help fill those positions from within the company. 
## Results
##### After identifying the relationships between the existing CSV files, we created the PH-EmployeeDB within SQL. After defining the table names, column names/datatypes, and any primary/foreign keys within SQL's Query Tool, we imported the CSV files into their corresponding database table. Once the tables were created, we could begin to write queries and join tables for the purpose of our analysis: determining which employees are eligible for retirement and which are eligible for a mentorship program. The results of our analysis are below:
- 72,458 employees are currently eligible for retirement. 
- "Senior Engineer" is the title with the most retiring employees and "Manager" is the title with the least retiring employees. 
- 1,549 employees are currently eligible for the mentorship program. 
- Of these eligible employees, the most common title is "Senior Staff" and the least common is "Assistant Engineer". 
##### 
![employees_retiring_by_title.PNG](https://github.com/carinaediaz/pewlett-hackard-analysis/blob/main/Images/employees_retiring_by_title.PNG)
![employees_mentorship_by_title.PNG](https://github.com/carinaediaz/pewlett-hackard-analysis/blob/main/Images/employees_mentorship_by_title.PNG)
## Summary
##### Pewlett Hackard will have a significant number of their employees retiring over the next four years, with the company needing to fill 72,458 positions as the 'silver tsunami' retires. Based on the mentorship eligibility table we created, there will not be nearly enough internal employees to fill these positions. Pewlett Hackard will need to either expand their eligibility criteria for the mentorship program or begin to look at hiring from outside the firm. 
##### By editing our mentorship program criteria to include employees born in 1962-1965 (instead of only 1965), we vastly increase our pool of mentorship eligible employees from 1,549 to 56,859. 
```
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date, 
    de.from_date, 
    de.to_date, 
    t.title
INTO mentorship_eligibility_expanded
FROM employees as e
LEFT JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE de.to_date = '9999-01-01' AND (e.birth_date BETWEEN '1962-01-01' AND '1965-12-31')
ORDER BY emp_no;
```
##### With this new table created, we can then run a count query to determine how many of each title are now eligible for the mentorship program. 
![employees_mentorship_expanded_by_title.PNG](https://github.com/carinaediaz/pewlett-hackard-analysis/blob/main/Images/employees_mentorship_expanded_by_title.PNG)
##### By expanding our search criteria for the mentorship program, Pewlett Hackard can focus on training internal employees rather than launching a large hiring campaign. 
