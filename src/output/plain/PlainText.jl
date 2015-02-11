type PlainText
  borders::Border
  content::Matrix{PlainCell}
  widths::Vector{Int}
  heights::Vector{Int}
end

immutable CellBorder
  left::Bool
  right::Bool
  top::Bool
  bottom::Bool
end

immutable PlainCell
  content::String
  colspan::Int
  rowspan::Int
end

PlainCell() = PlainCell("")
height(c::PlainCell) = 1
width(c::PlainCell) = length(c.content)
