DROP TABLE StayIn;
DROP TABLE Examine;
DROP TABLE Admission;
DROP TABLE Doctor;
DROP TABLE Patient;
DROP TABLE RoomAccess;
DROP TABLE RoomService;
DROP TABLE Equipment;
DROP TABLE EquipmentType;
DROP TABLE Employee;
DROP TABLE Room;
CREATE TABLE Room (
        Num int NOT NULL PRIMARY KEY,
        OccupiedFlag char(1) NOT NULL,
        CONSTRAINT OccupiedFlagVal CHECK (OccupiedFlag in ('F', 'T')));
CREATE TABLE Employee (
        ID char(20) NOT NULL PRIMARY KEY,
        FName char(15) NOT NULL,
        LName char(30) NOT NULL,
        Salary int CHECK(Salary > 0),
        JobTitle char(40) NOT NULL,
        OfficeNum int,
        EmpRank char(30) NOT NULL,
        SupervisorID char(20));
ALTER TABLE Employee ADD FOREIGN KEY (SupervisorID) REFERENCES Employee(ID);
ALTER TABLE Employee ADD CONSTRAINT chk_empRank CHECK(empRank IN('Regular employees','Division managers','General managers'));
ALTER TABLE Employee ADD FOREIGN KEY (OfficeNum) REFERENCES Room(Num);
CREATE TABLE EquipmentType (
        ID char(20) NOT NULL PRIMARY KEY,
        Description VARCHAR2(100) NOT NULL,
        Model VARCHAR(20) NOT NULL,
        Instructions VARCHAR(200) NOT NULL,
        NumberOfUnits int NOT NULL CHECK(NumberOfUnits  > -1));
CREATE TABLE Equipment (
        Serial# char(20) NOT NULL PRIMARY KEY,
        TypeID char(20) NOT NULL,
        PurchaseYear int,
        LastInspection DATE NOT NULL,
        RoomNum int NOT NULL);
ALTER TABLE Equipment ADD FOREIGN KEY (RoomNum) REFERENCES Room(Num);
ALTER TABLE Equipment ADD FOREIGN KEY (TypeID) REFERENCES EquipmentType(ID);
CREATE TABLE RoomService (
        RoomNum int NOT NULL,
        Service CHAR(20) NOT NULL,
        Constraint service_pk PRIMARY KEY(RoomNum, Service));
ALTER TABLE RoomService ADD FOREIGN KEY (RoomNum) REFERENCES Room(Num);
CREATE TABLE RoomAccess (
        RoomNum int NOT NULL,
        employeeID char(20) NOT NULL,
        Constraint RoomAccess_pk PRIMARY KEY(RoomNum, employeeID));
ALTER TABLE RoomAccess ADD FOREIGN KEY (RoomNum) REFERENCES Room(Num);
ALTER TABLE RoomAccess ADD FOREIGN KEY (employeeID) REFERENCES Employee(ID);
CREATE TABLE Patient(
        SSN int NOT NULL PRIMARY KEY,
        FName char(20) NOT NULL,
        LName char(20) NOT NULL,
        Address char(30),
        TelNum char(20),
        CONSTRAINT SSNVal CHECK (SSN < 1000000000));
CREATE TABLE Doctor(
        ID char(20) NOT NULL PRIMARY KEY,
        FName char(15) NOT NULL,
        LName char(30) NOT NULL,
        Gender char(1)  NOT NULL CHECK (Gender in ('M', 'F', 'O')),
        Speciality char(15));
CREATE TABLE Admission(
        Num char(20) NOT NULL PRIMARY KEY,
        StartDate DATE NOT NULL,
        LeaveDate DATE,
        TotalPayment int NOT NULL,
        InsurancePayment BINARY_FLOAT NOT NULL,
        PatientSSN int NOT NULL,
        FollowUp DATE,
        CONSTRAINT InsurPayVal CHECK (InsurancePayment <= 1 AND InsurancePayment >= 0));
ALTER TABLE Admission ADD FOREIGN KEY (PatientSSN) REFERENCES Patient(SSN);
CREATE TABLE Examine(
        DoctorID char(20) NOT NULL,
        Notes VARCHAR2(100),
        AdmissionNum char(20) NOT NULL,
        Constraint Examine_pk PRIMARY KEY(DoctorID, AdmissionNum));
