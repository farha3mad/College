--create tables 
CREATE DATABASE bank_system;

CREATE TABLE branch
  (
     branch_id      INT PRIMARY KEY CHECK(branch_id > 0),
     branch_name    VARCHAR (50),
     branch_city    VARCHAR (50),
     branch_manager VARCHAR(50)
  );

CREATE TABLE dept
  (
     dept_id      INT PRIMARY KEY,
     brach_id     INT FOREIGN KEY REFERENCES branch(branch_id),
     dept_name    VARCHAR (50),
     dept_manager VARCHAR(50)
  );

CREATE TABLE employee
  (
     emp_id        INT PRIMARY KEY CHECK(emp_id  > 0) ,
     brach_id      INT FOREIGN KEY REFERENCES branch(branch_id),
     emp_f_name    VARCHAR(50),
     emp_l_name    VARCHAR (50),
     emp_gender    VARCHAR(10),
     date_of_birth DATE,
     emp_add       VARCHAR(100),
     emp_phoneno   VARCHAR(100),
     emp_salary    FLOAT,
     dept_id       INT FOREIGN KEY REFERENCES dept (dept_id)
  );

CREATE TABLE client
  (
     c_id            INT PRIMARY KEY CHECK(c_id  > 0) ,
     brach_id        INT FOREIGN KEY REFERENCES branch(branch_id),
     c_f_name        VARCHAR(50),
     c_l_name        VARCHAR(50),
     c_gender        VARCHAR(10),
     c_date_of_birth DATE,
     c_job           VARCHAR(50),
     c_add           VARCHAR(50),
     c_phoneno       VARCHAR(100),
     balance         FLOAT
  );

-- insert values 

INSERT INTO branch
VALUES      (1,
             'first',
             'Cairo',
             'Ahmed Ali');

INSERT INTO branch
VALUES      (2,
             'second',
             'Mansoura',
             'Aliaa Ramy');

INSERT INTO branch
VALUES      (3,
             'thrid',
             'Luxor',
             'Mohamed Fared');

INSERT INTO branch
VALUES      (4,
             'fourth',
             'Alex',
             'Basem Mahmoud');

INSERT INTO branch
VALUES      (5,
             'fifth',
             'Hurgada',
             'Tarek Lotfy');

INSERT INTO dept
VALUES      (11,
             1,
             'HR',
             'Ali Ahmed');

INSERT INTO dept
VALUES      (12,
             2,
             'Finance',
             'Basma Mohamed');

INSERT INTO dept
VALUES      (13,
             3,
             'PR',
             'Laila Tarek');

INSERT INTO dept
VALUES      (14,
             4,
             'Customer Service',
             'Pola Hani');

INSERT INTO dept
VALUES      (15,
             5,
             'Marketing',
             'Mamdouh Kassim');

INSERT INTO employee
VALUES     (101,
            1,
            'Dalia',
            'Khaled',
            'female',
            '2000-1-1',
            'Talkha',
            '010999988889',
            3000,
            11);

INSERT INTO employee
VALUES     (102,
            2,
            'Yassmin',
            'Reda',
            'female',
            '1990-1-1',
            'Mahala',
            '010999988779',
            6000,
            12);

INSERT INTO employee
VALUES     (103,
            3,
            'Salma',
            'Khaled',
            'female',
            '1995-10-1',
            'Glaa street',
            '010991188779',
            5000,
            13);

INSERT INTO employee
VALUES     (104,
            4,
            'Ahmed',
            'Moussa',
            'male',
            '1980-7-13',
            'Teraa street',
            '010992288779',
            10000,
            14);

INSERT INTO employee
VALUES     (105,
            5,
            'Ramy',
            'Ehab',
            'male',
            '1999-12-12',
            'Mahala',
            '010999988889',
            6000,
            15);

INSERT INTO employee
VALUES     (106,
            5,
            'Toka',
            'Mahmoud',
            'female',
            '2000-2-1',
            'Nakhla street',
            '010787888889',
            5000,
            11);

INSERT INTO employee
VALUES     (107,
            4,
            'nada',
            'Reda',
            'female',
            '1980-1-1',
            'Mahala',
            '012311188779',
            8800,
            12);

INSERT INTO employee
VALUES     (108,
            3,
            'sara',
            'ramy',
            'female',
            '1992-11-11',
            'samya El gamal street',
            '010771188779',
            9000,
            13);

