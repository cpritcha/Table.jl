facts("Bounding Box") do
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
end
