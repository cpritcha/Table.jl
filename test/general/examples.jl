fmt1 = "%.2f"
fmt2 = "%s"

tbl_dbl_width = begin
  r1 = Range(Box{Int}(Point(0,0), Point(2,1)), 1,1)
  r2 = Range(Box{Int}(Point(0,1), Point(1,2)), 2,1)
  r3 = Range(Box{Int}(Point(1,1), Point(2,2)), 3,2)

  layout = push(push(Layout([r1]), r2), r3)
  styles = [
    expandstyle(fmt2),
    uniformstyle(fmt1)
  ]
  data = Any[ExpandDataElement("Head",1,2), reshape(["< 15"],1,1), reshape([.5],1,1)]

  Table(data, layout, styles)
end

tbl_dbl_height = begin
  r1 = Range(Box{Int}(Point(0,0), Point(1,2)), 1,1)
  r2 = Range(Box{Int}(Point(1,0), Point(2,1)), 2,1)
  r3 = Range(Box{Int}(Point(1,1), Point(2,2)), 3,2)

  layout = push(push(Layout([r1]), r2), r3)
  styles = [
    expandstyle(fmt2),
    uniformstyle(fmt1)
  ]
  data = Any[ExpandDataElement("Head",2,1), reshape(["< 15"],1,1), reshape([.5],1,1)]

  Table(data, layout, styles)
end

tbl_hier_width = begin
  r1 = Range(Box{Int}(Point(0,0),Point(4,1)),1,1)
  r2 = Range(Box{Int}(Point(0,1),Point(4,3)),2,1)

  layout = push(Layout([r1]),r2)
  styles = [
    expandstyle(fmt2)
    cartesianstyle(fmt2)
  ]

  data = Any[
    ExpandDataElement(["Age / Sex"], 1, 4),
    CartesianDataElement(
      Vector[["< 15", ">= 15"],
             ["M", "F"]],true)]

  Table(data, layout, styles)
end

tbl_hier_height = begin
  r1 = Range(Box{Int}(Point(0,0),Point(1,4)),1,1)
  r2 = Range(Box{Int}(Point(1,0),Point(3,4)),2,1)

  layout = push(Layout([r1]),r2)
  styles = [
    expandstyle(fmt2)
    cartesianstyle(fmt2)
  ]

  data = Any[
    ExpandDataElement(["Age / Sex"], 4, 1),
    CartesianDataElement(
      Vector[["< 15", ">= 15"],
             ["M", "F"]],false)]

  Table(data, layout, styles)
end

tbl_pivottable = begin
  srand(100)
  r1 = Range(Box{Int}(Point(0,0),Point(2,2)),1,1) # Empty
  r2 = Range(Box{Int}(Point(2,0),Point(6,1)),2,1) # Col Header
  r3 = Range(Box{Int}(Point(2,1),Point(6,3)),3,2) # Col Levels
  r4 = Range(Box{Int}(Point(0,2),Point(2,3)),4,3) # Row Header
  r5 = Range(Box{Int}(Point(0,3),Point(2,5)),5,2)
  r6 = Range(Box{Int}(Point(2,3),Point(6,5)),6,4)

  layout = push(push(push(push(push(Layout([r1]), r2), r3), r4), r5), r6)
  styles = [
    expandstyle("%s"),
    cartesianstyle("%s"),
    uniformstyle("%s"),
    uniformstyle("%.2f"),
  ]

  data=Any[
    ExpandDataElement("",2,2),
    ExpandDataElement("Age / Sex",1,4),
    CartesianDataElement(
    Vector[["M", "F"],["\$\\leq\$ 15", "> 15"]], true),
    reshape(["Sex", "stats"],1,2),
    CartesianDataElement(
        Vector[["LT 6", "GT 6"],["mean"]], false),
    rand(2,4)
  ]

  Table(data, layout, styles)
end

tblnames = [:tbl_dbl_width;
        :tbl_dbl_height;
        :tbl_hier_width;
        :tbl_hier_height;
        :tbl_pivottable]