INSERT INTO employee
VALUES     (109,
            4,
            'Waleed',
            'Moursy',
            'male',
            '1970-9-13',
            'Teraa street',
            '010991188779',
            20000,
            14);

INSERT INTO employee
VALUES     (110,
            2,
            'tamer',
            'Ashour',
            'male',
            '1989-2-12',
            'Mahala',
            '010999933889',
            15000,
            15);

INSERT INTO client
VALUES     (77,
            1,
            'hamada',
            'mostafa',
            'male',
            '1965-10-12',
            'dentist',
            'tanta',
            '011268753678',
            70000.0);

INSERT INTO client
VALUES     (78,
            3,
            'sara',
            'ahmed',
            'female',
            '2000-2-6',
            'nurse',
            'cairo',
            '011287654478',
            1000.0);

INSERT INTO client
VALUES     (79,
            2,
            'lara',
            'seif',
            'female',
            '1995-12-7',
            'singer',
            'alex',
            '01127445678',
            5000.0);

INSERT INTO client
VALUES     (80,
            4,
            'ali',
            'mahmoud',
            'male',
            '1985-12-3',
            'teacher',
            'kafr elshikh',
            '011268656578',
            30000.0);

INSERT INTO client
VALUES     (110,
            1,
            'shrouk',
            'hegazi',
            'female',
            '1989-2-12',
            'doctor',
            'Mahala',
            '010999933889',
            150000);

INSERT INTO client
VALUES     (112,
            1,
            'farha',
            'emad',
            'female',
            '1989-2-12',
            'doctor',
            'Mahala',
            '010999933889',
            130000);

INSERT INTO client
VALUES     (111,
            1,
            'wael',
            'mohamed',
            'male',
            '1989-2-12',
            'doctor',
            'Mahala',
            '010999933889',
            200000);

-- Functions and Procedures




CREATE PROCEDURE Raise_salary_by_id @emp_id              INT,
                                   @percent_of_increase FLOAT
AS
  BEGIN
      UPDATE employee
      SET    emp_salary = emp_salary * ( 1 + @percent_of_increase )
      WHERE  emp_id = @emp_id;
  END

--SELECT * FROM employee;
--EXECUTE Raise_salary_by_id @emp_id = 101 , @percent_of_increase = 0.2
--SELECT * FROM employee;

 
CREATE PROCEDURE Raise_salary_by_Dept @dept_id              INT,
                                   @percent_of_increase FLOAT
AS
  BEGIN
      UPDATE employee
      SET    emp_salary = emp_salary * ( 1 + @percent_of_increase )
      WHERE  dept_id = @dept_id;
  END


--SELECT * FROM employee;
--EXECUTE Raise_salary_by_Dept @dept_id = 11 , @percent_of_increase = 0.2
--SELECT * FROM employee;


CREATE FUNCTION Get_emp_info(@emp_f_name VARCHAR(50) ,
                              @emp_l_name VARCHAR(50) )
RETURNS TABLE AS
RETURN (SELECT * FROM employee WHERE emp_f_name = @emp_f_name
               AND emp_l_name = @emp_l_name)

--SELECT * FROM dbo.Get_emp_info('Salma','Khaled');

CREATE FUNCTION Get_emp_info_by_id(@emp_id     INT) 
RETURNS TABLE AS
RETURN (SELECT * FROM employee WHERE emp_id = @emp_id )

--SELECT * FROM dbo.Get_emp_info_by_id(101);

CREATE FUNCTION Get_client_info(@client_f_name VARCHAR(50) ,
                              @client_l_name VARCHAR(50) )
RETURNS TABLE AS
RETURN (SELECT * FROM client WHERE c_f_name  = @client_f_name 
               AND c_l_name  = @client_l_name )

--SELECT * FROM client;
--SELECT * FROM Get_client_info('hamada','mostafa');

CREATE FUNCTION Get_client_info_by_id(@client_id     INT)
RETURNS TABLE AS
RETURN (SELECT * FROM client WHERE c_id = @client_id )

--SELECT * FROM Get_client_info_by_id(77);

CREATE FUNCTION Get_client_info_by_job(@client_job    VARCHAR(50))
RETURNS TABLE AS
RETURN (SELECT * FROM client WHERE c_job = @client_job )

--SELECT * FROM Get_client_info_by_job('doctor');



