*** Settings ***
Resource    ../../resources/common_resources.robot
Resource    ../../resources/Pages/NEG_Keywords.robot
Resource    ../../resources/Pages/UI_Open_Account_Page_Keywords.robot
Suite Setup       Launch Application
Suite Teardown    Close Application
*** Test Cases ***
TC-NEG-01: Fund Transfer With Negative Amount
    Ensure User Is Logged In
    Create New Account
    Transfer Negative Amount