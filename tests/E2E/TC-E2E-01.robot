*** Settings ***
Resource    ../../resources/common_resources.robot
Resource    ../../resources/Pages/E2E_Keywords.robot
Suite Setup     Launch Application
Suite Teardown  Close Application
*** Test Cases ***
TC-E2E-01: Create Account Via UI And Validate Via API
    Ensure User Is Logged In
    ${account_id}=    Create Account And Capture Details
    Log To Console   Created Account: ${account_id}
    Validate Account Exists Via API  ${account_id}
