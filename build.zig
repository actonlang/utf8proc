const std = @import("std");
const print = @import("std").debug.print;

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const build_shared_libs = b.option(bool, "BUILD_SHARED_LIBS",
                "Build shared libraries (otherwise static ones)") orelse true;

    var lib = b.addStaticLibrary(.{
        .name = "utf8proc",
        .target = target,
        .optimize = optimize,
    });
    if (build_shared_libs) {
        lib = b.addSharedLibrary(.{
            .name = "utf8proc",
            .target = target,
            .optimize = optimize,
        });
    }

    var flags = std.ArrayList([]const u8).init(b.allocator);
    defer flags.deinit();

    if (!build_shared_libs) {
        flags.append("-DUTF8PROC_STATIC") catch unreachable;
    }

    lib.addCSourceFile(.{
        .file = b.path("utf8proc.c"),
        .flags = flags.items
    });
    lib.linkLibC();
    lib.installHeader(b.path("utf8proc.h"), "utf8proc.h");
    b.installArtifact(lib);
}
