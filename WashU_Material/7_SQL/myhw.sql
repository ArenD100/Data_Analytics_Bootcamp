-- import departments 
CREATE TABLE departments (
dept_no VARCHAR(50) Primary Key,
dept_name VARCHAR(50)
);

COPY departments FROM 'C:\Users\arend\ClassExamplesGit\WUSTL201904DATA2\02-Homework\09-SQL\Instructions\data\departments.txt' DELIMITER ',' CSV HEADER;

SELECT * FROM departments;

-- import employees
CREATE TABLE employees (
emp_no INT Primary Key,
birth_date DATE,
first_name VARCHAR(50),
last_name VARCHAR(50),
gender VARCHAR(50),
hire_date DATE
);

COPY employees FROM 'C:\Users\arend\ClassExamplesGit\WUSTL201904DATA2\02-Homework\09-SQL\Instructions\data\employees.txt' DELIMITER ',' CSV HEADER;

SELECT * FROM employees;

--import dept_emp
CREATE TABLE dept_emp (
emp_no INT REFERENCES employees(emp_no),
dept_no VARCHAR(50) REFERENCES departments(dept_no),
from_date DATE,
to_date DATE,
Primary Key(emp_no, dept_no)
);

COPY dept_emp FROM 'C:\Users\arend\ClassExamplesGit\WUSTL201904DATA2\02-Homework\09-SQL\Instructions\data\dept_emp.txt' DELIMITER ',' CSV HEADER;

SELECT * FROM dept_emp;

-- import dept_manager
CREATE TABLE dept_manager (
dept_no VARCHAR(50) REFERENCES departments(dept_no),
emp_no INT REFERENCES employees(emp_no),
from_date DATE,
to_date DATE,
Primary Key(dept_no, emp_no)
);

COPY dept_manager FROM 'C:\Users\arend\ClassExamplesGit\WUSTL201904DATA2\02-Homework\09-SQL\Instructions\data\dept_manager.txt' DELIMITER ',' CSV HEADER;

SELECT * FROM dept_manager;


-- import salaries
CREATE TABLE salaries (
emp_no INT REFERENCES employees(emp_no),
salary INT,
from_date DATE,
to_date DATE
);

COPY salaries FROM 'C:\Users\arend\ClassExamplesGit\WUSTL201904DATA2\02-Homework\09-SQL\Instructions\data\salaries.txt' DELIMITER ',' CSV HEADER;

SELECT * FROM salaries;

-- import titles
CREATE TABLE titles (
emp_no INT REFERENCES employees(emp_no),
title VARCHAR(50),
from_date DATE,
to_date DATE
);

COPY titles FROM 'C:\Users\arend\ClassExamplesGit\WUSTL201904DATA2\02-Homework\09-SQL\Instructions\data\titles.txt' DELIMITER ',' CSV HEADER;

SELECT * FROM titles;

-- homework analysis portion
-- question 1 
-- List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees, salaries
WHERE employees.emp_no = salaries.emp_no;


-- question two
-- List employees who were hired in 1986.

SELECT * FROM employees
WHERE EXTRACT(YEAR from hire_date) = 1986;

-- question 3
-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT dept_manager.dept_no, dept_manager.emp_no, dept_manager.from_date, dept_manager.to_date, 
departments.dept_name,
employees.last_name, employees.first_name
FROM dept_manager, departments, employees
WHERE dept_manager.emp_no = employees.emp_no AND dept_manager.dept_no = departments.dept_no;

-- question 4
-- List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM employees, departments, dept_emp
WHERE dept_emp.dept_no = departments.dept_no AND employees.emp_no = dept_emp.emp_no;

-- question 5 
-- List all employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name FROM employees
WHERE first_name LIKE 'Hercules' AND last_name LIKE 'B%';

--question 6 
-- List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp, departments, employees
WHERE employees.emp_no = dept_emp.emp_no AND dept_emp.dept_no = departments.dept_no AND dept_name LIKE 'Sales';

-- question 7
-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp, departments, employees
WHERE employees.emp_no = dept_emp.emp_no AND dept_emp.dept_no = departments.dept_no AND (dept_name LIKE 'Sales' OR dept_name Like 'Development');

-- question 8
-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT COUNT(last_name) as lastnamecount, last_name FROM employees
GROUP BY last_name
ORDER BY lastnamecount DESC; 


