*** Settings ***
Library    RequestsLibrary    
Library    OperatingSystem     
Library    DiffLibrary     

*** Variables ***
${expected_location}    C:\\Users\\petri.ryynanen\\eclipse-workspace\\Robot_Framework_REST\\Expected\\
${expected_response}    Get_response.json
${save_response_location}    C:\\Users\\petri.ryynanen\\eclipse-workspace\\Robot_Framework_REST\\Responses\\
${file}    apina.txt

*** Keywords ***
Test run 
    Create File    ${save_response_location}    ${file}    

*** Test Cases ***
Get test
    Test run
    #    robot -d results tests/get.robot