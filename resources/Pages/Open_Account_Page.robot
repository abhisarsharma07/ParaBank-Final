*** Settings ***
Library  SeleniumLibrary
Library    RequestsLibrary
Library     Collections
Resource  ../../variables/Open_Account_Variables.robot

*** Keywords ***
Open New Account Page
    Click Link    Open New Account

Create New Account
    Open New Account Page
    Select From List By Index  ${Account_Type_Dropdown}  0
    Sleep    2s
    Click Element  ${Open_Account_Button}

Capture Account ID
    Wait Until Page Contains    Account Opened!
    Sleep    2s
    Wait Until Element Is Visible    ${New_Account_Id}
    ${account_id}=  Get Text    ${New_Account_ID}
    Log To Console  New Account ID: ${account_id}
    RETURN  ${account_id}

Verify Success Message After Account Creation
    Page Should Contain    Congratulations, your account is now open.
    Sleep    2s

Open Account Overview
    Click Element    ${Account_Overview_Link}
    Wait Until Page Contains    Accounts Overview

Verify Account Appears In Overview
    [Arguments]    ${account_id}
    Page Should Contain    ${account_id}

Create New Checking Account
    Open New Account Page
    Select From List By Label    ${Account_Type_Dropdown}   CHECKING
    Sleep    2s
    Click Element    ${Open_Account_Button}

Create New Savings Account
    Open New Account Page
    Select From List By Label    ${Account_Type_Dropdown}   SAVINGS
    Sleep    2s
    Click Element    ${Open_Account_Button}

