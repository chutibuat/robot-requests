*** Settings ***				
Library	Collections			
Library	RequestsLibrary	

*** Variables ***
${URL}    https://trackapi.thailandpost.co.th/post/api/v1
${AUTHORIZATION}    Token AuQELmZ^OQMyZ0ZEPmY+PQVdA8U5JaD4WYO9JPG4VKE^YHDUPqQdTZMZSaUSG~E1U!T?TEP8CpYiHIFOH#S=EGTFRcZPWPW2VvDi


*** Test Cases ***				
Get Requests status 200 and success	
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${AUTHORIZATION}
    Create Session    Api    ${URL}    headers=${headers}	
    ${resp}=    Get Request    Api    /authenticate/token
    Should Be Equal As Strings    ${resp.status_code}    200
    ${resultJson}=     To Json    ${resp.content}
    &{result}=    Convert To Dictionary    ${resultJson}
    Should Not Be Empty    ${result.expire}
    Should Not Be Empty    ${result.token}
    Set Suite Variable    ${AUTHORIZATION_GET_ITEMS}    ${result.token}

Get Items 
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Token ${AUTHORIZATION_GET_ITEMS}
    ${barcode}=     Create List    EY145587896TH    RC338848854TH
    ${body}=    Create Dictionary    status=all    language=TH    barcode=${barcode}
    Create Session    Api    ${URL}    headers=${headers}    
    ${resp}=    Post Request    Api    /track    data=${body}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${resultJson}=     To Json    ${resp.content}
    &{result}=    Convert To Dictionary    ${resultJson}

    ${empty_list}=    Create List
    ${expect_items}=    Create Dictionary    EY145587896TH=${empty_list}    RC338848854TH=${empty_list} 

    Should Be Equal    ${result.response.track_count.track_date}    30/09/2562
    Should Be Equal    ${result.response['items']}     ${expect_items}
    