*** Settings ***				
Library	Collections			
Library	RequestsLibrary	

*** Variables ***
${URL}    https://trackapi.thailandpost.co.th/post
${AUTHORIZATION}    Token JdU!U:LGDlYFAgCBYRVLLUO;GhYEM#PCK.P!CxSuLLLfXLExI$M*J&Y|C^DhWAX-AKQVNuE6K?RmUMDDHKY2ZcM3D#X;MBPsSrOv


*** Test Cases ***				
Get Requests status 200 and success	
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${AUTHORIZATION}
    Create Session    Api    ${URL}    headers=${headers}	
    ${resp}=    Get Request    Api    /api/v1/authenticate/token
    Should Be Equal As Strings    ${resp.status_code}    200
    ${resultJson}=     To Json    ${resp.content}
    &{result}=    Convert To Dictionary    ${resultJson}
    Should Not Be Empty    ${result.expire}

# Get Requests length 
#     ${resp}=    Get Request    Api    /comments?postId=1
#     Should Be Equal As Strings    ${resp.status_code}    404
    # ${resultJson}=     To Json    ${resp.content}
    # ${length}=    Get Length    ${resultJson}
    # Should Be Equal As Integers    ${length}    5
    