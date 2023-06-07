const std = @import("std");
const print = @import("std").debug.print;

pub fn build(b: *std.build.Builder) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const lib = b.addStaticLibrary(.{
        .name = "utf8proc",
        .target = target,
        .optimize = optimize,
    });

    const source_files = [_][]const u8{
        "utf8proc.c",
    };

    lib.addCSourceFiles(&source_files, &[_][]const u8{});
    lib.linkLibC();
    b.installFile("utf8proc.h", "include/utf8proc.h");
    b.installArtifact(lib);
}
