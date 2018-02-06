*** Settings ***
Resource          ../base.robot
Resource          ./P800_kw.robot
Library           Collections
#Library           Selenium2Library

#import gui  keywords
Resource    keyword/FW/kw_Common.robot
Resource    keyword/FW/kw_Main_Menu.robot
Resource    keyword/FW/Device_Management/kw_Firmware.robot
Resource    keyword/FW/Device_Management/kw_System.robot
Resource    keyword/FW/Device_Management/kw_Reboot_Reset.robot
Resource    keyword/FW/Networking/kw_Diagnostics.robot
Resource    keyword/FW/Networking/kw_Internet_Connection.robot
Resource    keyword/FW/Networking/kw_Wireless.robot
Resource    keyword/FW/Networking/kw_Wireless_Extender.robot
Resource    keyword/FW/Status/kw_DMS.robot
Resource    keyword/FW/Status/kw_Overview.robot
