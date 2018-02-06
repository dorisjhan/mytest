*** Settings ***
Resource    base.robot

Force Tags    @FEATURE=Web_GUI    @AUTHOR=Hans_Sun
Suite Teardown    Run keywords    Config Setup DropAP

*** Variables ***

*** Test Cases ***
tc_Reset
    [Documentation]  tc_Reset
    ...    1. Go to DeviceManager Reboot/Reset page
    ...    2. Click Perform Reset and wait for loading page is finished and return to homepage
    [Tags]   @TCID=WRTM-326ACN-175    @DUT=WRTM-326ACN     @AUTHOR=Hans_Sun
    [Timeout]

    Go to DeviceManager Reboot/Reset page
    Click Perform Reset and wait for loading page is finished and return to homepage

*** Keywords ***
Go to DeviceManager Reboot/Reset page
    [Documentation]  Login Web GUI
    [Tags]   @AUTHOR=Hans_Sun
    Login Web GUI

Click Perform Reset and wait for loading page is finished and return to homepage
    [Documentation]  Click Reset Button And Verify Function Is Work
    [Tags]   @AUTHOR=Hans_Sun
    Click Reset Button And Verify Function Is Work

*** comment ***
2017-10-11     Hans_Sun
Init the script
