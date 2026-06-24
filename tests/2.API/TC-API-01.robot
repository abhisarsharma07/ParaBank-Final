*** Settings ***
Library  SeleniumLibrary
Resource    ../../resources/common_resources.robot
Resource    ../../resources/Pages/API_Keywords.robot

Suite Setup       Launch Application
Suite Teardown    Close Application
*** Test Cases ***
TC-API-01: GET Accounts List via API
    Ensure User Is Logged In
    Get Customer ID From Login
    Get Accounts List By Customer Id