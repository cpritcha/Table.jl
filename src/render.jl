abstract AbstractCell
abstract AbstractCells{T}

function styles{T <: AbstractStyleElement}(::Type{T}, tbl::Table)
  n = length(tbl.styles)
  styleels = Array(AbstractStyleElement, n)
  visited = fill(false, n)

  for rng in tbl.layout
    datael_id = rng.datael_id
    style_id  = rng.style_id
    if !visited[style_id]
      styleels[style_id] = style(T, tbl.data[datael_id], tbl.styles[style_id])
      visited[style_id]  = true
    end
  end
  return styleels
end

tcell(::Type{AbstractCell},
      styleel::AbstractStyleElement,
      datael::AbstractDataElement,
      i, j) = error("cell type must be concrete")

function writerange!{T <: AbstractCell}(cells::Matrix{T}, tbl::Table, rng::CellRange)
    box    = rng.box
    styleel  = tbl.styles[rng.style_id]
    datael = tbl.data[rng.datael_id]

    offset_x = xmin(box)
    offset_y = ymin(box)
    n, m = size(datael)

    for i=1:n
        for j=1:m
            cells[offset_y + i,offset_x + j] = tcell(T, styleel, datael, i, j)
        end
    end
    return nothing
end

function convert{T <: AbstractCell}(::Type{Matrix{T}}, tbl::Table)
    cells = Array(T, size(tbl))
    for rng in tbl.layout
        writerange!(cells, tbl, rng)
    end
    return cells
end

renderformatspecific{T <: AbstractCell}(
  io::IO, ::Type{T}, cells::AbstractCells) = error("eltype(cells) must be concrete")

function render{T <: AbstractCell, S <: AbstractStyleElement}(
    io::IO, ::Type{T}, ::Type{S}, tbl::Table)

  styleels = styles(S, tbl)
  newtbl = Table(tbl.data, tbl.layout, styleels)

  cells = convert(Matrix{T}, newtbl)
  renderformatspecific(io, T, cells)
end
