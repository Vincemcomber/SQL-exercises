### CHAPTER 1: CREATING DATABASE ###
# Create database:
CREATE DATABASE companyHR;

# Use database: 
USE companyHR;

# Deleting the Database
# For instance, to delete a database called wrongDB, we write:
DROP DATABASE wrongDB;


### CHAPTER 2: DEFINING TABLES ###
# A. Creating Tables

# To create the co_employees table, we use the code below:
CREATE TABLE co_employees (
id INT PRIMARY KEY AUTO_INCREMENT,
em_name VARCHAR(255) NOT NULL,
gender CHAR(1) NOT NULL,
contact_number VARCHAR(255),
age INT NOT NULL,
date_created TIMESTAMP NOT NULL DEFAULT NOW()
);

# Create a table called mentorships:
CREATE TABLE mentorships (
mentor_id INT NOT NULL,
mentee_id INT NOT NULL,
status VARCHAR(255) NOT NULL,
project VARCHAR(255) NOT NULL,
PRIMARY KEY (mentor_id, mentee_id, project),
CONSTRAINT fk1 FOREIGN KEY(mentor_id) REFERENCES
co_employees(id) ON DELETE CASCADE ON UPDATE RESTRICT,
CONSTRAINT fk2 FOREIGN KEY(mentee_id) REFERENCES
co_employees(id) ON DELETE CASCADE ON UPDATE RESTRICT,
CONSTRAINT mm_constraint UNIQUE(mentor_id, mentee_id)
);

#B. Altering Tables
#1. Lets alter the co_employees table
# Suppose we want to do the following:
# 1) Drop the age column
# 2) Add another column called salary which is of FLOAT type and cannot be null. This column should come after the contact_number column
# 3) Add a new column called years_in_company which is of INT type and cannot be null. This column should come after the salary column
# Here’s how we do it:

ALTER TABLE co_employees
DROP COLUMN age,
ADD COLUMN salary FLOAT NOT NULL AFTER contact_number,
ADD COLUMN years_in_company INT NOT NULL AFTER salary;

# C. Describe
#To describe the co_employees and mentorships tables, we write
DESCRIBE co_employees;
DESCRIBE mentorships;

#2. Lets alter the mentorships table:
#(i) For this table, we want to
# 1) Modify fk2 by changing ON UPDATE RESTRICT to ON UPDATE CASCADE
# 2) Drop the mm_constraint constraint

# In order to modify the foreign key constraint, we have to first drop the original foreign key using the statement below: 
ALTER TABLE mentorships DROP FOREIGN KEY fk2;

#(ii) Next, using a new ALTER statement (we are not allowed to drop and add a foreign key with the same name using a single ALTER statement), we add the foreign key back with the modified conditions. In addition, we also drop the mm_constraint constraint:
ALTER TABLE mentorships ADD CONSTRAINT fk2 FOREIGN KEY(mentee_id) REFERENCES co_employees(id) ON DELETE CASCADE ON UPDATE CASCADE, DROP INDEX mm_constraint;

### CHAPTER 3: INSERTING, UPDATING AND DELETING DATA ###
# A. Suppose we want to insert the information above into the co_employees and mentorships tables, we write:
INSERT INTO co_employees (em_name, gender, contact_number, salary,
years_in_company) VALUES
('James Lee', 'M', '516-514-6568', 3500, 11),
('Peter Pasternak', 'M', '845-644-7919', 6010, 10),
('Clara Couto', 'F', '845-641-5236', 3900, 8),
('Walker Welch', 'M', NULL, 2500, 4),
('Li Xiao Ting', 'F', '646-218-7733', 5600, 4),
('Joyce Jones', 'F', '523-172-2191', 8000, 3),
('Jason Cerrone', 'M', '725-441-7172', 7980, 2),
('Prudence Phelps', 'F', '546-312-5112', 11000, 2),
('Larry Zucker', 'M', '817-267-9799', 3500, 1),
('Serena Parker', 'F', '621-211-7342', 12000, 1);

