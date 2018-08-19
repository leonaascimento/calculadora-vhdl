onerror {quit -f}
vlib work
vlog -work work pwm_module.vo
vlog -work work pwm_module.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.pwm_module_vlg_vec_tst
vcd file -direction pwm_module.msim.vcd
vcd add -internal pwm_module_vlg_vec_tst/*
vcd add -internal pwm_module_vlg_vec_tst/i1/*
add wave /*
run -all