ALTER TABLE Examine ADD FOREIGN KEY (DoctorID) REFERENCES Doctor(ID);
ALTER TABLE Examine ADD FOREIGN KEY (AdmissionNum) REFERENCES Admission(Num);
CREATE TABLE StayIn(
        AdmissionNum char(20) NOT NULL,
        RoomNum int NOT NULL,
        StartDate DATE NOT NULL,
        LeaveDate DATE,
        Constraint StayIn_pk PRIMARY KEY(AdmissionNum, RoomNum, StartDate ));
ALTER TABLE StayIn ADD FOREIGN KEY (AdmissionNum) REFERENCES Admission(Num);
ALTER TABLE StayIn ADD FOREIGN KEY (RoomNum) REFERENCES Room(Num);


INSERT INTO Room (Num, OccupiedFlag)
VALUES (100,'F');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (150,'T');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (102,'T');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (113,'F');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (114,'F');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (212,'F');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (213,'F');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (214,'F');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (101,'T');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (269,'T');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (151,'T');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (254,'T');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (1,'T');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (2,'T');
INSERT INTO Room (Num, OccupiedFlag)
VALUES (3413,'T');
INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('54846969694415158488','Felicia','Hill',150000,'Cleaning Head',254,'General managers',null);


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('32184546132184845658','Andrew','Dobnowski',200000,'Customer service head',269,'General managers',null);


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('66666684511848755151','Aneta','Leave',80000,'Head Secratary',102,'Division managers','32184546132184845658');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('28478748955164845155','Beatris','Cook',70000,'Food Prep Head',151,'Division managers','32184546132184845658');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('98985564488455151685','Larry','Smel',55000,'Head Janator',1,'Division managers','54846969694415158488');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('58481213548484984521','William','Goat',60000,'Head Maid',2,'Division managers','54846969694415158488');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('10','Rodica','Neamtu',1000000,'Boss',3413,'Division managers','32184546132184845658');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('56323212584352265545','Bozo','Jankens',90000,'Clown',null,'Regular employees','10');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('32142827465399543128','Randy','Smith',40000,'Janator',1,'Regular employees','98985564488455151685');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('95471281322597651975','Rose','Russo',40000,'Janator',1,'Regular employees','98985564488455151685');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('19191916458754947912','Nate','Oliery',40000,'Janator',1,'Regular employees','98985564488455151685');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('78784549846516154858','Debra','Kean',40000,'Cashier',null,'Regular employees','28478748955164845155');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('32355818484583215482','Alfredo','Linguini',65000,'Chef',150,'Regular employees','28478748955164845155');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('69887485188516518485','Becky','Harkness',null,'Bus Boy',null,'Regular employees','28478748955164845155');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('48224848484815584845','Tracy','Biss',55000,'Receptionist',101,'Regular employees','66666684511848755151');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('54976846546845216532','Jake','Scott',55000,'Receptionist',101,'Regular employees','66666684511848755151');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('16948165131981651685','Sam','Maldonodo',45000,'Maid',2,'Regular employees','58481213548484984521');


INSERT INTO Employee (ID, FName, LName, Salary, JobTitle, OfficeNum, EmpRank, SupervisorID)
VALUES ('68485321346848452548','Chris','Schwimmer',45000,'Maid',2,'Regular employees','58481213548484984521');


INSERT INTO EquipmentType (ID, Description, Model, Instructions, NumberOfUnits)
VALUES ('11351848513154548784','CT Scanner','a','boom',0);


INSERT INTO EquipmentType (ID, Description, Model, Instructions, NumberOfUnits)
VALUES ('84845354832135165656','Ultrasound','z','zoom',0);


INSERT INTO EquipmentType (ID, Description, Model, Instructions, NumberOfUnits)
VALUES ('15846135878543215657','MRI Machine','T-37','NO METAL NEAR IT!!!!!!!!!!YES, WE ARE LOOKING AT YOU RANDY',3);


INSERT INTO EquipmentType (ID, Description, Model, Instructions, NumberOfUnits)
VALUES ('65132135454878765454','CAT Machine','S-2','Pet gently and make sure to feed, watch out for the claws',3);


