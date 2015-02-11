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
