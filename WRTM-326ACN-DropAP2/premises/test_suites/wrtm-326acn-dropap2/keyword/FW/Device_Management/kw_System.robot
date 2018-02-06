*** Settings ***
Resource    base.robot

*** Variables ***
${Button_SYNC} =    xpath=//*[@id="cbi-system-cfg02e48a-_systime"]/div/input
${Text_time} =    xpath=//*[@id="_systime-clock-status"]
${Select_timezone} =    xpath=//*[@id="cbid.system.cfg02e48a.zonename"]
${System_save} =    xpath=//*[@id="maincontent"]/div/form/div[3]/input[1]
${Language_tab} =    xpath=//*[@id="tab.system.cfg02e48a.language"]/a
${Select_language} =    xpath=//*[@id="cbid.system.cfg02e48a._lang"]
${Checkbox_NTPClinet} =    xpath=//*[@id="cbid.system.ntp.enable"]
${Checkbox_NTPServer} =    xpath=//*[@id="cbid.system.ntp.enable_server"]
${Input_candidates1} =    xpath=//*[@id="cbid.system.ntp.server.4"]
${Input_candidates2} =    xpath=//*[@id="cbid.system.ntp.server.5"]
${Button_candidates} =    xpath=//*[@id="cbi-system-ntp-server"]/div/div/img[4]
${Default_ntp_server}    3.openwrt.pool.ntp.org
${New_ntp_server}    time.stdtime.gov.tw

*** Keywords ***
Get Real Time
    [Documentation]
    [Tags]   @AUTHOR=Hans_Sun
    ${result}    Get Element text    web    ${Text_time}
    log    ${result}
    [Return]    ${result}

Select Timezone By Value
    [Arguments]    ${value}
    [Documentation]
    [Tags]   @AUTHOR=Hans_Sun
    Wait Until Keyword Succeeds    3x    2s    select_from_list_by_label    web    ${Select_timezone}    ${value}
    cpe click    web    ${System_save}
    Wait Until Config Has Applied Completely

Select Language By Value
    [Arguments]    ${value}
    [Documentation]
    [Tags]   @AUTHOR=Hans_Sun
    Wait Until Keyword Succeeds    3x    2s    select_from_list_by_value    web    ${Select_language}    ${value}
    cpe click    web    ${System_save}
    Wait Until Config Has Applied Completely

Enable NTP Client
    [Documentation]
    [Tags]   @AUTHOR=Hans_Sun
    Wait Until Keyword Succeeds    3x    2s    Select Checkbox    web    ${Checkbox_NTPClinet}
    cpe click    web    ${System_save}
    Wait Until Config Has Applied Completely

Disable NTP Client
    [Documentation]
    [Tags]   @AUTHOR=Hans_Sun
    Wait Until Keyword Succeeds    3x    2s    Unselect checkbox    web    ${Checkbox_NTPClinet}
    cpe click    web    ${System_save}
    Wait Until Config Has Applied Completely

Enable NTP Server
    [Documentation]
    [Tags]   @AUTHOR=Hans_Sun
    Wait Until Keyword Succeeds    3x    2s    Select Checkbox    web    ${Checkbox_NTPServer}
    cpe click    web    ${System_save}
    Wait Until Config Has Applied Completely

Disable NTP Server
    [Documentation]
    [Tags]   @AUTHOR=Hans_Sun
    Wait Until Keyword Succeeds    3x    2s    Unselect checkbox    web    ${Checkbox_NTPServer}
    cpe click    web    ${System_save}
    Wait Until Config Has Applied Completely

Add NTP Server Candidates
    [Documentation]
    [Tags]   @AUTHOR=Hans_Sun
    cpe click    web    ${Button_candidates}
    input text    web    ${Input_candidates2}    ${New_ntp_server}
    cpe click    web    ${System_save}
    Wait Until Config Has Applied Completely

Delete NTP Server Candidates
    [Documentation]
    [Tags]   @AUTHOR=Hans_Sun
    cpe click    web    ${Button_candidates}
    cpe click    web    ${System_save}
    Wait Until Config Has Applied Completely

Update NTP Server Candidates
    [Documentation]
    [Tags]   @AUTHOR=Hans_Sun
    input text    web    ${Input_candidates1}    ${New_ntp_server}
    cpe click    web    ${System_save}
    Wait Until Config Has Applied Completely
