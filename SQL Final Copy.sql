-- Query 1:
SELECT * FROM Patient;



-- Query 2:
SELECT PatientID, FirstName, LastName, BirthDate, Gender FROM Patient;



-- Query 3:
-- Create the VIEW  
CREATE VIEW patient_appointments AS
SELECT 
    p.PatientID,
    p.FirstName AS PatientFirstName,
    p.LastName AS PatientLastName,
    a.AppointmentID,
    a.AppointmentDate,
    a.ReasonForVisit,
    a.Status AS AppointmentStatus,
    d.FirstName AS DoctorFirstName,
    d.LastName AS DoctorLastName,
    d.Specialty AS DoctorSpecialty
FROM 
    patient p
JOIN 
    appointment a ON p.PatientID = a.PatientID
JOIN 
    doctor d ON a.DoctorID = d.DoctorID;

-- RUN the VIEW  
SELECT * FROM patient_appointments;



-- Query 4:
SELECT *
FROM Appointment a
JOIN Patient p ON a.PatientID = p.PatientID;



-- Query 5:
SELECT * FROM Doctor
ORDER BY doctorid ASC;



-- Query 6:
SELECT p.FirstName, p.LastName, a.AppointmentDate, d.FirstName AS
DoctorFirstName, d.LastName AS DoctorLastName
FROM Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Doctor d ON a.DoctorID = d.DoctorID
LIMIT 3;



-- Query 7:
SELECT DISTINCT p.FirstName, p.LastName, d.FirstName AS
DoctorFirstName, d.LastName AS DoctorLastName, r.RoomNumber
FROM Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Doctor d ON a.DoctorID = d.DoctorID
JOIN Room r ON a.PatientID = r.PatientID;



-- Query 8:
SELECT
	d.DoctorID,
	
	d.FirstName,
	
	d.LastName,
ROUND(AVG(t.Cost), 2) AS AverageCost
FROM
doctor d
JOIN
appointment a ON d.DoctorID = a.DoctorID
JOIN
treatment t ON a.AppointmentID = t.AppointmentID
GROUP BY
	d.DoctorID, d.FirstName, d.LastName
HAVING
AVG(t.Cost) > 200;



-- Query 9:
SELECT * FROM Appointment

WHERE DoctorID IN (SELECT DoctorID FROM Doctor WHERE Specialty = 'Cardiology');



-- Query 10:
SELECT FirstName, LENGTH(FirstName) AS FirstNameLength

FROM Patient;



-- Query 11:
SELECT * FROM Patient WHERE PatientID = 1;      -- View Table pre-DELETE statement

BEGIN;
DELETE FROM Patient WHERE PatientID = 1;        -- DELETE statement

SELECT * FROM Patient WHERE PatientID = 1;      -- View Table after DELETE statement

ROLLBACK;                                       -- ROLLBACK DELETE statement



-- Query 12:
SELECT * FROM Patient WHERE PatientID = 1;      -- View Table pre-UPDATE statement

BEGIN;
UPDATE Patient SET FirstName = 'Jacob' WHERE PatientID = 1;  -- UPDATE statement

SELECT * FROM Patient WHERE PatientID = 1;      -- View Table after UPDATE statement

ROLLBACK;                                       -- ROLLBACK UPDATE statement



-- Advanced Query 1: Number of Patients per Room Type and Average Cost of Treatments
SELECT
r.RoomType,
	COUNT(DISTINCT p.PatientID) AS NumberOfPatients,
	ROUND(AVG(t.Cost), 2) AS AverageTreatmentCost
	FROM
	Room r
	JOIN
	Patient p ON r.PatientID = p.PatientID
	JOIN
	Appointment a ON p.PatientID = a.PatientID
	JOIN
	Treatment t ON a.AppointmentID = t.AppointmentID
GROUP BY
r.RoomType
ORDER BY
NumberOfPatients DESC;



-- Advanced Query 2: Retrieve Detailed Patient Visit Information
SELECT 
    p.PatientID,
    p.FirstName || ' ' || p.LastName AS PatientName,
    d.FirstName || ' ' || d.LastName AS DoctorName,
    r.RoomNumber,
    r.RoomType,
    a.AppointmentDate,
    a.ReasonForVisit,
    STRING_AGG(t.TreatmentName, ', ') AS Treatments,
    SUM(t.Cost) AS TotalTreatmentCost
FROM 
    patient p
JOIN 
    appointment a ON p.PatientID = a.PatientID
JOIN 
    doctor d ON a.DoctorID = d.DoctorID
LEFT JOIN 
    room r ON p.PatientID = r.PatientID
LEFT JOIN 
    treatment t ON a.AppointmentID = t.AppointmentID
GROUP BY 
    p.PatientID, p.FirstName, p.LastName, 
    d.FirstName, d.LastName, 
    r.RoomNumber, r.RoomType, 
    a.AppointmentDate, a.ReasonForVisit
ORDER BY 
    p.LastName, p.FirstName, a.AppointmentDate;

