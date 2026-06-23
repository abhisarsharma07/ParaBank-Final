*** Settings ***
Library  SeleniumLibrary
Library    RequestsLibrary
Library     Collections
Resource   ../../variables/API_Variables.robot
Resource    ../../variables/global_variables.robot

*** Keywords ***
Get Customer ID From Login
    Create Session    ParaBank    ${BASE_URL_API}    verify=False
    ${headers}=     Create Dictionary   Accept=${ACCEPT_HEADER}
    ${response}=    GET On Session  ParaBank    /login/${Valid_Username}/${Valid_Password}  headers=${headers}
    Should Be Equal As Integers     ${response.status_code}     ${EXPECTED_STATUS}
    ${customer_id}=  Set Variable   ${response.json()}[id]
    ${customer_id}=    Convert To String    ${customer_id}
    Set Suite Variable    ${CUSTOMER_ID}    ${customer_id}
    Log To Console    Customer ID Found: ${CUSTOMER_ID}

Get Accounts List By Customer Id
## It will give First Account ID
    Create Session  ParaBank    ${BASE_URL_API}  verify=False
    ${headers}=  Create Dictionary  Accept=${ACCEPT_HEADER}
    ${response}=    GET On Session  ParaBank   /customers/${CUSTOMER_ID}/accounts   headers=${headers}
    Log To Console    Response Status Code : ${response.status_code}
    Log To Console    Response Body : ${response.text}
    Should Be Equal As Integers    ${response.status_code}    ${EXPECTED_STATUS}
    ${json_response}=   Set Variable     ${response.json()}
    Should Not Be Empty    ${json_response}
    Log To Console    Account JSON: ${json_response}
    ${accounts}=    Set Variable    ${response.json()}
    ${from_account_id}=    Convert To String    ${accounts}[0][id]
    Set Suite Variable    ${FROM_ACCOUNT_ID}    ${from_account_id}
    Log To Console    From Account ID: ${FROM_ACCOUNT_ID}
    RETURN  ${json_response}

Create New Account via API
     Create Session  ParaBank    ${BASE_URL_API}  verify=False
     ${headers}=    Create Dictionary   Accept=${ACCEPT_HEADER}
     ${params}=    Create Dictionary    customerId=${CUSTOMER_ID}   newAccountType=${ACCOUNT_TYPE}    fromAccountId=${FROM_ACCOUNT_ID}
     ${response}=    POST On Session     ParaBank   /createAccount  params=${params}    headers=${headers}
     Log To Console    Status Code : ${response.status_code}
     Log To Console    Response Body : ${response.text}
     Should Be Equal As Integers    ${response.status_code}  ${EXPECTED_STATUS}
     ${new_account}=         Set Variable    ${response.json()}
     ${new_account_id}=      Convert To String    ${new_account}[id]
     ${new_account_type}=    Set Variable    ${new_account}[type]
     ${new_account_bal}=     Set Variable    ${new_account}[balance]
     ${new_account_bal}=     Convert To String    ${new_account}[balance]
     Set Suite Variable    ${NEW_ACCOUNT_ID}    ${new_account_id}
     Set Suite Variable    ${CREATED_BALANCE}    ${new_account_bal}
     Log To Console    =====================================
     Log To Console    New Account Created Successfully!
     Log To Console    Account ID : ${NEW_ACCOUNT_ID}
     Log To Console    Account Type : ${new_account_type}
     Log To Console    Balance : ${new_account_bal}
     Log To Console    =====================================
     RETURN    ${new_account_id}

Get Account ID via API
    Create Session    ParaBank    ${Base_Url_API}   verify=False
    ${headers}=    Create Dictionary    Accept=${ACCEPT_HEADER}
    ${response}=    GET On Session  ParaBank   /customers/${CUSTOMER_ID}/accounts   headers=${headers}
    ${accounts}=    Set Variable    ${response.json()}
    ${last_account}=    Get From List    ${accounts}    -1
    ${new_account_id}=    Convert To String    ${last_account}[id]
    Set Suite Variable    ${ACCOUNT_ID}    ${new_account_id}
    Log To Console    Latest Account ID : ${NEW_ACCOUNT_ID}

Validate New Account Exists In API
    Create Session    ParaBank    ${Base_Url_API}   verify=False
    ${headers}=    Create Dictionary    Accept=${ACCEPT_HEADER}
    ${response}=    GET On Session  ParaBank   /customers/${CUSTOMER_ID}/accounts   headers=${headers}
    Log To Console    Response Status Code : ${response.status_code}
    Should Be Equal As Integers    ${response.status_code}    ${EXPECTED_STATUS}
    ${response_body}=   Set Variable    ${response.text}
    Log To Console    Response ${response_body}
    Should Contain    ${response_body}    ${ACCOUNT_ID}
    Log To Console  Account ID : ${ACCOUNT_ID} found successfully in API response.

Validate API Response Status And Structure
    Create Session    ParaBank  ${Base_URL_API}    verify=False
    ${headers}=     Create Dictionary   Accept=${ACCEPT_HEADER}
    ${response}=    GET On Session  ParaBank    /customers/${CUSTOMER_ID}/accounts   headers=${headers}
    Log To Console    Status Code : ${response.status_code}
    Should Be Equal As Integers     ${response.status_code}    ${EXPECTED_STATUS}
    ${response_json}=    Set Variable   ${response.json()}
    Log To Console    Response JSON : ${response_json}
    Should Not Be Empty     ${response_json}
    ${first_account}=    Set Variable   ${response_json}[0]
    Dictionary Should Contain Key   ${first_account}  id
    Dictionary Should Contain Key   ${first_account}  type
    Dictionary Should Contain Key   ${first_account}  balance
    Log To Console    id field is present
    Log To Console    type field is present
    Log To Console    balance field is present

