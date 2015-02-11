function getcellids(tbl, pt)
    # get appropriate style and data for that cell
    style_id = getrangeid(tbl.stylelayout, pt)
    data_id = getrangeid(tbl.datalayout, pt)

    return data_id, style_id
end

@doc """
Return the appropriate index of a data item given the position of the top left data range and the current position
""" ->
function getdata(data::Matrix, topleft, pt, span::(Int,Int))
    n, m   = size(data)
    rowspan, colspan = span

    repeat_y = rowspan
    repeat_x = colspan

    #println("\nn, m: ", n, ", ", m)
    #println("rowspan, colspan: ", rowspan ,", ", colspan)
    #println("repeat_y, repeat_x: ", repeat_y ,", ", repeat_x)
    ∇x = pt.x - topleft.x
    ∇y = pt.y - topleft.y
    #println("∇x, ∇y: ", ∇x, ", ", ∇y)
    j    = div(∇x, repeat_x) + 1
    i    = div(∇y, repeat_y) + 1
    on_x = mod(∇x, repeat_x) == 0
    on_y = mod(∇y, repeat_y) == 0
    #println("on_x, on_y: ", on_x, ", ", on_y)
    #println("i, j: ", i, ", ", j)

    return (on_x && on_y) && (n,m) >= (i,j) ? Nullable(data[i,j]) : Nullable{eltype(data)}()
end

function getrangeid(l::Layout, pt::Point)
    for r in l
        if topleftcontains(r.box, pt)
            return r.ref_id
        end
    end
    error("no style at location $pt")
end
