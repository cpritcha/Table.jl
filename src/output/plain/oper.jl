# ----------------- Border methods ------------------------
@doc """
Holds infomation on the presence or absence of a border.
""" ->
type Border
    horizontal::Matrix{Bool}
    vertical::Matrix{Bool}
end

function Border(tbl::Table)
  n, m = size(tbl)
  return new(fill(false, n+1, m), fill(false, n, m+1))
end

size(brd::Border) = (size(brd.horizontal, 1), size(brd.vertical, 2))
function setindex!(brd::Border, cell, i, j)
  brd.vertical[i,j] |= cell.border.left
  brd.vertical[i,j+1] |= cell.border.right

  brd.horizontal[i,j] |= cell.border.top
  brd.horizontal[i+1,j] |= cell.border.bottom
end

function show(io::IO, brd::Border)
    println(io, "Horizontal Lines")
    show(io, brd.horizontal)

    println(io, "\n\nVertical Lines")
    show(io, brd.vertical)
end

function neighborlines(brd::Border, i, j)
    n, m = size(brd)

    hasleft   = j > 1
    hasright  = j < m
    hastop    = i > 1
    hasbottom = i < n

    left   = hasleft ? brd.horizontal[i,j-1] : false
    right  = hasright ? brd.horizontal[i,j] : false
    top    = hastop ? brd.vertical[i-1, j] : false
    bottom = hasbottom ? brd.vertical[i, j] : false

    return [left; right; top; bottom]
end

function getconnections(brd::Border)
    n, m = size(brd)

    res = Array(Char,n,m)
    for j=1:m
        for i=1:n
            res[i,j] = getconnector(neighborlines(brd, i, j))
        end
    end
    return res
end

function getverticals(brd::Border, i)
    m = size(brd.vertical, 2)
    res = zeros(Char, m)
    for j=1:m
        res[j] = brd.vertical[i,j] ? '\u2502' : ' '
    end
    return res
end

function gethorizontals(brd::Border, i)
    m = size(brd.horizontal, 2)
    res = zeros(Char, m)
    for j=1:m
        res[j] = brd.horizontal[i,j] ? '\u2500' : ' '
    end
    return res
end

function allblank(horizontals)
    for el in horizontals
        if el != ' '
            return false
        end
    end
    return true
end

function _init_border(tbl::Table)
  n, m = size(tbl)
  return fill(' ', n+1, m+1)
end
_init_data(tbl::Table) = fill(PlainCell, size(tbl))

function convert(::Type{PlainText}, tbl::Table)
  border = Border(tbl)
  data = _init_data(tbl)
end
