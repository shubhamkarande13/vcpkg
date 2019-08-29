# header only
include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/SimpleAmqpClient-2.4.0)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/alanxz/SimpleAmqpClient/archive/v2.4.0.tar.gz"
    FILENAME "simpleamqpclient-2.4.tar.gz"
    SHA512 f36a0a941f8987b617bdd9d16bebf93c4daf7edc6631e73587bb3e24516a048dc06ba3aa977c095e0bb5e9ab3b251a415397081b9f4802fcd22fd6010e649954
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS
        -DENABLE_TESTING=OFF
        -DRabbitmqc_INCLUDE_DIR=${CURRENT_INSTALLED_DIR}/include
        -DRabbitmqc_LIBRARY=${CURRENT_INSTALLED_DIR}/lib/rabbitmq.4.lib
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

# Remove duplicate headers installed from debug build
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
# Remove data installed from debug build
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share/simpleamqpclient)
file(INSTALL ${SOURCE_PATH}/LICENSE-MIT DESTINATION ${CURRENT_PACKAGES_DIR}/share/simpleamqpclient RENAME copyright)
