*** Settings ***
Resource    ../../../resources/common_resources.robot
Resource    ../../../resources/Pages/UI_Open_Account_Page_Keywords.robot
Resource    ../../../resources/Pages/UI_Fund_Transfer_Page_Keywords.robot

Suite Setup       Launch Application
Suite Teardown    Close Application

*** Test Cases ***
TC-TF-UI-02 Verify Confirmation Message Details After Transfer
    Ensure User Is Logged In
    Create New Account
    Verify Confirmation Message After Transfer