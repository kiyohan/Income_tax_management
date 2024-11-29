import pymysql
from termcolor import colored
from tabulate import tabulate
import os
import getpass 

connection = None
cursor = None

# Establish a database connection
def db_connect(username, password):
    global connection, cursor
    connection = pymysql.connect(
        host='localhost',
        user=username,
        password=password
    )
    cursor = connection.cursor()

# Initialize the database
def db_init():
    global cursor
    cursor.execute('CREATE DATABASE IF NOT EXISTS Taxation_System')
    cursor.execute('USE Taxation_System')

# Close the database connection
def db_close():
    global connection
    connection.close()

# Execute a query and retrieve results
def db_query(query):
    global cursor
    cursor.execute(query)
    cursor.connection.commit()
    data = cursor.fetchall()
    headers = [desc[0] for desc in cursor.description] if cursor.description else []
    return data, headers

# Clear the console
def clear_console():
    os.system('cls' if os.name == 'nt' else 'clear')

ADMIN_USERNAMES = {"arman", "kiyohan" ,"rohan_DNA"}

def get_user_role(username):
    return "Admin" if username in ADMIN_USERNAMES else "User"

# Print the help menu
def print_help(role):
    admin_commands = [
        ("execute_custom_sql", "Execute a custom SQL query"),
        ("insert_ITR", "Insert a new ITR"),
        ("insert_assessee", "Insert a new assessee"),
        ("insert_slabs", "Insert into slabs table"),
        ("insert_income_details", "Insert a new income details"),
        ("update_address", "Update an assessee's address"),
        ("update_tax_rate", "Update tax rate in slabs table"),
        ("update_salary", "Updates an assessee's salary."),
        ("delete_assessee", "Delete an assessee"),
        ("delete_tds", "Delete a TDS record"),
        ("retrieve_slabs", "Retrieve all slabs with tax and CESS rates"),
        ("retrieve_transactions", "Retrieve transactions for a specific assessee"),
        ("find_highest_tax_income", "Find assessees with the highest taxable income"),
        ("exit", "Exit the program"),
    ]

    user_commands = [
        ("insert_assessee", "Insert a new assessee"),
        ("insert_ITR", "Insert a new ITR"),
        ("insert_income_details", "Insert a new income details"),
        ("retrieve_slabs", "Retrieve all slabs with tax and CESS rates"),
        ("retrieve_transactions", "Retrieve transactions for a specific assessee"),
        ("update_address", "Update an assessee's address"),
        ("update_salary", "Updates an assessee's salary."),
        ("exit", "Exit the program"),
    ]

    # Choose commands based on role
    commands = admin_commands if role == "Admin" else user_commands
    return commands

# Display menu and enforce access control
def show_menu(role):
    commands = print_help(role)
    print(colored(f"\n{role} Menu:", "yellow", attrs=["bold"]))
    for idx, (cmd, desc) in enumerate(commands, start=1):
        print(f"  {colored(f'{idx}. {cmd}', 'green')} - {desc}")
    print()

    while True:
        choice = input(colored("Enter your choice (number or command): ", "cyan"))
        if choice.isdigit() and 1 <= int(choice) <= len(commands):
            return commands[int(choice) - 1][0]
        elif any(choice == cmd for cmd, _ in commands):
            return choice
        else:
            print(colored("Invalid choice. Please try again.", "red"))

# Display query results in tabular format
def display_table(data, headers):
    if not data:
        print(colored("No data found.", "yellow"))
    else:
        print(colored(tabulate(data, headers=headers, tablefmt="grid"), "white"))


# Main logic
clear_console()
print(colored("Welcome to the Taxation System", "yellow", attrs=["bold"]))
print("Please enter your database credentials.")

username = input(colored("Username: ", "cyan"))
password = getpass.getpass(colored("Password: ", "cyan"))

