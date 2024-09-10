SET search_path to public


-- Insert data into the Patient table
INSERT INTO patient (PatientID, Firstname, Lastname, Birthdate, Gender, ContactNumber) VALUES
(NEXTVAL('patient_id_seq'), 'John', 'Doe', '1980-01-15', 'M', '(123)-456-7890'),
(NEXTVAL('patient_id_seq'), 'Jane', 'Smith', '1990-02-20', 'F', '(234)-567-8901'),
(NEXTVAL('patient_id_seq'), 'Alice', 'Johnson', '1975-03-25', 'F', '(345)-678-9012'),
(NEXTVAL('patient_id_seq'), 'Bob', 'Brown', '1985-04-30', 'M', '(456)-789-0123'),
(NEXTVAL('patient_id_seq'), 'Charlie', 'Davis', '1995-05-10', 'M', '(567)-890-1234');

-- Insert data into the Room table using existing PatientIDs
INSERT INTO room (RoomID, RoomNumber, RoomType, AvailabilityStatus, Capacity, PatientID) VALUES
(NEXTVAL('room_id_seq'), NEXTVAL('room_num_seq'), 'Single', TRUE, 1, 1),  -- Assuming PatientID 1 exists
(NEXTVAL('room_id_seq'), NEXTVAL('room_num_seq'), 'Double', FALSE, 2, 2), -- Assuming PatientID 2 exists
(NEXTVAL('room_id_seq'), NEXTVAL('room_num_seq'), 'Single', TRUE, 1, 3),  -- Assuming PatientID 3 exists
(NEXTVAL('room_id_seq'), NEXTVAL('room_num_seq'), 'Suite', TRUE, 3, 4),   -- Assuming PatientID 4 exists
(NEXTVAL('room_id_seq'), NEXTVAL('room_num_seq'), 'Single', FALSE, 1, 5); -- Assuming PatientID 5 exists

-- Insert data into the Doctor table
INSERT INTO doctor (DoctorID, Firstname, Lastname, Specialty, ContactNumber) VALUES
(NEXTVAL('doc_id_seq'), 'Dr. Emily', 'White', 'Cardiology', '(123)-456-7890'),
(NEXTVAL('doc_id_seq'), 'Dr. James', 'Green', 'Neurology', '(234)-567-8901'),
(NEXTVAL('doc_id_seq'), 'Dr. Linda', 'Black', 'Orthopedics', '(345)-678-9012'),
(NEXTVAL('doc_id_seq'), 'Dr. Michael', 'Blue', 'Pediatrics', '(456)-789-0123'),
(NEXTVAL('doc_id_seq'), 'Dr. Sarah', 'Red', 'Dermatology', '(567)-890-1234');

-- Insert data into the Appointment table using existing Patient & Doctor IDs
INSERT INTO appointment (AppointmentID, AppointmentDate, ReasonForVisit, Duration, Status, PatientID, DoctorID) VALUES
(NEXTVAL('appointment_id_seq'), '2024-08-25', 'Regular Checkup', 30, 'Scheduled', 1, 1), -- Assuming PatientID 1 and DoctorID 1 exists
(NEXTVAL('appointment_id_seq'), '2024-08-26', 'Follow-up', 45, 'Scheduled', 2, 2),       -- Assuming PatientID 2 and DoctorID 2 exists
(NEXTVAL('appointment_id_seq'), '2024-08-27', 'Consultation', 20, 'Scheduled', 3, 3),    -- Assuming PatientID 3 exists and DoctorID 3 exists
(NEXTVAL('appointment_id_seq'), '2024-08-28', 'Emergency', 60, 'Completed', 4, 4),       -- Assuming PatientID 4 exists and DoctorID 4 exists
(NEXTVAL('appointment_id_seq'), '2024-09-29', 'Routine Check', 30, 'Scheduled', 5, 5);   -- Assuming PatientID 5 exists and DoctorID 5 exists

-- Insert data into the Treatment table
INSERT INTO treatment (TreatmentID, TreatmentName, Description, Cost, Meds, AppointmentID) VALUES
(NEXTVAL('treatment_id_seq'), 'Physical Therapy, Surgery', 'Therapeutic exercises', 3100.00, 'Painkillers', 1),
(NEXTVAL('treatment_id_seq'), 'Chemotherapy', 'Cancer treatment', 2000.00, 'Chemotherapy drugs', 2),
(NEXTVAL('treatment_id_seq'), 'Radiology', 'X-ray imaging', 150.00, 'None', 3),
(NEXTVAL('treatment_id_seq'), 'Surgery', 'Appendectomy', 5000.00, 'Antibiotics', 4),
(NEXTVAL('treatment_id_seq'), 'Vaccination', 'Flu vaccine', 50.00, 'None', 5);


---------------------------------------------------------------------------------------------------------------------------------------------------


SELECT * FROM patient
SELECT * FROM room
SELECT * FROM doctor
SELECT * FROM appointment
SELECT * FROM treatment