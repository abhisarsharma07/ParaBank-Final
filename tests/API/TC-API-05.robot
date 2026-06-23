*** Settings ***
Resource    ../../resources/common_resources.robot
Resource    ../../resources/Pages/API_Keywords.robot
Suite Setup     Launch Application
Suite Teardown  Close Application
**** Test Cases ***
TC-API-05: Validate Account Balance Matches Creation Response via API
    Ensure User Is Logged In
    Get Customer ID From Login
    Get Accounts List By Customer Id
    Create New Account via API
    Validate Account Balance Via API