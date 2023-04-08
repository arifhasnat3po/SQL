DROP TABLE IF EXISTS employees;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE employees(
   id INT,
   first_name VARCHAR(40) NOT NULL,
   last_name VARCHAR(40) NOT NULL,
   PRIMARY KEY(id)
);
DROP TABLE IF EXISTS employee_audits;

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE employee_audits (
   id INT,
   employee_id INT NOT NULL,
   new_last_name VARCHAR(40) NOT NULL,
   old_last_name VARCHAR(40) NOT NULL,
   changed_on DATETIME(6) NOT NULL
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
drop function if exists log_last_name_changes;

delimiter //

create function log_last_name_changes()
    returns trigger 

language declare plpgsql

as $$
//

delimiter ;

begin
	if new.last_name <> old.last_name then 
	  insert into employee_audits(employee_id, new_last_name, old_last_name, changed_on)
	  values(old.id, new.last_name, old.last_name, now());
	 end if;
	
	return new;

end; $$
create trigger last_name_changes
  before update 
  on employees 
  for each row
  call  procedure  log_last_name_changes();
 
INSERT INTO employees (first_name, last_name)
VALUES ('John', 'Doe');

INSERT INTO employees (first_name, last_name)
VALUES ('Lily', 'Bush');

-- SQLINES LICENSE FOR EVALUATION USE ONLY
SELECT * FROM employees;
-- SQLINES LICENSE FOR EVALUATION USE ONLY
SELECT * FROM employee_audits;

