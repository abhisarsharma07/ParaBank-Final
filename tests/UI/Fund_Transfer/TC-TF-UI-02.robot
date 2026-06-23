*** Settings ***
Resource    ../../../resources/common_resources.robot
Resource    ../../../resources/Pages/Fund_Transfer_Page.robot
Resource    ../../../resources/Pages/Open_Account_Page.robot

Suite Setup       Launch Application
Suite Teardown    Close Application

*** Test Cases ***
TC-TF-UI-02 Verify Confirmation Message Details After Transfer
    Ensure User Is Logged In
    Create New Account
    Verify Confirmation Message After Transfer