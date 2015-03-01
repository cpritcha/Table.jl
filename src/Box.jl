immutable Point{T}
    x::T
    y::T
end

immutable Box{T}
    p1::Point{T}
    p2::Point{T}

    function Box{T}(p1::Point{T}, p2::Point{T})
        if (p1.x <= p2.x) && (p1.y <= p2.y)
            return new(p1, p2)
        else
            error("p1 > p2")
        end
    end
end

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

# returns box dimensions in relative coordinates for use in compose
_tovec(box::Box) = Float64[xmin(box), ymin(box), xmax(box), ymax(box)]

function _tovec{T <: Number}(boxes::Vector{Box{T}})
    n = length(boxes)
    boxcoords = Array(Float64, n, 4)

    for (i, box) in enumerate(boxes)
        boxcoords[i,:] = _tovec(box)
    end
    return boxcoords
end

function _viewbounds(boxcoords::Matrix{Float64})
    n = size(boxcoords, 1)
    xmin = minimum(slice(boxcoords, 1:n, 1))
    ymin = minimum(slice(boxcoords, 1:n, 2))
    xmax = maximum(slice(boxcoords, 1:n, 3))
    ymax = maximum(slice(boxcoords, 1:n, 4))
    return [xmin, ymin, xmax, ymax]
end

function rectangle(vbox::Matrix{Float64}, inset::Float64=0.2)
    xmin = vbox[:, 1] + inset
    ymin = vbox[:, 2] + inset
    width = vbox[:, 3] .- vbox[:, 1] - inset
    height = vbox[:, 4] .- vbox[:, 2] - inset
    return rectangle(xmin, ymin, width, height)
end

function plot(boxes::Vector{Box}, inset::Float64=0.05)
    coords = _tovec(boxes)
    bounds = _viewbounds(coords)
    rects = rectangle(coords, inset)
    return compose(context(units=UnitBox(bounds...)),
                    rects, fill("tomato"))
end
