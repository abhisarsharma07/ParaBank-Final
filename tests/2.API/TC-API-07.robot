*** Settings ***
Resource    ../../resources/common_resources.robot
Resource    ../../resources/Pages/API_Keywords.robot

Suite Setup     Launch Application
Suite Teardown  Close Application

*** Test Cases ***
TC-API-07: Validate API Response Time
    Ensure User Is Logged In
    Get Customer ID From Login
    Validate API Response Time
