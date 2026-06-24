*** Settings ***
Resource    ../../resources/common_resources.robot
Resource    ../../resources/Pages/API_Keywords.robot

Suite Setup     Launch Application
Suite Teardown  Close Application
*** Test Cases ***
TC-API-06: Validate Balance Update After Transfer
    Ensure User Is Logged In
    Get Customer ID From Login
    Get Accounts List By Customer Id
    ${account_id}=    Create New Account Via API
    Log To Console    Final New Account ID: ${account_id}
    Validate Balance Update After Transfer
