""
load("//:utilities_cc_toolchain_config.bzl", "cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

MINGW_ATTIFACTS_PATTERNS = {
    "windows_x86_64": "executable//.exe"
}

cc_toolchain_config(
    name = "cc_toolchain_config_%{clang_id}",
    toolchain_identifier = "%{clang_id}",
    host_name = "%{host_name}",
    target_name = "%{target_name}",
    target_cpu = "%{target_cpu}",
    compiler = {
        "name": "clang",
        "cc": "clang",
        "cxx": "clang++",
    },
    toolchain_bins = "@%{archive_name}//:compiler_components",
    artifacts_patterns_packed = MINGW_ATTIFACTS_PATTERNS["%{host_name}"],
    flags = {
        "cpp_copts": "",
        "conly_copts": "",
        "cxx_copts":  "",
        "link_copts":  ""
    },
    cxx_builtin_include_directories = [
        "%{toolchain_path_prefix}include",
        "%{toolchain_path_prefix}x86_64-w64-mingw32/include",
        "%{toolchain_path_prefix}lib/clang/%{clang_version}/include",
    ],
    lib_directories = [
        "%{toolchain_path_prefix}x86_64-w64-mingw32/lib",
    ]
)

cc_toolchain(
    name = "cc_toolchain_%{clang_id}",
    toolchain_identifier = "%{clang_id}",
    toolchain_config = "cc_toolchain_config_%{clang_id}",
    
    all_files = "@%{archive_name}//:all_files",
    ar_files = "@%{archive_name}//:ar",
    compiler_files = "@%{archive_name}//:compiler_files",
    dwp_files = "@%{archive_name}//:dwp",
    linker_files = "@%{archive_name}//:linker_files",
    objcopy_files = "@%{archive_name}//:objcopy",
    strip_files = "@%{archive_name}//:strip",
    supports_param_files = 0
)

toolchain(
    name = "toolchain_%{clang_id}",
    toolchain = "cc_toolchain_%{clang_id}",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",

    target_compatible_with = json.decode("%{target_compatible_with}"),
)

# gcc executables.
filegroup(
    name = "gcc",
    srcs = glob(["bin/gcc*"]),
)

filegroup(
    name = "clang",
    srcs = glob(["bin/clang*"]),
)

# g++ executables.
filegroup(
    name = "g++",
    srcs = glob(["bin/g++*"]),
)

filegroup(
    name = "clang++",
    srcs = glob(["bin/clang++*"]),
)

# gdb executables.
filegroup(
    name = "gdb",
    srcs = glob(["bin/gdb*"]),
)

# cpp executables.
filegroup(
    name = "cpp",
    srcs = glob(["bin/cpp*"]),
)

# gcov executables.
filegroup(
    name = "gcov",
    srcs = glob(["bin/gcov*"]),
)

# ar executables.
filegroup(
    name = "ar",
    srcs = glob(["bin/ar*"]),
)

# ld executables.
filegroup(
    name = "ld",
    srcs = glob(["bin/ld*"]),
)

# nm executables.
filegroup(
    name = "nm",
    srcs = glob(["bin/nm*"]),
)

# objcopy executables.
filegroup(
    name = "objcopy",
    srcs = glob(["bin/objcopy*"]),
)

# objdump executables.
filegroup(
    name = "objdump",
    srcs = glob(["bin/objdump*"]),
)

# strip executables.
filegroup(
    name = "strip",
    srcs = glob(["bin/strip*"]),
)

# as executables.
filegroup(
    name = "as",
    srcs = glob(["bin/as*"]),
)

# size executables.
filegroup(
    name = "size",
    srcs = glob(["bin/size*"]),
)

# size executables.
filegroup(
    name = "dwp",
    srcs = [],
)

# libraries and headers.
filegroup(
    name = "compiler_pieces",
    srcs = glob([
        "**"
    ]),
)

# files for executing compiler.
filegroup(
    name = "compiler_files",
    srcs = [
        ":compiler_pieces",
        ":cpp",
        ":gcc",
        ":g++",
        ":clang",
        ":clang++",
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        ":ar",
        ":compiler_pieces",
        ":gcc",
        ":g++",
        ":clang",
        ":clang++",
        ":ld",
    ],
)

# collection of executables.
filegroup(
    name = "compiler_components",
    srcs = [
        ":ar",
        ":as",
        ":cpp",
        ":gcc",
        ":g++",
        ":clang",
        ":clang++",
        ":gcov",
        ":ld",
        ":nm",
        ":objcopy",
        ":objdump",
        ":strip",
    ],
)

