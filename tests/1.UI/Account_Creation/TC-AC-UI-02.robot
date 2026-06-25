*** Settings ***
Resource  ../../../resources/common_resources.robot
Resource  ../../../resources/Pages/UI_Open_Account_Page_Keywords.robot
Suite Setup       Launch Application
Suite Teardown    Close Application

*** Test Cases ***
TC-AC-UI-02: Verify Success Message After Account Creation
    Ensure User Is Logged In
    Create New Account
    Verify Success Message After Account Creation

