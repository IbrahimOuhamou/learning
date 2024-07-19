//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const rl = @import("raylib");
const rgui = @import("raygui");

const TASK_WIDTH = 100;
const TASK_HEIGHT = 120;

const font_size = 10;

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    rl.initWindow(1200, 600, "بسم الله الرحمن الرحيم");
    defer rl.closeWindow();
}
