target("bin2s")
    set_plat("windows")
    set_toolchains("mingw")
    set_kind("binary")
    on_install(function(target)
        if is_subhost("msys") then
            os.cp(target:targetfile() .. ".exe", target:installdir())
        else
            os.cp(target:targetfile(), target:installdir())
        end
    end)
    add_cxxflags("-std=c++11", "-Wextra", "-Wpedantic", "-Werror")
    if is_mode("debug") then
        add_cxxflags("-g")
    else
        add_cxxflags("-O3", "-DNDEBUG")
    end

    add_files("src/bin2s.cpp")
    add_includedirs("deps/args")