INSERT INTO EquipmentType (ID, Description, Model, Instructions, NumberOfUnits)
VALUES ('12135498595988989695','X-Ray Machine','X-5','Turn on and run',3);


INSERT INTO EquipmentType (ID, Description, Model, Instructions, NumberOfUnits)
VALUES ('31274874231354454874','Mop','AS-96','Put mop in bucket then scrub floor',10);


INSERT INTO Equipment (Serial#, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('MLPA165874','15846135878543215657',2010,'25NOV19',213);


INSERT INTO Equipment (Serial#, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('MLPA182049','15846135878543215657',2011,'13DEC19',1);


INSERT INTO Equipment (Serial#, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('MLPA172358','15846135878543215657',2012,'15FEB20',150);


INSERT INTO Equipment (Serial#, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('CLTX138463','65132135454878765454',2013,'1OCT19',212);


INSERT INTO Equipment (Serial#, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('CLTX064485','65132135454878765454',2006,'25NOV19',1);


INSERT INTO Equipment (Serial#, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('CLTX092854','65132135454878765454',2009,'15JAN20',1);


INSERT INTO Equipment (Serial#, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('A01-01X','31274874231354454874',1978,'23SEP98',1);


INSERT INTO Equipment (Serial#, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('A01-02X','31274874231354454874',1996,'19OCT08',1);


INSERT INTO Equipment (Serial#, TypeID, PurchaseYear, LastInspection, RoomNum)
VALUES ('A01-03X','31274874231354454874',2003,'12JUL03',1);


INSERT INTO RoomService (roomNum, Service)
VALUES (100,'Emergency');


INSERT INTO RoomService (roomNum, Service)
VALUES (214,'X-Ray');


INSERT INTO RoomService (roomNum, Service)
VALUES (114,'Examine');


INSERT INTO RoomService (roomNum, Service)
VALUES (212,'CAT');


INSERT INTO RoomService (roomNum, Service)
VALUES (213,'MRI');


INSERT INTO RoomService (roomNum, Service)
VALUES (113,'Examine');


INSERT INTO RoomService (roomNum, Service)
VALUES (114,'Cast Removal');


INSERT INTO RoomService (roomNum, Service)
VALUES (114,'ICU');


INSERT INTO RoomService (roomNum, Service)
VALUES (113,'ICU');


INSERT INTO RoomService (roomNum, Service)
VALUES (1,'Cleaning Supplies');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (1,'32142827465399543128');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (1,'95471281322597651975');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (1,'19191916458754947912');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (3413,'10');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (150,'32355818484583215482');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (269,'32184546132184845658');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (101,'48224848484815584845');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (101,'54976846546845216532');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (2,'16948165131981651685');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (2,'68485321346848452548');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (151,'28478748955164845155');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (1,'98985564488455151685');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (2,'58481213548484984521');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (102,'66666684511848755151');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (254,'54846969694415158488');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (150,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (113,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (114,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (212,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (213,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (214,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (101,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (269,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (151,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (254,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (1,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (2,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (3413,'56323212584352265545');


INSERT INTO RoomAccess (RoomNum, employeeID)
VALUES (102,'56323212584352265545');


INSERT INTO Patient (SSN, FName, LName, Address, TelNum)
VALUES (1,'John','Doe',null,null);


INSERT INTO Patient (SSN, FName, LName, Address, TelNum)
VALUES (2,'Jane','Doe',null,null);


INSERT INTO Patient (SSN, FName, LName, Address, TelNum)
VALUES (654685152,'Marry','Poppin','34 West Wood Dr', '3657806458');


INSERT INTO Patient (SSN, FName, LName, Address, TelNum)
VALUES (111223333,'Hans','Jager','6 Stein St', '3657729521');


INSERT INTO Patient (SSN, FName, LName, Address, TelNum)
VALUES (666854326,'Gertrude','Holt','1 Creapy Avn','6666666666');


INSERT INTO Patient (SSN, FName, LName, Address, TelNum)
VALUES (879878745,'Gilgamesh','Beowolf','Maple St', '3657808888');


INSERT INTO Patient (SSN, FName, LName, Address, TelNum)
VALUES (326498521,'Erich', 'Hannon', '54 Oliver St', '3657728546');


INSERT INTO Patient (SSN, FName, LName, Address, TelNum)
VALUES (154784856,'Eric', 'Hannon', '54 Oliver St', '3657728537');


INSERT INTO Patient (SSN, FName, LName, Address, TelNum)
VALUES (154845165,'Erik', 'Hannon', '54 Oliver St', '3657728558');


INSERT INTO Patient (SSN, FName, LName, Address, TelNum)
VALUES (654878751,'Erick', 'Hannon', '54 Oliver St', '3657728542');


INSERT INTO Patient (SSN, FName, LName, Address, TelNum)
VALUES (232154548,'Fred','Jones','1805 Swarthmore Ave', '1877527745437');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES ('98653934297365094534','M','None','Damm','Mark');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES('89386767859434594305','F','Radiology','Schmit','Sara');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES ('98347569456740956823','M','Cardiology','DiPetrio','Jack');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES ('65435165484135789221','M','Pediatric','Yang','Chris');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES ('21168432147545862758','F','Exorcisms','Baker','Emily');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES ('98758462113254878456','M','None','Holden','Theador');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES ('98524875319954666228','F','Oncology','Weiswalder','Stephanie');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES ('24552125754154845158','F','Anesthesiology','OSullivan','Shannon');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES ('21256463654964878542','F','Anesthesiology','Frick','Mia');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES ('28524542143949224641','M','Neurology','Sanders','Harland');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES ('35265469986566595646','M','Geriatric','DiPetrio','Jackson');


INSERT INTO Doctor (ID, Gender, Speciality, LName, FName)
VALUES ('15215478535455488445','F','Cardiology','Hegenlocher','Jane');


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44855056','23JAN20','23JAN20',150,0.5,326498521,null);


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44855057','23JAN20','23JAN20',150,0.5,154784856,null);


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44855058','23JAN20','23JAN20',150,0.5,154845165,null);


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44855059','23JAN20','23JAN20',150,0.5,654878751,null);


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44855060','23JAN20','23JAN20',3666,0.666,666854326,'24JAN20');


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44855061','23JAN20','30JAN20',12000,0.75,879878745,'15FEB20');


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44855062','23JAN20','25JAN20',4000,1,111223333,'1FEB20');


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44855334','24JAN20','24JAN20',3666,0.666,666854326,'25JAN20');


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44855592','25JAN20','25JAN20',3666,0.666,666854326,null);


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44856453','1FEB20','1FEB20',50,1,111223333,'22FEB20');


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44856462','1FEB20','1FEB20',200,0.75,879878745,null);


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44856739','2FEB20','2FEB20',175,0,232154548,'4FEB20');


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44856752','2FEB20','3FEB20',700,0.45,654685152,'5FEB20');


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44857234','4FEB20','4FEB20',50,0,232154548,null);


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44857253','4FEB20',null,8045,0,1,null);


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44857254','4FEB20',null,6730,0,2,null);


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44857427','5FEB20','5FEB20',150,0.45,654685152,null);


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44859234','22FEB20','22FEB20',50,1,111223333,'23FEB20');


INSERT INTO Admission (Num, StartDate, LeaveDate, TotalPayment, InsurancePayment, PatientSSN, FollowUp)
VALUES ('44859267','23FEB20','23FEB20',50,1,111223333,'26FEB20');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('21168432147545862758','Hey eyes turned black and her head turned all the way around, I recommend strong bible prayers','44855060');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('21168432147545862758','We found a few cats in her stomach, more praying and holy water','44855334');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('21168432147545862758','I can no longer see her, do not let her take me to the dark place','44855592');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('15215478535455488445','hi','44855062');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('15215478535455488445','ja','44859234');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('15215478535455488445','bitte','44859267');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('35265469986566595646','oldest','44859234');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('98653934297365094534','IDK','44855062');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('35265469986566595646','old','44855062');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('35265469986566595646','older','44856453');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('15215478535455488445','hi','44856453');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('28524542143949224641','rip','44856453');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('89386767859434594305','f','44856453');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44855061', 113, '23JAN20', '24JAN20');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44855061', 114, '25JAN20', '26JAN20');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44855061', 113, '28JAN20', '29JAN20');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44855060', 114, '23JAN20', '23JAN20');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44855334', 114, '24JAN20', '24JAN20');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44855592', 113, '25JAN20', '25JAN20');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44856752', 113, '2FEB20', '3FEB20');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44855062', 113, '24JAN20', '24JAN20');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44855062', 113, '23JAN20', '23JAN20');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44855062', 114, '25JAN20', '25JAN20');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44856453', 113, '1FEB20', '1FEB20');


INSERT INTO StayIn (AdmissionNum, RoomNum, StartDate, LeaveDate)
VALUES ('44859234', 113, '22FEB20', '22FEB20');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('24552125754154845158','fell asleep','44855056');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('24552125754154845158','fell asleep','44855057');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('24552125754154845158','fell asleep','44855058');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('24552125754154845158','fell asleep','44855059');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('24552125754154845158','fell asleep','44855060');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('24552125754154845158','fell asleep','44855061');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('24552125754154845158','fell asleep','44855062');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('24552125754154845158','fell asleep','44855334');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('24552125754154845158','fell asleep','44855592');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('24552125754154845158','fell asleep','44856453');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('24552125754154845158','fell asleep','44857427');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('21256463654964878542','fell asleep','44857427');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('21256463654964878542','fell asleep','44855056');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('21256463654964878542','fell asleep','44855057');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('21256463654964878542','fell asleep','44855058');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('21256463654964878542','fell asleep','44855059');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('21256463654964878542','fell asleep','44855060');


INSERT INTO Examine (DoctorID, Notes, AdmissionNum)
VALUES ('21256463654964878542','fell asleep','44855061');


CREATE VIEW CriticalCases AS
        SELECT SSN AS Patient_SSN, FName AS firstName, LName AS lastName, CNT AS numberOfAdmissionsToICU
        FROM Patient P, (SELECT PatientSSN, CNT
                                FROM (SELECT PatientSSN, count(AdmissionNum) AS CNT
                                        FROM StayIn S, Admission A
                                        WHERE S.AdmissionNum = A.Num
AND S.RoomNum in (SELECT RoomNum
                                                                FROM RoomService
                                                                WHERE Service = 'ICU')
GROUP BY PatientSSN)
WHERE CNT >= 2) S
        WHERE P.SSN = S.patientSSN;


CREATE VIEW DoctorsLoad AS
        SELECT DoctorID, Gender AS gender, load
        FROM Doctor D, ((SELECT ID AS DoctorID, 'Underloaded' AS load
                                FROM Doctor
                                WHERE ID NOT IN (SELECT DoctorID
FROM Examine))
                                union
((SELECT DoctorID, 'Overloaded' AS load
                                FROM Examine
                                GROUP BY DoctorID
                                HAVING count(AdmissionNum) > 10)
Union
(SELECT DoctorID, 'Underloaded' AS load
                                FROM Examine 
                                GROUP BY DoctorID
                                HAVING count(AdmissionNum) <= 10))) L
        WHERE D.ID = L.DoctorID;


SELECT Patient_SSN, firstName, lastName
FROM CriticalCases
WHERE numberOfAdmissionsToICU > 4;


SELECT DoctorID, FName AS firstName, LName AS lastName
        FROM DoctorsLoad L, Doctor D
        WHERE L.gender = 'F'
        AND L.load = 'Overloaded'
        AND L.DoctorID = D.ID;


SELECT DoctorID, PatientSSN, Notes
FROM DoctorsLoad L, (SELECT DoctorID AS ID, PatientSSN, Notes
FROM Examine E, (SELECT Num, PatientSSN
FROM Admission A, CriticalCases C
WHERE A.PatientSSN = C.Patient_SSN) A
                        WHERE E.AdmissionNum = A.Num) D
WHERE L.load = 'Underloaded'
AND L.DoctorID = D.ID;


CREATE or REPLACE TRIGGER ICUNotesNotNull
BEFORE INSERT OR UPDATE on Examine
FOR EACH ROW
DECLARE
        inICU int;
BEGIN
        SELECT count(AdmissionNum) into inICU
FROM StayIn s, (SELECT RoomNum
                                FROM RoomService
                                WHERE Service = 'ICU') r
        WHERE r.RoomNum = s.RoomNum
        AND s.AdmissionNum = :new.AdmissionNum;
        
IF inICU > 0 and :new.Notes IS NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Cannot do stuff');
        END IF;


END;
/


CREATE or REPLACE TRIGGER InsuranceCalculation
BEFORE INSERT OR UPDATE on Admission
FOR EACH ROW
BEGIN
        :new.InsurancePayment := 0.65;
END;
/


CREATE or REPLACE TRIGGER RegularHasDivision 
BEFORE INSERT OR UPDATE ON Employee
FOR EACH ROW
DECLARE
        superRank char(30);
BEGIN
        IF :new.SupervisorID IS NULL and :new.EmpRank != 'General managers' THEN
                RAISE_APPLICATION_ERROR(-20004, 'Super null');
        END IF;
        IF :new.EmpRank = 'Regular employees' THEN
                SELECT EmpRank into superRank
                FROM Employee
                WHERE :new.SupervisorID = ID;
        END IF;
IF 'Division managers' != superRank THEN
                RAISE_APPLICATION_ERROR(-20004, 'Cannot do stuff');
        END IF;
END;
/


CREATE or REPLACE TRIGGER DivisionHasGeneral
BEFORE INSERT OR UPDATE ON Employee
FOR EACH ROW
DECLARE
        superRank char(30);
BEGIN
        IF :new.SupervisorID IS NULL and :new.EmpRank != 'General managers' THEN
                RAISE_APPLICATION_ERROR(-20004, 'Super null');
        END IF;
        IF :new.EmpRank = 'Division managers' THEN
                SELECT EmpRank into superRank
                FROM Employee
                WHERE :new.SupervisorID = ID;
        END IF;
IF 'General managers' != superRank THEN
                RAISE_APPLICATION_ERROR(-20004, 'Cannot do stuff');
        END IF;
END;
/


CREATE or REPLACE TRIGGER GeneralHasNoSuper
BEFORE INSERT OR UPDATE ON Employee
FOR EACH ROW
DECLARE
        superRank char(30);
BEGIN
        IF :new.EmpRank = 'General managers' and :new.SupervisorID IS NOT NULL THEN
                RAISE_APPLICATION_ERROR(-20004, 'Should not have supervisor');
        END IF;
        
END;
/


CREATE or REPLACE TRIGGER Emergency
BEFORE INSERT on StayIn
FOR EACH ROW
DECLARE
        roomServ char(20);
BEGIN
        SELECT Service into roomServ
        FROM RoomService
        WHERE :new.RoomNum = RoomNum;
        
        IF roomServ = 'Emergency' THEN
                Update Admission Set FollowUp = ADD_MONTHS(:new.StartDate, 2) WHERE :new.AdmissionNum = Num;
        END IF;
END;
/


CREATE or REPLACE TRIGGER CTUltraNotNullAfter2006
BEFORE INSERT OR UPDATE on Equipment
FOR EACH ROW
DECLARE
        equipmentName VARCHAR2(100);
BEGIN
        SELECT Description into equipmentName
        FROM EquipmentType
        WHERE :new.TypeID = ID;


        IF equipmentName = 'CT Scanner' or equipmentName = 'Ultrasound' THEN
                IF :new.PurchaseYear IS NULL or :new.PurchaseYear <= 2006 THEN
                        RAISE_APPLICATION_ERROR(-20004, 'Year can not be null or before 2007.');
                END IF;
        END IF;
END;
/


CREATE or REPLACE TRIGGER PrintInformationOfVisit
AFTER UPDATE on Admission
FOR EACH ROW
DECLARE
        fName char(20);
        lName char(20);
        Addr char(30);
        CURSOR Doctors IS SELECT FName, LName, Notes FROM Examine E, Doctor D WHERE E.DoctorID = D.ID AND :new.Num = AdmissionNum;
BEGIN
        IF :new.LeaveDate IS NOT NULL THEN
                SELECT FName, LName, Address into fName, lName, Addr
                FROM Patient
                WHERE :new.PatientSSN = SSN;
dbms_output.put_line(fName || lName || Addr);


For rec In Doctors LOOP
dbms_output.put_line(rec.FName || rec.LName || rec.Notes);
END LOOP;
        END IF;
END;
/