type Layout{T}
  r::Vector{CellRange{T}}
end
Layout{T}(::Type{T}) = Layout(CellRange{T}[])
==(l1::Layout, l2::Layout) = l1.r == l2.r

length(l::Layout) = length(l.r)
start(l::Layout) = start(l.r)
next(l::Layout, st) = next(l.r, st)
done(l::Layout, st) = done(l.r, st)

function size(l::Layout)
  n, m = 0
  for r in l
    box = _box(r)

    ncand = xmax(box)
    if n < ncand
      n = ncand
    end
    mcand = ymax(box)
    if m < mcand
      m = mcand
    end
  end
  return n, m
end

function push{T}(layout::Layout{T}, newcellrange::CellRange{T})

  newlayout = CellRange{T}[]
  i = 1
  for cellrange in layout
    if intersects(_box(newcellrange), _box(cellrange))
      pieces = shatterinto(newcellrange, cellrange)
      for piece in pieces
        push!(newlayout, piece)
      end
    else
      push!(newlayout, cellrange)
    end
    i+=1
  end
  push!(newlayout, newcellrange)

  return Layout(newlayout)
end

function plot{T}(layout::Layout{T}, inset::Float64=0.05)
    coords = _tovec(Box{T}[_box(cellrange) for cellrange in layout])
    bounds = _viewbounds(coords)
    rects = rectangle(coords, inset)
    return compose(context(units=UnitBox(bounds...)),
                    rects, fill("tomato"))
end
