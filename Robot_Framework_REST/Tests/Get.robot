*** Settings ***
Library    RequestsLibrary    
Library    OperatingSystem     
Library    DiffLibrary     

*** Variables ***
${expected_location}    C:\\Users\\petri.ryynanen\\eclipse-workspace\\Robot_Framework_REST\\Expected\\
${expected_response}    Get_response.json
${save_response_location}    C:\\Users\\petri.ryynanen\\eclipse-workspace\\Robot_Framework_REST\\Responses\\Get_response.json

*** Keywords ***
Test run
    Create Session    getSession    https://reqres.in       verify=true
    ${response}    Get Request    getSession    /api/users?page=2
    log    ${response.status_code}
    log    ${response.text}
    Should Be Equal As Strings    ${response.status_code}    200   
    ${pretty_printed_response}    To Json    ${response.text}    true    
    Create Binary File    ${save_response_location}    ${pretty_printed_response}
    ${expected_response}    Get Binary File    ${expected_location}${expected_response}
    ${saved_response}    Get Binary File    ${save_response_location}
    Diff Outputs    ${saved_response}     ${expected_location}${expected_response}          

*** Test Cases ***
Get test
    Test run
    #    robot -d results tests/get.robot