INSERT INTO mentorships (mentor_id, mentee_id, status, project)
VALUES
(1, 2, 'Ongoing', 'SQF Limited'),
(1, 3, 'Past', 'Wayne Fibre'),
(2, 3, 'Ongoing', 'SQF Limited'),
(3, 4, 'Ongoing', 'SQF Limited'),
(6, 5, 'Past', 'Flynn Tech');

# B. Updating Data
#1. For instance, suppose we want to update the contact number of 'James Lee' from '516-514-6568' to '516-514-1729', we use the code
UPDATE co_employees SET contact_number = '516-514-1729' WHERE id = 1;

UPDATE co_employees SET id = 12 WHERE id = 1;

# C. Deleting Data
# For instance, to delete 'Li Xiao Ting' (id = 5) from the employees table, we use the following code:
DELETE FROM employees WHERE id = 5;

# D. Constraints
# Try inserting the following data into mentorships:
INSERT INTO mentorships VALUES (4, 21, 'Ongoing', 'Flynn Tech');

# SELECT ALL FROM TABLES
SELECT * FROM co_employees;
SELECT * FROM mentorships;


### CHAPTER 4: SELECTING DATA PART 1 ###
## A: Selecting Everything
# to select all data from the co_employees and mentorships tables, we write
SELECT * FROM co_employees;
SELECT * FROM mentorships;

## B: Filtering Columns
# Suppose we only want to select the em_name and gender columns from the co_employees table, we write:
SELECT em_name, gender from co_employees;

# Using Aliases
SELECT em_name AS `Employee Name`, gender AS Gender FROM co_employees;

## C: Filtering Rows
# We can use the LIMIT keyword. This limits the number of rows retrieved by the SELECT statement. For instance, if we write
SELECT em_name AS 'Employee Name', gender AS Gender FROM co_employees LIMIT 3;

## D: DISTINCT
# 1. Another way to filter rows is to remove duplicates. This can be achieved using the DISTINCT keyword. If we write:
SELECT gender FROM co_employees;

# 2. If we want to remove the duplicates, we can write:
SELECT DISTINCT(gender) FROM co_employees;

## E: WHERE clause 

#1. Use COMPARISON
# For instance, if we want to select all rows from the co_employees table whose id is not equal to 1, we write
SELECT * FROM co_employees WHERE id != 1;

#2. Use BETWEEN
# If we want to select rows with values between two numbers, we can use the BETWEEN keyword. For instance, to select rows with id between 1 (inclusive) and 3 (inclusive), we write:
SELECT * FROM co_employees WHERE id BETWEEN 1 AND 3;

#3. Use LIKE
#(i). If we want to select rows whose column values “look like” a specified pattern, we use the LIKE keyword.
# If we want to select employees whose names end with ‘er’, we can do it as follows:
SELECT * FROM co_employees WHERE em_name LIKE '%er';
# The % symbol is used to indicate that there can be an unknown number of characters in front of 'er'.

#(ii). If we want to select employees whose names have 'er' anywhere within (not necessarily at the back), we can use the following statement:
SELECT * FROM co_employees WHERE em_name LIKE '%er%';
# We add the % symbol in front of and behind ‘er’ to indicate that there can be any number of characters before and after it.

#(iii).  In contrast to the % symbol that represents an unknown number of characters, the _ symbol is used to represent exactly ONE character.
# Suppose we want to select the rows of all co_employees that have ‘e’ as the fifth letter in their names, we write:
SELECT * FROM co_employees WHERE em_name LIKE '____e%';
# Here, we use FOUR _ symbols to indicate that there are four characters before ‘e’. This will give us the records of Joyce Jones, Prudence Phelps and Walker Welch.

#4. Use IN 
# This keyword is used to select rows with column values inside a certain list.
# Suppose we want to select rows that have id 6, 7, or 9, we can write
SELECT * FROM co_employees WHERE id IN (6, 7, 9);

#5. Use NOT IN 
# On the other hand, if we want to select rows that do not have id 7 or 8, we use the NOT IN keywords:
SELECT * FROM co_employees WHERE id NOT IN (7, 8);

