*** Settings ***
Library    RequestsLibrary    
Library    OperatingSystem    
Library    String       
Library    DiffLibrary      

*** Variables ***
${payload_location}    C:\\Users\\petri.ryynanen\\git\\Robot_Framework_REST\\Robot_Framework_REST\\Payloads\\
${payload}    Update_user.Json 
${expected_location}    C:\\Users\\petri.ryynanen\\git\\Robot_Framework_REST\\Robot_Framework_REST\\Expected\\
${expected_response}    Put_expected.json
${save_response_location}    C:\\Users\\petri.ryynanen\\git\\Robot_Framework_REST\\Robot_Framework_REST\\Responses\\
${saved_response}    Put_response.json

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
    Create Binary File    ${save_response_location}${saved_response}  ${pretty_printed_response}
    ${response_to_be_edited}    Get File    ${save_response_location}${saved_response}
    ${edited_response}    Replace String Using Regexp    ${response_to_be_edited}    2018....................    edited_date
    ${final_response}    Replace String Using Regexp    ${edited_response}    \\d\\d{1,3}    edited_id
    Create Binary File    ${save_response_location}${saved_response}    ${final_response}
    ${response}    Get File    ${save_response_location}${saved_response}     
    ${expected}    Get File    ${expected_location}${expected_response} 
    Diff Files    ${response}     ${expected}        

*** Test Cases ***
Put test
    Test run
	#    robot -d results tests/put.robot