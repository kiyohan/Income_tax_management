-- Effective_Timeline
-- INSERT INTO Effective_Timeline (Effective_from, Effective_to) VALUES
-- ('2022-04-01', '2023-03-31'),
-- ('2023-04-01', '2024-03-31');

-- -- Slab_range
-- INSERT INTO Slab_range (Minimum_Income, Maximum_Income) VALUES
-- (0.00, 250000.00),
-- (250001.00, 500000.00),
-- (500001.00, 1000000.00),
-- (1000001.00, 1500000.00);

-- Slabs
INSERT INTO Slabs (Slab_ID, Minimum_Income, Maximum_Income, Tax_Rate, CESS_Rate, Effective_from,Effective_to) VALUES
(1, 0.00, 250000.00,0.00, 0.00, 2022,2023),
(2, 250001.00, 500000.00,5.00, 4.00, 2022,2023),
(3, 500001.00, 1000000.00,10.00, 4.00,2022,2023),
(4, 1000001.00, 1500000.00,20.00, 4.00, 2022,2023);
-- Assessee
INSERT INTO Assessee (PAN, Address, Phone, Filing_Status, Representative_PAN) VALUES
('ABCDE1234F', '123 Main St, City', '1234567890', 'Filed', NULL),
('FGHIJ5678K', '456 Side St, City', '0987654321', 'Not Filed', 'ABCDE1234F'),
('JKLMN9101P', '789 Back St, City', '1122334455', 'Filed', NULL),
('NOPQR5678L', '987 Market Rd, City', '6677889900', 'Filed', 'JKLMN9101P');

-- Individual_Assessee
INSERT INTO Individual_Assessee (PAN, First_Name, Middle_Name, Last_Name, DOB, Gender, Residency_Status, Aadhar_Number) VALUES
('ABCDE1234F', 'John', 'Michael', 'Doe', '1990-01-01', 'M', 'Resident', '123456789012'),
('FGHIJ5678K', 'Jane', 'Elizabeth', 'Smith', '1985-05-10', 'F', 'Resident', '234567890123');

-- Corporate_Assessee
INSERT INTO Corporate_Assessee (PAN, Company_Name, Registration_Number, Date_of_Incorporation) VALUES
('JKLMN9101P', 'TechCorp Pvt Ltd', 'TC12345', '2010-03-15'),
('NOPQR5678L', 'Finance Solutions Ltd', 'FS98765', '2015-08-20');

-- Assessee_Bank_Details
INSERT INTO Assessee_Bank_Details (Bank_Account_Number, PAN, Account_Holder_Name, Bank_Address, IFSC) VALUES
('111122223333', 'ABCDE1234F', 'John Doe', '123 Bank St, City', 'IFSC001'),
('444455556666', 'FGHIJ5678K', 'Jane Smith', '456 Bank St, City', 'IFSC002');

-- Non_Assessee_with_PAN
INSERT INTO Non_Assessee_with_PAN (PAN, First_Name, Middle_Name, Last_Name, DOB, Gender, Address, Contact_Number, Residency_Status, Aadhar_Number, Is_tax_defaulter) VALUES
('NOPQR1234S', 'David', 'Andrew', 'Brown', '1980-12-20', 'M', '789 Side Lane, City', '6677889900', 'Resident', '345678901234', FALSE);

-- Non_Assessee_Bank_Details
INSERT INTO Non_Assessee_Bank_Details (Bank_Account_Number, PAN) VALUES
('777788889999', 'NOPQR1234S');

-- Bank_Transactions
INSERT INTO Bank_Transactions (Transaction_ID, Transaction_Type, Sender_Account_Number, Receiver_Account_Number, Transaction_Amount) VALUES
(1, 'Transfer', '111122223333', '777788889999', 1000.00),
(2, 'Deposit', NULL, '444455556666', 5000.00),
(3, 'Withdrawal', '444455556666', NULL, 2000.00);

-- Transactions_Involving_Assessee
INSERT INTO Transactions_Involving_Assessee (Transaction_Number, Account_Number) VALUES
(1, '111122223333'),
(3, '444455556666');

-- Transactions_Involving_Non_Assessee
INSERT INTO Transactions_Involving_Non_Assessee (Transaction_Number, Bank_Account_Number) VALUES
(1, '777788889999');

-- TDS
INSERT INTO TDS (TDS_Certificate_Number, PAN, Deductor_Name, Deductor_TAN, Income_Type, TDS_Amount, Date_of_Deduction, Section_Code, Start_Year, End_Year) VALUES
(1001, 'ABCDE1234F', 'Corp A', 'TAN001', 'Salary', 5000.00, '2022-06-15', '192', 2022, 2023);

-- TCS
INSERT INTO TCS (TCS_Certificate_Number, PAN, Seller_Name, Seller_TAN, TCS_Amount, Date_of_Collection, Section_Code, Start_Year, End_Year) VALUES
(2001, 'JKLMN9101P', 'Shop A', 'TAN002', 200.00, '2022-06-20', '206C', 2022, 2023);

-- Goods
INSERT INTO Goods (TCS_Certificate_Number, Goods_Type) VALUES
(2001, 'Electronics'),
(2001, 'Furniture');

--Corresponding_year
INSERT INTO Corresponding_year (Start_Year, End_Year) VALUES
(2022, 2023),
(2023, 2024);

-- ITR
INSERT INTO ITR (Acknowledgement_Number, PAN, Age, Tax_Payer_Category, Submission_Date, Regime, Due_Date, Start_Year, End_Year,Total_Taxable_Income, Total_Tax_Paid, Status) VALUES
(3001, 'ABCDE1234F', 33, 'Individual', '2022-07-01', 'New', '2023-07-31', 2022,2023, 1000000.00, 105000.00, 'Processed');