#6. Use AND, OR
# The AND keyword gives us rows that satisfy ALL the conditions listed while the OR keyword selects rows that satisfy at least one of the conditions.
# For instance, if we want to select all female employees who have worked more than 5 years in the company or have salaries above 5000, we can write:
SELECT * FROM co_employees WHERE (years_in_company > 5 OR salary > 5000) AND gender = 'F';

## F: Sorting Rows
# Now that we know how to select data from our tables and filter the results, let’s cover one last concept before we end this chapter. Let’s look at how we can sort the results returned by the SELECT statement.
# To do that, we use the ORDER BY clause. We can choose to sort the results based on one or more columns.
# Suppose we want to sort the rows of the employees table using gender, followed by the employee’s name (em_name), we write
SELECT * FROM co_employees ORDER BY gender, em_name;

# If we want to sort by descending order, we use the DESC keyword as shown below:
SELECT * FROM co_employees ORDER BY gender DESC, em_name;


### CHAPTER 5: SELECTING DATA PART 2 ###
## A. CONCAT()
# The first is the CONCAT() function. This function allows us to combine two or more strings into a single string. This is known as concatenating the strings.
# To use the CONCAT() function, we need to provide it with some input. Specifically, we need to tell the function what strings to concatenate.
# For instance, if we want to concatenate 'Hello' and ' World', we write
SELECT CONCAT('Hello', ' World');

## B. SUBSTRING()
# The SUBSTRING() function requires us to pass in a string, the starting position to extract the substring, and the desired length of the substring (in that order).
# For instance,
SELECT SUBSTRING('Programming', 2);

# On the other hand,
SELECT SUBSTRING('Programming', 2, 6);

## C. NOW()
# This function gives us the current date and time whenever that function is being used. 
# It is commonly used to record the date and time that a particular record is inserted into a table.

## D. CURDATE()
# This gives us the current date. For instance,
SELECT CURDATE();

## E. CURTIME()
# Finally, we have the CURTIME() function. This gives us the current time.
SELECT CURTIME()

### F: Aggregate Functions ###
## 1. COUNT()
# The COUNT() function returns the number of the rows in the table.
# If we pass in * to the function, it returns the total number of rows in the table.
# If we pass in a column name instead, it returns the number of non NULL values in that column (NULL values are ignored).
# If we want to remove duplicates, we add the DISTINCT keyword before the column name.

#Example 1:
SELECT COUNT(*) FROM co_employees;

#Example 2:
SELECT COUNT(contact_number) FROM co_employees;
# The last row (Walker Welch) is excluded from the count as the value is NULL.

#Example 3a:
SELECT COUNT(gender) FROM co_employees;

# Example 3b:
SELECT COUNT(DISTINCT gender) FROM co_employees;

## 2. AVG()
# The AVG() function returns the average of a set of values.
# Example:
SELECT AVG(salary) FROM co_employees;

# In our case, if we want to round off the result of the AVG() function to 2 decimal places, we write
SELECT ROUND(AVG(salary), 2) FROM co_employees;

## 3. MAX()
# The MAX() function returns the maximum of a set of values.
#Example:
SELECT MAX(salary) FROM co_employees;

## 4. MIN()
# The MIN() function returns the minimum of a set of values.
#Example:
SELECT MIN(salary) FROM co_employees;

## 5. SUM()
# The SUM() function returns the sum of a set of values.
# Example:
SELECT SUM(salary) FROM co_employees;

## G: GROUP BY 
SELECT gender, MAX(salary) FROM co_employees GROUP BY gender;

## H:  HAVING
# Suppose we want to display rows from the previous table only when the maximum salary is above 10000, we do that using the statement below:
SELECT gender, MAX(salary) FROM co_employees GROUP BY gender HAVING MAX(salary) > 10000;


### CHAPTER 6: SELECTING DATA PART 3 ###
## A: JOINS
# There are three main types of joins in mySQL: inner join, left join and right join.
#(i) Now, let’s look at an example using our employees and mentorships tables.

