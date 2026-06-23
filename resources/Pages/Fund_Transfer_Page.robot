*** Settings ***
Library  SeleniumLibrary
Library     Collections
Resource  ../../variables/fund_transfer_variables.robot

*** Keywords ***
Open Transfer Funds Page
    Click Link    Transfer Funds
    Wait Until Element Is Visible    ${From_Account_Dropdown}
    Sleep    2s


Transfer Funds Between Accounts
    Open Transfer Funds Page
    Wait Until Element Is Visible    ${Amount_Field}
    Input Text    ${Amount_Field}    100
    Sleep    2s
    Select From List By Index    ${From_Account_Dropdown}  0
    Sleep    2s
    Select From List By Index    ${To_Account_Dropdown}  1
    Sleep    2s
    Click Element    ${Transfer_Button}
    Wait Until Page Contains    Transfer Complete!


Verify Confirmation Message After Transfer
    Open Transfer Funds Page
    ${amount}=    Set Variable  100
    Wait Until Element Is Visible    ${Amount_Field}
    Input Text    ${Amount_Field}    ${amount}
    Sleep    2s
    Select From List By Index    ${From_Account_Dropdown}  0
    Sleep    2s
    Select From List By Index    ${To_Account_Dropdown}  1
    ${from_account}=    Get Selected List Label  ${From_Account_Dropdown}

    ${to_account}=    Get Selected List Label  ${To_Account_Dropdown}
    Sleep    2s
    Click Element    ${Transfer_Button}
    Sleep    2s
    Wait Until Page Contains    Transfer Complete!

    Log To Console    Verifying confirmation message after transfer
    Log To Console    From Account: ${from_account}
    Log To Console    To Account: ${to_account}
    Log To Console    Amount: ${amount}
    Page Should Contain    ${from_account}
    Page Should Contain    ${to_account}
    Page Should Contain    ${amount}

Get Accounts From Overview
    Click Link    Accounts Overview
    Wait Until Page Contains    Accounts Overview
    Sleep    2s
    ${accounts}=    Get WebElements    xpath=//table[@id='accountTable']//a
    ${account_list}=    Create List
    FOR    ${acc}    IN    @{accounts}
        ${account_no}=    Get Text    ${acc}
        Append To List    ${account_list}    ${account_no}
    END
    RETURN    ${account_list}

Verify Accounts Present In Transfer Dropdowns
    [Arguments]    ${account_list}
    ${from_accounts}=    Get List Items    ${From_Account_Dropdown}
    ${to_accounts}=      Get List Items    ${To_Account_Dropdown}
    FOR    ${account}    IN    @{account_list}
        List Should Contain Value    ${from_accounts}    ${account}
        List Should Contain Value    ${to_accounts}      ${account}
    END
    Log To Console    Accounts Overview: ${account_list}
    Log To Console    From Dropdown: ${from_accounts}
    Log To Console    To Dropdown: ${to_accounts}
    
Transfer Funds Using Same Account
    Click Link    Transfer Funds
    Wait Until Element Is Visible    ${Amount_Field}
    Sleep    2s
    Select From List By Index    ${From_Account_dropdown}   0
    Select From List By Index    ${To_Account_Dropdown}     0
    Input Text    ${Amount_Field}    100
    Click Element    ${Transfer_Button}
    
Verify Same Account Validation
    Page Should Contain    Transfer Complete!
    Log    BUG DFT-01: Same account transfer was allowed by application    WARN
    Log To Console    Log    BUG DFT-01: Same account transfer was allowed by application    WARN




