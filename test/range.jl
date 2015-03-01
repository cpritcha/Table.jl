facts("Ranges") do

  context("range shatterinto range") do
    @fact shatterinto(r1, r1) => Range{Int}[]
    @fact shatterinto(r1, r2) => Range{Int}[]
    @fact shatterinto(r1, r3) => [Range(Box{Int}(Point(1,10), Point(12,12)), 3,3)
                                      Range(Box{Int}(Point(10,1), Point(12,10)), 3,3)]
    @fact shatterinto(r1, r4) => [r4]
    @fact shatterinto(r1, r5) => [r5]
    @fact shatterinto(r1, r6) => [Range(Box{Int}(Point(-1,10), Point(13,14)), 6,6),
                                      Range(Box{Int}(Point(-1,-2), Point(13,0)), 6,6),
                                      Range(Box{Int}(Point(10,0),  Point(13,10)), 6,6),
                                      Range(Box{Int}(Point(-1,0),  Point(0,10)), 6,6)]
  end

  context("push layout") do
    @fact push(Layout([r2]), r1) => Layout{Int64}([r1])
    @fact push(Layout([r1]), r2) => Layout{Int64}(
                    [Range{Int64}(Box{Int64}(Point{Int64}(0,2),Point{Int64}(10,10)),1,1),
                     Range{Int64}(Box{Int64}(Point{Int64}(0,0),Point{Int64}(10,1)),1,1),
                     Range{Int64}(Box{Int64}(Point{Int64}(2,1),Point{Int64}(10,2)),1,1),
                     Range{Int64}(Box{Int64}(Point{Int64}(0,1),Point{Int64}(1,2)),1,1),
                     Range{Int64}(Box{Int64}(Point{Int64}(1,1),Point{Int64}(2,2)),2,2)])
    @fact push(Layout([r2]), r1) => Layout{Int64}(
      [Range{Int64}(Box{Int64}(Point{Int64}(0,0),Point{Int64}(10,10)),1,1)])

    @fact push(push(Layout([r1]), r2), r5) => Layout{Int64}(
      [Range{Int64}(Box{Int64}(Point{Int64}(0,2),Point{Int64}(10,10)),1,1),
       Range{Int64}(Box{Int64}(Point{Int64}(0,0),Point{Int64}(10,1)),1,1),
       Range{Int64}(Box{Int64}(Point{Int64}(2,1),Point{Int64}(10,2)),1,1),
       Range{Int64}(Box{Int64}(Point{Int64}(0,1),Point{Int64}(1,2)),1,1),
       Range{Int64}(Box{Int64}(Point{Int64}(1,1),Point{Int64}(2,2)),2,2),
       Range{Int64}(Box{Int64}(Point{Int64}(5,10),Point{Int64}(12,12)),5,5)])
  end
end
