module Table

include("box/Box.jl")
export Box, Point

import Base: contains, intersect
include("box/oper.jl")
export xmin, xmax, ymin, ymax,
  contains, intersects, intersect, shatterinto, distinctify

import Base: convert
if Base.VERSION < v"0.4"
  include("backport/nullable.jl")
  export Nullable, get, isequal, isnull
end
end # module
