using Tables, Formatting

include("../general/examples.jl")

for tblname in tblnames

  fname = "./examples/$(string(tblname)).txt"
  f = open(fname, "w")
  println("opened: $fname")
  render(f, eval(tblname))
  close(f)
  println("closed: $fname")
end
