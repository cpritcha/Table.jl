isequal(box1::Box, box2::Box) = box1 == box2

xmax{T}(box::Box{T}) = box.p2.x
ymax{T}(box::Box{T}) = box.p2.y
xmin{T}(box::Box{T}) = box.p1.x
ymin{T}(box::Box{T}) = box.p1.y

function contains(box::Box, p::Point)
  return (xmin(box) < p.x) && (ymin(box) < p.y) &&
         (xmax(box) > p.x) && (ymax(box) > p.y)
end

_between(x,y,z) = x > y && y < z
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

function shatterinto{T <: Number}(newbox::Box{T}, box::Box{T})
  ibox = intersect(newbox, box)

  if isnull(ibox)
    return [box]
  else
    ibox = get(ibox)
  end

  hastopspace    = ymax(box) > ymax(ibox)
  hasbottomspace = ymin(box) < ymin(ibox)

  hasrightspace  = xmax(box) > xmax(ibox)
  hasleftspace   = xmin(box) < xmin(ibox)

  res = Box{T}[]
  # place top
  if hastopspace
    print("top")
    p1, p2 = Point(xmin(box), ymax(ibox)), Point(xmax(box), ymax(box))
    push!(res, Box{T}(p1, p2))
  end
  # place bottom
  if hasbottomspace
    print("bottom")
    p1, p2 = Point(xmin(box), ymin(box)), Point(xmax(box), ymin(ibox))
    push!(res, Box{T}(p1, p2))
  end
  # place right
  if hasrightspace
    print("right")
    p1, p2 = Point(xmax(ibox), ymin(ibox)), Point(xmax(box), ymax(ibox))
    print("\tp1: $p1,  p2: $p2")
    push!(res, Box{T}(p1, p2))
  end
  # place left
  if hasleftspace
    print("left")
    p1, p2 = Point(xmin(box), ymin(ibox)), Point(xmin(ibox), ymax(ibox))
    push!(res, Box{T}(p1, p2))
  end
  return res
end

function distinctify(addedboxes, boxes)
  distinctboxes = copy(boxes)

  for addedbox in addedboxes
    newboxes = Set{Box{Int}}()
    for box in distinctboxes
      if intersects(addedbox, box)
        union!(newboxes, shatterinto(addedbox, box))
      end
      push!(newboxes, addedbox)
    end
    distinctboxes = newboxes
  end

  return distinctboxes
end
