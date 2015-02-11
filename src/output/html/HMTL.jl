function render(io, tbl::Table, pt::Point)
    data_id, style_id = getcellids(tbl, pt)

    data_rng = tbl.datalayout.r[data_id]
    data = tbl.data[data_id]

    style_rng = tbl.datalayout.r[style_id]
    style = tbl.style[style_id]

    topleft = style_rng.box.p1

    rowspan = style.cell.rowspan
    colspan = style.cell.colspan
    content = getdata(data, topleft, pt, (rowspan, colspan))
    #println("content", content)
    if !isnull(content)
        print(io, "\t\t<td colspan=\"$(colspan)\" rowspan=\"$(rowspan)\">")
        str = text(get(content), style.text)
        print(io, htmlescape(str))
        println(io, "</td>")
    end
    return nothing
end

function render(io::IO, tbl::Table)
    n, m = size(tbl)
    println(io, "<table>")
    for i=1:n
        println(io, "\t<tr>")
        for j=1:m
            pt = Point(j-1,i-1)
            render(io, tbl, pt)
        end
        println(io, "\t</tr>")
    end
    println(io,"</table>")
end

