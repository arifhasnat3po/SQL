DROP TABLE IF EXISTS employees;

CREATE TABLE employees(
   id INT,
   first_name VARCHAR(40) NOT NULL,
   last_name VARCHAR(40) NOT NULL,
   PRIMARY KEY(id)
);


DROP TABLE IF EXISTS employee_audits;


CREATE TABLE employee_audits (
   id INT,
   employee_id INT NOT NULL,
   new_last_name VARCHAR(40) NOT NULL,
   old_last_name VARCHAR(40) NOT NULL,
   changed_on DATETIME(6) NOT NULL
);

create trigger last_name_changes
  before update 
  on employees 
  for each row
  call  procedure insert into employee_audits(employee_id, new_last_name, old_last_name, changed_on);
 
INSERT INTO employees (first_name, last_name)
VALUES ('John', 'Doe');

INSERT INTO employees (first_name, last_name)
VALUES ('Lily', 'Bush');


SELECT * FROM employees;

SELECT * FROM employee_audits;


UPDATE employees
SET last_name = 'Alice'
WHERE ID = 1;


SELECT * FROM employee_audits;