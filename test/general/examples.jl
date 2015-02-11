fmt1 = generate_formatter("%.2f")
fmt2 = generate_formatter("%s")

tbl_dbl_width = begin
  r1 = Range(Box{Int}(Point(0,0), Point(2,1)), 1)
  r2 = Range(Box{Int}(Point(0,1), Point(1,2)), 2)
  r3 = Range(Box{Int}(Point(1,1), Point(2,2)), 3)

  stylelayout = push(push(Layout([r1]), r2), r3)
  style = [
    RangeStyle(TextProp(fmt2), CellProp(2,1), RangeProp()),
    RangeStyle(TextProp(fmt2), CellProp(), RangeProp()),
    RangeStyle(TextProp(fmt1), CellProp(), RangeProp())
  ]
  datalayout = stylelayout
  data = Any[reshape(["Head"],1,1), reshape(["< 15"],1,1), reshape([.5],1,1)]

  Table(data, datalayout, style, stylelayout)
end

tbl_dbl_height = begin
  r1 = Range(Box{Int}(Point(0,0), Point(1,2)), 1)
  r2 = Range(Box{Int}(Point(1,0), Point(2,1)), 2)
  r3 = Range(Box{Int}(Point(1,1), Point(2,2)), 3)

  stylelayout = push(push(Layout([r1]), r2), r3)
  style = [
    RangeStyle(TextProp(fmt2), CellProp(2,1), RangeProp()),
    RangeStyle(TextProp(fmt2), CellProp(), RangeProp()),
    RangeStyle(TextProp(fmt1), CellProp(), RangeProp())
  ]
  datalayout = stylelayout
  data = Any[reshape(["Head"],1,1), reshape(["< 15"],1,1), reshape([.5],1,1)]

  Table(data, datalayout, style, stylelayout)
end

tbl_hier_width = begin
  r1 = Range(Box{Int}(Point(0,0),Point(4,1)),1)
  r2 = Range(Box{Int}(Point(0,1),Point(4,2)),2)
  r3 = Range(Box{Int}(Point(0,2),Point(4,3)),3)

  stylelayout = push(push(Layout([r1]), r2), r3)
  style = [
    RangeStyle(TextProp(fmt2), CellProp(4,1), RangeProp()),
    RangeStyle(TextProp(fmt2), CellProp(2,1), RangeProp()),
    RangeStyle(TextProp(fmt2), CellProp(), RangeProp())
  ]

  datalayout = stylelayout
  data = Any[
    reshape(["Age / Sex"],1,1),
    reshape(["< 15", ">= 15"],1,2),
    reshape(["M", "F", "M", "F"],1,4)]

  Table(data, datalayout, style, stylelayout)
end

tbl_hier_height = begin
  r1 = Range(Box{Int}(Point(0,0),Point(1,4)),1)
  r2 = Range(Box{Int}(Point(1,0),Point(2,4)),2)
  r3 = Range(Box{Int}(Point(2,0),Point(3,4)),3)

  stylelayout = push(push(Layout([r1]), r2), r3)
  style = [
    RangeStyle(TextProp(fmt2), CellProp(4,1), RangeProp()),
    RangeStyle(TextProp(fmt2), CellProp(2,1), RangeProp()),
    RangeStyle(TextProp(fmt2), CellProp(), RangeProp())
  ]

  datalayout = stylelayout
  data = Any[
    reshape(["Age / Sex"],1,1),
    reshape(["< 15", ">= 15"],1,2),
    reshape(["M", "F", "M", "F"],1,4)]

  Table(data, datalayout, style, stylelayout)
end

tbl_pivottable = begin
  srand(100)
  r0 = Range(Box{Int}(Point(0,0),Point(1,2)),1) # Empty
  r1 = Range(Box{Int}(Point(1,0),Point(5,1)),2) # Col Header
  r2 = Range(Box{Int}(Point(1,1),Point(5,2)),3) # Age
  r3 = Range(Box{Int}(Point(1,2),Point(5,3)),4) # Sex
  r4 = Range(Box{Int}(Point(0,2),Point(1,3)),5) # Row Header
  r5 = Range(Box{Int}(Point(0,3),Point(1,5)),6)
  r6 = Range(Box{Int}(Point(1,3),Point(5,5)),7)

  stylelayout = push(push(push(push(push(push(Layout([r0]), r1), r2), r3), r4), r5), r6)
  style = [
    RangeStyle(TextProp(fmt2), CellProp(1,2), RangeProp()),
    RangeStyle(TextProp(fmt2), CellProp(4,1), RangeProp()),
    RangeStyle(TextProp(fmt2), CellProp(2,1), RangeProp()),
    RangeStyle(TextProp(fmt2), CellProp(), RangeProp()),
    RangeStyle(TextProp(fmt2), CellProp(), RangeProp()),
    RangeStyle(TextProp(fmt2), CellProp(), RangeProp()),
    RangeStyle(TextProp(fmt1), CellProp(), RangeProp()),
  ]

  datalayout=stylelayout
  data=Matrix[reshape([""],1,1),
    reshape(["Age / Sex"],1,1),
    reshape(["LT 15", "GT 15"],1,2),
    reshape(["M", "F", "M", "F"],1,4),
    reshape(["mean"], 1,1),
    reshape(["LT 6", "GT 6"],2,1),
    rand(2,4)
  ]

  Table(data, datalayout, style, stylelayout)
end

tblnames = [:tbl_dbl_width;
        :tbl_dbl_height;
        :tbl_hier_width;
        :tbl_hier_height;
        :tbl_pivottable]
