const std = @import("std");
const print = @import("std").debug.print;

pub fn build(b: *std.Build) void {
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

    lib.addCSourceFiles(.{
        .files = &source_files,
        .flags = &[_][]const u8{
            "-DUTF8PROC_STATIC",
        },
    });
    lib.linkLibC();
    lib.installHeader(b.path("utf8proc.h"), "utf8proc.h");
    b.installArtifact(lib);
}
