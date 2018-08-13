onerror {quit -f}
vlib work
vlog -work work stack.vo
vlog -work work stack.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.stack_vlg_vec_tst
vcd file -direction stack.msim.vcd
vcd add -internal stack_vlg_vec_tst/*
vcd add -internal stack_vlg_vec_tst/i1/*
add wave /*
run -all
