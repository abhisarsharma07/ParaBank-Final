*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/login_variable.robot
Resource  ../../variables/global_variables.robot


*** Keywords ***
Register User
    [Documentation]     This keyword registers a new user on the Parabank application.
    ${url}=    Get Location
    Log To Console    Current URL: ${url}
    Wait Until Element Is Visible    ${REGISTER_LINK}    10s
    Click Element    ${REGISTER_LINK}
    Input Text    ${FIRST_NAME}    Abhisar
    Input Text    ${LAST_NAME}    Sharma
    Input Text    ${ADDRESS}    123 Main Street
    Input Text    ${CITY}    Deeg
    Input Text    ${STATE}    Rajasthan
    Input Text    ${ZIPCODE}    321203
    Input Text    ${PHONE}    8949657244
    Input Text    ${SSN}    123-45-6789
    Input Text    ${USERNAME}   ${Valid_Username}
    Input Text    ${PASSWORD}   ${Valid_Password}
    Input Text    ${CONFIRM_PASSWORD}    ${Valid_Password}
    Click Element    ${REGISTER_BTN}
    Sleep    2s
    
    Wait Until Page Contains    Your account was created successfully. You are now logged in.
    Log To Console    User registered successfully
    
Login User
    [Documentation]     This Keyword helps to loginthr user
    Input Text  ${LOGIN_USERNAME}   ${Valid_Username}
    Input Text  ${LOGIN_PASSWORD}   ${Valid_Password}
    Click Element    ${LOGIN_BUTTON}
