*** Settings ***
Library    RequestsLibrary    
Library    OperatingSystem     
Library    DiffLibrary     

*** Variables ***
${expected_location}    C:\\Users\\petri.ryynanen\\eclipse-workspace\\Robot_Framework_REST\\expected\\
${expected_response}    Get_response.json
${save_response_location}    C:\\Users\\petri.ryynanen\\eclipse-workspace\\Robot_Framework_REST\\responses
${file}    apina.txt

*** Keywords ***
Test run 
    Create File    ${save_response_location}apina.txt    Kissa    

*** Test Cases ***
Get test
    Test run
    #    robot -d results tests/get.robot