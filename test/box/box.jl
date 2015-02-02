facts("Bounding Box") do
  box1 = Box{Int}(Point(0,0), Point(10,10))
  box2 = Box{Int}(Point(1,1), Point(2,2))
  box3 = Box{Int}(Point(1,1), Point(12,12))
  box4 = Box{Int}(Point(11,11), Point(12,12))
  box5 = Box{Int}(Point(5,10), Point(12,12))
  box6 = Box{Int}(Point(-1,-2), Point(13,14))

  context("box contains point") do
    @fact contains(box1, Point(5,5)) => true
    @fact contains(box1, Point(-5,5)) => false
    @fact contains(box1, Point(5,15)) => false
    @fact contains(box1, Point(10,9)) => false
    @fact contains(box1, Point(11,11)) => false
  end

  context("box intersects box") do
    @fact intersects(box1, box1) => true
    @fact intersects(box1, box2) => true
    @fact intersects(box1, box3) => true
    @fact intersects(box1, box4) => false
    @fact intersects(box1, box5) => false
    @fact intersects(box1, box6) => true
  end

  context("box contains box") do
    @fact contains(box1, box1) => false
    @fact contains(box1, box2) => true
    @fact contains(box1, box3) => false
    @fact contains(box1, box4) => false
    @fact contains(box1, box5) => false
    @fact contains(box1, box6) => false
  end

  context("box intersect box") do
    @fact isequal(intersect(box1, box1), Nullable(box1)) => true
    @fact isequal(intersect(box1, box2), Nullable(box2)) => true
    @fact isequal(intersect(box1, box3), Nullable(Box{Int}(Point(1,1), Point(10,10)))) => true
    @fact isequal(intersect(box1, box4), Nullable{Box{Int}}()) => true
    @fact isequal(intersect(box1, box5), Nullable{Box{Int}}()) => true
    @fact isequal(intersect(box1, box6), Nullable(box1)) => true
  end

  context("box shatterinto box") do
    @fact shatterinto(box1, box1) => Box{Int}[]
    @fact shatterinto(box1, box2) => Box{Int}[]
    @fact shatterinto(box1, box3) => [Box{Int}(Point(1,10), Point(12,12)),
                                      Box{Int}(Point(10,1), Point(12,10))]
    @fact shatterinto(box1, box4) => [box4]
    @fact shatterinto(box1, box5) => [box5]
    @fact shatterinto(box1, box6) => [Box{Int}(Point(-1,10), Point(13,14)),
                                      Box{Int}(Point(-1,-2), Point(13,0)),
                                      Box{Int}(Point(10,0),  Point(13,10)),
                                      Box{Int}(Point(-1,0),  Point(0,10))]
  end

  context("distinctify boxes") do
    @pending distinctify(boxes)
  end
end
