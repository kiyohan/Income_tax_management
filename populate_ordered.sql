CREATE DATABASE IF NOT EXISTS Taxation_System;

USE Taxation_System;

-- Base table for Effective Timeline
-- CREATE TABLE IF NOT EXISTS Effective_Timeline (
--     Effective_from DATE PRIMARY KEY,
--     Effective_to DATE
-- );

-- Base table for Slab Range
-- CREATE TABLE IF NOT EXISTS Slab_range (
--     Minimum_Income DECIMAL(15, 2) PRIMARY KEY,
--     Maximum_Income DECIMAL(15, 2)
-- );

-- Slabs Table depending on Effective Timeline and Slab Range
CREATE TABLE IF NOT EXISTS Slabs (
    Slab_ID INT PRIMARY KEY,
    Minimum_Income DECIMAL(15, 2) DEFAULT 0.00,
    Maximum_Income DECIMAL(15, 2) DEFAULT 0.00,
    Tax_Rate DECIMAL(5, 2),
    CESS_Rate DECIMAL(5, 2),
    Effective_from YEAR,
    Effective_to YEAR
    -- FOREIGN KEY (Effective_from) REFERENCES Effective_Timeline(Effective_from),

);

-- Assessee Table
CREATE TABLE IF NOT EXISTS Assessee (
    PAN VARCHAR(15) PRIMARY KEY,
    Address VARCHAR(255),
    Phone VARCHAR(15),
    Filing_Status VARCHAR(20),
    Representative_PAN VARCHAR(15),
    FOREIGN KEY (Representative_PAN) REFERENCES Assessee(PAN) ON DELETE CASCADE
);

-- Individual Assessee Subclass
CREATE TABLE IF NOT EXISTS Individual_Assessee (
    PAN VARCHAR(15) PRIMARY KEY,
    First_Name VARCHAR(50),
    Middle_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    DOB DATE,
    Gender CHAR(1),
    Residency_Status VARCHAR(20),
    Aadhar_Number VARCHAR(12) UNIQUE,
    FOREIGN KEY (PAN) REFERENCES Assessee(PAN) ON DELETE CASCADE
);

-- Corporate Assessee Subclass
CREATE TABLE IF NOT EXISTS Corporate_Assessee (
    PAN VARCHAR(15) PRIMARY KEY,
    Company_Name VARCHAR(255),
    Registration_Number VARCHAR(50) UNIQUE,
    Date_of_Incorporation DATE,
    FOREIGN KEY (PAN) REFERENCES Assessee(PAN) ON DELETE CASCADE
);

-- Assessee Bank Details
CREATE TABLE IF NOT EXISTS Assessee_Bank_Details (
    Bank_Account_Number VARCHAR(20) PRIMARY KEY,
    PAN VARCHAR(15),
    Account_Holder_Name VARCHAR(255),
    Bank_Address VARCHAR(255),
    IFSC VARCHAR(11),
    FOREIGN KEY (PAN) REFERENCES Assessee(PAN) ON DELETE CASCADE
);

-- Non-Assessee with PAN
CREATE TABLE IF NOT EXISTS Non_Assessee_with_PAN (
    PAN VARCHAR(15) PRIMARY KEY,
    First_Name VARCHAR(50),
    Middle_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    DOB DATE,
    Gender CHAR(1),
    Address VARCHAR(255),
    Contact_Number VARCHAR(15),
    Residency_Status VARCHAR(20),
    Aadhar_Number VARCHAR(12) UNIQUE,
    Is_tax_defaulter BOOLEAN DEFAULT FALSE
);

-- Non-Assessee Bank Details
CREATE TABLE IF NOT EXISTS Non_Assessee_Bank_Details (
    Bank_Account_Number VARCHAR(20) PRIMARY KEY,
    PAN VARCHAR(15),
    FOREIGN KEY (PAN) REFERENCES Non_Assessee_with_PAN(PAN) ON DELETE CASCADE
);

-- Bank Transactions Table
CREATE TABLE IF NOT EXISTS Bank_Transactions (
    Transaction_ID INT PRIMARY KEY,
    Transaction_Type VARCHAR(50),
    Sender_Account_Number VARCHAR(20),
    Receiver_Account_Number VARCHAR(20),
    Transaction_Amount DECIMAL(15, 2) DEFAULT 0.00
);

-- Transactions Involving Assessee
CREATE TABLE IF NOT EXISTS Transactions_Involving_Assessee (
    Transaction_Number INT PRIMARY KEY,
    Account_Number VARCHAR(20),
    FOREIGN KEY (Transaction_Number) REFERENCES Bank_Transactions(Transaction_ID),
    FOREIGN KEY (Account_Number) REFERENCES Assessee_Bank_Details(Bank_Account_Number)
);

