*** Settings ***
Resource    ../../resources/common_resources.robot
Resource    ../../resources/Pages/API_Keywords.robot
Suite Setup     Launch Application
Suite Teardown  Close Application
*** Test Cases ***
TC-API-03: Validate API Response Status and Structure
    Ensure User Is Logged In
    Get Customer ID From Login
    Validate API Response Status And Structure










