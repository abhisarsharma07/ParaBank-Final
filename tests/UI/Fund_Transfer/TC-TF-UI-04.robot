*** Settings ***
Resource    ../../../resources/common_resources.robot
Resource    ../../../resources/Pages/Fund_Transfer_Page.robot

Suite Setup       Launch Application
Suite Teardown    Close Application
*** Test Cases ***
TC-TF-UI-04 : Verify From and To Account Cannot Be Same
    Ensure User Is Logged In
    Transfer Funds Using Same Account
    Verify Same Account Validation