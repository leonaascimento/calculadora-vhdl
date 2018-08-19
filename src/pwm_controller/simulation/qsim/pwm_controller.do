onerror {quit -f}
vlib work
vlog -work work pwm_controller.vo
vlog -work work pwm_controller.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.pwm_controller_vlg_vec_tst
vcd file -direction pwm_controller.msim.vcd
vcd add -internal pwm_controller_vlg_vec_tst/*
vcd add -internal pwm_controller_vlg_vec_tst/i1/*
add wave /*
run -all
