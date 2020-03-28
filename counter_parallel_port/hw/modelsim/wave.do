onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /parallel_port_tb/parallel_port_instance/Clk
add wave -noupdate /parallel_port_tb/parallel_port_instance/IRQ
add wave -noupdate /parallel_port_tb/parallel_port_instance/ParPort
add wave -noupdate /parallel_port_tb/parallel_port_instance/iRegDir
add wave -noupdate /parallel_port_tb/parallel_port_instance/iRegPort
add wave -noupdate /parallel_port_tb/parallel_port_instance/iRegPin
add wave -noupdate /parallel_port_tb/parallel_port_instance/iIRQEn
add wave -noupdate /parallel_port_tb/ParPort(2)
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 347
configure wave -valuecolwidth 114
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {821 ns}
