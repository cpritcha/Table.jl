facts("HTML Table") do
  for tblname in tblnames
    println(tblname)
    pb = PipeBuffer()
    rendercells(pb, tocellarray(eval(tblname)))
    @fact takebuf_string(pb) == readall("./html/examples/$(tblname).txt") => true
  end
end
