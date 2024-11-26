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
    print('ITR: insert a new ITR')
    print('query: run a query on the database')
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
    keyword = input('Enter command: ')
    if keyword == 'exit':
        break
    elif keyword == 'help':
        print_help()
    elif keyword == 'query':
        query = input('Enter query: ')
        if query == 'ITR':
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
            # also we need to derive Age from Individual_Assessee table form dob and insert it into ITR table
            age_query = f'SELECT YEAR(CURDATE()) - YEAR(dob) - (RIGHT(CURDATE(), 5) < RIGHT(dob, 5)) FROM Individual_Assessee WHERE PAN = "{PAN}"'
            age_result = db_query(age_query)
            Age = age_result[0][0] if age_result else None
            print(Age)
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
            result=db_query(query)
            print('Query executed successfully')
            print(result)
        except Exception as e:
            print(e)
    else:
        print('Invalid command')

db_close()

