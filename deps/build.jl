using BinDeps
using Compat.Libdl
C_URL    = "https://github.com/TEOS-10/GSW-C/archive/master.zip"
SLibName = "libgswteos-10.so.GSW."
LibName  = "libgswteos-10.$(Libdl.dlext)"

@BinDeps.setup

libgswteos = library_dependency("libgswteos", aliases = [LibName])

provides(Sources, URI(C_URL), libgswteos, unpacked_dir = "GSW-C-master")

srcdir = joinpath(BinDeps.depsdir(libgswteos), "src", "GSW-C-master")
prefix = joinpath(BinDeps.depsdir(libgswteos), "usr", "lib")

provides(SimpleBuild,
  (@build_steps begin
    `mkdir -p $prefix`
    GetSources(libgswteos)
    @build_steps begin
        ChangeDirectory(srcdir)
        `make`
        `cp $SLibName $(prefix)/$LibName`
    end
end), libgswteos) #, os = :Unix)


@BinDeps.install Dict(:libgswteos => :libgswteos)
