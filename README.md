# Income Tax Management CLI

## Overview
The Income Tax Management CLI is a command-line interface tool designed to manage various aspects of income tax records. It allows users to insert, update, delete, and retrieve information related to assessees, income tax returns (ITR), slabs, and transactions. The tool supports role-based access control, with different commands available to Admins and regular Users.

## Commands

### Admin Commands
- `execute_custom_sql`: Execute a custom SQL query.
- `insert_ITR`: Insert a new Income Tax Return (ITR).
- `insert_assessee`: Insert a new assessee (individual or company).
- `insert_slabs`: Insert new tax slabs.
- `update_address`: Update an assessee's address.
- `update_tax_rate`: Update tax rate in slabs table.
- `update_salary`: Update an assessee's salary.
- `delete_assessee`: Delete an assessee.
- `delete_tds`: Delete a TDS record.
- `retrieve_slabs`: Retrieve all slabs with tax and CESS rates.
- `retrieve_transactions`: Retrieve transactions for a specific assessee.
- `find_highest_tax_income`: Find assessees with the highest taxable income.
- `exit`: Exit the program.

### User Commands
- `insert_assessee`: Insert a new assessee (individual or company).
- `insert_ITR`: Insert a new Income Tax Return (ITR).
- `retrieve_slabs`: Retrieve all slabs with tax and CESS rates.
- `retrieve_transactions`: Retrieve transactions for a specific assessee.
- `update_address`: Update an assessee's address.
- `update_salary`: Update an assessee's salary.
- `exit`: Exit the program.

## Roles
- **Admin**: Has access to all commands, including custom SQL execution and deletion of records.
- **User**: Has limited access to commands, primarily for inserting and retrieving records.

## Getting Started
### Installation
1. **Install dependencies**:
    ```sh
    pip install -r requirements.txt
    ```

2. **Import the database**:
    ```sh
    mysql -u your_username -p 
    source <path to populate_ordered.sql>
    source <path to data_insert1.sql>
    ```

3. **Run the script**:
    ```sh
    python script.py
    ```

### Usage
1. **Start the CLI**:
    ```sh
    python script.py
    ```

2. **Enter your database credentials**:
    - Username
    - Password

3. **Follow the on-screen menu to execute commands based on your role**.
