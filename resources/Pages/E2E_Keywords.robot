*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Resource    ../../variables/E2E_Variables.robot

*** Keywords ***
Create Account And Capture Details
    Click Link    Open New Account
    Wait Until Element Is Visible   ${ACCOUNT_TYPE_DROPDOWN}
    Sleep    2s
    Select From List By Label   ${ACCOUNT_TYPE_DROPDOWN}    SAVINGS
    Click Element   ${OPEN_ACCOUNT_BUTTON}
    Wait Until Element Is Visible   ${NEW_ACCOUNT_ID}
    ${account_id}=    Get Text  ${NEW_ACCOUNT_ID}
    RETURN    ${account_id}

Validate Account Exists Via API
   [Arguments]    ${account_id}
   ${cookie}=    Get Cookie    JSESSIONID
   Log To Console   Cookie Value: ${cookie.value}
   ${cookies}=    Create Dictionary  JSESSIONID=${cookie.value}
   Create Session   bank    https://parabank.parasoft.com   verify=False
   ${headers}=    Create Dictionary    Accept=application/json
   ${response}=    GET On Session   bank    /parabank/services_proxy/bank/accounts/${account_id}  headers=${headers}    cookies=${cookies}
   Log To Console   Status Code: ${response.status_code}
   Log To Console   Response: ${response.text}
   Should Be Equal As Integers   ${response.status_code}   200
   Should Contain   ${response.text}    ${account_id}

Get Account Balance From API
    [Arguments]    ${account_id}
    ${cookie}=    Get Cookie    JSESSIONID
    ${cookies}=    Create Dictionary   JSESSIONID=${cookie.value}
    Create Session    bank  https://parabank.parasoft.com  verify=False
    ${headers}=    Create Dictionary    Accept=application/json
    ${response}=    GET On Session   bank  /parabank/services_proxy/bank/accounts/${account_id}  headers=${headers}  cookies=${cookies}
    ${json}=    Evaluate    $response.json()
    RETURN    ${json["balance"]}

Perform Transfer
    [Arguments]  ${amount}
    Click Link    Transfer Funds
    Wait Until Element Is Visible    ${AMOUNT_FIELD}
    Sleep    2s
    ${from_options}=    Get List Items   ${FROM_ACCOUNT_DROPDOWN}
    ${to_options}=    Get List Items    ${TO_ACCOUNT_DROPDOWN}
    Log To Console  From Accounts: ${from_options}
    Log To Console  To Accounts: ${to_options}
    ${from_account}=    Set Variable    ${from_options}[0]
    ${to_account}=    Set Variable   ${to_options}[1]
    ${before_from}=    Get Account Balance From API  ${from_account}
    ${before_to}=    Get Account Balance From API   ${to_account}
    Log To Console  Before From: ${before_from}
    Log To Console  Before To: ${before_to}
    Select From List By Label   ${FROM_ACCOUNT_DROPDOWN}    ${from_account}
    Select From List By Label    ${TO_ACCOUNT_DROPDOWN}  ${to_account}
    Input Text  ${AMOUNT_FIELD}  ${amount}
    Click Element   ${TRANSFER_BUTTON}
    Wait Until Page Contains    Transfer Complete!
    Log To Console  Transfer Completed Successfully
    RETURN  ${from_account}  ${to_account}  ${before_from}  ${before_to}

Validate Balance Changes
     [Arguments]   ${from_account}  ${to_account}  ${amount}  ${before_from}  ${before_to}
      Log To Console    Before From: ${before_from}
      Log To Console    Before To: ${before_to}
      ${after_from}=    Get Account Balance From API     ${from_account}
      ${after_to}=    Get Account Balance From API   ${to_account}
      ${expected_from}=    Evaluate  float(${before_from}) - float(${amount})
      ${expected_to}=    Evaluate    float(${before_to}) + float(${amount})
      Should Be Equal As Numbers    ${after_from}   ${expected_from}
      Should Be Equal As Numbers    ${after_to}     ${expected_to}