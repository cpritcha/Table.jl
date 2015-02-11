using Tables
using Formatting
using FactCheck

# FactCheck.setstyle(:compact)
# write your own tests here

box1 = Box{Int}(Point(0,0), Point(10,10))
box2 = Box{Int}(Point(1,1), Point(2,2))
box3 = Box{Int}(Point(1,1), Point(12,12))
box4 = Box{Int}(Point(11,11), Point(12,12))
box5 = Box{Int}(Point(5,10), Point(12,12))
box6 = Box{Int}(Point(-1,-2), Point(13,14))

r1 = Range(box1, 1)
r2 = Range(box2, 2)
r3 = Range(box3, 3)
r4 = Range(box4, 4)
r5 = Range(box5, 5)
r6 = Range(box6, 6)

include("box.jl")
include("range.jl")

include("general/examples.jl")
include("html/html.jl")
