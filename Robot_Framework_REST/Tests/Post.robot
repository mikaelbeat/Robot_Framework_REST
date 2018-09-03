*** Settings ***
Library    RequestsLibrary    
Library    OperatingSystem      

*** Variables ***
${payload_location}    C:\\Users\\petri.ryynanen\\eclipse-workspace\\Robot_Framework_REST\\payloads\\
${payload}    Create_user.Json 

*** Keywords ***
Test run
    ${payload}    get binary file    ${payload_location}${payload}  
    Create Session    postSession    https://reqres.in       verify=true
    ${response}    Post Request    postSession    /api/users    ${payload}
    log    ${response.status_code}
    log    ${response.text}
    Should Be Equal As Strings    ${response.status_code}    201   
    Should Contain    ${response.text}    createdAt     

*** Test Cases ***
Post test
    Test run
#    robot -d results tests/post.robot