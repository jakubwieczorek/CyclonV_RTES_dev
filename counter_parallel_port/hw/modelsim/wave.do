onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /swap_test/Clk
add wave -noupdate /swap_test/nReset
add wave -noupdate /swap_test/sAddress
add wave -noupdate /swap_test/sChipSelect
add wave -noupdate /swap_test/sWrite
add wave -noupdate /swap_test/sWriteData
add wave -noupdate /swap_test/sRead
add wave -noupdate /swap_test/sReadData
add wave -noupdate /swap_test/mAddress
add wave -noupdate /swap_test/mByteEnable
add wave -noupdate /swap_test/mWrite
add wave -noupdate /swap_test/mWriteData
add wave -noupdate /swap_test/mRead
add wave -noupdate /swap_test/mReadData
add wave -noupdate /swap_test/mWaitRequest
add wave -noupdate /swap_test/period
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {1 us}
