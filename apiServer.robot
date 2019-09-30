*** Settings ***				
Library	Collections			
Library	RequestsLibrary	

*** Variables ***
${URL}    http://localhost:3000

*** Test Cases ***
Get Items 
    Create Session    Api    ${URL}    
    ${resp}=    Get Request    Api    /getItems
    Should Be Equal As Strings    ${resp.status_code}    200
    ${resultJson}=     To Json    ${resp.content}
    ${result}=    Convert To Dictionary    ${resultJson}
    
    ${expect_ED852942182TH[0]}=    Create Dictionary    barcode=ED852942182TH   status=103    status_description=รับฝาก    status_date=19/07/2562 18:12:26+07:00    location=คต.กาดสวนแก้ว     postcode=00131
    ${expect_ED852942182TH[1]}=    Create Dictionary    barcode=ED852942182TH   status=201    status_description=ส่งออกจากที่ทำการกลางทาง    status_date=20/07/2562 15:12:15+07:00    location=คต.กาดสวนแก้ว     postcode=00131

    ${expect_ED852942182TH}=    Create List	    ${expect_ED852942182TH[0]}    ${expect_ED852942182TH[1]}
    ${count_number}=    Convert To Integer    48
    ${track_count_limit}=    Convert To Integer    1500
    ${expect_track_count}=    Create Dictionary    track_date=27/08/2562    count_number=${count_number}    track_count_limit=${track_count_limit}
    ${expect_items}=    Create Dictionary    ED852942182TH=${expect_ED852942182TH}
    ${status}=    Convert To Boolean    true

    ${expect_response}=    Create Dictionary    items_return=${expect_items}    track_count=${expect_track_count}
    ${expect_getItems}=    Create Dictionary    response=${expect_response}    message=successful    status=${status}
    
    Should Be Equal    ${resultJson}     ${expect_getItems}
    