CREATE PROCEDURE Add_employee @emp_id            INT,
                              @branch_id         INT,
                              @emp_f_name        VARCHAR(50),
                              @emp_l_name        VARCHAR(50),
                              @emp_gender        VARCHAR(10),
                              @emp_date_of_birth DATE,
                              @emp_add           VARCHAR(50),
                              @emp_phoneNo       VARCHAR(50),
                              @emp_salary        FLOAT,
                              @Dep_id            INT
AS
  BEGIN
      INSERT INTO employee
      VALUES     (@emp_id,
                  @branch_id,
                  @emp_f_name,
                  @emp_l_name,
                  @emp_gender,
                  @emp_date_of_birth,
                  @emp_add,
                  @emp_phoneNo,
                  @emp_salary,
                  @Dep_id)
  END

/*EXECUTE Add_employee @emp_id =9, @branch_id =1, @emp_f_name = 'qqqqqqqqqqqqqqqq',
@emp_l_name ='eeee', @emp_gender ='male', @emp_date_of_birth ='2000-2-2',@emp_add ='Road',
@emp_phoneNo ='010', @emp_salary =20000, @Dep_id =12*/
--SELECT * FROM employee;

CREATE PROCEDURE Add_client @c_id            INT,
                            @branch_id       INT,
                            @c_f_name        VARCHAR(50),
                            @c_l_name        VARCHAR(50),
                            @c_gender        VARCHAR(10),
                            @c_date_of_birth DATE,
                            @c_job           VARCHAR(50),
                            @c_add           VARCHAR(50),
                            @c_phoneNo       VARCHAR(50),
                            @balance         FLOAT
AS
  BEGIN
      INSERT INTO client
      VALUES     (@c_id,
                  @branch_id,
                  @c_f_name,
                  @c_l_name,
                  @c_gender,
                  @c_date_of_birth,
                  @c_job,
                  @c_add,
                  @c_phoneNo,
                  @balance )
  END

CREATE PROCEDURE Remove_employee @emp_id INT
AS
  BEGIN
      DELETE FROM employee
      WHERE  emp_id = @emp_id;
  END

--EXECUTE Remove_employee @emp_id = 9
CREATE PROCEDURE Remove_client @c_id INT
AS
  BEGIN
      DELETE FROM client
      WHERE  c_id = @c_id;
  END

--EXECUTE Remove_client @c_id = 110
CREATE PROCEDURE Withdraw_money @c_id            INT,
                                @AMOUNT_OF_MONEY FLOAT
AS
  BEGIN
      IF( (SELECT balance
           FROM   client
           WHERE  c_id = @c_id) >= @AMOUNT_OF_MONEY )
        BEGIN
            PRINT 'Sucessful withdraw';

            UPDATE client
            SET    balance = balance - @AMOUNT_OF_MONEY
            WHERE  c_id = @c_id;
        END
      ELSE
        PRINT 'withdraw FAIL!!';
  END

--EXECUTE withdraw_money @c_id =77 , @AMOUNT_OF_MONEY =1000
CREATE PROCEDURE Save_money @c_id            INT,
                            @AMOUNT_OF_MONEY FLOAT
AS
  BEGIN
      UPDATE client
      SET    balance = balance + @AMOUNT_OF_MONEY
      WHERE  c_id = @c_id;
  END

--EXECUTE save_money @c_id =77 , @AMOUNT_OF_MONEY =1000
CREATE VIEW retrive_client
AS
  SELECT c_id,
         Concat(c_f_name, c_l_name)              AS [FullName],
         Year(Getdate()) - Year(c_date_of_birth) AS client_age,
         balance
  FROM   client
  WHERE  balance >= 100000;

SELECT *
FROM   retrive_client
ORDER  BY balance DESC;

DROP VIEW retrive_client;

CREATE VIEW top_salaries
AS
  SELECT Avg(employee.emp_salary) AS avrage,
         dept.dept_name
  FROM   employee
         INNER JOIN dept
                 ON employee.dept_id = dept.dept_id
  GROUP  BY dept.dept_name;

SELECT TOP(3) *
FROM   top_salaries
ORDER BY avrage DESC;

DROP VIEW top_salaries;

CREATE VIEW display_branches
AS
  SELECT branch.branch_name,
         Sum(client.balance) AS total_sum
  FROM   branch
         INNER JOIN client
                 ON branch.branch_id = client.brach_id
  GROUP  BY branch.branch_name;

SELECT *
FROM   display_branches
ORDER  BY total_sum DESC;

DROP VIEW display_branches; 