SELECT co_employees.id, mentorships.mentor_id, co_employees.em_name AS 'Mentor', mentorships.project AS 'Project Name' FROM mentorships JOIN co_employees ON co_employees.id = mentorships.mentor_id;

#(ii) In the example above, if you do not want the id and mentor_id columns to show, you can use the code below:
SELECT co_employees.em_name AS 'Mentor', mentorships.project AS 'Project Name' FROM mentorships JOIN co_employees ON co_employees.id = mentorships.mentor_id;

## B: UNIONS
# The UNION keyword is used to combine the results of two or more SELECT statements. Each SELECT statement must have the same number of columns.
# The column names from the first SELECT statement will be used as the column names for the results returned.

#(i) For example, tor the co_employees table, we can do a UNION as follows:
SELECT em_name, salary FROM co_employees WHERE gender = 'M' UNION
SELECT em_name, years_in_company FROM co_employees WHERE gender =
'F';
# The first 5 rows are from the first SELECT statement while the last 4 are from the second statement.

# For instance, if we do a UNION ALL as follows
SELECT mentor_id FROM mentorships UNION ALL
SELECT id FROM co_employees WHERE gender = 'F';
# we’ll get 1, 1, 2, 3, 3, 6, 8, 10 as the result. The ids 1 and 3 are repeated because they are returned by both SELECT statements.

SELECT mentor_id FROM mentorships UNION
SELECT id FROM co_employees WHERE gender = 'F';
# In contrast, if we simply do a UNION, we’ll get 1, 2, 3, 6, 8, 10 as the result. The duplicates are removed.


### CHAPTER 7: VIEWS ###
# An SQL view is a virtual table.
# In contrast to actual tables, views do not contain data. Instead, they contain SELECT statements. The data to display is retrieved using those SELECT statements.

## A. Creating a View
CREATE VIEW myView AS SELECT co_employees.id, mentorships.mentor_id, co_employees.em_name AS 'Mentor', mentorships.project AS 'Project Name' FROM mentorships JOIN co_employees ON co_employees.id = mentorships.mentor_id;

# We can select data from it like how we select data from a table. For instance, we can write the code below to view all:
SELECT * FROM myView;

# If we only want the mentor_id and Project Name columns, we can write
SELECT mentor_id, `Project Name` FROM myView;

## B. Altering a View
# After creating a view, if we want to make any changes to it, we use the ALTER VIEW keywords.
# For instance, we can use the following statement to alter myView:
ALTER VIEW myView AS
SELECT co_employees.id, mentorships.mentor_id, co_employees.em_name AS 'Mentor', mentorships.project AS 'Project' FROM mentorships JOIN co_employees ON co_employees.id = mentorships.mentor_id;

## C. Deleting a View
# To delete myView, we write:
DROP VIEW IF EXISTS myView;


### CHAPTER 8: TRIGGERS ###
# A trigger is a series of actions that is activated when a defined event occurs for a specific table. This event can either be an INSERT, UPDATE or DELETE. Triggers can be invoked before or after the event.
# Suppose one of the employees has just resigned from the company and we want to delete this employee from the employees table. However, before we do that, we would like to transfer the data into another table called ex_employees as a form of back up. We can do this using a trigger.
# Let’s first create an ex_employees table using the code below:
CREATE TABLE ex_employees (em_id INT PRIMARY KEY, em_name VARCHAR(255) NOT NULL, gender CHAR(1) NOT NULL, date_left TIMESTAMP DEFAULT NOW());

## A. Trigger
# A delimiter is a character or sequence of characters that specifies the end of a SQL statement.
DELIMITER $$
CREATE TRIGGER update_ex_employees BEFORE DELETE ON co_employees FOR EACH ROW BEGIN INSERT INTO ex_employees (em_id, em_name, gender) VALUES (OLD.id, OLD.em_name, OLD.gender); END $$ DELIMITER ;