-- Is_penaliser
INSERT INTO Is_penaliser (Penalty, PAN) VALUES
(500.00, 'ABCDE1234F');

-- Corresponding_Slabs
INSERT INTO Corresponding_Slabs (Acknowledgement_Number, Slab_ID) VALUES
(3001, 3);

-- Income_Details
INSERT INTO Income_Details (Acknowledgement_Number, PAN, Start_Year,Salary_Income, Business_Income, Capital_Gain, House_Property_Income, Agriculture_Income, Other_Income_Total) VALUES
(3001, 'ABCDE1234F', 2022, 800000.00, 50000.00, 20000.00, 10000.00, 5000.00, 10000.00);

-- Other_Income
INSERT INTO Other_Income (Acknowledgement_Number, Income_source) VALUES
(3001, 'Interest Income'),
(3001, 'Dividend');

-- Deduction_limit
INSERT INTO Deduction_limit (Deduction_Type, Max_allowable_limit) VALUES
('80C', 150000.00),
('80D', 25000.00);

-- Deduction_period
INSERT INTO Deduction_period (Acknowledgement_Number, PAN, Start_Year) VALUES
(3001, 'ABCDE1234F', 2022);

-- Deduction
INSERT INTO Deduction (Acknowledgement_Number, Deduction_Type, Deduction_Amount) VALUES
(3001, '80C', 100000.00),
(3001, '80D', 20000.00);

-- Sections
INSERT INTO Sections (Acknowledgement_Number, Deduction_Type, Section_Code) VALUES
(3001, '80C', '80C'),
(3001, '80D', '80D');

-- Tax_Verification
INSERT INTO Tax_Verification (Acknowledgement_Number, Bank_Account_Number, Status, Start_Year, Requested_Date, Processed_Date, Tax_Amount, Tax_Paid, IFSC_Code) VALUES
(3001, '111122223333', 'Completed', 2022, '2022-08-01', '2022-08-05', 105000.00, 105000.00, 'IFSC001');

-- Refund_details
INSERT INTO Refund_details (Acknowledgement_Number, Refund_amount, Refund_status) VALUES
(3001, 0.00, 'No Refund');

DELIMITER $$

CREATE PROCEDURE calculate_slabs_for_itr(ack_no INT)
BEGIN
    DECLARE net_income DECIMAL(15, 2);
    DECLARE total_deduction DECIMAL(15, 2) DEFAULT 0;
    DECLARE remaining_income DECIMAL(15, 2);
    DECLARE slab_amount DECIMAL(15, 2);
    DECLARE slabid INT ;  
    DECLARE min_income DECIMAL(15, 2);
    DECLARE max_income DECIMAL(15, 2);
    DECLARE done INT DEFAULT 0;

    -- Declare a cursor for iterating over slabs
    DECLARE slab_cursor CURSOR FOR
        SELECT Slab_ID, Minimum_Income, Maximum_Income
        FROM Slabs
        WHERE Effective_from <= (SELECT Start_Year FROM ITR WHERE Acknowledgement_Number = ack_no)
        AND Effective_to >= (SELECT End_Year FROM ITR WHERE Acknowledgement_Number = ack_no);

    -- Declare continue handler for the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Calculate total deductions for the given ack_no
    SELECT COALESCE(SUM(Deduction_Amount), 0)
    INTO total_deduction
    FROM Deduction
    WHERE Acknowledgement_Number = ack_no;

    -- Get total income from the Income_Details table
    SELECT Total_income
    INTO net_income
    FROM Income_Details
    WHERE Acknowledgement_Number = ack_no;

    -- Subtract deductions to calculate net income
    SET net_income = net_income - total_deduction;
    SET remaining_income = net_income;

    -- Open the cursor
    OPEN slab_cursor;

    -- Loop through the slabs
    read_loop: LOOP
        FETCH slab_cursor INTO slabid, min_income, max_income;

        -- Exit the loop when there are no more rows to fetch
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- For each slab, calculate the applicable amount
        IF remaining_income > 0 THEN
            -- Determine the slab amount based on remaining income
            IF remaining_income >= (max_income - min_income) THEN
                SET slab_amount = max_income - min_income;
                SET remaining_income = remaining_income - slab_amount;
            ELSE
                SET slab_amount = remaining_income;
                SET remaining_income = 0;
            END IF;

            -- Insert the record into Corresponding_Slabs
            INSERT INTO Corresponding_Slabs (Acknowledgement_Number, Slab_ID, Amount)
            VALUES (ack_no, slabid, slab_amount);
        END IF;

    END LOOP;

    -- Close the cursor
    CLOSE slab_cursor;

END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER after_itr_insert
AFTER INSERT ON Income_Details
FOR EACH ROW
BEGIN
    -- Call the stored procedure to calculate slabs for the inserted ack_no
    CALL calculate_slabs_for_itr(NEW.Acknowledgement_Number);
END$$

DELIMITER ;



DELIMITER $$

CREATE TRIGGER update_total_income_before_insert
BEFORE INSERT ON Income_Details
FOR EACH ROW
BEGIN
    -- Calculate the Total_income before the insert
    SET NEW.Total_income = NEW.Salary_Income + NEW.Business_Income + NEW.Capital_Gain +
                           NEW.House_Property_Income + NEW.Agriculture_Income + NEW.Other_Income_Total;
END$$

DELIMITER ;
