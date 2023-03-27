--Build Tables and dependancies

Drop TABLE titles CASCADE;
Drop TABLE employees CASCADE;
Drop TABLE departments CASCADE;
Drop TABLE dept_manager CASCADE;
Drop TABLE dept_emp CASCADE ;
Drop TABLE salaries CASCADE;

CREATE TABLE titles(
	title_id VARCHAR(30) PRIMARY KEY NOT NULL,
	title VARCHAR (30) NOT NULL
);

CREATE TABLE employees(
	emp_no INTEGER PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR (30) REFERENCES titles (title_id), 
	birth_date DATE NOT NULL, 
	first_name VARCHAR (30) NOT NULL, 
	last_name VARCHAR (30) NOT NULL, 
	sex VARCHAR (5) NOT NULL, 
	hire_date DATE NOT NULL
);

ALTER TABLE employees 
ADD CONSTRAINT fk_emp_title_id 
FOREIGN KEY (emp_title_id) 
REFERENCES titles(title_id);


CREATE TABLE departments(
	dept_no VARCHAR (10) PRIMARY KEY NOT NULL,
	dept_name VARCHAR (30)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR (10) REFERENCES departments (dept_no),
	emp_no INTEGER REFERENCES employees(emp_no)
);

ALTER TABLE dept_manager ADD CONSTRAINT pk_dept_manager PRIMARY KEY (dept_no, emp_no);

CREATE TABLE dept_emp(
	emp_no INTEGER REFERENCES employees (emp_no),
	dept_no VARCHAR REFERENCES departments(dept_no)
);
ALTER TABLE dept_emp ADD CONSTRAINT pk_dept_emp PRIMARY KEY(emp_no, dept_no);

CREATE TABLE salaries(
	emp_no INTEGER REFERENCES employees (emp_no),
	salary INTEGER
);

--Pull in CSV files and confirm they are present
SELECT * FROM titles;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_manager; 
SELECT * FROM dept_emp;
SELECT * FROM salaries;

-- Data Analysis
-- Questions:

-- #1
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

--#2
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1/1/86' AND '12/31/86';


--#3
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_no, departments.dept_name
FROM dept_manager 
JOIN employees ON dept_manager.emp_no = employees.emp_no 
JOIN departments ON dept_manager.dept_no = departments.dept_no; 

--#4
SELECT departments.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp 
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no;

--#5
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND
last_name LIKE 'B%';

--#6
Select employees.emp_no, employees.last_name, employees.first_name , departments.dept_no, departments.dept_name
FROM dept_emp
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.dept_no = 'd007';

--#7
Select employees.emp_no, employees.last_name, employees.first_name , departments.dept_no, departments.dept_name
FROM dept_emp
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.dept_no = 'd007' OR dept_emp.dept_no = 'd005';

--#8
SELECT employees.last_name, COUNT(*) AS Frequency
FROM employees
GROUP BY employees.last_name;


