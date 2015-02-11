_refid(r::Range) = r.ref_id
_box(r::Range) = r.box

function shatterinto{T <: Number}(r1::Range{T}, r2::Range{T})
  box = _box(r2)
  refid = _refid(r2)
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

#   println("\nshattering...")
  res = Range{T}[]
  # place top
  if hastopspace
#     print("top")
    p1, p2 = Point(xmin(box), ymax(ibox)), Point(xmax(box), ymax(box))
    push!(res, Range(Box{T}(p1, p2), refid))
  end
  # place bottom
  if hasbottomspace
#     print("bottom")
    p1, p2 = Point(xmin(box), ymin(box)), Point(xmax(box), ymin(ibox))
    push!(res, Range(Box{T}(p1, p2), refid))
  end
  # place right
  if hasrightspace
#     print("right")
    p1, p2 = Point(xmax(ibox), ymin(ibox)), Point(xmax(box), ymax(ibox))
    push!(res, Range(Box{T}(p1, p2), refid))
  end
  # place left
  if hasleftspace
#     print("left")
    p1, p2 = Point(xmin(box), ymin(ibox)), Point(xmin(ibox), ymax(ibox))
    push!(res, Range(Box{T}(p1, p2), refid))
  end
  return res
end

function push{T}(layout::Layout{T}, newrange::Range{T})

  newlayout = Range{T}[]
  i = 1
  for range in layout
    if intersects(_box(newrange), _box(range))
      pieces = shatterinto(newrange, range)
      for piece in pieces
        push!(newlayout, piece)
      end
    else
      push!(newlayout, range)
    end
    i+=1
  end
  push!(newlayout, newrange)

  return Layout(newlayout)
end
