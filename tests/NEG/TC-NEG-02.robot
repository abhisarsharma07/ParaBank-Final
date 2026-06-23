*** Settings ***
Resource    ../../resources/common_resources.robot
Resource    ../../resources/Pages/NEG_Keywords.robot
Resource    ../../resources/Pages/Open_Account_Page.robot
Suite Setup       Launch Application
Suite Teardown    Close Application
*** Test Cases ***
TC-NEG-02: Fund Transfer Non-Numeric Amount
    Ensure User Is Logged In
    Create New Account
    Transfer With Non Numeric Amount
