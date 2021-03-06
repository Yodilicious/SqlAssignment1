/* 
    PROG3200_Assignment01
        Created By: Jodi Visser (7236805)
        Date: October 9, 2017
*/

BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW project_size_view';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE EmployeeProject PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Project PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Manager PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Employee PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Department PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Room PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Building PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;

/*
Question 2 [10 Marks]:Create a list of commands to create the set of tables you described in Question 1
*/
CREATE TABLE Building (
    BuildingId          NUMBER(*)       NOT NULL, 
    Name                VARCHAR2(128)   NOT NULL,
    CONSTRAINT pk_building PRIMARY KEY (BuildingId)
);
DESCRIBE Building;

CREATE TABLE Room (
    RoomId              NUMBER(*)       NOT NULL, 
    RoomNumber          VARCHAR2(16)    NOT NULL,
    BuildingId          NUMBER(*)       NOT NULL,

    CONSTRAINT pk_room PRIMARY KEY (RoomId),

    CONSTRAINT fk_building_id
        FOREIGN KEY (BuildingId)
        REFERENCES Building(BuildingId)
);
DESCRIBE Room;

CREATE TABLE Department (
    DepartmentNumber    VARCHAR2(16)   NOT NULL, 
    Name                VARCHAR2(64)   NOT NULL, 
    CONSTRAINT pk_department_number PRIMARY KEY (DepartmentNumber)
);
DESCRIBE Department;

CREATE TABLE Employee (
    EmployeeNumber      NUMBER(*)       NOT NULL, 
    Name                VARCHAR2(128)   NOT NULL,
    DepartmentNumber    VARCHAR2(16)    NOT NULL,

    CONSTRAINT pk_employee_number PRIMARY KEY (EmployeeNumber),

    CONSTRAINT fk_department_number
        FOREIGN KEY (DepartmentNumber)
        REFERENCES Department(DepartmentNumber)
);
DESCRIBE Employee;

CREATE TABLE Manager (
    ManagerNumber       NUMBER(*)       NOT NULL,
    Name                VARCHAR2(64)    NOT NULL,
    
    CONSTRAINT pk_manager_number PRIMARY KEY (ManagerNumber)
);
DESCRIBE Manager;

CREATE TABLE Project (
    ProjectNumber       NUMBER(*)       NOT NULL, 
    Name                VARCHAR2(128)   NOT NULL,
    Budget              NUMBER(*, 2)    NOT NULL,
    ManagerId           NUMBER(*)       NOT NULL,
    RoomId              NUMBER(*)       NOT NULL,

    CONSTRAINT pk_project PRIMARY KEY (ProjectNumber),

    CONSTRAINT fk_manager_id
        FOREIGN KEY (ManagerId)
        REFERENCES Manager(ManagerNumber),

    CONSTRAINT fk_room_id
        FOREIGN KEY (RoomId)
        REFERENCES Room(RoomId)
);
DESCRIBE Project;

CREATE TABLE EmployeeProject (
    EmployeeNumber      NUMBER(*)       NOT NULL,
    ProjectNumber       NUMBER(*)       NOT NULL,
    HourlyRate          NUMBER(*, 2)    NOT NULL,

    CONSTRAINT pk_employee_projects PRIMARY KEY (EmployeeNumber, ProjectNumber),

    CONSTRAINT fk_employee_number
        FOREIGN KEY (EmployeeNumber)
        REFERENCES Employee(EmployeeNumber),

    CONSTRAINT fk_project_number
        FOREIGN KEY (ProjectNumber)
        REFERENCES Project(ProjectNumber)
);
DESCRIBE EmployeeProject;

/*
Question 3 [10 Marks]:Insert or load the data as included in the table given into the tables created in Question 2
*/
INSERT INTO Building(BuildingId, Name) VALUES (1, 'Avengers Tower');
INSERT INTO Building(BuildingId, Name) VALUES (2, 'Baxter Building');

SELECT * FROM Building;

INSERT INTO Department(DepartmentNumber, Name) VALUES ('M001', 'IT');
INSERT INTO Department(DepartmentNumber, Name) VALUES ('M002', 'ENG');
INSERT INTO Department(DepartmentNumber, Name) VALUES ('M003', 'Finance');

SELECT * FROM Department;

