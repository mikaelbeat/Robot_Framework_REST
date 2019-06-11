*** Settings ***
Library    RequestsLibrary    
Library    OperatingSystem     
Library    DiffLibrary     

*** Variables ***
${expected_location}    Expected
${expected_response}    Get_expected.json
${save_response_location}    Responses
${saved_response}    Get_response.json 

*** Keywords ***
Test run
    Create Session    getSession    https://reqres.in       verify=true
    ${response}    Get Request    getSession    /api/users?page=2
    log    ${response.status_code}
    log    ${response.text}
    Should Be Equal As Strings    ${response.status_code}    200   
    ${pretty_printed_response}    To Json    ${response.text}    true    
    Create binary File    ${save_response_location}${saved_response}   ${pretty_printed_response}
    ${response}    Get File    ${save_response_location}${saved_response}     
    ${expected}    Get File    ${expected_location}${expected_response}  
    Diff Outputs    ${response}      ${expected}         

*** Test Cases ***
Get test
    Test run
    #    robot -d results tests/get.robot