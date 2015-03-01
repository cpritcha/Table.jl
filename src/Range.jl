immutable CellRange{T}
  box::Box{T}
  datael_id::Int
  style_id::Int
end
size(rng::CellRange)  = size(rng.box)

_data_id(r::CellRange) = r.datael_id
_style_id(r::CellRange) = r.style_id
_box(r::CellRange) = r.box

function shatterinto{T <: Number}(r1::CellRange{T}, r2::CellRange{T})
  box = _box(r2)
  dataid  = _data_id(r2)
  styleid = _style_id(r2)
  ibox = intersect(_box(r1), box)

  if isnull(ibox)
    return [r2]
  else
    ibox = get(ibox)
  end

  hastopspace    = ymax(box) > ymax(ibox)
  hasbottomspace = ymin(box) < ymin(ibox)

  hasrightspace  = xmax(box) > xmax(ibox)
  hasleftspace   = xmin(box) < xmin(ibox)

  res = CellRange{T}[]
  # place top
  if hastopspace
#     print("top")
    p1, p2 = Point(xmin(box), ymax(ibox)), Point(xmax(box), ymax(box))
    push!(res, Range(Box{T}(p1, p2), dataid, styleid))
  end
  # place bottom
  if hasbottomspace
#     print("bottom")
    p1, p2 = Point(xmin(box), ymin(box)), Point(xmax(box), ymin(ibox))
    push!(res, Range(Box{T}(p1, p2), dataid, styleid))
  end
  # place right
  if hasrightspace
#     print("right")
    p1, p2 = Point(xmax(ibox), ymin(ibox)), Point(xmax(box), ymax(ibox))
    push!(res, Range(Box{T}(p1, p2), dataid, styleid))
  end
  # place left
  if hasleftspace
#     print("left")
    p1, p2 = Point(xmin(box), ymin(ibox)), Point(xmin(ibox), ymax(ibox))
    push!(res, Range(Box{T}(p1, p2), dataid, styleid))
  end
  return res
end
