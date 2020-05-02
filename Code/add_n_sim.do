setenv LMC_TIMEUNIT -9
vlib work
vmap work work 
vcom -work work "bram.vhd"
vcom -work work "bram_block.vhd"
vcom -work work "add_n.vhd" 
vcom -work work "add_n_top.vhd"
vcom -work work "add_n_tb.vhd"
vsim +notimingchecks -L work work.add_n_tb -wlf add_n_sim.wlf 

add wave -noupdate -group add_n_tb
add wave -noupdate -group add_n_tb -radix hexadecimal /add_n_tb/*
add wave -noupdate -group add_n_tb/add_n_top_inst
add wave -noupdate -group add_n_tb/add_n_top_inst -radix hexadecimal /add_n_tb/add_n_top_inst/*
add wave -noupdate -group add_n_tb/add_n_top_inst/add_n_inst
add wave -noupdate -group add_n_tb/add_n_top_inst/add_n_inst -radix hexadecimal /add_n_tb/add_n_top_inst/add_n_inst/*
add wave -noupdate -group add_n_tb/add_n_top_inst/x_inst
add wave -noupdate -group add_n_tb/add_n_top_inst/x_inst -radix hexadecimal /add_n_tb/add_n_top_inst/x_inst/*
add wave -noupdate -group add_n_tb/add_n_top_inst/y_inst
add wave -noupdate -group add_n_tb/add_n_top_inst/y_inst -radix hexadecimal /add_n_tb/add_n_top_inst/y_inst/*
add wave -noupdate -group add_n_tb/add_n_top_inst/z_inst
add wave -noupdate -group add_n_tb/add_n_top_inst/z_inst -radix hexadecimal /add_n_tb/add_n_top_inst/z_inst/*
run -all