Validate Account Type Matches UI Input
    Create Session    ParaBank  ${Base_Url_API}    verify=False
    ${headers}=     Create Dictionary   Accept=${ACCEPT_HEADER}
    ${response}=    GET On Session   ParaBank    /accounts/${ACCOUNT_ID}   headers=${headers}
    Log To Console    Status Code : ${response.status_code}
    Should Be Equal As Integers     ${response.status_code}   ${EXPECTED_STATUS}
    ${response_json}=    Set Variable   ${response.json()}
    Log To Console    Response : ${response_json}
    Dictionary Should Contain Key   ${response_json}    type
    ${api_account_type}=    Set Variable    ${response_json['type']}
    Log To Console    UI Account Type : CHECKING
    Log To Console    API Account Type : ${api_account_type}
    Should Be Equal   ${api_account_type}  CHECKING
    Log To Console    Account type validation successful.

Validate Account Balance Via API
      Create Session    ParaBank  ${Base_Url_API}    verify=False
      ${headers}=    Create Dictionary  Accept=${ACCEPT_HEADER}
      ${response}=    GET On Session    ParaBank    /accounts/${NEW_ACCOUNT_ID}   headers=${headers}
      Log To Console    Status Code   : ${response.status_code}
      Log To Console    Response Body : ${response.text}
      Should Be Equal As Integers    ${response.status_code}    200
      ${account}=    Set Variable    ${response.json()}
      Dictionary Should Contain Key    ${account}    id
      Dictionary Should Contain Key    ${account}    type
      Dictionary Should Contain Key    ${account}    balance
      Should Be True    ${account}[balance] >= 0
      Should Be Equal As Strings    ${account}[id]    ${NEW_ACCOUNT_ID}
      ${acc_id}=      Convert To String    ${account}[id]
      ${acc_type}=    Set Variable         ${account}[type]
      ${acc_bal}=     Convert To String    ${account}[balance]
     Log To Console    Account ID : ${acc_id}
     Log To Console    Account Type : ${acc_type}
     Log To Console    Balance : ${acc_bal}
     Log To Console    Expected : ${CREATED_BALANCE}


Validate Balance Update After Transfer
    Create Session    ParaBank  ${Base_Url_API}    verify=False
    ${headers}=     Create Dictionary   Accept=${ACCEPT_HEADER}
    ${from_before_response}=    GET On Session  ParaBank    /accounts/${FROM_ACCOUNT_ID}    headers=${headers}
    ${from_before_json}=    Set Variable    ${from_before_response.json()}
    ${from_before_balance}=    Set Variable    ${from_before_json['balance']}
    ${to_before_response}=    GET On Session    ParaBank    /accounts/${NEW_ACCOUNT_ID}  headers=${headers}
    ${to_before_json}=    Set Variable    ${to_before_response.json()}
    ${to_before_balance}=    Set Variable    ${to_before_json['balance']}
    Log To Console    From Account Balance Before : ${from_before_balance}
    Log To Console    To Account Balance Before : ${to_before_balance}

    ${headers}=    Create Dictionary    Accept=${ACCEPT_HEADER}
    ${params}=    Create Dictionary      fromAccountId=${FROM_ACCOUNT_ID}   toAccountId=${NEW_ACCOUNT_ID}     amount=50
    ${response}=    POST On Session  ParaBank   /transfer   params=${params}    headers=${headers}
    Log To Console    Transfer Status : ${response.status_code}
    Log To Console    Transfer Response : ${response.text}
    Should Be Equal As Integers    ${response.status_code}    200

    Sleep    2s
    ${from_after_response}=    GET On Session   ParaBank    /accounts/${FROM_ACCOUNT_ID}    headers=${headers}
    ${from_after_json}=    Set Variable    ${from_after_response.json()}
    ${from_after_balance}=    Set Variable    ${from_after_json['balance']}
    ${to_after_response}=    GET On Session  ParaBank   /accounts/${NEW_ACCOUNT_ID}  headers=${headers}
    ${to_after_json}=    Set Variable    ${to_after_response.json()}
    ${to_after_balance}=    Set Variable    ${to_after_json['balance']}
    Log To Console    From Account Balance After : ${from_after_balance}
    Log To Console    To Account Balance After : ${to_after_balance}
    Should Be True    ${from_after_balance} < ${from_before_balance}
    Should Be True    ${to_after_balance} > ${to_before_balance}
    Log To Console    From Account balance decreased successfully.
    Log To Console    To Account balance increased successfully.

Validate API Response Time
        Create Session  ParaBank    ${Base_URL_API}  verify=False
        ${headers}=    Create Dictionary    Accept=${ACCEPT_HEADER}
        ${response}=    GET On Session  ParaBank    /customers/${CUSTOMER_ID}/accounts  headers=${headers}
        Log To Console    Status Code : ${response.status_code}
        Should Be Equal As Integers    ${response.status_code}  ${EXPECTED_STATUS}
        ${response_time}=    Set Variable   ${response.elapsed.total_seconds()}
        Log To Console    Response Time : ${response_time} seconds
        ${MAX_RESPONSE_TIME}=   Set Variable    2
        Should Be True  ${response_time} < ${MAX_RESPONSE_TIME}
        Log To Console   API response time is within acceptable limit.

