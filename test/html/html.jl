facts("HTML Table") do
  for tblname in tblnames
    pb = PipeBuffer()
    render(pb, eval(tblname))
    @fact takebuf_string(pb) == readall("./html/examples/$(tblname).txt") => true
  end
end
