*** Settings ***
Resource    base.robot

*** Variables ***
${Select_Protocal} =    xpath=//*[@id="cbid.network.wan.proto"]
${Button_Save} =    xpath=//*[@id="maincontent"]/div/form/div[3]/input[1]
${Input_Static_IP}    xpath=//*[@id="cbid.network.wan.ipaddr"]
${Input_Subnet_Mask}    xpath=//*[@id="cbid.network.wan.netmask"]
${Input_Static_Gateway}    xpath=//*[@id="cbid.network.wan.gateway"]
${Input_Static_DNS1}    xpath=//*[@id="cbid.network.wan.dns.1"]
${Input_PPPoE_Username}    xpath=//*[@id="cbid.network.wan.username"]
${Input_PPPoE_Password}    xpath=//*[@id="cbid.network.wan.password"]
${InvalidIPHTMLMSG}    css=input[class="cbi-input-text cbi-input-invalid"]

*** Keywords ***
Config DHCP Client
    [Arguments]
    [Documentation]
    [Tags]
    Wait Until Keyword Succeeds    3x    2s    click links    web    Networking  Internet Connection
    Wait Until Keyword Succeeds    3x    2s    select_from_list_by_value    web    ${Select_Protocal}    dhcp
    Wait Until Keyword Succeeds    3x    2s    cpe click    web    ${Button_Save}
    Wait Until Config Has Applied Completely

Config Static Client
    [Arguments]
    [Documentation]
    [Tags]
    Wait Until Keyword Succeeds    3x    2s    click links    web    Networking  Internet Connection
    Wait Until Keyword Succeeds    3x    2s    select_from_list_by_value    web    ${Select_Protocal}    static
    Input Text    web    ${Input_Static_IP}    ${g_dut_static_ipaddr}
    Input Text    web    ${Input_Subnet_Mask}    ${g_dut_static_netmask}
    Input Text    web    ${Input_Static_Gateway}    ${g_dut_static_gateway}
    Input Text    web    ${Input_Static_DNS1}    ${g_dut_static_dns1}
    Wait Until Keyword Succeeds    3x    2s    cpe click    web    ${Button_Save}
    Wait Until Config Has Applied Completely

Config PPPoE Cleint
    [Arguments]    ${username}    ${password}
    [Documentation]
    [Tags]
    Wait Until Keyword Succeeds    3x    2s    click links    web    Networking  Internet Connection
    Wait Until Keyword Succeeds    3x    2s    select_from_list_by_value    web    ${Select_Protocal}    pppoe
    Input Text    web    ${Input_PPPoE_Username}    ${username}
    Input Text    web    ${Input_PPPoE_Password}    ${password}
    Wait Until Keyword Succeeds    3x    2s    cpe click    web    ${Button_Save}
    Wait Until Config Has Applied Completely