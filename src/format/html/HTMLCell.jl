immutable HTMLCell <: AbstractCell
    text::Nullable{String}
    colspan::Int
    rowspan::Int
    tagstring::String
end

function showcell(io::IO, c::HTMLCell)
    rows = c.rowspan > 1 ? " rowspan=\"$(c.rowspan)\"" : ""
    cols = c.colspan > 1 ? " colspan=\"$(c.colspan)\"" : ""

    if !isnull(c.text)
        println(io, "\t\t<td$(rows)$(cols)$(c.tagstring)>$(get(c.text))</td>")
    end
end

function tcell(::Type{HTMLCell},
              styleel::AbstractStyleElement,
              datael,
              i::Int, j::Int)
  hascontents = istext(styleel, datael, i, j)
  txt = hascontents ?
    Nullable(htmlescape(text(datael[i,j], styleel.text))) :
    Nullable{eltype(datael)}()
  cs, rs  = colspan(styleel, datael, i, j), rowspan(styleel, datael, i, j)

  return HTMLCell(txt, cs, rs, styleel.tagstring)
end
