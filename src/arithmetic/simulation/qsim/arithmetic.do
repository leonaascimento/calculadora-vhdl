onerror {quit -f}
vlib work
vlog -work work arithmetic.vo
vlog -work work arithmetic.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.arithmetic_vlg_vec_tst
vcd file -direction arithmetic.msim.vcd
vcd add -internal arithmetic_vlg_vec_tst/*
vcd add -internal arithmetic_vlg_vec_tst/i1/*
add wave /*
run -all
