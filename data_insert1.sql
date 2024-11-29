-- Slab_range
-- INSERT INTO Slab_range (Minimum_Income, Maximum_Income) VALUES
-- (0.00, 250000.00),
-- (250001.00, 500000.00),
-- (500001.00, 1000000.00),
-- (1000001.00, 1500000.00);

-- Slabs
INSERT INTO Slabs (Slab_ID, Minimum_Income, Maximum_Income, Tax_Rate, CESS_Rate, Effective_from,Effective_to) VALUES
(1, 0.00, 250000.00,0.00, 0.00, 2022, 2023),
(2, 250001.00, 500000.00, 5.00, 1.00, 2022, 2023),
(3, 500001.00, 1000000.00, 10.00, 2.00, 2022, 2023),
(4, 1000001.00, 9999999999.00, 20.00, 4.00, 2022, 2023),
(5, 0.00, 250000.00,0.00, 0.00, 2023, 2024),
(6, 250001.00, 500000.00, 5.00, 1.00, 2023, 2024),
(7, 500001.00, 1000000.00, 10.00, 2.00, 2023, 2024),
(8, 1000001.00, 9999999999.00, 20.00, 4.00, 2023, 2024),
(9, 0.00, 250000.00,0.00, 0.00, 2024, 2025),
(10, 250001.00, 500000.00, 5.00, 1.00, 2024, 2025),
(11, 500001.00, 1000000.00, 10.00, 2.00, 2024, 2025),
(12, 1000001.00, 9999999999.00, 20.00, 4.00, 2024, 2025);

-- Assessee
INSERT INTO Assessee (PAN, Address, Phone, Filing_Status, Representative_PAN) VALUES
('ABCDE1234F', '123 Main St, City', '1234567890', 'Filed', NULL),
('FGHIJ5678K', '456 Side St, City', '0987654321', 'Not Filed', 'ABCDE1234F'),
('JKLMN9101P', '789 Back St, City', '1122334455', 'Not Filed', NULL),
('NOPQR5678L', '987 Market Rd, City', '6677889900', 'Not Filed', 'JKLMN9101P');

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
('123456789123', 'ABCDE1234F', 'John Doe', '123 Bank St, City', 'IFSC001'),
('321987654321', 'FGHIJ5678K', 'Jane Smith', '456 Bank St, City', 'IFSC002');

-- Non_Assessee_with_PAN
INSERT INTO Non_Assessee_with_PAN (PAN, First_Name, Middle_Name, Last_Name, DOB, Gender, Address, Contact_Number, Residency_Status, Aadhar_Number, Is_tax_defaulter) VALUES
('NONPQR1234', 'David', 'Andrew', 'Brown', '1980-12-20', 'M', '789 Side Lane, City', '6677889900', 'Resident', '345678901234', FALSE),
('NONPAN1234', 'Spider',NULL, 'Man','1900-10-19','M','123 Tax Lane', '9876543210','NRI','424225242458', TRUE);

-- Non_Assessee_Bank_Details
INSERT INTO Non_Assessee_Bank_Details (Bank_Account_Number, PAN) VALUES
('987321654132', 'NONPQR1234'),
('721789456123', 'NONPAN1234');

-- Bank_Transactions
INSERT INTO Bank_Transactions (Transaction_ID, Transaction_Type, Sender_Account_Number, Receiver_Account_Number, Transaction_Amount) VALUES
(1, 'Transfer', '123456789123', '777788889999', 1000.00),
(2, 'Deposit', NULL, '444455556666', 5000.00),
(3, 'Withdrawal', '321987654321', NULL, 2000.00),
(4, 'Transfer', '963258741543',  '987321654132', 3500.00),
(5, 'Transfer', '721789456123', '987321654132', 250001.00);

-- Transactions_Involving_Assessee
INSERT INTO Transactions_Involving_Assessee (Transaction_Number, Account_Number) VALUES
(1, '123456789123'),
(3, '321987654321');



-- Transactions_Involving_Non_Assessee
INSERT INTO Transactions_Involving_Non_Assessee (Transaction_Number, Bank_Account_Number) VALUES
(4, '987321654132'),
(5, '721789456123');


