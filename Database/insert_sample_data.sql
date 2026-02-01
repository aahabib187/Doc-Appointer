-- 1️⃣ USERS (parents of admin, doctor, patient, technician)
INSERT INTO users (id, name, email, pass, phone, role) VALUES (1,'Alice Admin','alice@example.com','alice123','01711111111','admin');
INSERT INTO users (id, name, email, pass, phone, role) VALUES (2,'Dr. Bob','bob@example.com','bob123','01722222222','doctor');
INSERT INTO users (id, name, email, pass, phone, role) VALUES (3,'Patient Charlie','charlie@example.com','charlie123','01733333333','patient');
INSERT INTO users (id, name, email, pass, phone, role) VALUES (4,'Tech Dan','dan@example.com','dan123','01744444444','technician');

-- 2️⃣ ADMIN (parent for hospital_branches, departments, specialization, etc.)
INSERT INTO admin (id, users_id, role, branch_id) VALUES (1, 11, 'superadmin', NULL);

-- 3️⃣ HOSPITAL BRANCHES
INSERT INTO hospital_branches (id, admin_id, name, address, established_date) 
VALUES (1, 1, 'Central Hospital', '123 Main St', SYSDATE);

-- 4️⃣ DEPARTMENTS
INSERT INTO departments (id, admin_id, name, description) VALUES (1, 1, 'General Medicine', 'Handles general patients');

-- 5️⃣ SPECIALIZATION
INSERT INTO specialization (id, admin_id, name, description) VALUES (1, 1, 'Cardiology', 'Heart specialist');

-- 6️⃣ DOCTOR (after user, admin, department, branch)
INSERT INTO doctor (id, user_id, admin_id, license_number, degrees, experience_years, available_days_times, dept_id, branch_id)
VALUES (1, 12, 1, 'LIC12345', 'MBBS, MD', 10, 'Mon-Fri 09:00-15:00', 1, 1);

-- 7️⃣ PATIENT (after user)
INSERT INTO patient (id, user_id, date_of_birth, gender, occupation, blood_type, marital_status, address)
VALUES (1, 13, DATE '1990-05-12', 'M', 'Engineer', 'O+', 'Single', '123 Street, City');

-- 8️⃣ MEDICAL TECHNICIAN (after user, admin, department, branch)
INSERT INTO medical_technician (id, user_id, admin_id, degrees, experience_years, dept_id, branch_id)
VALUES (1, 14, 1, 'BSc Medical Tech', 5, 1, 1);

-- 9️⃣ TIME SLOTS (after admin)
INSERT INTO time_slots (id, admin_id_last, start_time, end_time, status, last_edited_at, type_id)
VALUES (1, 1, TO_DATE('09:00','HH24:MI'), TO_DATE('09:30','HH24:MI'), 'available', SYSDATE, 1);

-- 🔟 TESTS (after admin, technician)
INSERT INTO tests (id, admin_id, test_name, test_hours, technician_id)
VALUES (1, 1, 'Blood Test', 2, 1);

-- 1️⃣1️⃣ BEDS (after admin)
INSERT INTO beds (id, admin_id, room_number, ward_number, type, status)
VALUES (1, 1, '101', 'A', 'General', 'available');

-- 1️⃣2️⃣ DOCTOR APPOINTMENTS (after patient, doctor, time_slot)
INSERT INTO doctors_appointments (id, patient_id, doctor_id, appointment_date, time_slot_id, status, type)
VALUES (1, 1, 1, SYSDATE, 1, 'scheduled', 'consultation');

-- 1️⃣3️⃣ LAB TEST APPOINTMENTS (after patient, doctor, time_slot, test)
INSERT INTO lab_test_appointments (id, patient_id, reference, doctor_id, time_slot_id, test_id, test_file_url)
VALUES (1, 1, 'REF001', 1, 1, 1, NULL);

-- 1️⃣4️⃣ BED BOOKING (after doctor appointment, bed, time_slot)
INSERT INTO bed_booking_appointments (id, doctor_appointment_id, bed_id, time_slot_id, status)
VALUES (1, 1, 1, 1, 'booked');

-- 1️⃣5️⃣ PRESCRIPTION (after doctor appointment)
INSERT INTO prescription (id, appointment_id, date_issued, chief_complaints, investigations, required_tests, diagnosis, history, instructions, visit_again_at)
VALUES (1, 1, SYSDATE, 'Fever', 'Blood test', 'Blood Test', 'Viral Fever', 'No previous', 'Rest and hydrate', SYSDATE+7);

-- 1️⃣6️⃣ MEDICATIONS
INSERT INTO medications (id, medicine_name, duration, dosage) VALUES (1, 'Paracetamol', '5 days', '500mg');

-- 1️⃣7️⃣ PRESCRIBED MED (after prescription, medication)
INSERT INTO prescribed_med (id, prescription_id, medication_id) VALUES (1, 1, 1);

-- 1️⃣8️⃣ BILLS (after admin, doctor appointment)
INSERT INTO bills (id, admin_id, appointment_id, total_amount, status, issue_date)
VALUES (1, 1, 1, 500, 'unpaid', SYSDATE);

-- 1️⃣9️⃣ BRANCH CONTACTS (after admin, branch)
INSERT INTO branch_contacts (id, admin_id, branch_id, contact_no, type)
VALUES (1, 1, 1, '01710000000', 'Emergency');

-- 2️⃣0️⃣ EMERGENCY CONTACTS (after patient)
INSERT INTO emergency_contacts (id, patient_id, contact_no, name, relation, contact_address)
VALUES (1, 1, '01712345678', 'Eve', 'Sister', '456 Secondary St');

-- ✅ COMMIT ALL
COMMIT;
SELECT * FROM DOCTOR;