is_admin = username in ADMIN_USERNAMES
try:
    db_connect(username, password)
    db_init()
    clear_console()
    print(colored("Database initialized successfully!", "green", attrs=["bold"]))
except Exception as e:
    print(colored(f"Error: {e}", "red", attrs=["bold"]))
    exit()

# Determine user role
role = get_user_role(username)
print(colored(f"Logged in as {role}.", "blue", attrs=["bold"]))

while True:
    commands = print_help(role)
    query = show_menu(role)

    if query == 'exit':
        print(colored("Exiting... Goodbye!", "yellow", attrs=["bold"]))
        break

    # Only Admins can execute restricted queries
    if role != "Admin" and query in {'insert_slabs', 'update_tax_rate', 'delete_assessee', 'delete_tds', 'find_highest_tax_income', 'execute_custom_sql'}:
        print(colored("You do not have permission to execute this query.", "red"))
        continue


    elif query == 'insert_assessee':
        print(colored("Enter the following details to insert a new assessee:", "cyan"))
        is_individual = input("Enter 'Y' for individual and 'N' for company: ")
        if is_individual == 'Y':
            PAN = input("  PAN: ")
            Address = input("  Address: ")
            Phone = input("  Phone: ")
            Filing_Status = input("  Filing Status: ")
            
            ans = input('Are you representative of any other assessee? enter Y/N :')
            if ans == 'Y':
                Representative_PAN = input("  Representative PAN: ")

            FirstName = input("  First Name: ")
            MiddleName = input("  Middle Name: ")
            LastName = input("  Last Name: ")
            DOB = input("  Date of Birth(YYYY-MM-DD): ")
            Gender = input("Gender(M/F): ")
            Residence_Status = input("Residence Status: ")
            Aadhar = input("Aadhar Number: ")
            
            if ans == 'Y':
                query = f'''
                    INSERT INTO Assessee (PAN, Address, Phone, Filing_Status, Representative_PAN)
                    VALUES ("{PAN}", "{Address}", "{Phone}", "{Filing_Status}", "{Representative_PAN}")
                '''
            else:
                query = f'''
                    INSERT INTO Assessee (PAN, Address, Phone, Filing_Status)
                    VALUES ("{PAN}", "{Address}", "{Phone}", "{Filing_Status}")
                '''

            query2 = f'''
                INSERT INTO Individual_Assessee (PAN, First_Name, Middle_Name, Last_Name, DOB, Gender, Residency_Status, Aadhar_Number)
                VALUES ("{PAN}", "{FirstName}", "{MiddleName}", "{LastName}", "{DOB}", "{Gender}", "{Residence_Status}", "{Aadhar}")
            '''

        if is_individual == 'N':
            PAN = input("  PAN: ")
            Address = input("  Address: ")
            Phone = input("  Phone: ")
            Filing_Status = input("  Filing Status: ")
            Representative_PAN = input("  Representative PAN: ")

            Company_Name = input("  Company Name: ")
            Registration_Number = input("  Registration Number: ")
            Incorporation_Date = input("  Incorporation Date(YYYY-MM-DD): ")

            query = f'''
                INSERT INTO Assessee (PAN, Address, Phone, Filing_Status, Representative_PAN)
                VALUES ("{PAN}", "{Address}", "{Phone}", "{Filing_Status}", "{Representative_PAN}")
            '''

            query2 = f'''
                INSERT INTO Corporate_Assessee (PAN, Company_Name, Registration_Number, Date_of_Incorporation)
                VALUES ("{PAN}", "{Company_Name}", "{Registration_Number}", "{Incorporation_Date}")
            '''

        try:
            db_query(query)
            print(colored("Assessee inserted successfully.", "green"))
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

        try:
            db_query(query2)
            print(colored("Individual/ Corporate Assessee inserted successfully.", "green"))
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

    elif query == 'update_address':
        PAN = input("Enter the PAN of the assessee: ")
        Address = input("Enter the new address: ")
        query = f'''
            UPDATE Assessee
            SET Address = "{Address}"
            WHERE PAN = "{PAN}"
        '''
        try:
            db_query(query)
            print(colored("Address updated successfully.", "green"))
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

    elif query == 'update_salary':
        Ack_no=input("Enter Acknowledgement No: ")
        Salary = input("Enter the new salary: ")
        query = f'''
            UPDATE Income_Details
            SET Salary_Income = "{Salary}"
            WHERE Acknowledgement_Number = "{Ack_no}"
        '''

        try:
            db_query(query)
            print(colored("Salary updated successfully.", "green"))
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

    elif query == 'delete_assessee' and is_admin:
        PAN = input("Enter the PAN of the assessee to delete: ")
        query = f'''
            DELETE FROM Assessee
            WHERE PAN = "{PAN}"
        '''
        try:
            db_query(query)
            print(colored("Assessee deleted successfully.", "green"))
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

    elif query == 'insert_slabs' and is_admin:
        print(colored("Enter the following details to insert into slabs table:", "cyan"))
        Slab_ID = input("  Slab ID: ")
        Minimum_Income = input("  Minimum Income: ")
        Maximum_Income = input("  Maximum Income: ")
        Tax_Rate = input("  Tax Rate: ")
        CESS_Rate = input("  CESS Rate: ")
        Effective_from = input("  Effective from: ")
        Effective_to = input("  Effective to: ")
        query = f'''
            INSERT INTO Slabs (Slab_ID, Minimum_Income, Maximum_Income, Tax_Rate, CESS_Rate, Effective_from, Effective_to)
            VALUES ("{Slab_ID}", "{Minimum_Income}", "{Maximum_Income}", "{Tax_Rate}", "{CESS_Rate}", "{Effective_from}", "{Effective_to}")
        '''

        try:
            db_query(query)
            print(colored("Slabs inserted successfully.", "green"))
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

    elif query == 'retrieve_slabs':
        query = 'SELECT * FROM Slabs'
        try:
            data, headers = db_query(query)
            print(colored("Slabs Table:", "green"))
            display_table(data, headers)
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

    elif query == 'update_tax_rate' and is_admin:
        Slab_ID = input("Enter the Slab ID to update: ")
        Tax_Rate = input("Enter the new Tax Rate: ")
        query = f'''
            UPDATE Slabs
            SET Tax_Rate = "{Tax_Rate}"
            WHERE Slab_ID = "{Slab_ID}"
        '''
        try:
            db_query(query)
            print(colored("Tax Rate updated successfully.", "green"))
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

    elif query == 'insert_ITR':
        print('Enter the following details')
        Acknowledgement_no = input('Acknowledgement_no: ')
        PAN = input('PAN: ')
        Tax_Payer_Category = input('Tax_Payer_Category: ')
        Submission_date = input('Submission_date(YYYY-MM-DD): ')
        Regime = input('Regime: ')
        Due_date = input('Due_date(YYYY-MM-DD): ')
        Start_Year = input('Start_Year: ')
        End_Year = input('End_Year: ')
        Total_Tax_Paid = input('Total_Tax_Paid: ')
        age_query = f'SELECT YEAR(CURDATE()) - YEAR(dob) - (RIGHT(CURDATE(), 5) < RIGHT(dob, 5)) FROM Individual_Assessee WHERE PAN = "{PAN}"'
        age_result = db_query(age_query)
        Age = age_result[0][0] if age_result else None
        Age = int(Age[0])
        if Age is None:
            print('Error: PAN not found in Individual_Assessee table')
            continue
        query = f'''
            INSERT INTO ITR (Acknowledgement_Number, PAN, Age, Tax_Payer_Category, Submission_Date, Regime, Due_Date, Start_Year, End_Year, Total_Tax_Paid, Status)
            VALUES ("{Acknowledgement_no}", "{PAN}", {Age}, "{Tax_Payer_Category}", "{Submission_date}", "{Regime}", "{Due_date}", "{Start_Year}", "{End_Year}", "{Total_Tax_Paid}", "Pending")
        '''

        try:
            db_query(query)
            print(colored("ITR inserted successfully.", "green"))
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

    elif query == 'insert_income_details':
        print('Enter the following details')
        Acknowledgement_no = input('Acknowledgement_no: ')
        PAN = input('PAN: ')
        Start_Year = input('Start_Year: ')
        End_Year = input('End_Year: ')
        Salary_Income = input('Salary_Income: ')
        Business_Income = input('Business_Income: ')
        Capital_Gain = input('Capital_Gains: ')
        House_Property_Income = input('House_Property_Income: ')
        Agriculture_Income = input('Agriculture_Income: ')
        Other_Incomes = input("Whether any other income? (Y/N): ")
        if Other_Incomes == 'N':
            Other_Income_Total = 0
        elif Other_Incomes == 'Y':
            Other_Income_Total = input('Other_Income_Total: ')
        
        query = f'''
            INSERT INTO Income_Details (Acknowledgement_Number, PAN, Start_Year, End_Year, Salary_Income, Business_Income, Capital_Gain, House_Property_Income, Agriculture_Income, Other_Income_Total)
            VALUES ("{Acknowledgement_no}", "{PAN}", "{Start_Year}", "{End_Year}", "{Salary_Income}", "{Business_Income}", "{Capital_Gain}", "{House_Property_Income}", "{Agriculture_Income}", "{Other_Income_Total}")
        '''

        if Other_Incomes == 'Y':
            Other_Income = input('Other_Income: ')
            query2 = f'''
                INSERT INTO Other_Income (Acknowledgement_Number, Income_source)
                VALUES ("{Acknowledgement_no}", "{Other_Income}")
            '''
            try:    
                db_query(query2)
                print(colored("Other Income Details inserted successfully.", "green"))
            except Exception as e:
                print(colored(f"Error: {e}", "red"))

        try:
            db_query(query)
            print(colored("Income Details inserted successfully.", "green"))
        except Exception as e:
            print(colored(f"Error: {e}", "red"))


    elif query == 'find_highest_tax_income' and is_admin:
        query = '''
            SELECT PAN, Total_Taxable_Income FROM ITR
            ORDER BY Total_Taxable_Income DESC LIMIT 5
        '''
        try:
            data, headers = db_query(query)
            print(colored("Top 5 Assessees by Taxable Income:", "cyan"))
            display_table(data, headers)
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

    elif query == 'retrieve_transactions':
        Transaction_ID = input("Enter the Transaction ID: ")
        query = f'''
            SELECT * FROM Bank_Transactions
            WHERE Transaction_ID = "{Transaction_ID}"
        '''
        try:
            data, headers = db_query(query)
            print(colored("Transaction Details:", "cyan"))
            display_table(data, headers)
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

    elif query == 'delete_tds' and is_admin:
        TDS_Certificate_Number = input("Enter the TDS Certificate Number to delete: ")
        query = f'''
            DELETE FROM TDS
            WHERE TDS_Certificate_Number = "{TDS_Certificate_Number}"
        '''
        try:
            db_query(query)
            print(colored("TDS record deleted successfully.", "green"))
        except Exception as e:
            print(colored(f"Error: {e}", "red"))

    elif query == 'execute_custom_sql' and is_admin:
        print(colored("Enter your custom SQL query:", "cyan"))
        custom_sql = input("SQL Query: ")
        try:
            data, headers = db_query(custom_sql)
            print(colored("Query executed successfully.", "green"))
            print(colored("Results:", "cyan"))
            display_table(data, headers)
        except Exception as e:
            print(colored(f"Error executing query: {e}", "red"))
    

    else:
        print(colored("Command not yet implemented.", "red"))

    
try:
    db_close()
except Exception as e:
    print(colored(f"Error closing database: {e}", "red"))