-- Transactions Involving Non-Assessee
CREATE TABLE IF NOT EXISTS Transactions_Involving_Non_Assessee (
    Transaction_Number INT PRIMARY KEY,
    Bank_Account_Number VARCHAR(20),
    FOREIGN KEY (Transaction_Number) REFERENCES Bank_Transactions(Transaction_ID) ON DELETE CASCADE,
    FOREIGN KEY (Bank_Account_Number) REFERENCES Non_Assessee_Bank_Details(Bank_Account_Number) ON DELETE CASCADE
);

-- TDS Table
CREATE TABLE IF NOT EXISTS TDS (
    TDS_Certificate_Number INT PRIMARY KEY,
    PAN VARCHAR(15),
    Deductor_Name VARCHAR(255),
    Deductor_TAN VARCHAR(20),
    Income_Type VARCHAR(50),
    TDS_Amount DECIMAL(15, 2) DEFAULT 0.00,
    Date_of_Deduction DATE,
    Section_Code VARCHAR(10),
    Start_Year YEAR,
    End_Year YEAR,
    FOREIGN KEY (PAN) REFERENCES Assessee(PAN)
);

-- TCS Table
CREATE TABLE IF NOT EXISTS TCS (
    TCS_Certificate_Number INT PRIMARY KEY,
    PAN VARCHAR(15),
    Seller_Name VARCHAR(255),
    Seller_TAN VARCHAR(20),
    TCS_Amount DECIMAL(15, 2)   DEFAULT 0.00,
    Date_of_Collection DATE,
    Section_Code VARCHAR(10),
    Start_Year YEAR,
    End_Year YEAR,
    FOREIGN KEY (PAN) REFERENCES Assessee(PAN)
);

-- Goods Table
CREATE TABLE IF NOT EXISTS Goods (
    TCS_Certificate_Number INT,
    Goods_Type VARCHAR(50),
    PRIMARY KEY (TCS_Certificate_Number, Goods_Type),
    FOREIGN KEY (TCS_Certificate_Number) REFERENCES TCS(TCS_Certificate_Number) ON DELETE CASCADE
);

-- Corresponding Year Table
-- CREATE TABLE IF NOT EXISTS Corresponding_year (
--     Start_Year YEAR PRIMARY KEY,
--     End_Year YEAR
-- );

-- Is Penaliser Table
CREATE TABLE IF NOT EXISTS Is_penaliser (
    Acknowledgement_Number INT ,
    Penalty DECIMAL(15, 2) DEFAULT 0.00,
    PAN VARCHAR(15),
    PRIMARY KEY (Acknowledgement_Number,PAN)
    -- FOREIGN KEY (PAN) REFERENCES ITR(PAN)
);

-- ITR Table
CREATE TABLE IF NOT EXISTS ITR (
    Acknowledgement_Number INT PRIMARY KEY,
    PAN VARCHAR(15),
    Age INT,
    Tax_Payer_Category VARCHAR(50),
    Submission_Date DATE,
    Regime VARCHAR(50),
    Due_Date DATE,
    Start_Year YEAR,
    End_Year YEAR,
    Total_Taxable_Income DECIMAL(15, 2) DEFAULT 0.00,
    Total_Tax_Paid DECIMAL(15, 2)   DEFAULT 0.00,
    Status VARCHAR(20),
    FOREIGN KEY (PAN) REFERENCES Assessee(PAN) ON DELETE CASCADE
    -- FOREIGN KEY (Start_Year) REFERENCES Corresponding_year(Start_Year)
);

ALTER TABLE Is_penaliser
ADD FOREIGN KEY (PAN) REFERENCES ITR(PAN);

CREATE TABLE IF NOT EXISTS Corresponding_Slabs (
    Acknowledgement_Number INT,
    Slab_ID INT,
    Amount DECIMAL(15, 2) DEFAULT 0.00,
    PRIMARY KEY (Acknowledgement_Number, Slab_ID),
    FOREIGN KEY (Acknowledgement_Number) REFERENCES ITR(Acknowledgement_Number) ON DELETE CASCADE
    -- FOREIGN KEY (Slab_ID) REFERENCES Slabs(Slab_ID)
);


