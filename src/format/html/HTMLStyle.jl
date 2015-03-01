#=
Style
=#

immutable TextProp
  fmt
end

abstract AbstractSpanProp
immutable StaticSpanProp <: AbstractSpanProp
  colspan::Int
  rowspan::Int
end
StaticSpanProp() = StaticSpanProp(1,1)

immutable CartesianSpanProp <: AbstractSpanProp
end
immutable ExpandSpanProp <: AbstractSpanProp
end

immutable HTMLStyleElement{S <: AbstractSpanProp} <: AbstractStyleElement
  text::TextProp
  span::S
  tagstring::String
end

text(txt, txtprop::TextProp) = txtprop.fmt(txt)

rowspan(style::HTMLStyleElement{StaticSpanProp}, datael, i, j) = style.span.rowspan
colspan(style::HTMLStyleElement{StaticSpanProp}, datael, i, j) = style.span.colspan
istext(style::HTMLStyleElement{StaticSpanProp},  datael, i, j) = true

function colspan(style::HTMLStyleElement{CartesianSpanProp},
                 datael::CartesianDataElement, i, j)
  isvertical(datael) ? datael.spansizes[i] : 1
end
function rowspan(style::HTMLStyleElement{CartesianSpanProp},
                 datael::CartesianDataElement, i, j)
  isvertical(datael) ? 1 : datael.spansizes[j]
end
function istext(style::HTMLStyleElement{CartesianSpanProp},
                datael::CartesianDataElement, i, j)
  if isvertical(datael)
    return mod(j-1, datael.spansizes[i]) == 0
  else
    return mod(i-1, datael.spansizes[j]) == 0
  end
end

function rowspan(style::HTMLStyleElement{ExpandSpanProp},
        datael, i, j)
  n, m = size(datael)
  return n
end
function colspan(style::HTMLStyleElement{ExpandSpanProp},
                 datael, i, j)
  n, m = size(datael)
  return m
end
istext(style::HTMLStyleElement{ExpandSpanProp}, datael, i, j) = i==1 && j==1
