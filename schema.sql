-- ================================
-- SPARC SPORTS SCHOLARSHIP PORTAL
-- PostgreSQL Schema (FINAL)
-- ================================

BEGIN;

-- ================================
-- USERS
-- ================================
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(10) NOT NULL CHECK (role IN ('student','admin')),
    gender VARCHAR(6) CHECK (gender IN ('Male','Female')),
    dob DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ================================
-- SPORTS
-- ================================
CREATE TABLE sports (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    category VARCHAR(20) NOT NULL CHECK (category IN ('Team','Individual'))
);

-- ================================
-- SCHOLARSHIP SCHEMES
-- ================================
CREATE TABLE scholarship_schemes (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    open_date DATE NOT NULL,
    close_date DATE NOT NULL,
    total_seats INT NOT NULL CHECK (total_seats <= 20),
    boys_seats INT NOT NULL CHECK (boys_seats <= 10),
    girls_seats INT NOT NULL CHECK (girls_seats <= 10),
    active BOOLEAN DEFAULT TRUE
);

-- ================================
-- APPLICATIONS
-- ================================
CREATE TABLE applications (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id),
    scheme_id INT NOT NULL REFERENCES scholarship_schemes(id),
    sport_id INT NOT NULL REFERENCES sports(id),
    scholarship_level VARCHAR(10) NOT NULL CHECK (scholarship_level IN ('Elite','Scholar')),
    status VARCHAR(20) NOT NULL DEFAULT 'Submitted'
        CHECK (status IN ('Submitted','Under Review','Approved','Rejected')),
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, scheme_id)
);

-- ================================
-- DOCUMENTS
-- ================================
CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    application_id INT NOT NULL REFERENCES applications(id) ON DELETE CASCADE,
    document_type VARCHAR(50) NOT NULL
        CHECK (document_type IN ('Age Proof','Performance Certificate','Photograph')),
    file_path TEXT NOT NULL
);

-- ================================
-- SEAT ALLOCATION (CRITICAL)
-- ================================
CREATE TABLE seat_allocations (
    id SERIAL PRIMARY KEY,
    scheme_id INT NOT NULL REFERENCES scholarship_schemes(id),
    gender VARCHAR(6) NOT NULL CHECK (gender IN ('Male','Female')),
    allocated_count INT NOT NULL DEFAULT 0,
    UNIQUE (scheme_id, gender)
);

-- ================================
-- APPLICATION STATUS LOGS (AUDIT)
-- ================================
CREATE TABLE application_status_logs (
    id SERIAL PRIMARY KEY,
    application_id INT NOT NULL REFERENCES applications(id),
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ================================
-- INDEXES (PERFORMANCE)
-- ================================
CREATE INDEX idx_applications_scheme ON applications(scheme_id);
CREATE INDEX idx_applications_status ON applications(status);
CREATE INDEX idx_users_role ON users(role);

-- ================================
-- SEED DATA
-- ================================

-- SPORTS
INSERT INTO sports (name, category) VALUES
('Kabaddi','Team'),
('Kho-Kho','Team'),
('Badminton','Individual'),
('Table Tennis','Individual'),
('Silambam','Individual'),
('Athletics','Individual'),
('Boxing','Individual'),
('Chess','Individual');

-- SCHOLARSHIP SCHEME
INSERT INTO scholarship_schemes
(name, open_date, close_date, total_seats, boys_seats, girls_seats)
VALUES
('SPARC Sports Scholarship 2025','2025-08-20','2025-09-20',20,10,10);

-- INITIAL SEAT ALLOCATION ROWS
INSERT INTO seat_allocations (scheme_id, gender, allocated_count)
VALUES
(1,'Male',0),
(1,'Female',0);

COMMIT;
