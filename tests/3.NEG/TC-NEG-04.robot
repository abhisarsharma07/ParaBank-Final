*** Settings ***
Resource    ../../resources/common_resources.robot
Resource    ../../resources/Pages/NEG_Keywords.robot
Suite Setup       Launch Application
Suite Teardown    Close Application
*** Test Cases ***
TC-NEG-04: API Validation for Invalid Account ID
    Ensure User Is Logged In
    Validate Invalid Account ID