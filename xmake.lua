add_rules("mode.debug", "mode.release")

target("bin2s")
    set_plat("windows")
    set_toolchains("mingw")
    set_kind("binary")
    add_cxxflags("-std=c++11", "-Wextra", "-Wpedantic", "-Werror")
    if is_mode("debug") then
        add_cxxflags("-g")
    else
        add_cxxflags("-O3", "-DNDEBUG")
    end
    add_files("src/bin2s.cpp")
    add_includedirs("deps/args")

    on_install(function(target)
        if is_subhost("msys") then
            os.cp(target:targetfile() .. ".exe", target:installdir())
        else
            os.cp(target:targetfile(), target:installdir())
        end
    end)

    on_package(function(target)
        local packagedir = "$(buildir)/packages/" .. target:name() .. "/"
        os.cp(target:targetfile(), packagedir)
    end)

