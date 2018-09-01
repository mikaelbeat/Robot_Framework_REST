*** Settings ***
Library    RequestsLibrary    
Library    OperatingSystem    
Library    String      
Library    XML  
Library    DiffLibrary      

*** Variables ***
${payload_location}    C:\\Users\\petri.ryynanen\\eclipse-workspace\\Robot_Framework_REST\\Payloads\\
${payload}    Update_user.Json 
${expected_location}    C:\\Users\\petri.ryynanen\\eclipse-workspace\\Robot_Framework_REST\\Expected\\
${expected_response}    Put_response.json
${save_response_location}    C:\\Users\\petri.ryynanen\\eclipse-workspace\\Robot_Framework_REST\\Put_response\\saved_response.json

*** Keywords ***
Test run
    ${payload}    get binary file    ${payload_location}${payload}  
    Create Session    putSession    https://reqres.in       verify=true
    ${response}    Post Request    putSession    /api/users/2    ${payload}
    log    ${response.status_code}
    log    ${response.text}
    Should Be Equal As Strings    ${response.status_code}    201   
    Should Contain    ${response.text}    createdAt   
    ${pretty_printed_response}    To Json    ${response.text}    true    
    Create Binary File    ${save_response_location}    ${pretty_printed_response}
    ${response_to_be_edited}    Get Binary File    ${save_response_location}
    ${edited_response}    Replace String Using Regexp    ${response_to_be_edited}    2018....................    edited_date
    ${final_response}    Replace String Using Regexp    ${edited_response}    \\d\\d\\d    edited_id
    Create Binary File    ${save_response_location}    ${final_response}
    Diff Files    ${save_response_location}    ${expected_location}${expected_response}         

*** Test Cases ***
Put test
    Test run
	#    robot -d results tests/put.robot