# We use BEFORE DELETE ON employees to indicate that we want this trigger to be activated before we delete the record from the employees table. If we want the trigger to be activated after we delete the record, we’ll write AFTER DELETE ON employees.

DELETE FROM co_employees WHERE id = 10;
SELECT * FROM co_employees;
SELECT * FROM ex_employees;

## B. Deleting a Trigger
DROP TRIGGER IF EXISTS update_ex_employees;


### CHAPTER 9: VARIABLES AND STORED ROUTINES ###
## A. VARIABLES
# A variable is a name given to data that we need to store and use in our SQL statements.

# For instance, suppose we want to get all information related to employee 1 from the employees and mentorships tables. We can do that as follows:
SELECT * FROM co_employees WHERE id = 1;
SELECT * FROM mentorships WHERE mentor_id = 1;
SELECT * FROM mentorships WHERE mentee_id = 1;

# To do that, we can first declare and initialize a variable using the statement below:
SET @em_id = 1;

# Once the variable is declared and initialized, we can modify our SELECT statements to make use of this variable:
SELECT * FROM mentorships WHERE mentor_id = @em_id;
SELECT * FROM mentorships WHERE mentee_id = @em_id;
SELECT * FROM co_employees WHERE id = @em_id;

# For instance, to get the information for employee 2, we can assign a new value to @em_id using the statement below:
SET @em_id = 2;

# Besides assigning numerical values to variables, we can also assign text to them. To do that, we need to use quotation marks:
SET @em_name = 'Jamie';

# Next, we can assign the result of a mathematical operation to a variable. For instance, we can do the following:
SET @price = 12;
SET @price = @price + 3;

# Here, we assign the result of the SQRT() function to @result.
# SQRT() is a pre-written function in MySQL that gives us the square root of a number. In the statement above, SQRT(9) gives 3 as the answer. This value is then assigned to @result.

# In order to display the value of any variable, we use the SELECT keyword.
SET @result = SQRT(9);
SELECT @result;

# Alternatively, we can combine the two statements into a single statement:
SELECT @result := SQRT(9);


## B. Stored Routines
# A stored routine is a set of SQL statements that are grouped, named and stored together in the server.
# There are two types of stored routines - stored procedures and stored functions.

#(1): Stored Procedures
# The main difference is, instead of using CREATE TRIGGER, we use CREATE PROCEDURE to create the stored procedure.

# Suppose we want to create a stored procedure to select all information from our two tables (co_employees and mentorships). Here’s how we do it:

DELIMITER $$
CREATE PROCEDURE select_info() BEGIN SELECT * FROM co_employees; SELECT * FROM mentorships; END $$ DELIMITER ;

# Next, let’s run this stored procedure. To do that, we use the CALL keyword:
CALL select_info();

# Suppose instead of selecting everything from the two tables, we only want to select the records of a particular employee. We can create a stored procedure as follows:
DELIMITER $$
DELIMITER $$
CREATE PROCEDURE employee_info(IN p_em_id INT)
BEGIN
SELECT * FROM mentorships WHERE mentor_id = p_em_id;
SELECT * FROM mentorships WHERE mentee_id = p_em_id;
SELECT * FROM co_employees WHERE id = p_em_id;
END $$
DELIMITER ;

# There are three types of parameters for stored procedures: IN, OUT and INOUT.
#1.An IN parameter is used to pass information to the stored procedure.
#2.An OUT parameter is used to get information from the stored procedure while
#3.An INOUT parameter serves as both an IN and OUT parameter.

# Suppose we want to get the information for employee 1, we write:
CALL employee_info(1);

# Here, we pass in the value 1 to the stored procedure. This tells MySQL that the value of p_em_id should be replaced by 1 in all the SQL statements within the stored procedure.
# For instance, the statement
SELECT * FROM co_employees WHERE id = p_em_id;
# becomes
SELECT * FROM co_employees WHERE id = 1;

