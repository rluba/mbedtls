AT_COMPILE_TIME :: true;

COMPILE       :: false; // Enable to compile the library from source before generating bindings.

MBEDTLS_PATH :: "mbedtls-3.4.1"; // Path to the source, not included in this repo.

DECLARATION_PREFIXES_TO_OMIT :: string.[
    "MBEDTLS_PSA_BUILTIN_",
    "PSA_WANT_",
];

#if AT_COMPILE_TIME {
    #run {
        set_build_options_dc(.{do_output=false});
        if !generate_bindings() {
            compiler_set_workspace_status(.FAILED);
        }
    }
} else {
    #import "System";

    main :: () {
        set_working_directory(path_strip_filename(get_path_of_running_executable()));
        if !generate_bindings() {
            exit(1);
        }
    }
}

generate_bindings :: () -> bool {
    #if COMPILE {
		success := build_mbedtls();
		if !success return false;
	}

    output_filename: string;
    opts: Generate_Bindings_Options;
    {
        using opts;

		#if OS == .LINUX {
			array_add(*libpaths, "linux");
		} else #if OS == .MACOS {
			array_add(*libpaths, "macos");
		} else {
			assert(false);
		}
		output_filename = "unix.jai";
		generate_library_declarations = false;
		footer = FOOTER_UNIX;

        array_add(*libpaths,      tprint("%/lib", PLATFORM_NAME));
        array_add(*libnames,      "libmbedcrypto");
        array_add(*libnames,      "libmbedx509");
        array_add(*libnames,      "libmbedtls");

		mbedtls_include_path :=   tprint("%/include", PLATFORM_NAME);
        array_add(*include_paths, mbedtls_include_path);
        // array_add(*source_files,  tprint("%/mbedtls/sha256.h", mbedtls_include_path));
        array_add(*source_files,  tprint("%/mbedtls/aes.h", mbedtls_include_path));
        array_add(*source_files,  tprint("%/mbedtls/md.h", mbedtls_include_path));
        array_add(*source_files,  tprint("%/mbedtls/constant_time.h", mbedtls_include_path));

        // array_add(*strip_enum_value_prefixes, .["TidyOptionId", "Tidy"]);
        alias_original_enum_names = false;
        log_stripped_declarations = true;
        generate_compile_time_struct_checks = true;

        visitor   = mbedtls_visitor;
    }

    return generate_bindings(opts, output_filename);
}

#if OS == .LINUX {
    PLATFORM_NAME :: "linux";
} else #if OS == .MACOS {
    PLATFORM_NAME :: "macos";
} else {
    compiler_report(tprint("Unsupported platform: %", OS));
}

build_mbedtls :: () -> bool {
	install_dir := PLATFORM_NAME;
    success := make_directory_if_it_does_not_exist(install_dir);
    if !success {
        log_error("Could not create directory \"%\"\n", install_dir);
		return false;
    }

	absolute_install_dir := get_absolute_path(install_dir);
	assert(absolute_install_dir != "");

    absolute_build_dir := join(absolute_install_dir, "_build");
    log("Configuring mbedtls... \"%\" -> \"%\"", absolute_build_dir, absolute_install_dir);
	if file_exists(absolute_build_dir) {
		success := delete_directory(absolute_build_dir);
		if !success {
			log_error("Could not delete old build directory");
			return false;
		}
	}
    success = make_directory_if_it_does_not_exist(absolute_build_dir);
    if !success {
        log_error("Could not create directory \"%\"\n", absolute_build_dir);
		return false;
    }

	absolute_mbedtls_path := get_absolute_path(MBEDTLS_PATH);
    config_command: [..] string;
    array_add(*config_command,
		"cmake",
		absolute_mbedtls_path,
        "-DENABLE_TESTING=Off",
        "-DUSE_SHARED_MBEDTLS_LIBRARY=On",
        tprint("-DCMAKE_INSTALL_PREFIX=%", absolute_install_dir),
        tprint("-DCMAKE_PREFIX_PATH=%",    install_dir),
	);

    #if OS == .MACOS {
        using options := get_build_options();
        array_add(*config_command, tprint("-DCMAKE_OSX_DEPLOYMENT_TARGET=%.%", minimum_os_version.major, minimum_os_version.minor));
    }
    run_or_exit(..config_command, working_directory = absolute_build_dir);
    log("Done configuring mbedtls");

    log("Building mbedtls…");
    build_command: [..] string;
    array_add(*build_command, "cmake", "--build", absolute_build_dir, "--target", "install");
    run_or_exit(..build_command);
	log("Done building mbedtls");

	return true;
}

run_or_exit :: (command: .. string, working_directory := "") -> string {
    // Enable this to see the commands being executed.
    // Might be useful if, for example, you need to compile LLVM on a platform where we don’t have a Jai compiler yet and want to do it manually.
    // log("Executing command \"%\" in directory \"%\"\n", join(..command, separator = " "), working_directory);

    result, output_string, error_string := run_command(..command, working_directory = working_directory, capture_and_return_output = true, print_captured_output = true);
    defer {
        free(error_string);
    }
    if result.exit_code != 0 {
        log_error("Could not run command \"%\" in directory \"%\". Exit code: %\nError:\n%", get_quoted_command_string(command), working_directory, result.exit_code, error_string);
        // if !LIVE_OUTPUT {
        //     log_error("Output:\n%", output_string);
        // }
        exit(1);
    }
    return output_string;
}


mbedtls_visitor :: (decl: *Declaration, parent_decl: *Declaration) -> Declaration_Visit_Result {
    if !parent_decl {
        for DECLARATION_PREFIXES_TO_OMIT {
            if begins_with(decl.name, it) {
                decl.decl_flags |= .OMIT_FROM_OUTPUT;
                return .STOP;
            }
        }
    }

    return .RECURSE;
}

#import "Basic";
#import "Bindings_Generator";
#import "Compiler";
#import "File";
#import "File_Utilities";
#import "String";
#import "Process";

FOOTER_UNIX :: #string END

#if OS == .MACOS {
    libmbedcrypto :: #library "macos/lib/libmbedcrypto";
    libmbedx509   :: #library "macos/lib/libmbedx509";
    libmbedtls    :: #library "macos/lib/libmbedtls";
} else #if OS == .LINUX {
    libmbedcrypto :: #library "linux/lib/libmbedcrypto";
    libmbedx509   :: #library "linux/lib/libmbedx509";
    libmbedtls    :: #library "linux/lib/libmbedtls";
}

END