INSERT INTO Employee(EmployeeNumber, Name, DepartmentNumber) VALUES (1, 'Alice', 'M001');
INSERT INTO Employee(EmployeeNumber, Name, DepartmentNumber) VALUES (2, 'Bob', 'M002');
INSERT INTO Employee(EmployeeNumber, Name, DepartmentNumber) VALUES (3, 'Carl', 'M002');
INSERT INTO Employee(EmployeeNumber, Name, DepartmentNumber) VALUES (4, 'Donna', 'M003');
INSERT INTO Employee(EmployeeNumber, Name, DepartmentNumber) VALUES (5, 'Earl', 'M001');
INSERT INTO Employee(EmployeeNumber, Name, DepartmentNumber) VALUES (6, 'Felicia', 'M003');

SELECT * FROM Employee;

INSERT INTO Manager(ManagerNumber, Name) VALUES (1, 'T. Stark');
INSERT INTO Manager(ManagerNumber, Name) VALUES (2, 'R. Richards');
INSERT INTO Manager(ManagerNumber, Name) VALUES (3, 'V. Von Doom');

SELECT * FROM Manager;

INSERT INTO Room(RoomId, RoomNumber, BuildingId) VALUES (1, 'A123', 1);
INSERT INTO Room(RoomId, RoomNumber, BuildingId) VALUES (2, 'B222', 2);
INSERT INTO Room(RoomId, RoomNumber, BuildingId) VALUES (3, 'B100', 2);
INSERT INTO Room(RoomId, RoomNumber, BuildingId) VALUES (4, 'A200', 1);

SELECT * FROM Room;

INSERT INTO Project(ProjectNumber, Name, Budget, ManagerId, RoomId) VALUES (1, 'Repulsor Tech Development', 5000000, 1, 1);
INSERT INTO Project(ProjectNumber, Name, Budget, ManagerId, RoomId) VALUES (2, 'Unstable Molecule Research', 500000, 1, 1);
INSERT INTO Project(ProjectNumber, Name, Budget, ManagerId, RoomId) VALUES (3, 'Doombot Development', 1000000, 1, 1);
INSERT INTO Project(ProjectNumber, Name, Budget, ManagerId, RoomId) VALUES (4, 'Hulkbuster Repair', 2000000, 1, 1);

SELECT * FROM Project;

INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (1, 1, 20.0);
INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (1, 2, 25.0);
INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (1, 3, 30.0);

INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (2, 3, 20.0);
INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (2, 4, 15.0);

INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (3, 5, 25.0);
INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (3, 2, 21.0);
INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (3, 4, 20.0);

INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (4, 6, 25.0);
INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (4, 1, 21.0);
INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (4, 2, 22.0);
INSERT INTO EmployeeProject(ProjectNumber, EmployeeNumber, HourlyRate) VALUES (4, 3, 25.0);

SELECT * FROM EmployeeProject;

/*
Question 4 [10 Marks]: Create a Project Size View, which lists the project name, manager name, 
project budget and number of employees on the project. Include the view creation statement 
and the output from a SELECT * from this view
*/
CREATE VIEW project_size_view AS
SELECT p.Name project_name, m.Name manager_name, p.Budget, COUNT(ep.EmployeeNumber) employee_count
FROM Project p
JOIN Manager m ON p.ManagerId = m.ManagerNumber
JOIN EmployeeProject ep ON p.ProjectNumber = ep.ProjectNumber
GROUP BY p.Name, m.Name, p.Budget
ORDER BY COUNT(ep.EmployeeNumber) DESC;

SELECT * FROM project_size_view;

/*
Question 5 [10 Marks]: Create an SQL query to list the names of all employeecurrently working on the 
Hulkbuster Repair project. Rewrite your query in one other way.
*/
SELECT e.Name EmployeeName 
FROM PROJECT p
JOIN EmployeeProject ep ON p.ProjectNumber = ep.ProjectNumber
JOIN Employee e ON ep.EmployeeNumber = e.EmployeeNumber
WHERE p.NAME = 'Hulkbuster Repair'
ORDER BY e.Name ASC;

/* output to first query:
Alice
Bob
Carl
Felicia
*/

SELECT e.Name EmployeeName 
FROM EmployeeProject ep
JOIN Employee e ON ep.EmployeeNumber = e.EmployeeNumber
WHERE ep.ProjectNumber IN (SELECT p.ProjectNumber FROM Project p WHERE p.NAME = 'Hulkbuster Repair')
ORDER BY e.Name ASC;

/* output to second query:
Alice
Bob
Carl
Felicia
*/

