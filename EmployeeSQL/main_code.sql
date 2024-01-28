--DROP TABLE IF EXISTS employees;


CREATE TABLE "departments" (
    "depto_no" VARCHAR   NOT NULL,
    "depto_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "depto_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT,
    "salary" INT   
);

CREATE TABLE "employees" (
    "emp_no" INT,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_day" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   
);

CREATE TABLE "dept_emp" (
    "emp_no" INT,
    "dept_no" VARCHAR   NOT NULL
);

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("depto_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("depto_no");


SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM titles;
SELECT * FROM salaries;
SELECT * FROM employees;

-- 1.- List the employee number, last name, first name, sex, and salary of each employee.

SELECT 
	e.emp_no AS "employee number", 
	e.last_name AS "employee last name", 
	e.first_name AS "employee first name", 
	e.sex, 
	s.salary AS "employee salary"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

--2.- List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT 
	first_name AS "employee first name", 
	last_name AS "employee last name", 
	hire_date AS "hire date"
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3.- List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT 
	dm.dept_no AS "department number", 
	d.depto_name AS "department name", 
	dm.emp_no AS "manager emp no", 
	e.last_name AS "manager last name", 
	e.first_name AS "manager first day"
FROM dept_manager dm
JOIN departments d ON dm.dept_no = d.depto_no
JOIN employees e ON dm.emp_no = e.emp_no;

-- 4.- List the department number for each employee along with that employee’s employee number, last name, first name, and department name. 

SELECT 
	de.dept_no AS "department number", 
	e.emp_no AS "employee number", 
	e.last_name AS "employee last name", 
	e.first_name AS "employee first name", 
	d.depto_name AS "department name"
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.depto_no;

-- 5.- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT 
	first_name AS "employee first name", 
	last_name AS "employee last name", 
	sex AS "sex"
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6.- List each employee in the Sales department, including their employee number, last name, and first name.

SELECT 
	d.depto_name AS "department", 
	de.emp_no AS "employee number", 
	e.last_name AS "employee last name", 
	e.first_name AS "employee first name"
FROM departments d
JOIN dept_emp de ON d.depto_no = de.dept_no
JOIN employees e ON de.emp_no = e.emp_no
WHERE d.depto_name = 'Sales';

-- 7.- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT 
	d.depto_name AS "department", 
	de.emp_no AS "employee number", 
	e.last_name AS "employee last name", 
	e.first_name AS "employee first name"
FROM departments d
JOIN dept_emp de ON d.depto_no = de.dept_no
JOIN employees e ON de.emp_no = e.emp_no
WHERE d.depto_name IN ('Sales','Development');

-- 8.- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT 
	last_name AS "employee last name", 
	COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC; 
