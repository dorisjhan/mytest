*** Settings ***
Resource    base.robot

*** Variables ***
${Table_Wan_Type} =     xpath=/html/body/div/div[3]/div[2]/div/fieldset[3]/table/tbody/tr[1]/td[2]/table/tbody/tr/td/small/strong[1]
${Table_Wan} =     xpath=/html/body/div/div[3]/div[2]/div/fieldset[3]/table/tbody/tr[1]/td[2]/table

*** Keywords ***
Verify DHCP Wan Type
    [Arguments]
    [Documentation]
    [Tags]
    Wait Until Keyword Succeeds    10x    2s    click links    web    Status  Overview
    Wait Until Keyword Succeeds    5x    2s    Check Wan Type    web   dhcp

Verify Static Wan Type
    [Arguments]
    [Documentation]
    [Tags]
    Wait Until Keyword Succeeds    10x    2s    click links    web    Status  Overview
    ${result}    Wait Until Keyword Succeeds    5x    2s    Check Wan Type    web    static
    Should Contain    ${result}    ${g_dut_static_ipaddr}

Check Wan Type
    [Arguments]    ${b}    ${type}
    [Documentation]
    [Tags]
    Reload Page    ${b}
    sleep    1
    ${value}    get_element_text    ${b}    ${Table_Wan}
    log    ${value}
    Should Contain    ${value}    ${type}
    [return]    ${value}