-- TDS
INSERT INTO TDS (TDS_Certificate_Number, PAN, Deductor_Name, Deductor_TAN, Income_Type, TDS_Amount, Date_of_Deduction, Section_Code, Start_Year, End_Year) VALUES
(1001, 'ABCDE1234F', 'Corp A', 'DTAN001', 'Salary', 5000.00, '2022-06-15', '192', 2022, 2023);
(1002, 'FGHIJ5678K', 'Corp B', 'DTAN002', 'Salary', 4500.00, '2022-09-23', '192', 2022, 2023);

-- TCS
INSERT INTO TCS (TCS_Certificate_Number, PAN, Seller_Name, Seller_TAN, TCS_Amount, Date_of_Collection, Section_Code, Start_Year, End_Year) VALUES
(2001, 'FGHIJ5678K', 'Shop A', 'STAN001', 200.00, '2022-06-20', '206C', 2022, 2023);

-- Goods
INSERT INTO Goods (TCS_Certificate_Number, Goods_Type) VALUES
(2001, 'Electronics'),
(2001, 'Furniture');

-- ITR
INSERT INTO ITR (Acknowledgement_Number, PAN, Age, Tax_Payer_Category, Submission_Date, Regime, Due_Date, Start_Year, End_Year,Total_Taxable_Income, Total_Tax_Paid, Status) VALUES
(3001, 'ABCDE1234F', 33, 'Individual', '2023-07-01', 'New', '2022-07-31', 2022,2023, 49124.45, 50000.00, 'Processed');

-- Is_penaliser
INSERT INTO Is_penaliser (Acknowledgement_Number, Penalty, PAN) VALUES
(3001, 244.40, 'ABCDE1234F');

-- Corresponding_Slabs
INSERT INTO Corresponding_Slabs (Acknowledgement_Number, Slab_ID, Amount) VALUES
(3001, 1, 250000.00),
(3001, 2, 249999.00);
(3001, 2, 395001.00);

-- Income_Details
INSERT INTO Income_Details (Acknowledgement_Number, PAN, Start_Year,End_Year,Salary_Income, Business_Income, Capital_Gain, House_Property_Income, Agriculture_Income, Other_Income_Total,Total_income) VALUES
(3001, 'ABCDE1234F', 2022,2023, 800000.00, 50000.00, 20000.00, 10000.00, 5000.00, 10000.00,895000.00);

-- Other_Income
INSERT INTO Other_Income (Acknowledgement_Number, Income_source) VALUES
(3001, 'Interest Income'),
(3001, 'Dividend');

-- Deduction_limit
INSERT INTO Deduction_limit (Deduction_Type, Max_allowable_limit) VALUES
('80C',100000000.00),
('80D',100000000.00);

-- Deduction
INSERT INTO Deduction (Acknowledgement_Number, Deduction_Type, Deduction_Amount) VALUES
(3001, '80C', 100000.00),
(3001, '80D', 20000.00);

-- Sections
INSERT INTO Sections (Acknowledgement_Number, Deduction_Type, Section_Code) VALUES
(3001, '80C', '80C'),
(3001, '80D', '80D');

-- Tax_Verification
INSERT INTO Tax_Verification (Acknowledgement_Number, Bank_Account_Number, Status, Start_Year,End_Year, Requested_Date, Processed_Date, Tax_Amount, Tax_Paid, IFSC_Code) VALUES
(3001, '123456789123', 'Completed', 2022,2023, '2022-08-01', '2022-08-05', 49124.45, 50000.00, 'IFSC001');

-- Refund_details
INSERT INTO Refund_details (Acknowledgement_Number, Refund_amount, Refund_status) VALUES
(3001, 875.55, 'Done');

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
      DELETE FROM Corresponding_Slabs WHERE Acknowledgement_Number = ack_no;
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


-- DELIMITER $$

-- CREATE TRIGGER after_itr_insert
-- AFTER INSERT ON Income_Details
-- FOR EACH ROW
-- BEGIN
--     -- Call the stored procedure to calculate slabs for the inserted ack_no
--     CALL calculate_slabs_for_itr(NEW.Acknowledgement_Number);
-- END$$

-- DELIMITER ;



DELIMITER $$

 -- INSERT TRIGGER FOR TAX VERIFICATION
