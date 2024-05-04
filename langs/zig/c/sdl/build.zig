//بسم الله الرحمن الرحيم
//la ilaha illa Allah mohammed rassoul Allah
const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const bismi_allah = b.addExecutable(.{ .name = "bismi-allah", .target = target, .optimize = optimize });
    b.installArtifact(bismi_allah);
    bismi_allah.linkLibC();
    bismi_allah.addCSourceFiles(&.{"src/bismi_allah.c"}, &.{ "-std=c11", "-Wall" });

    // const sdl_dep = b.dependency("SDL", .{
    //     .optimize = .ReleaseFast,
    //     .target = target,
    // });
    // bismi_allah.linkLibrary(sdl_dep.artifact("SDL2"));
    // b.installArtifact(bismi_allah);

    if (target.isNativeOs() and target.getOsTag() == .linux) {
        // The SDL package doesn't work for Linux yet, so we rely on system
        // packages for now.
        bismi_allah.linkSystemLibrary("SDL2");
        bismi_allah.linkLibC();
    } else {
        const sdl_dep = b.dependency("SDL", .{
            .optimize = .ReleaseFast,
            .target = target,
        });
        bismi_allah.linkLibrary(sdl_dep.artifact("SDL2"));
    }

    b.installArtifact(bismi_allah);

    const run_cmd = b.addRunArtifact(bismi_allah);
    //run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
