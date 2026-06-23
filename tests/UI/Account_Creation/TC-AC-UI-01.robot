*** Settings ***
Resource  ../../../resources/common_resources.robot
Resource  ../../../resources/Pages/Open_Account_Page.robot
Suite Setup       Launch Application
Suite Teardown    Close Application

*** Test Cases ***
TC-AC-UI-01: Create New Account With Valid Data
    [Documentation]  Verify that a user can successfully create a new account by selecting a valid account type and an existing account for funding.
    Ensure User Is Logged In
    Wait Until Page Contains    Accounts Overview
    Create New Account
    ${account_id}=  Capture Account ID
    Should Not Be Empty    ${account_id}
