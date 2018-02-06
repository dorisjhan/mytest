*** Settings ***
Library           RequestsLibrary
Library           Collections

Force Tags    @FEATURE=CLOUD_API    @AUTHOR=Jill_Chou

*** Variables ***
${domainName}      https://s5-dropap.securepilot.com
${deviceid}     701a05010003
${devicepw}     j5b5xdh1
${apiKey}   DropAP-GFFnDFe4WM
${apiToken}     c37832b370ab9b51633ba20e2717f86435c37a95
${time}     20170925
${profile}  ${true}
${get_auth}     ${true}
${deviceInfo}   {"name": "My Device"}
${deviceInfoNew}    {"name": "My Device test"}
${pin}      18833648
${userId}   700009637


*** Test Cases ***
tc_Login_and_Get_Info_Device
    [Tags]    get    @FEATURE=CLOUD_API    @AUTHOR=Jennie_Chang
    ${auth}=    Create list    701a05010002    4u9kpm2h
    ${apiKey}=    Create list    DropAP-GFFnDFe4WM
    ${domainName}=    Set Variable    https://s5.securepilot.com
    ${apiToken}=    Create list    c37832b370ab9b51633ba20e2717f86435c37a95
    ${service}    Create list    MSG
    ${value}    Create list    MSG
    #device login api
    Create Digest Session    S5    ${domainName}    ${auth}    debug=3
    ${resp}=    Get Request    S5    /v1/device/login
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['status']['code']}    1221
    Delete All Sessions
    #get device info
    Create Session    S5    ${domainName}
    ${data} =    Create Dictionary    token=${resp.json()['global_session']['token']}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${resp1}=    Post Request    S5    /v1/device/get_info    data=${data}    headers=${headers}
    Log    ${resp1}
    Should Be Equal As Strings    ${resp1.status_code}    200
    Should Be Equal As Strings    ${resp1.json()['status']['code']}    1221
    Delete All Sessions
    # get_service_all
    Create Session    S5    ${domainName}
    ${data} =    Create Dictionary    token=${resp.json()['global_session']['token']}    api_key=${apiKey}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${resp2}=    Post Request    S5    /v1/device/get_service_all    data=${data}    headers=${headers}
    Should Be Equal As Strings    ${resp2.status_code}    200
    Should Be Equal As Strings    ${resp2.json()['status']['code']}    1200
    Log    ${resp2.json()['MSG']}
    Delete All Sessions
    #get service info (Get device Service)
    Create Session    S5    ${domainName}
    ${data} =    Create Dictionary    token=${resp.json()['global_session']['token']}    api_key=${apiKey}    info=${resp2.json()}    service=${service}
    Log    ${data}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${resp3}=    Post Request    S5    /v1/device/get_service_info    data=${data}    headers=${headers}
    Should Be Equal As Strings    ${resp3.status_code}    200
    Should Be Equal As Strings    ${resp3.json()['status']['code']}    1221
    Delete All Sessions

