*** Settings ***
Resource    ../../resources/common_resources.robot
Resource    ../../resources/Pages/API_Keywords.robot
Suite Setup     Launch Application
Suite Teardown  Close Application
*** Test Cases ***
TC-API-04: Validate Account Type Matches UI Input
    Ensure User Is Logged In
    Get Customer ID From Login
    Get Account ID via API
    Validate Account Type Matches UI Input
