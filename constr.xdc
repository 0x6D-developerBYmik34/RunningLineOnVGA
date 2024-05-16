#set_property -dict {PACKAGE_PIN J26 IOSTANDARD LVCMOS33} [get_ports {led_2}]
#set_property -dict {PACKAGE_PIN H26 IOSTANDARD LVCMOS33} [get_ports {led_3}]

create_clock -period 20.000 -waveform {0.000 10.000} [get_ports clk]
create_generated_clock -source [get_ports clk] -multiply_by 2 [get_pins design_top_i/clk_wiz_1/clk_out1]

set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS33} [get_ports clk]
set_property -dict {PACKAGE_PIN AF9 IOSTANDARD LVCMOS18} [get_ports rst_n]
#set_property -dict {PACKAGE_PIN AF10 IOSTANDARD LVCMOS18} [get_ports sw3]

#set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS33} [get_ports UART_rxd]
#E10
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports UART_txd]
#B10

#------VGA-------

set_property -dict {PACKAGE_PIN W26 IOSTANDARD LVCMOS33} [get_ports vga_hs]
set_property -dict {PACKAGE_PIN W25 IOSTANDARD LVCMOS33} [get_ports vga_vs]

set_property -dict {PACKAGE_PIN M26 IOSTANDARD LVCMOS33} [get_ports {vga_r[0]}]
set_property -dict {PACKAGE_PIN N23 IOSTANDARD LVCMOS33} [get_ports {vga_r[1]}]
set_property -dict {PACKAGE_PIN N26 IOSTANDARD LVCMOS33} [get_ports {vga_r[2]}]
set_property -dict {PACKAGE_PIN P25 IOSTANDARD LVCMOS33} [get_ports {vga_r[3]}]
set_property -dict {PACKAGE_PIN P23 IOSTANDARD LVCMOS33} [get_ports {vga_r[4]}]

set_property -dict {PACKAGE_PIN R25 IOSTANDARD LVCMOS33} [get_ports {vga_g[0]}]
set_property -dict {PACKAGE_PIN R23 IOSTANDARD LVCMOS33} [get_ports {vga_g[1]}]
set_property -dict {PACKAGE_PIN T23 IOSTANDARD LVCMOS33} [get_ports {vga_g[2]}]
set_property -dict {PACKAGE_PIN R22 IOSTANDARD LVCMOS33} [get_ports {vga_g[3]}]
set_property -dict {PACKAGE_PIN U25 IOSTANDARD LVCMOS33} [get_ports {vga_g[4]}]
set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS33} [get_ports {vga_g[5]}]

set_property -dict {PACKAGE_PIN U24 IOSTANDARD LVCMOS33} [get_ports {vga_b[0]}]
set_property -dict {PACKAGE_PIN V23 IOSTANDARD LVCMOS33} [get_ports {vga_b[1]}]
set_property -dict {PACKAGE_PIN V24 IOSTANDARD LVCMOS33} [get_ports {vga_b[2]}]
set_property -dict {PACKAGE_PIN U26 IOSTANDARD LVCMOS33} [get_ports {vga_b[3]}]
set_property -dict {PACKAGE_PIN V26 IOSTANDARD LVCMOS33} [get_ports {vga_b[4]}]
