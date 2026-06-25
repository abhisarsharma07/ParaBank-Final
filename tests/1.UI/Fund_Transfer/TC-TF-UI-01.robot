*** Settings ***
Resource    ../../../resources/common_resources.robot
Resource    ../../../resources/Pages/UI_Fund_Transfer_Page_Keywords.robot
Resource    ../../../resources/Pages/UI_Open_Account_Page_Keywords.robot

Suite Setup       Launch Application
Suite Teardown    Close Application

*** Test Cases ***
TC-TF-UI-01: Successful Fund Transfer Between Two Accounts
    Ensure User Is Logged In
    Create New Account
    Transfer Funds Between Accounts
    Page Should Contain    Transfer Complete!