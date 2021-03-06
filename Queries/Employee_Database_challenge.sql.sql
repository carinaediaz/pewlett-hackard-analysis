-- Create retirement_titles table
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    ti.title,
    ti.from_date,
    ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;


-- Create unique_titles table that removes emp_no duplicate occurrences
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;


-- Create retiring_titles table with retiring title counts
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;


-- Create mentorship_elegibility table by filtering by DOB
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date, 
    de.from_date, 
    de.to_date, 
    t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE de.to_date = '9999-01-01' AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;


-- Create mentorship_elegibility table by expanding DOB filter
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
