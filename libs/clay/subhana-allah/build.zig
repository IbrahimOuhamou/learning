// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const sdl_dep = b.dependency("sdl", .{
        .target = target,
        .optimize = optimize,
    });
    const sdl_lib = sdl_dep.artifact("SDL3");

    const sdl_image_dep = b.dependency("sdl_image", .{
        .target = target,
        .optimize = optimize,
    });
    const sdl_image_lib = sdl_image_dep.artifact("SDL_image");

    const sdl_ttf_dep = b.dependency("sdl_ttf", .{
        .target = target,
        .optimize = optimize,
    });
    const sdl_ttf_lib = sdl_ttf_dep.artifact("SDL_ttf");

    const zclay_dep = b.dependency("zclay", .{
    .target = target,
    .optimize = optimize,
    });

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe_mod.addImport("zclay", zclay_dep.module("zclay"));

    const exe = b.addExecutable(.{
        .name = "subhana_allah",
        .root_module = exe_mod,
    });
    exe.linkLibrary(sdl_lib);
    exe.linkLibrary(sdl_image_lib);
    exe.linkLibrary(sdl_ttf_lib);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const exe_unit_tests = b.addTest(.{
        .root_module = exe_mod,
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}