-- Income Details Table
CREATE TABLE IF NOT EXISTS Income_Details (
    Acknowledgement_Number INT,
    PAN VARCHAR(15),
    Start_Year YEAR,
    End_Year YEAR,
    Salary_Income DECIMAL(15, 2) DEFAULT 0.00,
    Business_Income DECIMAL(15, 2) DEFAULT 0.00,
    Capital_Gain DECIMAL(15, 2) DEFAULT 0.00,
    House_Property_Income DECIMAL(15, 2) DEFAULT 0.00,
    Agriculture_Income DECIMAL(15, 2) DEFAULT 0.00,
    Other_Income_Total DECIMAL(15, 2) DEFAULT 0.00,
    Total_income DECIMAL(15, 2) DEFAULT 0.00, -- salary_income + business_income + capital_gain + house_property_income + agriculture_income + other_income_total
    PRIMARY KEY (Acknowledgement_Number),
    FOREIGN KEY (Acknowledgement_Number) REFERENCES ITR(Acknowledgement_Number) ON DELETE CASCADE,
    FOREIGN KEY (PAN) REFERENCES Assessee(PAN) ON DELETE CASCADE
    -- FOREIGN KEY (Start_Year) REFERENCES Corresponding_year(Start_Year)
);

-- Other Income Table
CREATE TABLE IF NOT EXISTS Other_Income (
    Acknowledgement_Number INT,
    Income_source VARCHAR(100),
    PRIMARY KEY (Acknowledgement_Number, Income_source),
    FOREIGN KEY (Acknowledgement_Number) REFERENCES Income_Details(Acknowledgement_Number) ON DELETE CASCADE
);

-- Deduction Limit Table
CREATE TABLE IF NOT EXISTS Deduction_limit (
    Deduction_Type VARCHAR(50) PRIMARY KEY,
    Max_allowable_limit DECIMAL(15, 2) DEFAULT 0.00
);

-- -- Deduction Period Table
-- CREATE TABLE IF NOT EXISTS Deduction_period (
--     Acknowledgement_Number INT PRIMARY KEY,
--     PAN VARCHAR(15),
--     Start_Year YEAR,
--     FOREIGN KEY (Acknowledgement_Number) REFERENCES ITR(Acknowledgement_Number),
--     FOREIGN KEY (PAN) REFERENCES Assessee(PAN),
--     FOREIGN KEY (Start_Year) REFERENCES Corresponding_year(Start_Year)
-- );

-- Deduction Table
CREATE TABLE IF NOT EXISTS Deduction (
    Acknowledgement_Number INT,
    Deduction_Type VARCHAR(50),
    Deduction_Amount DECIMAL(15, 2) DEFAULT 0.00,
    PRIMARY KEY (Acknowledgement_Number, Deduction_Type),
    -- FOREIGN KEY (Acknowledgement_Number) REFERENCES Deduction_period(Acknowledgement_Number),
    FOREIGN KEY (Deduction_Type) REFERENCES Deduction_limit(Deduction_Type) ON DELETE CASCADE
);

-- Sections Table
CREATE TABLE IF NOT EXISTS Sections (
    Acknowledgement_Number INT,
    Deduction_Type VARCHAR(50),
    Section_Code VARCHAR(10),
    PRIMARY KEY (Acknowledgement_Number, Deduction_Type),
    FOREIGN KEY (Acknowledgement_Number) REFERENCES Deduction(Acknowledgement_Number) ON DELETE CASCADE,
    FOREIGN KEY (Deduction_Type) REFERENCES Deduction(Deduction_Type) ON DELETE CASCADE
);

-- Tax Verification Table
CREATE TABLE IF NOT EXISTS Tax_Verification (
    Acknowledgement_Number INT PRIMARY KEY,
    Bank_Account_Number VARCHAR(20),
    Status VARCHAR(20),
    Start_Year YEAR,
    End_Year YEAR,
    Requested_Date DATE,
    Processed_Date DATE,
    Tax_Amount DECIMAL(15, 2)   DEFAULT 0.00,
    Tax_Paid DECIMAL(15, 2) DEFAULT 0.00,
    IFSC_Code VARCHAR(11),
    FOREIGN KEY (Acknowledgement_Number) REFERENCES ITR(Acknowledgement_Number) ON DELETE CASCADE
    -- FOREIGN KEY (Start_Year) REFERENCES Corresponding_year(Start_Year)
);

-- Refund Details Table
CREATE TABLE IF NOT EXISTS Refund_details (
    Acknowledgement_Number INT PRIMARY KEY,
    Refund_amount DECIMAL(15, 2) DEFAULT 0.00,
    Refund_status VARCHAR(20),
    FOREIGN KEY (Acknowledgement_Number) REFERENCES Tax_Verification(Acknowledgement_Number) ON DELETE CASCADE
);


