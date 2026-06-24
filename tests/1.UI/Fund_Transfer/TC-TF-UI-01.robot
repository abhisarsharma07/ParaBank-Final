*** Settings ***
Resource    ../../../resources/common_resources.robot
Resource    ../../../resources/Pages/Fund_Transfer_Page.robot
Resource    ../../../resources/Pages/Open_Account_Page.robot

Suite Setup       Launch Application
Suite Teardown    Close Application

*** Test Cases ***
TC-TF-UI-01: Successful Fund Transfer Between Two Accounts
    Ensure User Is Logged In
    Create New Account
    Transfer Funds Between Accounts
    Page Should Contain    Transfer Complete!