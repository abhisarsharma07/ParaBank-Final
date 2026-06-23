*** Settings ***
Library  SeleniumLibrary
Resource  Pages/login_Page.robot
Resource  ../variables/global_variables.robot

*** Keywords ***
Launch Application
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window

Close Application
    Close Browser

Ensure User Is Logged In
    [Documentation]   This Keyword will ensure that user is logged in, and if is not then it will register and then login it.
    Login User
    ${login_success}=  Run Keyword And Return Status    Wait Until Page Contains    Accounts Overview    10s
    IF    not ${login_success}
        Go To    ${BASE_URL}
        Register User
    END

