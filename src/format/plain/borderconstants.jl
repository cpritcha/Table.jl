module PlainBox
# lines
const horizontal = '\u2500'
const vertical = '\u2502'

# elbows
const up_right_corner = '\u250C'
const up_left_corner = '\u2510'
const down_right_corner = '\u2514'
const down_left_corner = '\u2518'

# t intersections
const vertical_right_t = '\u251C'
const vertical_left_t  = '\u2524'
const horizontal_down_t = '\u252C'
const horizontal_up_t = '\u2534'

const cross = '\u253C'

@doc """
Thin line unicode box drawing characters arranged for easy access.

Elements are arranged so that converting booleans of whether or not the
left, right, top or bottom neighbouring box drawing characters are present
into a linear index selects the correct box drawing character.

Example
=======
```julia
left =   true
right=   false
top  =   false
bottom = true

simple[bottom + 2*top + 4*right + 8*left] # == up_left_corner
```
""" ->
const simple =
[
    ' ',
    ' ',
    ' ',
    vertical,
    ' ',
    up_right_corner,
    down_right_corner,
    vertical_right_t,
    ' ',
    up_left_corner,
    down_left_corner,
    vertical_left_t,
    horizontal,
    horizontal_down_t,
    horizontal_up_t,
    cross
]
end
