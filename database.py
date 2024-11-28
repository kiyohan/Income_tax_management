import pymysql

connection = None
cursor = None

def db_connect(username, password):
    global connection, cursor
    connection = pymysql.connect(
        host='localhost',
        user=username,
        password=password
    )
    cursor = connection.cursor()

def db_init():
    global cursor
    # create database if not exists
    cursor.execute('CREATE DATABASE IF NOT EXISTS Taxation_System')
    cursor.execute('USE Taxation_System')
    # run a sql file to create tables
    # with open('populate_ordered.sql', 'r') as file:
    #     sql = file.read()
    #     cursor.execute(sql)
    # connection.commit()

def db_close():
    global connection
    connection.close()

def db_query(query):
    global cursor
    cursor.execute(query)
    cursor.connection.commit()
    return cursor.fetchall()

def print_help():
    print('Commands:')
    print('help: print this help message')
    print('insert_ITR: insert a new ITR')
    print('insert_assessee: insert a new assessee')
    print('insert_individual_assessee: insert a new individual assessee')
    print('insert_slabs: insert into slabs table')
    print('update_address: update assessee\'s address')
    print('update_tax_rate: update tax rate in slabs table')
    print('delete_assessee: delete an assessee')
    print('delete_tds: delete a TDS record')
    print('retrieve_slabs: retrieve all slabs with tax and CESS rate')
    print('retrieve_transactions: retrieve transactions for a specific assessee')
    print('find_highest_tax_income: find assessees with highest taxable income')
    print('retrieve_tax_defaults: retrieve all assessees with tax defaults')
    print('update_penalty: update the penalty based on tax paid')
    print('exit: exit the program')

print('Welcome to the Taxation System')
print('Please enter your username and password')
username = input('Username: ')
password = input('Password: ')

db_connect(username, password)
db_init()

print('Database initialized successfully')
print('For help, type "help"')

while True:
    query = input('Enter query: ')

    if query == 'exit':
        break
    elif query == 'help':
        print_help()
    elif query == 'insert_assessee':
        # code to insert into Assessee table
        pass
    elif query == 'insert_individual_assessee':
        # code to insert into Individual_Assessee table
        pass
    elif query == 'insert_slabs':
        # code to insert into Slabs table
        pass
    elif query == 'update_address':
        # code to update address in Assessee table
        pass
    elif query == 'update_tax_rate':
        # code to update tax rate in Slabs table
        pass
    elif query == 'delete_assessee':
        # code to delete an assessee
        pass
    elif query == 'delete_tds':
        # code to delete a TDS record
        pass
    elif query == 'retrieve_slabs':
        # code to retrieve all slabs with tax and CESS rate
        pass
    elif query == 'retrieve_transactions':
        # code to retrieve transactions for a specific assessee
        pass
    elif query == 'find_highest_tax_income':
        # code to find assessees with highest taxable income
        pass
    elif query == 'retrieve_tax_defaults':
        # code to retrieve all assessees with tax defaults
        pass
    elif query == 'update_penalty':
        # code to update the penalty based on tax paid
        pass
    elif query == 'insert_ITR':
        print('Enter the following details')
        Acknowledgement_no = input('Acknowledgement_no: ')
        PAN = input('PAN: ')
        Tax_Payer_Category = input('Tax_Payer_Category: ')
        Submission_date = input('Submission_date: ')
        Regime = input('Regime: ')
        Due_date = input('Due_date: ')
        Start_Year = input('Start_Year: ')
        Total_Taxable_Income = input('Total_Taxable_Income: ')
        Total_Tax_Paid = input('Total_Tax_Paid: ')
        age_query = f'SELECT YEAR(CURDATE()) - YEAR(dob) - (RIGHT(CURDATE(), 5) < RIGHT(dob, 5)) FROM Individual_Assessee WHERE PAN = "{PAN}"'
        age_result = db_query(age_query)
        Age = age_result[0][0] if age_result else None
        if Age is None:
            print('Error: PAN not found in Individual_Assessee table')
            continue
        query = f'''
            INSERT INTO ITR (Acknowledgement_Number, PAN, Age, Tax_Payer_Category, Submission_Date, Regime, Due_Date, Start_Year, Total_Taxable_Income, Total_Tax_Paid, Status)
            VALUES ("{Acknowledgement_no}", "{PAN}", {Age}, "{Tax_Payer_Category}", "{Submission_date}", "{Regime}", "{Due_date}", "{Start_Year}", "{Total_Taxable_Income}", "{Total_Tax_Paid}", "Pending")
        '''
    else:
        print('Invalid query')

    try:
        result = db_query(query)
        print('Query executed successfully')
        print(result)
    except Exception as e:
        print(e)

db_close()
