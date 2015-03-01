module TableInterface
import Compose: compose, context, fill, rectangle, UnitBox
import Formatting: format, generate_formatter
import Base: contains, convert, done, getindex,
  intersect, length, next, size, start, writemime, ==

if Base.VERSION < v"0.4"
  using Docile
  import Base: get, isequal, eltype
  include("backport/nullable.jl")
  export Nullable, get, isequal, isnull, eltype
end

export
  done, getindex, length, lengths, next, size, start, ==,
  Box, Point,
  AbstractDataElement, ExpandDataElement, CartesianDataElement,
    isvertical,
  CellRange,
  Layout,
  AbstractStyleElement, AbstractPresentationStyleElement,
    CartesianStyleElement, ExpandStyleElement, UniformStyleElement,
    style, styles,
  Table,
  AbstractCell, AbstractCells, render, convert, writerange!, tcell

include("Box.jl")
include("DataElement.jl")
include("Range.jl")
include("Layout.jl")
include("StyleElement.jl")
include("Style.jl")
include("Table.jl")
include("render.jl")

end # module

module Tables
module HTMLFormat
  import Base: convert, writemime
  import Formatting: generate_formatter
  using TableInterface
  import TableInterface: style, styles, tcell, renderformatspecific

  if Base.VERSION < v"0.4"
    export Nullable, get, isequal, isnull, eltype
  end

  export HTMLTable, HTMLCell, HTMLStyleElement, style, styles, writemime
  include("format/converters.jl")
end
end
