module Tables
import Base: convert
if Base.VERSION < v"0.4"
  using Docile
  import Base: get, isequal, eltype
  include("backport/nullable.jl")
  export Nullable, get, isequal, isnull, eltype
end

import Base: start, next, done, length, size, writemime

include("box/Box.jl")
export Box, Point

include("range/Range.jl")
export Range, Layout, start, next, done, length

import Base: contains, intersect
include("box/oper.jl")
export size, xmin, xmax, ymin, ymax,
  contains, topleftcontains, intersects, intersect

import Base: ==
include("range/oper.jl")
export box, refid, shatterinto, push, ==

import Compose: compose, context, fill, rectangle, UnitBox
include("box/plot.jl")
include("range/plot.jl")
export plot

import Formatting: format
include("style/Style.jl")
export RangeStyle, RangeProp, TextProp, CellProp, text

include("table/Table.jl")
export Table, size

include("output/converters.jl")
export HTML, writemime, render

end # module
