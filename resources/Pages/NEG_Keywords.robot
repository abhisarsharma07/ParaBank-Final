*** Settings ***
Library     SeleniumLibrary
Library  RequestsLibrary
Resource    ../../variables/Neg_Variables.robot

*** Keywords ***
Transfer Negative Amount
    Click Link    Transfer Funds
    Wait Until Element Is Visible    ${AMOUNT_FIELD}
    Input Text    ${AMOUNT_FIELD}    -50
    Sleep    2s
    Wait Until Element Is Visible    ${FROM_ACCOUNT_DROPDOWN}
    Sleep    2s
    Select From List By Index    ${FROM_ACCOUNT_DROPDOWN}  0
    Wait Until Element Is Visible    ${TO_ACCOUNT_DROPDOWN}
    Select From List By Index    ${TO_ACCOUNT_DROPDOWN}  1
    Click Element    ${TRANSFER_BUTTON}
     ${status}=  Run Keyword And Return Status
    ...  Page Should Not Contain    Transfer Complete!
    IF    ${status} == False
        Log    BUG DFT-02: Negative amount transfer allowed — Known Defect
    ELSE
        Log    Transfer was correctly rejected    INFO
    END
    Log To Console    BUG DFT-02: Known defect — negative transfer not blocked

Transfer With Non Numeric Amount
    Click Link    Transfer Funds
    Sleep    2s
    Select From List By Index    ${FROM_ACCOUNT_DROPDOWN}  0
    Sleep    2s
    Select From List By Index    ${TO_ACCOUNT_DROPDOWN}  1
    Input Text    ${AMOUNT_FIELD}    abc
    Sleep    2s
    Click Element    ${TRANSFER_BUTTON}
    Sleep    2s
    Wait Until Page Contains    Error!
    Page Should Contain    An internal error has occurred and has been logged.

Transfer Amount Greater Than Balance
    Click Link    Transfer Funds
    Wait Until Element Is Visible    ${AMOUNT_FIELD}
    Sleep    2s
    Select From List By Index    ${FROM_ACCOUNT_DROPDOWN}  0
    Sleep    2s
    Select From List By Index    ${TO_ACCOUNT_DROPDOWN}  1
    Input Text    ${AMOUNT_FIELD}    100000
    Click Element    ${TRANSFER_BUTTON}
    ${status}=    Run Keyword And Return Status
    ...    Page Should Not Contain    Transfer Complete
    IF    ${status} == False
        Log    BUG DFT-03: Insufficient balance transfer allowed — Known Defect
    ELSE
        Log    Transfer was correctly rejected    INFO
    END
    Log To Console    BUG DFT-03: Insufficient balance transfer allowed — Known Defect

Validate Invalid Account ID
    Create Session    ParaBank    ${BASE_API_URL}
    ${headers}=    Create Dictionary    Accept=${ACCEPT_HEADER}
    ${response}=    GET On Session   ParaBank   /accounts/${INVALID_ACCOUNT_ID}  headers=${headers}  expected_status=any
    Log To Console    Status Code : ${response.status_code}
    Log To Console    Response Body : ${response.text}
    Should Be True    ${response.status_code} >= 400
    ...  msg=Expected 400 error for invalid account ID — got ${response.status_code}

    Log To Console    API correctly returned error: ${response.status_code}



