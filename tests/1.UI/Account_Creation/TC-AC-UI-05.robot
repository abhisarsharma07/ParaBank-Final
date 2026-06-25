*** Settings ***
Resource  ../../../resources/common_resources.robot
Resource  ../../../resources/Pages/UI_Open_Account_Page_Keywords.robot
Suite Setup       Launch Application
Suite Teardown    Close Application

*** Test Cases ***
TC-AC-UI-05: Create New SAVINGS Account Successfully
    Ensure User Is Logged In
    Create New Savings Account
    ${account_id}=    Capture Account ID
    Verify Account Appears In Overview    ${account_id}
    Log To Console    The Savings Account ID is: ${account_id}

