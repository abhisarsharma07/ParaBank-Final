*** Settings ***
Resource  ../../../resources/common_resources.robot
Resource  ../../../resources/Pages/UI_Open_Account_Page_Keywords.robot
Suite Setup       Launch Application
Suite Teardown    Close Application

*** Test Cases ***
TC-AC-UI-03: Verify New Account Appears in Account Overview
    Ensure User Is Logged In
    Create New Account
    ${account_id}=    Capture Account ID
    Open Account Overview
    Sleep    2s
    Verify Account Appears In Overview  ${account_id}
    Log To Console    ${account_id}

