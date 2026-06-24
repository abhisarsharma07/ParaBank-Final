*** Settings ***
Resource  ../../../resources/common_resources.robot
Resource  ../../../resources/Pages/Open_Account_Page.robot
Suite Setup       Launch Application
Suite Teardown    Close Application

*** Test Cases ***
TC-AC-UI-04: Create New CHECKING Account Successfully
    Ensure User Is Logged In
    Create New Checking Account
    ${account_id}=    Capture Account ID
    Verify Account Appears In Overview    ${account_id}
    Log To Console    The Checking Account ID is: ${account_id}