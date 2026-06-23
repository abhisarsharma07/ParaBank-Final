*** Variables ***

${TRANSFER_FUNDS_LINK}      xpath=//a[text()='Transfer Funds']
${AMOUNT_FIELD}             id=amount
${FROM_ACCOUNT_DROPDOWN}    xpath=//select[@id="fromAccountId"]
${TO_ACCOUNT_DROPDOWN}      xpath=//select[@id="toAccountId"]
${TRANSFER_BUTTON}          xpath=//input[@value='Transfer']

${BASE_API_URL}         https://parabank.parasoft.com/parabank/services/bank
${INVALID_ACCOUNT}   999999999
${ACCOUNT_ENDPOINT}  /parabank/services_proxy/bank/accounts/${INVALID_ACCOUNT}
${ACCEPT_HEADER}        application/json
${EXPECTED_STATUS}      200
${INVALID_ACCOUNT_ID}   999999999