CREATE TRIGGER after_tax_verification_insert
AFTER INSERT ON Tax_Verification
FOR EACH ROW
BEGIN
    IF NEW.Tax_Paid > NEW.Tax_Amount THEN
        INSERT INTO Refund_details (Acknowledgement_Number, Refund_amount, Refund_status)
        VALUES (
            NEW.Acknowledgement_Number,
            ABS(NEW.Tax_Paid - NEW.Tax_Amount),
            'Pending' 
        );
    END IF;
END$$

DELIMITER ;


DELIMITER $$
-- UPDATE TRIGGER FOR TAX VERIFICATION
CREATE TRIGGER after_tax_verification_update
AFTER UPDATE ON Tax_Verification
FOR EACH ROW
BEGIN
    IF NEW.Tax_Paid > NEW.Tax_Amount AND (NEW.Tax_Paid != OLD.Tax_Paid OR NEW.Tax_Amount != OLD.Tax_Amount) THEN
        INSERT INTO Refund_details (Acknowledgement_Number, Refund_amount, Refund_status)
        VALUES (
            NEW.Acknowledgement_Number,
            ABS(NEW.Tax_Paid - NEW.Tax_Amount),
            'Pending' 
        );
    END IF;
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

DELIMITER $$

CREATE TRIGGER update_total_income_before_update
BEFORE UPDATE ON Income_Details
FOR EACH ROW
BEGIN
    -- Calculate the Total_income before the insert
    SET NEW.Total_income = NEW.Salary_Income + NEW.Business_Income + NEW.Capital_Gain +
                           NEW.House_Property_Income + NEW.Agriculture_Income + NEW.Other_Income_Total;
END$$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE calculate_total_tax(IN ack_no INT)
BEGIN
    DECLARE total_slab_tax DECIMAL(15, 2) DEFAULT 0;
    DECLARE tcs_amount DECIMAL(15, 2) DEFAULT 0;
    DECLARE tds_amount DECIMAL(15, 2) DEFAULT 0;
    DECLARE total_tax DECIMAL(15, 2) DEFAULT 0;
    DECLARE pan_card VARCHAR(15);
    DECLARE itr_start_year YEAR;
    DECLARE itr_end_year YEAR;
    DECLARE bankaccountnumber VARCHAR(20);
    DECLARE ifsccode VARCHAR(11);
    DECLARE requesteddate DATE;
    DECLARE duedate DATE;
    DECLARE taxpaid DECIMAL(15, 2);
    DECLARE penalties DECIMAL(15, 2 ) DEFAULT 0;

    -- Fetch PAN, Start_Year, End_Year, Requested_Date, and Tax_Paid from the ITR table
    SELECT PAN, Start_Year, End_Year, Submission_Date, Total_Tax_Paid ,Due_Date
    INTO pan_card, itr_start_year, itr_end_year, requesteddate, taxpaid ,duedate
    FROM ITR
    WHERE Acknowledgement_Number = ack_no;

    -- Call procedure to calculate slabs
    CALL calculate_slabs_for_itr(ack_no);

    -- Calculate tax for all slabs for the given acknowledgment number
    SELECT 
        SUM((Amount * Tax_Rate / 100) + ((Amount * Tax_Rate / 100) * CESS_Rate / 100)) 
    INTO total_slab_tax
    FROM 
        Corresponding_Slabs cs
    JOIN 
        Slabs s ON cs.Slab_ID = s.Slab_ID
    WHERE 
        cs.Acknowledgement_Number = ack_no;

    -- Fetch TCS amount for the given PAN card number and matching year range
    SELECT COALESCE(SUM(t.TCS_Amount), 0)
    INTO tcs_amount
    FROM TCS AS t
    WHERE t.PAN = pan_card
    AND t.Start_Year >= itr_start_year
    AND t.End_Year <= itr_end_year;

    -- Fetch TDS amount for the given PAN card number and matching year range
    SELECT COALESCE(SUM(d.TDS_Amount), 0)
    INTO tds_amount
    FROM TDS AS d
    WHERE d.PAN = pan_card
    AND d.Start_Year >= itr_start_year
    AND d.End_Year <= itr_end_year;

    -- Calculate the total tax
    IF total_slab_tax - tcs_amount - tds_amount > 0 THEN
       SET total_tax = total_slab_tax - tcs_amount - tds_amount;
    END IF;

    -- Update the Total_Taxable_Income field in the ITR table
    -- UPDATE ITR
    -- SET Total_Taxable_Income = total_tax
    -- WHERE Acknowledgement_Number = ack_no;

    -- Fetch Bank Account Details for the given PAN card
    SELECT Bank_Account_Number, IFSC
    INTO bankaccountnumber, ifsccode
    FROM Assessee_Bank_Details
    WHERE PAN = pan_card;
    DELETE FROM Tax_Verification WHERE Acknowledgement_Number = ack_no;

    -- Insert data into Tax_Verification table
    INSERT INTO Tax_Verification (
        Acknowledgement_Number,
        Bank_Account_Number,
        Status,
        Start_Year,
        Requested_Date,
        -- Processed_Date,
        Tax_Amount,
        Tax_Paid,
        IFSC_Code
    )
    VALUES (
        ack_no,
        bankaccountnumber,
        'Pending', -- Default status
        itr_start_year,
        requesteddate,
        -- CURDATE(), -- Processed_Date is current date
        total_tax,
        taxpaid,
        ifsccode
    );

    DELETE FROM Is_penaliser WHERE Acknowledgement_Number = ack_no AND PAN = pan_card;

    IF requesteddate > duedate THEN
        -- Calculate penalties if the condition is true
        SET penalties = 0.005 * total_tax;
        SET total_tax = total_tax + penalties;
    END IF;

    IF taxpaid < total_tax THEN
        -- Calculate penalties if the condition is true
        SET penalties = 0.005 * total_tax + total_tax - taxpaid;
    END IF;


    INSERT INTO Is_penaliser(Acknowledgement_Number, Penalty,PAN)
    VALUES (ack_no,penalties,pan_card);
    

    UPDATE ITR
    SET Total_Taxable_Income = total_tax
    WHERE Acknowledgement_Number = ack_no;
    -- Display the acknowledgment number and total tax
    -- SELECT 
    --     ack_no AS Acknowledgement_Number,  
    --     total_tax AS Total_Tax;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_refund_status_update