# Next, let’s look at an example for OUT parameters. Suppose we want to get the name and gender of a particular employee. In addition, we want to store these information into variables so that we can use them in our subsequent SQL statements. Here’s how we can do it:
DELIMITER $$
CREATE PROCEDURE employee_name_gender(IN p_em_id INT, OUT p_name
VARCHAR(255), OUT p_gender CHAR(1))
BEGIN
SELECT em_name, gender INTO p_name, p_gender FROM co_employees
WHERE id = p_em_id;
END $$
DELIMITER ;
# Here, we declare an IN parameter called p_em_id and two OUT parameters called p_name and p_gender.

# Inside the stored procedure, we use the INTO keyword to store the results returned by the SQL statement into the OUT parameters.
# To call the stored procedure, we write
CALL employee_name_gender(1, @v_name, @v_gender);

#Inside the parentheses, we pass the value 1 to the IN parameter and the variables @v_name and @v_gender to the OUT parameters.

# You may notice that we did not declare @v_name and @v_gender before passing them to our stored procedure. This is allowed in MySQL. When we pass in variables that have not been declared previously, MySQL will declare the variables for us. Hence, there is no need for us to declare @v_name and @v_gender before using them.
# After we call the stored procedure, MySQL will store the result of the SELECT statement (em_name and gender in this example) into the @v_name and @v_gender variables. We can then use these variables in subsequent SQL statements. For instance, if we run the previous CALL statement followed by the SELECT statement below:

SELECT * FROM co_employees WHERE gender = @v_gender;


# Last but not least, let’s look at an example of an INOUT parameter. Suppose we want to get the mentor_id of a record based on its mentee_id and project values, here's how we can do it:
DELIMITER $$
CREATE PROCEDURE get_mentor(INOUT p_em_id INT, IN p_project
VARCHAR(255))
BEGIN
SELECT mentor_id INTO p_em_id FROM mentorships WHERE
mentee_id = p_em_id AND project = p_project;
END $$
DELIMITER ;
# Here, p_em_id serves as both an IN and OUT parameter. Hence, we declare it as an INOUT parameter.

# In order to call get_mentor(), we can first declare a variable called @v_id. Suppose we set it to 3 using the statement below:
SET @v_id = 3;

# We can then pass this variable (@v_id) and the project name (e.g. 'Wayne Fibre') to the stored procedure as shown below:
CALL get_mentor(@v_id, 'Wayne Fibre');

# When we do that, the stored procedure executes the SELECT statement within and updates the value of @v_id to 1 (which is the mentor_id returned by the SELECT statement). If we want to view the value of @v_id after the procedure is called, we use the following SELECT statement:
SELECT @v_id;


#(ii): Stored Functions
# One of the key differences is that a stored function must return a value using the RETURN keyword.
# Stored functions are executed using a SELECT statement while stored procedures are executed using the CALL keyword.

# With reference to our employees table, suppose we want to calculate the amount of bonus to pay our employees. We can write a stored function to perform the calculation. The code below shows how it can be done:
DELIMITER $$
CREATE FUNCTION calculateBonus(p_salary DOUBLE, p_multiple
DOUBLE) RETURNS DOUBLE DETERMINISTIC
BEGIN
DECLARE bonus DOUBLE(8, 2);
SET bonus = p_salary*p_multiple;
RETURN bonus;
END $$
DELIMITER ;

# To call this function, we use it within a SELECT statement. For instance, we can do the following:
SELECT id, em_name, salary, calculateBonus(salary, 1.5) AS bonus FROM co_employees;

## C: Deleting Stored Routines
# For instance, to delete the calculateBonus function, we write
DROP FUNCTION IF EXISTS calculateBonus;


