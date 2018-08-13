onerror {quit -f}
vlib work
vlog -work work subtractor.vo
vlog -work work subtractor.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.subtractor_vlg_vec_tst
vcd file -direction subtractor.msim.vcd
vcd add -internal subtractor_vlg_vec_tst/*
vcd add -internal subtractor_vlg_vec_tst/i1/*
add wave /*
run -all