AFTER UPDATE ON Refund_details
FOR EACH ROW
BEGIN
    -- Check if the Refund_status is updated to 'Done'
    IF NEW.Refund_status = 'Done' THEN
        -- Update the Status and Processed_Date in the Tax_Verification table
        UPDATE Tax_Verification
        SET Status = 'Done',
            Processed_Date = CURDATE()
        WHERE Acknowledgement_Number = NEW.Acknowledgement_Number;
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER update_is_defaulter
AFTER INSERT ON Transactions_Involving_Non_Assessee
FOR EACH ROW
BEGIN
    -- Declare a variable to store the cumulative transaction amount for the non-assessee
    DECLARE total_amount DECIMAL(15, 2);

    -- Calculate the total transaction amount for the involved bank account
    SELECT SUM(Bank_Transactions.Transaction_Amount) INTO total_amount
    FROM Bank_Transactions
    INNER JOIN Transactions_Involving_Non_Assessee
    ON Bank_Transactions.Transaction_ID = Transactions_Involving_Non_Assessee.Transaction_Number
    WHERE Transactions_Involving_Non_Assessee.Bank_Account_Number = NEW.Bank_Account_Number;

    -- Check if the total exceeds the threshold
    IF total_amount > 250000 THEN
        -- Update the defaulter status in the Non_Assessee_with_PAN table
        UPDATE Non_Assessee_with_PAN
        SET Is_tax_defaulter = TRUE
        WHERE PAN = (SELECT PAN
                     FROM Non_Assessee_Bank_Details
                     WHERE Bank_Account_Number = NEW.Bank_Account_Number);
    END IF;
END$$

DELIMITER ;


-- -- Insert transactions
-- INSERT INTO Bank_Transactions (Transaction_ID, Transaction_Type, Sender_Account_Number, Receiver_Account_Number, Transaction_Amount)
-- VALUES 
-- (5, 'Transfer', 'ACC000001', 'ACC123456', 5000.00),
-- (6, 'Transfer', 'ACC000002', 'ACC123456', 3000.00),
-- (7, 'Transfer', 'ACC000003', 'ACC123456', 4000.00);

