*** Settings ***
Resource      base.robot


*** Variables ***
${Input_SSID} =     css=input[id="cbid.wireless.ra0.ssid"]
${Checkbox_Hidden_SSID} =      id=cbid.wireless.ra0.hidden
${Select_Security}=    css=select[id="cbid.wireless.ra0.encryption"]
${Input_Password}=     css=input[id="cbid.wireless.ra0._wepkey"]
${Button_SAVE} =    xpath=/html/body/div/div[3]/div[2]/div/form/div[3]/input[1]
${Select_Guest_Turn_On_Off}=    css=select[id="cbid.wireless.ra1.disabled"]
${Input_Guest_SSID}=    css=input[id="cbid.wireless.ra1.ssid"]
${Previous_SSID} =
${Previous_Checkbox_Hidden_SSID_State}=
${Previous_Select_Security}=
${Previous_Input_Password}=
#${Previous_Guest_Network_Radio_On_Off}=
${Previous_Guest_Network_SSID}=
${Input_PasswordForWPA-PSK}=     xpath=//*[@id="cbid.wireless.ra0._wpakey"]
${InvalidHtmlMSGForWirelessPassword}    css=input[class="cbi-input-password cbi-input-invalid"]

*** Keywords ***

Set SSID Value
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]  ${ssid}
    input text    web    ${Input_SSID}    ${ssid}
    Save Wireless Config

Set Hidden SSID Checkbox to Checked
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
     Select Checkbox    web    ${Checkbox_Hidden_SSID}
     Save Wireless Config

Verify Hidden SSID Checkbox is Checked
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    Checkbox Should Be Selected     web     ${Checkbox_Hidden_SSID}

Backup Current Checkbox Hidden SSID State
    [Documentation]
    [Tags]  @AUTHOR=Johnny_Peng
    ${checkbox_state} =     run keyword and return status   Checkbox Should Be Selected     web     ${Checkbox_Hidden_SSID}
    Set Test Variable       ${Previous_Checkbox_Hidden_SSID_State}    ${checkbox_state}

Restore To Previous Checkbox Hidden SSID State
    [Documentation]  Restore the checkbox state
    [Tags]  @AUTHOR=Johnny_Peng
    kw_Common.Set Checkbox State     ${Checkbox_Hidden_SSID}      ${Previous_Checkbox_Hidden_SSID_State}
    Save Wireless Config

Reset To Default Checkbox Hidden SSID State
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    Unselect checkbox       web     ${Checkbox_Hidden_SSID}
    Save Wireless Config

Backup Previous SSID Value
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    ${element_value} =     Get Element Value     web      ${Input_SSID}
    Set Test Variable       ${Previous_SSID}    ${element_value}

Restore To Previous SSID Value
    Set SSID Value       ${Previous_SSID}

Verify SSID Value
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]  ${ssid}
    Wait Until Element Is Visible    web    ${Input_SSID}
    ${input_text}=     Get Element value    web     ${Input_SSID}
    should be equal   ${ssid}    ${input_text}


Backup Current Security And Password State
    [Documentation]  Backup Security List Value, if Security List Value is not Open, Backup Password Value
    [Tags]   @AUTHOR=Johnny_Peng
    Backup Current Security State
    Backup Current Password State

Get Security Value
    [Documentation]
    [Tags]  @AUTHOR=Johnny_Peng
    ${security_value}=   Wait Until Keyword Succeeds    5x    3s    get selected list label    web    ${Select_Security}
    [Return]    ${security_value}

Backup Current Security State
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    ${security_value}=   Get Security Value
    Set Test Variable   ${Previous_Select_Security}     ${security_value}

Backup Current Password State
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    ${input_password_is_visible}=   Assert Password Input Is Visible
    Run Keyword Unless      ${input_password_is_visible}==True
    ...                      Return From Keyword

    ${password}=     Get Element Value     web      ${Input_Password}
    Set Test Variable   ${Previous_Input_Password}     ${password}

Set Security And Password
    [Documentation]  Write Security and Password Value
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]     ${security}     ${password}
    Set Security Value    ${security}
    Set Password    ${password}
    Save Wireless Config

Set Security Value
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]       ${security}
    Select From List By Label    web    ${Select_Security}    ${security}

Set Password For WPA-PSK Security Type
    [Documentation]
    [Tags]   @AUTHOR=Jujung_Chang
    [Arguments]     ${password}
    ${input_password_is_visible}=    Assert Password Input Is Visible
    Run Keyword Unless      ${input_password_is_visible}==True
        ...                      Return From Keyword
    input text    web    ${Input_PasswordForWPA-PSK}    ${password}

Set Password
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]     ${password}
    ${input_password_is_visible}=    Assert Password Input Is Visible
    Run Keyword Unless      ${input_password_is_visible}==True
        ...                      Return From Keyword
    input text    web    ${Input_Password}    ${password}

Verify Security And Password Were Set
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]     ${security}    ${password}
    Assert Security Value     ${security}
    Assert Password Value     ${password}

Assert Security Value
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]     ${security}
    ${current_securiry_value}=    Get Security Value
    should be equal   ${security}    ${current_securiry_value}

Assert Password Value
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]   ${password}
    ${input_password_is_visible}=    Assert Password Input Is Visible
    Run Keyword Unless      ${input_password_is_visible}==True
    ...                      Return From Keyword
    ${current_password_value}=      Get Element Value     web      ${Input_Password}
    should be equal   ${password}    ${current_password_value}

Restore To Previous Security State
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    Set Security And Password   ${Previous_Select_Security}     ${Previous_Input_Password}


#Guest Network


Set Guest Network Radio State
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]     ${radio_on_off}
    Select From List By Label    web    ${Select_Guest_Turn_On_Off}    ${radio_on_off}
    Save Wireless Config

Verify Guest Network Radio Is on or off
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]     ${radio_on_off}
    ${current_radio_is_on_off}=    Wait Until Keyword Succeeds    5x    3s    get selected list label    web    ${Select_Guest_Turn_On_Off}
    should be equal   ${radio_on_off}     ${current_radio_is_on_off}

Backup Current Guest Network SSID
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
     ${element_value} =     Get Element Value     web      ${Input_Guest_SSID}
     Set Test Variable       ${Previous_Guest_Network_SSID}    ${element_value}

Verify Guest Network SSID Value
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]     ${guest_network_ssid}
    ${current_guest_network_ssid_value}=      Get Element Value     web      ${Input_Guest_SSID}
    should be equal   ${guest_network_ssid}     ${current_guest_network_ssid_value}

Restore Guest Network SSID
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    Set Guest Network SSID    ${previous_guest_network_ssid}


Turn On Guest Network and Set Guest Network SSID
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]     ${guest_network_ssid}
    Select From List By Label    web    ${Select_Guest_Turn_On_Off}    on
    input text    web    ${Input_Guest_SSID}    ${guest_network_ssid}
    Save Wireless Config

Assert Password Input Is Visible
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    ${security_value}=      Get Security Value
    ${is_visible}=  run keyword and return status   should not be equal     ${security_value}       Open
    [Return]    ${is_visible}

Set Guest Network SSID
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    [Arguments]     ${guest_network_ssid}
    input text    web    ${Input_Guest_SSID}    ${guest_network_ssid}
    Save Wireless Config
#

Save Wireless Config
    [Documentation]
    [Tags]   @AUTHOR=Johnny_Peng
    cpe click       web    ${Button_SAVE}
    kw_Common.Wait Until Config Has Applied Completely


