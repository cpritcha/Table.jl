isequal(box1::Box, box2::Box) = box1 == box2

size(box::Box) = (box.p2.y - box.p1.y, box.p2.x - box.p1.x)
xmax{T}(box::Box{T}) = box.p2.x
ymax{T}(box::Box{T}) = box.p2.y
xmin{T}(box::Box{T}) = box.p1.x
ymin{T}(box::Box{T}) = box.p1.y

function contains(box::Box, p::Point)
  return (xmin(box) < p.x) && (ymin(box) < p.y) &&
         (xmax(box) > p.x) && (ymax(box) > p.y)
end

function topleftcontains(box::Box, p::Point)
  return (xmin(box) <= p.x) && (ymin(box) <= p.y) &&
         (xmax(box) >  p.x) && (ymax(box) >  p.y)
end

function intersects{T}(box1::Box{T}, box2::Box{T})
  return (xmin(box1) < xmax(box2)) && (xmax(box1) > xmin(box2)) &&
         (ymin(box1) < ymax(box2)) && (ymax(box1) > ymin(box2))
end

contains{T}(box1::Box{T}, box2::Box{T}) = contains(box1, box2.p1) && contains(box1, box2.p2)
iscontainedby{T}(box1::Box{T}, box2::Box{T}) = contains(box2, box1)

function intersect{T}(box1::Box{T}, box2::Box{T})
  p1 = Point(max(xmin(box1), xmin(box2)),
             max(ymin(box1), ymin(box2)))
  p2 = Point(min(xmax(box1), xmax(box2)),
             min(ymax(box1), ymax(box2)))

  if p1.x < p2.x && p1.y < p2.y
    return Nullable{Box{T}}(Box{T}(p1,p2))
  else
    return Nullable{Box{T}}()
  end
end
