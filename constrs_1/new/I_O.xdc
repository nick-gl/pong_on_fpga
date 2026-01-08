#clk
set_property PACKAGE_PIN F14 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
create_clock -name sys_clock -period 83.333 [get_ports {clk}]

#rst
set_property PACKAGE_PIN C18 [get_ports {rst}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst}]

#butttons 
set_property PACKAGE_PIN G15 [get_ports {up_right}]
set_property IOSTANDARD LVCMOS33 [get_ports {up_right}]
set_property PACKAGE_PIN K16 [get_ports {down_right}]
set_property IOSTANDARD LVCMOS33 [get_ports {down_right}]

set_property PACKAGE_PIN J16 [get_ports {up_left}]
set_property IOSTANDARD LVCMOS33 [get_ports {up_left}]
set_property PACKAGE_PIN H13 [get_ports {down_left}]
set_property IOSTANDARD LVCMOS33 [get_ports {down_left}]

set_property PULLDOWN true       [get_ports {up_right down_right up_left down_left}]

#uart
set_property PACKAGE_PIN R12 [get_ports {tx}]  
set_property IOSTANDARD LVCMOS33 [get_ports {tx}]

#ball_radius
## Switches for ball_radius[3:0]
set_property PACKAGE_PIN H14 [get_ports {ball_radius[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ball_radius[0]}]
set_property PULLUP true [get_ports {ball_radius[0]}]

set_property PACKAGE_PIN H18 [get_ports {ball_radius[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ball_radius[1]}]
set_property PULLUP true [get_ports {ball_radius[1]}]

set_property PACKAGE_PIN G18 [get_ports {ball_radius[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ball_radius[2]}]
set_property PULLUP true [get_ports {ball_radius[2]}]

set_property PACKAGE_PIN M5 [get_ports {ball_radius[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ball_radius[3]}]
set_property PULLUP true [get_ports {ball_radius[3]}]



