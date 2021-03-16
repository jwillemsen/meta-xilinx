inherit esw deploy python3native

DEPENDS += "python3-dtc-native python3-pyyaml-native xilstandalone libxil xiltimer"

do_configure_prepend() {
    cd ${S}
    lopper.py ${DTS_FILE} -- baremetallinker_xlnx.py ${ESW_MACHINE} ${S}/${ESW_COMPONENT_SRC}
    install -m 0755 memory.ld ${S}/${ESW_COMPONENT_SRC}/
    install -m 0755 *.cmake ${S}/${ESW_COMPONENT_SRC}/
}

do_generate_eglist () {
    cd ${S}
    lopper.py ${DTS_FILE} -- bmcmake_metadata_xlnx.py ${ESW_MACHINE} ${S}/${ESW_COMPONENT_SRC} drvcmake_metadata
    install -m 0755 *.cmake ${S}/${ESW_COMPONENT_SRC}/
}
addtask generate_eglist before do_configure after do_prepare_recipe_sysroot
do_prepare_recipe_sysroot[rdeptask] = "do_unpack"

do_install() {
    install -d ${D}/${base_libdir}/firmware
    install -m 0755  ${B}/*.elf ${D}/${base_libdir}/firmware
}

do_deploy() {
    install -d ${DEPLOYDIR}/${MACHINE}-${BPN}/
    install -Dm 0644 ${WORKDIR}/package/${base_libdir}/firmware/*.elf ${DEPLOYDIR}/${MACHINE}-${BPN}/
}
addtask deploy before do_build after do_package

FILES_${PN} = "${base_libdir}/firmware/*.elf"
