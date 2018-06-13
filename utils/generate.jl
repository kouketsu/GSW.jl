using Clang

C_header = "src/gswteos-10.h"
C_URI = "https://github.com/TEOS-10/GSW-C/"

LibGit2.clone(C_URI, "src/")

includes = ["/usr/include",
# "/usr/lib/gcc/x86_64-redhat-linux/4.4.4/include",
# "/usr/lib/gcc/x86_64-linux-gnu/4.8/include",
# "/usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed"
]

function ff(x, y)
  #  @show y
  #ismatch(r"gsw", x)
  return ismatch(r"gsw", y)
end

hdrs = readstring(C_header)

context = wrap_c.init(
output_file = "../src/gen_gswteos10.jl",
common_file = "../src/gen_gswteos_h.jl",
headers = [C_header],
clang_includes = includes,
clang_diagnostics = true,
header_wrapped=(x,y)->ff(x,y),#(@show x; ismatch(r"gsw", y)),
header_library=x->"libgswteos",
# rewriter = rewriter
)

context.options = wrap_c.InternalOptions(true, true)

run(context)

#@show hdrs
