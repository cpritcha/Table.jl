function plot{T}(layout::Layout{T}, inset::Float64=0.05)
    coords = _tovec(Box{T}[_box(range) for range in layout])
    bounds = _viewbounds(coords)
    rects = rectangle(coords, inset)
    return compose(context(units=UnitBox(bounds...)),
                    rects, fill("tomato"))
end