-- -- Link transactions with the non-assessee's bank account
-- INSERT INTO Transactions_Involving_Non_Assessee (Transaction_Number, Bank_Account_Number)
-- VALUES 
-- (5, 'ACC123456'),
-- (6, 'ACC123456'),
-- (7, 'ACC123456');


DELIMITER $$

CREATE TRIGGER after_insert_Income_Details
AFTER INSERT ON Income_Details
FOR EACH ROW
BEGIN
    CALL calculate_total_tax(NEW.Acknowledgement_Number);
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_update_Income_Details
AFTER UPDATE ON Income_Details
FOR EACH ROW
BEGIN
    CALL calculate_total_tax(NEW.Acknowledgement_Number);
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_insert_Deduction
AFTER INSERT ON Deduction
FOR EACH ROW
BEGIN
    CALL calculate_total_tax(NEW.Acknowledgement_Number);
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_update_Deduction
AFTER UPDATE ON Deduction
FOR EACH ROW
BEGIN
    CALL calculate_total_tax(NEW.Acknowledgement_Number);
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER after_insert_Slabs
AFTER INSERT ON Slabs
FOR EACH ROW
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE ack_no INT;
    DECLARE ack_cursor CURSOR FOR SELECT Acknowledgement_Number FROM ITR;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN ack_cursor;

    read_loop: LOOP
        FETCH ack_cursor INTO ack_no;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Call calculate_total_tax for each acknowledgment number
        CALL calculate_total_tax(ack_no);
    END LOOP;

    CLOSE ack_cursor;
END$$

DELIMITER $$

CREATE TRIGGER after_update_Slabs
AFTER UPDATE ON Slabs
FOR EACH ROW
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE ack_no INT;
    DECLARE ack_cursor CURSOR FOR SELECT Acknowledgement_Number FROM ITR;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN ack_cursor;

    read_loop: LOOP
        FETCH ack_cursor INTO ack_no;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Call calculate_total_tax for each acknowledgment number
        CALL calculate_total_tax(ack_no);
    END LOOP;

    CLOSE ack_cursor;
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER after_insert_TCS
AFTER INSERT ON TCS
FOR EACH ROW
BEGIN
    DECLARE ack_no INT;

    -- Fetch Acknowledgement_Number from ITR based on PAN from TCS
    SELECT Acknowledgement_Number
    INTO ack_no
    FROM ITR
    WHERE PAN = NEW.PAN;

    IF ack_no IS NOT NULL THEN
        CALL calculate_total_tax(ack_no);
    END IF;
END$$

DELIMITER $$

CREATE TRIGGER after_update_TCS
AFTER UPDATE ON TCS
FOR EACH ROW
BEGIN
    DECLARE ack_no INT;

    -- Fetch Acknowledgement_Number from ITR based on PAN from TCS
    SELECT Acknowledgement_Number
    INTO ack_no
    FROM ITR
    WHERE PAN = NEW.PAN;

    IF ack_no IS NOT NULL THEN
        CALL calculate_total_tax(ack_no);
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_insert_TDS
AFTER INSERT ON TDS
FOR EACH ROW
BEGIN
    DECLARE ack_no INT;

    -- Fetch Acknowledgement_Number from ITR based on PAN from TDS
    SELECT Acknowledgement_Number
    INTO ack_no
    FROM ITR
    WHERE PAN = NEW.PAN;

    IF ack_no IS NOT NULL THEN
        CALL calculate_total_tax(ack_no);
    END IF;
END$$

DELIMITER $$

CREATE TRIGGER after_update_TDS
AFTER UPDATE ON TDS
FOR EACH ROW
BEGIN
    DECLARE ack_no INT;

    -- Fetch Acknowledgement_Number from ITR based on PAN from TDS
    SELECT Acknowledgement_Number
    INTO ack_no
    FROM ITR
    WHERE PAN = NEW.PAN;

    IF ack_no IS NOT NULL THEN
        CALL calculate_total_tax(ack_no);
    END IF;
END$$

DELIMITER ;
