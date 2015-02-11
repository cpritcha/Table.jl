immutable TextProp
  fmt
end
text(txt, txtprop::TextProp) = txtprop.fmt(txt)

immutable CellProp
  colspan::Int
  rowspan::Int
end
CellProp() = CellProp(1,1)

immutable RangeProp
end

immutable RangeStyle
  text::TextProp
  cell::CellProp
  range::RangeProp
end
