SET search_path to public

------- DROP statements to clean up objects from previous run

-- FK Constraints	
ALTER TABLE room DROP CONSTRAINT fk_room_patientid;
ALTER TABLE appointment DROP CONSTRAINT fk_appointment_patientid;
ALTER TABLE appointment DROP CONSTRAINT fk_appointment_doctorid;
ALTER TABLE treatment DROP CONSTRAINT fk_treatment_appointmentid;

-- Trigger
DROP TRIGGER check_appointment_date ON appointment;

-- Function
DROP FUNCTION check_appointment_date_func();

-- Sequences
DROP SEQUENCE room_id_seq;
DROP SEQUENCE room_num_seq;
DROP SEQUENCE patient_id_seq;
DROP SEQUENCE doc_id_seq;
DROP SEQUENCE treatment_id_seq;
DROP SEQUENCE appointment_id_seq;

-- Tables
DROP TABLE patient;
DROP TABLE room;
DROP TABLE appointment;
DROP TABLE treatment;
DROP TABLE doctor;

-- Views
DROP VIEW patient_appointments;

---------------------------------------------------------------------------------------------------------------------------------------------------


------- Create the patient table

CREATE TABLE patient (
    PatientID INT PRIMARY KEY,               -- Unique identifier for each patient
    FirstName VARCHAR(50) NOT NULL,          -- Patient's first name
    LastName VARCHAR(50) NOT NULL,           -- Patient's last name
    BirthDate DATE NOT NULL,                 -- Patient's birth date
    Gender CHAR(1) CHECK (Gender IN ('M', 'F', 'O')), -- Patient's gender (M = Male, F = Female, O = Other)
    ContactNumber VARCHAR(15)                -- Patient's contact number
);

------- Create the room table with foreign key constraint

CREATE TABLE room (
    RoomID INT PRIMARY KEY,                  -- Unique identifier for each room
    RoomNumber INT NOT NULL,                 -- Unique Room number (e.g., '101', '202A')
    RoomType VARCHAR(50) NOT NULL,           -- Type of room (e.g., 'Private', 'Semi-Private', 'Shared')
    AvailabilityStatus BOOLEAN NOT NULL,     -- Availability status (TRUE = available, FALSE = not available)
    Capacity INT NOT NULL,                   -- Capacity of the room (e.g., number of beds)
    PatientID INT,                           -- ID of the patient assigned to the room
	CONSTRAINT fk_room_patientid             -- Foreign key constraint
        FOREIGN KEY (PatientID)
        REFERENCES patient (PatientID) ON DELETE CASCADE
);

------- Create the doctor table

CREATE TABLE doctor (
    DoctorID INT PRIMARY KEY,                -- Unique identifier for each doctor
    FirstName VARCHAR(50) NOT NULL,          -- Doctor's first name
    LastName VARCHAR(50) NOT NULL,           -- Doctor's last name
    Specialty VARCHAR(100),                  -- Doctor's specialty (e.g., 'Cardiology', 'Orthopedics')
    ContactNumber VARCHAR(15)                -- Doctor's contact number
);

------- Create the appointment table with foreign key constraints

CREATE TABLE appointment (
    AppointmentID INT PRIMARY KEY,           -- Unique identifier for each appointment
    PatientID INT NOT NULL,                  -- ID of the patient for the appointment
    DoctorID INT NOT NULL,                   -- ID of the doctor for the appointment
    AppointmentDate DATE NOT NULL,           -- Date and time of the appointment
    ReasonForVisit VARCHAR(200),             -- Reason for the visit (e.g., symptoms, check-up)
    Duration INT NOT NULL,                   -- Duration of the appointment (e.g., '1 hour', '30 minutes')
    Status VARCHAR(50) NOT NULL,             -- Status of the appointment (e.g., 'Scheduled', 'Completed', 'Cancelled')
	CONSTRAINT fk_appointment_patientid      -- Foreign key constraint
        FOREIGN KEY (PatientID)
        REFERENCES patient (PatientID) ON DELETE CASCADE,
	CONSTRAINT fk_appointment_doctorid       -- Foreign key constraint
        FOREIGN KEY (DoctorID)
        REFERENCES doctor (DoctorID) ON DELETE CASCADE
);

------- Create the treatment table with a foreign key constraint

CREATE TABLE treatment (
    TreatmentID INT PRIMARY KEY,             -- Unique identifier for each treatment
    TreatmentName VARCHAR(100) NOT NULL,     -- Name of the treatment
    Description VARCHAR(200),                -- Detailed description of the treatment
    Cost NUMERIC(6, 2) NOT NULL,             -- Cost of the treatment (e.g., 100.00)
    Meds VARCHAR(100),                       -- Medications or drugs used in the treatment
    AppointmentID INT,                       -- ID of the associated appointment
	CONSTRAINT fk_treatment_appointmentid    -- Foreign key constraint
        FOREIGN KEY (AppointmentID)
        REFERENCES appointment (AppointmentID) ON DELETE CASCADE
);


---------------------------------------------------------------------------------------------------------------------------------------------------


-- Create the trigger function for AppointmentDate " can not be in the past "
CREATE OR REPLACE FUNCTION check_appointment_date_func()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.AppointmentDate < CURRENT_DATE THEN
        RAISE EXCEPTION 'AppointmentDate cannot be in the past';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger for AppointmentDate
CREATE TRIGGER check_appointment_date
BEFORE INSERT OR UPDATE ON appointment
FOR EACH ROW
EXECUTE FUNCTION check_appointment_date_func();


---------------------------------------------------------------------------------------------------------------------------------------------------


-- SEQUENCE for column 'RoomID'
CREATE SEQUENCE room_id_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 999999                      -- MAX VAL is set to 999999 
CYCLE
CACHE 20;

-- SEQUENCE for column 'RoomNumber'
CREATE SEQUENCE room_num_seq
START WITH 101
INCREMENT BY 1
MINVALUE 101
MAXVALUE 999999
CYCLE
CACHE 20;

-- SEQUENCE for column 'PatientID'
CREATE SEQUENCE patient_id_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 999999
CYCLE
CACHE 20;

-- SEQUENCE for column 'DoctorID'
CREATE SEQUENCE doc_id_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 999999
CYCLE
CACHE 20;

-- SEQUENCE for column 'TreatmentID'
CREATE SEQUENCE treatment_id_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 999999
CYCLE
CACHE 20;

-- SEQUENCE for column 'AppointmentID'
CREATE SEQUENCE appointment_id_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 999999
CYCLE
CACHE 20;
