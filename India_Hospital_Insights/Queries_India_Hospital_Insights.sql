--1. Total Number of Patients

SELECT SUM(Patients_count) AS Total_Number_Of_Patients
FROM hospital; -- ANS: 9347(Patients)

--2. Average Number of Doctors per Hospital

SELECT ROUND(AVG(doctors_count),2) AS doctors_per_hospital
FROM hospital; -- ANS 26.71

--3. Top 3 Departments with the Highest Number of Patients

SELECT department, SUM (patients_count) AS total_patients
FROM hospital
GROUP BY department
ORDER BY total_patients DESC
LIMIT 3;

--4. Hospital with the Maximum Medical Expenses

SELECT hospital_name, medical_expenses
FROM hospital
ORDER BY medical_expenses DESC  --FOR HIGHEST SINGLE MEDICAL EXPENSE IN THE TABLE
LIMIT 1;

SELECT hospital_name,location, SUM(medical_expenses) AS TOTAL_MEDICAL_EXPENSES
FROM hospital
GROUP BY hospital_name, location 
ORDER BY TOTAL_MEDICAL_EXPENSES DESC LIMIT 1;  --Same Hospitals included in same location 


--5. Daily Average Medical Expenses

SELECT 
  hospital_name, location, ROUND(AVG(daily_total), 2) AS daily_average_medical_expense
FROM (
    SELECT 
      hospital_name, location, discharge_date, SUM(medical_expenses) AS daily_total
    FROM hospital
    GROUP BY hospital_name, location, discharge_date
) sub
GROUP BY hospital_name, location
ORDER BY daily_average_medical_expense DESC;--Grouping same hospital branch


--6. Longest Hospital Stay, Find the patient with the longest stay


SELECT *, AGE(discharge_date, admission_date) AS hospital_stay_duration
FROM hospital
ORDER BY hospital_stay_duration DESC
LIMIT 1;

--7. Total Patients Treated Per City

SELECT location, SUM(patients_count) AS total_patients_count
FROM hospital
GROUP BY location
ORDER BY total_patients_count DESC;

 
--8. Average Length of Stay Per Department


SELECT department, ROUND(AVG(discharge_date-admission_date),2) AS length_of_stay
FROM hospital 
GROUP BY department
ORDER BY length_of_stay DESC;

--9. Identify the Department with the Lowest Number of Patients

SELECT department, SUM(patients_count) AS total_patients
FROM hospital
GROUP BY department
ORDER BY total_patients 
LIMIT 1;

--10. Monthly Medical Expenses Report

SELECT 
    DATE_TRUNC('month', discharge_date) AS month,
    SUM(medical_expenses) AS total_medical_expenses
FROM hospital
GROUP BY month
ORDER BY month;
