type Table
  data
  datalayout
  style
  stylelayout
end

function size(tbl::Table)
  n, m = 0, 0

  for rng in tbl.stylelayout
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
