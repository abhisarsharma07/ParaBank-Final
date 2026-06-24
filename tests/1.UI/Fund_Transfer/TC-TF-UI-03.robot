*** Settings ***
Resource    ../../../resources/common_resources.robot
Resource    ../../../resources/Pages/Fund_Transfer_Page.robot

Suite Setup       Launch Application
Suite Teardown    Close Application

*** Test Cases ***
TC-TF-UI-03: Verify Transfer Page Dropdown Shows All Accounts
    Ensure User Is Logged In
    ${accounts}=    Get Accounts From Overview
    Open Transfer Funds Page
    Verify Accounts Present In Transfer Dropdowns    ${accounts}