tc_Bind_and_unbind_user
    [Tags]    Bind /unbind user    @FEATURE=CLOUD_API    @AUTHOR=Jill_Chou
    ${auth}=    Create List    ${deviceid}    ${devicepw}
    Create Digest Session    S5    ${domainName}    auth=${auth}    debug=3
    ${resp1}=    Get Request    S5    /v1/device/login
    Should Be Equal As Strings    ${resp1.status_code}    200
    Should Be Equal As Strings    ${resp1.json()['status']['code']}    1221
    Delete All Sessions

    Create Session  S5  ${domainName}
    ${data}   Create Dictionary   token=${resp1.json()['global_session']['token']}     api_key=${apiKey}    user_id=${userId}    time=${time}    api_token=${apitoken}   level=0
    ${headers}   Create Dictionary   Content-Type=application/json
    ${resp}  Post Request      S5      /v1/device/add_user    headers=${headers}      data=${data}
    ${resp2}=    To Json  ${resp.content}
    Should Be Equal As Strings  ${resp.status_code}  200
    Should Be Equal As Strings    ${resp.json()['status']['code']}      1231
    Delete All Sessions

    Create Session  S5  ${domainName}
    ${data}   Create Dictionary   token=${resp1.json()['global_session']['token']}     api_key=${apiKey}    get_auth=${get_auth}
    ${headers}   Create Dictionary   Content-Type=application/json
    ${resp}  Post Request      S5      /v1/device/get_user_list    headers=${headers}      data=${data}
    ${resp2}=    To Json  ${resp.content}
    Should Be Equal As Strings  ${resp.status_code}  200
    should be equal as strings    ${resp.json()['user_list'][0]['uid']}     ${userid}
    Should Be Equal As Strings    ${resp.json()['status']['code']}      1240
    Delete All Sessions

    Create Session  S5  ${domainName}
    ${data}   Create Dictionary   token=${resp1.json()['global_session']['token']}     device_info=${deviceinfonew}
    ${headers}   Create Dictionary   Content-Type=application/json
    ${resp}  Put Request      S5      /v1/device/edit_info    headers=${headers}      data=${data}
    ${resp2}=    To Json  ${resp.content}
    Should Be Equal As Strings  ${resp.status_code}  200
    Should Be Equal As Strings    ${resp.json()['status']['code']}      1223
    Delete All Sessions

    Create Session  S5  ${domainName}
    ${data}   Create Dictionary   token=${resp1.json()['global_session']['token']}
    ${headers}   Create Dictionary   Content-Type=application/json
    ${resp}  Post Request      S5      /v1/device/get_info    headers=${headers}      data=${data}
    ${resp2}=    To Json  ${resp.content}
    Should Be Equal As Strings  ${resp.status_code}  200
    should be equal as strings    ${resp.json()['info']['profile']['name']}     My Device test
    Should Be Equal As Strings    ${resp.json()['status']['code']}      1221
    Delete All Sessions

    Create Session  S5  ${domainName}
    ${data}   Create Dictionary   token=${resp1.json()['global_session']['token']}     api_key=${apiKey}    get_auth=${get_auth}
    ${headers}   Create Dictionary   Content-Type=application/json
    ${resp}  Post Request      S5      /v1/device/get_user_list    headers=${headers}      data=${data}
    ${resp2}=    To Json  ${resp.content}
    Should Be Equal As Strings  ${resp.status_code}  200
    Should Be Equal As Strings    ${resp.json()['status']['code']}      1240
    Delete All Sessions

    Create Session  S5  ${domainName}
    ${data}   Create Dictionary   token=${resp1.json()['global_session']['token']}     api_key=${apiKey}    user_id=${userId}    time=${time}    api_token=${apitoken}
    ${headers}   Create Dictionary   Content-Type=application/json
    ${resp}  Post Request      S5      /v1/device/rm_user    headers=${headers}      data=${data}
    ${resp2}=    To Json  ${resp.content}
    Should Be Equal As Strings  ${resp.status_code}  200
    Should Be Equal As Strings    ${resp.json()['status']['code']}      1234
    Delete All Sessions

    Create Session  S5  ${domainName}
    ${data}   Create Dictionary   token=${resp1.json()['global_session']['token']}     api_key=${apiKey}    get_auth=${get_auth}
    ${headers}   Create Dictionary   Content-Type=application/json
    ${resp}  Post Request      S5      /v1/device/get_user_list    headers=${headers}      data=${data}
    ${resp2}=    To Json  ${resp.content}
    Should Be Equal As Strings  ${resp.status_code}  200
    Should Be Equal As Strings    ${resp.json()['status']['code']}      1240
    Delete All Sessions

tc_device_reset_default
    [Tags]    Bind /unbind user    @FEATURE=CLOUD_API    @AUTHOR=Jill_Chou
    ${auth}=    Create List    ${deviceid}    ${devicepw}
    Create Digest Session    S5    ${domainName}    auth=${auth}    debug=3
    ${resp1}=    Get Request    S5    /v1/device/login
    Should Be Equal As Strings    ${resp1.status_code}    200
    Should Be Equal As Strings    ${resp1.json()['status']['code']}    1221
    Delete All Sessions

    Create Session  S5  ${domainName}
    ${data}   Create Dictionary   token=${resp1.json()['global_session']['token']}     api_key=${apiKey}    user_id=${userId}    time=${time}    api_token=${apitoken}   level=0
    ${headers}   Create Dictionary   Content-Type=application/json
    ${resp}  Post Request      S5      /v1/device/add_user    headers=${headers}      data=${data}
    ${resp2}=    To Json  ${resp.content}
    Should Be Equal As Strings  ${resp.status_code}  200
    Should Be Equal As Strings    ${resp.json()['status']['code']}      1231
    Delete All Sessions

    Create Session  S5  ${domainName}
    ${data}   Create Dictionary   token=${resp1.json()['global_session']['token']}     api_key=${apiKey}    get_auth=${get_auth}
    ${headers}   Create Dictionary   Content-Type=application/json
    ${resp}  Post Request      S5      /v1/device/get_user_list    headers=${headers}      data=${data}
    ${resp2}=    To Json  ${resp.content}
    Should Be Equal As Strings  ${resp.status_code}  200
    should be equal as strings    ${resp.json()['user_list'][0]['uid']}     ${userid}
    Should Be Equal As Strings    ${resp.json()['status']['code']}      1240
    Delete All Sessions

    Create Session  S5  ${domainName}
    ${data}   Create Dictionary   token=${resp1.json()['global_session']['token']}     api_key=${apiKey}    time=${time}    api_token=${apitoken}
    ${headers}   Create Dictionary   Content-Type=application/json
    ${resp}  Post Request      S5      /v1/device/reset_default    headers=${headers}      data=${data}
    ${resp2}=    To Json  ${resp.content}
    Should Be Equal As Strings  ${resp.status_code}  200
    Should Be Equal As Strings    ${resp.json()['status']['code']}      1227
    Delete All Sessions

    Create Session  S5  ${domainName}
    ${data}   Create Dictionary   token=${resp1.json()['global_session']['token']}     api_key=${apiKey}    get_auth=${get_auth}
    ${headers}   Create Dictionary   Content-Type=application/json
    ${resp}  Post Request      S5      /v1/device/get_user_list    headers=${headers}      data=${data}
    ${resp2}=    To Json  ${resp.content}
    Should Be Equal As Strings  ${resp.status_code}  200
    Should Be Equal As Strings    ${resp.json()['status']['code']}      1240
    Delete All Sessions
