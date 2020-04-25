# TCL File Generated by Component Editor 18.1
# Wed Apr 22 20:20:01 CEST 2020
# DO NOT MODIFY


# 
# swap_accelerator "swap_accelerator" v1.0
# Jakub Wieczorek 2020.04.22.20:20:01
# swap accelerator components with DMA
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module swap_accelerator
# 
set_module_property DESCRIPTION "swap accelerator components with DMA"
set_module_property NAME swap_accelerator
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP custom_components
set_module_property AUTHOR "Jakub Wieczorek"
set_module_property DISPLAY_NAME swap_accelerator
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL swap
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file swap.vhd VHDL PATH ../hdl/swap.vhd TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock Clk clk Input 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset reset_sink_1
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 sAddress address Input 3
add_interface_port avalon_slave_0 sChipSelect chipselect Input 1
add_interface_port avalon_slave_0 sWrite write Input 1
add_interface_port avalon_slave_0 sWriteData writedata Input 32
add_interface_port avalon_slave_0 sRead read Input 1
add_interface_port avalon_slave_0 sReadData readdata Output 32
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point reset_sink_1
# 
add_interface reset_sink_1 reset end
set_interface_property reset_sink_1 associatedClock clock
set_interface_property reset_sink_1 synchronousEdges DEASSERT
set_interface_property reset_sink_1 ENABLED true
set_interface_property reset_sink_1 EXPORT_OF ""
set_interface_property reset_sink_1 PORT_NAME_MAP ""
set_interface_property reset_sink_1 CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink_1 SVD_ADDRESS_GROUP ""

add_interface_port reset_sink_1 nReset reset_n Input 1


# 
# connection point avalon_master
# 
add_interface avalon_master avalon start
set_interface_property avalon_master addressUnits SYMBOLS
set_interface_property avalon_master associatedClock clock
set_interface_property avalon_master associatedReset reset_sink_1
set_interface_property avalon_master bitsPerSymbol 8
set_interface_property avalon_master burstOnBurstBoundariesOnly false
set_interface_property avalon_master burstcountUnits WORDS
set_interface_property avalon_master doStreamReads false
set_interface_property avalon_master doStreamWrites false
set_interface_property avalon_master holdTime 0
set_interface_property avalon_master linewrapBursts false
set_interface_property avalon_master maximumPendingReadTransactions 0
set_interface_property avalon_master maximumPendingWriteTransactions 0
set_interface_property avalon_master readLatency 0
set_interface_property avalon_master readWaitTime 1
set_interface_property avalon_master setupTime 0
set_interface_property avalon_master timingUnits Cycles
set_interface_property avalon_master writeWaitTime 0
set_interface_property avalon_master ENABLED true
set_interface_property avalon_master EXPORT_OF ""
set_interface_property avalon_master PORT_NAME_MAP ""
set_interface_property avalon_master CMSIS_SVD_VARIABLES ""
set_interface_property avalon_master SVD_ADDRESS_GROUP ""

add_interface_port avalon_master mAddress address Output 32
add_interface_port avalon_master mByteEnable byteenable Output 4
add_interface_port avalon_master mRead read Output 1
add_interface_port avalon_master mReadData readdata Input 32
add_interface_port avalon_master mWaitRequest waitrequest Input 1
add_interface_port avalon_master mWrite write Output 1
add_interface_port avalon_master mWriteData writedata Output 32

