typealias HTMLTable Matrix{HTMLCell}

function renderformatspecific(io::IO, ::Type{HTMLCell}, cells::HTMLTable)
    n, m = size(cells)
    println(io, "<table>")
    for i=1:n
        println(io, "\t<tr>")
        for j=1:m
            showcell(io, cells[i,j])
        end
        println(io, "\t</tr>")
    end
    println(io,"</table>")
end

