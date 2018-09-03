*** Settings ***
Library    RequestsLibrary    
Library    OperatingSystem     
Library    DiffLibrary     

*** Variables ***
${expected_location}    C:\\Users\\petri.ryynanen\\git\Robot_Framework_REST\\Robot_Framework_REST\\expected\\
${expected_response}    Get_response.json
${save_response_location}    C:\\Users\\petri.ryynanen\\git\Robot_Framework_REST\\Robot_Framework_REST\\expected\\
${saved_response}    Get_response.json 

*** Keywords ***
Test run
    Create Session    getSession    https://reqres.in       verify=true
    ${response}    Get Request    getSession    /api/users?page=2
    log    ${response.status_code}
    log    ${response.text}
    Should Be Equal As Strings    ${response.status_code}    200   
    ${pretty_printed_response}    To Json    ${response.text}    true    
    Create File    ${save_response_location}${saved_response}   ${pretty_printed_response}
    ${expected_response}    Get File    ${expected_location}${expected_response}
    ${saved_response2}    Get File    ${save_response_location}${saved_response}
    Diff Outputs    ${saved_response2}      ${expected_location}${expected_response}          

*** Test Cases ***
Get test
    Test run
    #    robot -d results tests/get.robot