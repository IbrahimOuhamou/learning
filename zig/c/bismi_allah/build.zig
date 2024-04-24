//بسم الله الرحمن الرحيم
//la ilaha illa Allah mohammed rassoul Allah

//if Allah wills I will try to compile using zig's build system

const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const bismi_allah = b.addExecutable(.{ .name = "bismi-allah", .target = target, .optimize = optimize });
    b.installArtifact(bismi_allah);
    bismi_allah.linkLibC();
    bismi_allah.addCSourceFiles(&.{"bismi_allah.c"}, &.{ "-std=c11", "-Wall" });

    const run_cmd = b.addRunArtifact(bismi_allah);
    //run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
