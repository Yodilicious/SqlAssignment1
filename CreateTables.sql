CREATE TABLE Project (
    ProjectNumber       NUMBER(*),      NOT NULL, 
    Name                VARCHAR2(128)   NOT NULL,
    Budget              NUMBER(*, 2)    NOT NULL,
    ManagerId           NUMBER(*)       NOT NULL,
    RoomId              NUMBER(*)       NOT NULL,

    CONSTRAINT pk_project PRIMARY KEY (ProjectNumber),

    CONSTRAINT fk_manager_id
        FOREIGN KEY (ManagerId)
        REFERENCES Employee(EmployeeNumber),

    CONSTRAINT fk_room_id
        FOREIGN KEY (RoomId)
        REFERENCES Room(RoomId)
);

CREATE TABLE Department (
    DepartmentNumber    VARCHAR2(16)   NOT NULL, 
    Name                VARCHAR2(64)   NOT NULL, 
    CONSTRAINT pk_department_number PRIMARY KEY (DepartmentNumber)
);

CREATE TABLE Employee (
    EmployeeNumber      NUMBER(*)       NOT NULL, 
    Name                VARCHAR2(128)   NOT NULL,
    DepartmentNumber    VARCHAR2(16)    NOT NULL,

    CONSTRAINT pk_employee_number PRIMARY KEY (EmployeeNumber),

    CONSTRAINT fk_department_number
        FOREIGN KEY (DepartmentNumber)
        REFERENCES Department(DepartmentNumber)
);

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

CREATE TABLE Building (
    BuildingId          NUMBER(*)       NOT NULL, 
    Name                VARCHAR2(128)   NOT NULL,
    CONSTRAINT pk_building PRIMARY KEY (BuildingId)
);

CREATE TABLE Room (
    RoomId              NUMBER(*)       NOT NULL, 
    RoomNumber          VARCHAR2(16)    NOT NULL,
    BuildingId          NUMBER(*)       NOT NULL,

    CONSTRAINT pk_room PRIMARY KEY (RoomId),

    CONSTRAINT fk_building_id
        FOREIGN KEY (BuildingId)
        REFERENCES Building(BuildingId)
);

INSERT INTO Building(BuildingId, Name) VALUES (1, 'Avengers Tower');
INSERT INTO Building(BuildingId, Name) VALUES (2, 'Baxter Building');

INSERT INTO Department(DepartmentNumber, Name) VALUES ('M001', 'IT');
INSERT INTO Department(DepartmentNumber, Name) VALUES ('M002', 'ENG');
INSERT INTO Department(DepartmentNumber, Name) VALUES ('M003', 'Finance');

INSERT INTO Employee(EmployeeNumber, Name, DepartmentNumber) VALUES (001, 'Alice', 'M001');
INSERT INTO Employee(EmployeeNumber, Name, DepartmentNumber) VALUES (002, 'Bob', 'M002');
INSERT INTO Employee(EmployeeNumber, Name, DepartmentNumber) VALUES (003, 'Carl', 'M002');
INSERT INTO Employee(EmployeeNumber, Name, DepartmentNumber) VALUES (004, 'Donna', 'M003');
INSERT INTO Employee(EmployeeNumber, Name, DepartmentNumber) VALUES (005, 'Earl', 'M001');

INSERT INTO Room(RoomId, RoomNumber, BuildingId) VALUES (1, 'A123', 1);
INSERT INTO Room(RoomId, RoomNumber, BuildingId) VALUES (2, 'B222', 2);
INSERT INTO Room(RoomId, RoomNumber, BuildingId) VALUES (3, 'B100', 2);
INSERT INTO Room(RoomId, RoomNumber, BuildingId) VALUES (4, 'A200', 1);

