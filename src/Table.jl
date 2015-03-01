function checksizes(data, layout)
  for rng in layout
    size_range = size(rng)
    el = data[_data_id(rng)]
    size_el = size(el)
    if size_range != size_el
      error(
        """
        size mismatch
        rng: $rng
        el: $el
        size_range: $size_range, size_el: $size_el\n
        """)
    end
  end
  return nothing
end
type Table
  data::Vector
  layout
  styles::Vector{AbstractStyleElement}

  function Table(data, layout, styles)
    checksizes(data, layout)
    return new(data, layout, styles)
  end
end

function size(tbl::Table)
  n, m = 0, 0

  for rng in tbl.layout
    ncand = ymax(rng.box)
    mcand = xmax(rng.box)
    if n < ncand
      n = ncand
    end
    if m < mcand
      m = mcand
    end
  end
  return n, m
end