### CHAPTER 10: CONTROL FLOW TOOLS
## A: IF statement
# Example 1
DELIMITER $$
CREATE FUNCTION if_demo_A(x INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
IF x > 0 THEN RETURN 'x is positive';
ELSEIF x = 0 THEN RETURN 'x is zero';
ELSE RETURN 'x is negative';
END IF;
END $$
DELIMITER ;

# This IF statement first checks if the input (x) is greater than zero. If it is, it returns 'x is positive'. If it is not, it checks if x equals zero. If it is, it returns 'x is zero'. If both the first two conditions are not met, it moves on to the ELSE statement and returns 'x is negative'.

# To run this function, we write:
SELECT if_demo_A(2);

# Example 2
DELIMITER $$
CREATE FUNCTION if_demo_B(x INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
IF x > 0 THEN RETURN 'x is positive';
ELSEIF x = 0 THEN RETURN 'x is zero';
END IF;
END $$
DELIMITER ;

# This example is similar to the previous one except that we omitted the ELSE statement. If we run the function now, we’ll get the following outputs:
SELECT if_demo_B(2);

## B: CASE statement
# The CASE statement is very similar to the IF statement and can often be used interchangeably. In most cases, choosing between IF and CASE is a matter of personal preference.

# Example 1
DELIMITER $$
CREATE FUNCTION case_demo_A(x INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
CASE x
WHEN 1 THEN RETURN 'x is 1';
WHEN 2 THEN RETURN 'x is 2';
ELSE RETURN 'x is neither 1 nor 2';
END CASE;
END $$
DELIMITER ;

# Calling the function:
SELECT case_demo_A(1);

SELECT case_demo_A(5);

# Example 2
DELIMITER $$
CREATE FUNCTION case_demo_B(x INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
CASE
WHEN x > 0 THEN RETURN 'x is positive';
WHEN x = 0 THEN RETURN 'x is zero';
ELSE RETURN 'x is negative';
END CASE;
END $$
DELIMITER ;
# This second example uses the second syntax and tests x for a range instead of a single value.

#. Calling the function:
SELECT case_demo_B(1);

SELECT case_demo_B(-1);

## C: WHILE statement
# The next control flow statement is the WHILE statement. This statement allows us to specify a task to be done repeatedly while a certain condition is valid.

# Example
DELIMITER $$
CREATE FUNCTION while_demo(x INT, y INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
DECLARE z VARCHAR(255);
SET z = '';
while_example: WHILE x<y DO
SET x = x + 1;
SET z = concat(z, x);
END WHILE;
RETURN z;
END $$
DELIMITER ;

# Here, we first declare a local variable z and initialize it to an empty string (an empty string is a string with no content).
# Next, we declare a WHILE statement. A WHILE statement can be labelled (but labelling it is optional). Here we label it while_example.
# Next, the WHILE condition checks if x is smaller than y. (Both x and y are input parameters to the function.)
# While x is smaller than y, the WHILE statement does the following: First, it increases x by 1.
# Next, it uses the concat() function to concatenate z with the new value of x.
# Finally, it assigns the result back to z.

# After the WHILE statement, we simply return the value of z.
# If you run the function using the following statement:
SELECT while_demo(1, 5);

## D: REPEAT statement
#A REPEAT statement is also used to perform repetitive tasks. It repeatedly performs some tasks until the UNTIL condition is met.

# Example
DELIMITER $$
CREATE FUNCTION repeat_demo(x INT, y INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
DECLARE z VARCHAR(255);
SET z = '';
REPEAT
SET x = x + 1;
SET z = concat(z, x);
UNTIL x>=y
END REPEAT;
RETURN z;
END $$
DELIMITER ;

# This REPEAT statement repeats two tasks (SET x = x + 1 and SET z = concat(z, x)) until the x >= y condition is met.
# If you run the function with the following statement
SELECT repeat_demo(1, 5);

# Hence, if you run the following statement
SELECT repeat_demo(5, 1);
# you’ll get 6 as the result because even though the REPEAT condition (UNTIL x>=y) is already met, the two tasks inside the REPEAT statement are executed at least once since the check is done after the tasks are completed.

## E: LOOP statement
# The LOOP statement is very similar to the WHILE and REPEAT statements, except that it does not come with a condition to exit the loop.
# Instead, we use the ITERATE or LEAVE keywords to exit it.

# Example 1
DELIMITER $$
CREATE FUNCTION loop_demo_A(x INT, y INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
DECLARE z VARCHAR(255);
SET z = '';
simple_loop: LOOP
SET x = x + 1;
IF x > y THEN
LEAVE simple_loop;
END IF;
SET z = concat(z, x);
END LOOP;
RETURN z;
END $$
DELIMITER ;

# Within the loop above, we do the following:
#(i) First, we increase the value of x by 1.
#(ii) Next, we check if x is greater than y. If it is, we leave the loop.
# To leave the loop, we write
#LEAVE simple_loop;

# LEAVE is a keyword in MySQL to indicate that we want to exit the loop. We must provide the name of the loop to exit. In our example, we are exiting simple_loop.
# If the LEAVE condition is not met, we remain in the loop and concatenate z with x.

# If you run the function now with the following statement:
SELECT loop_demo_A(1, 5);

# Example 2
# Besides using the LEAVE keyword, we can also use the ITERATE keyword. In contrast to the LEAVE keyword that exits the loop completely, the ITERATE keyword only skips one iteration of the loop.

# Let’s look at an example:
DELIMITER $$
CREATE FUNCTION loop_demo_B(x INT, y INT) RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
DECLARE z VARCHAR(255);
SET z = '';
simple_loop: LOOP
SET x = x + 1;
IF x = 3 THEN ITERATE simple_loop;
ELSEIF x > y THEN LEAVE simple_loop;
END IF;
SET z = concat(z, x);
END LOOP;
RETURN z;
END $$
DELIMITER ;

# Here, we added one more IF condition to our LOOP statement. This IF condition uses the ITERATE keyword.
# If you run the function using the following statement,
SELECT loop_demo_B(1, 5);


### CHAPTER 11: CURSORS ###
# A cursor is a mechanism that allows us to step through the rows returned by a SQL statement.

# Example

# Suppose we want to get the names and genders of all employees in our employees table and combine them into a single line of text, here’s how we do it:
DELIMITER $$
CREATE FUNCTION get_employees () RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
DECLARE v_employees VARCHAR(255) DEFAULT '';
DECLARE v_name VARCHAR(255);
DECLARE v_gender CHAR(1);
DECLARE v_done INT DEFAULT 0;
DECLARE cur CURSOR FOR
SELECT em_name, gender FROM employees;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;
OPEN cur;
employees_loop: LOOP
FETCH cur INTO v_name, v_gender;
IF v_done = 1 THEN LEAVE employees_loop;
ELSE SET v_employees = concat(v_employees, ', ',
v_name, ': ', v_gender);
END IF;
END LOOP;
CLOSE cur;
RETURN substring(v_employees, 3);
END $$
DELIMITER ;

# First, we declare a function called get_employees.
# Within the function, we declare four local variables: v_employees, v_name, v_gender and v_done and set the default values of v_employees and v_done to '' and 0 respectively (using the DEFAULT keyword).
# Next, we declare a cursor called cur for the following SELECT statement:
SELECT em_name, gender FROM co_employees;

# We also declare a handler called v_done for this cursor.
# After that, we open the cursor and declare a loop called employees_loop to work with the cursor.
# Within the loop, we fetch the row that cur is currently pointing at and store the results into the v_name and v_gender variables. We need to store the results into two variables as we selected two columns from the employees table.
# Next, we check if v_done equals 1.
# v_done equals 1 when the cursor reaches the end of the table (i.e. when there is no more data for the cursor to fetch).
# If v_done equals 1, we exit the loop. Else, we use the concat() function to concatenate v_employees with v_name and v_gender, separated by a colon and comma.
# The initial value of v_employees is an empty string (denoted by ''). When we first concatenate v_employees with ', ', v_name, ': ' and v_gender, we’ll get: , James Lee: M, as James Lee and M is the name and gender of the first employee.
# After we do this concatenation, we assign the concatenated result back to the v_employees variable.
# The LOOP statement then repeats the same process for all the other rows in the table.
# After looping, we close the cursor and return the value of v_employees.
# However, before we do that, we use the substring() function to remove the first comma from the string.

# If you call this function using the statement
SELECT get_employees();
