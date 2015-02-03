module Table

import Base: start, next, done, length

include("box/Box.jl")
export Box, Point

include("range/Range.jl")
export Range, Layout, start, next, done, length

import Base: contains, intersect
include("box/oper.jl")
export xmin, xmax, ymin, ymax,
  contains, intersects, intersect

include("range/oper.jl")
export box, refid, shatterinto, push

import Compose: compose, context, fill, rectangle, UnitBox
include("box/plot.jl")
include("range/plot.jl")
export rectangle, plot

import Base: convert
if Base.VERSION < v"0.4"
  using Docile
  include("backport/nullable.jl")
  export Nullable, get, isequal, isnull
end
end # module
