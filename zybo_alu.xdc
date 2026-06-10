## ===============================
## System Clock (125 MHz PL clock)
## ===============================
set_property -dict { PACKAGE_PIN K17 IOSTANDARD LVCMOS33 } [get_ports sysclk]
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports sysclk]


## ===============================
## Push Buttons
## ===============================
set_property -dict { PACKAGE_PIN K18 IOSTANDARD LVCMOS33 } [get_ports btn0]   ; # BTN0
set_property -dict { PACKAGE_PIN P16 IOSTANDARD LVCMOS33 } [get_ports btn1]   ; # BTN1
set_property -dict { PACKAGE_PIN K19 IOSTANDARD LVCMOS33 } [get_ports btn2]   ; # BTN2
set_property -dict { PACKAGE_PIN Y16 IOSTANDARD LVCMOS33 } [get_ports btn3]   ; # BTN3

## ===============================
## Slide Switches (4-bit input)
## ===============================
set_property -dict { PACKAGE_PIN G15 IOSTANDARD LVCMOS33 } [get_ports sw[0]] ; # SW0
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports sw[1]] ; # SW1
set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports sw[2]] ; # SW2
set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [get_ports sw[3]] ; # SW3


## ===============================
## LEDs (4-bit output display)
## ===============================
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports led[0]] ; # LED0
set_property -dict { PACKAGE_PIN M15 IOSTANDARD LVCMOS33 } [get_ports led[1]] ; # LED1
set_property -dict { PACKAGE_PIN G14 IOSTANDARD LVCMOS33 } [get_ports led[2]] ; # LED2
set_property -dict { PACKAGE_PIN D18 IOSTANDARD LVCMOS33 } [get_ports led[3]] ; # LED3