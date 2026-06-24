*** Settings ***
Resource    ../../resources/common_resources.robot
Resource    ../../resources/Pages/API_Keywords.robot
Suite Setup     Launch Application
Suite Teardown  Close Application

*** Test Cases ***
TC-API-02: Validate New Account Exists via API
    Ensure User Is Logged In
    Get Customer ID From Login
    Get Account ID via API
    Validate New Account Exists In API