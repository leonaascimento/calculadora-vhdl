onerror {quit -f}
vlib work
vlog -work work operator_adapter.vo
vlog -work work operator_adapter.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.operator_adapter_vlg_vec_tst
vcd file -direction operator_adapter.msim.vcd
vcd add -internal operator_adapter_vlg_vec_tst/*
vcd add -internal operator_adapter_vlg_vec_tst/i1/*
add wave /*
run -all
