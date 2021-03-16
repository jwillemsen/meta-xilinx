inherit features_check

REQUIRED_DISTRO_FEATURES = "canps"

inherit esw python3native

DEPENDS += "xilstandalone xilmem"

ESW_COMPONENT_SRC = "/XilinxProcessorIPLib/drivers/canps/src/"
ESW_COMPONENT_NAME = "libcanps.a"

addtask do_generate_driver_data before do_configure after do_prepare_recipe_sysroot
do_prepare_recipe_sysroot[rdeptask] = "do_unpack"
