immutable Range{T}
  box::Box{T}
  ref_id::Int
end

type Layout{T}
  r::Vector{Range{T}}
end
Layout{T}(::Type{T}) = Layout(Range{T}[])
length(l::Layout) = length(l.r)
start(l::Layout) = start(l.r)
next(l::Layout, st) = next(l.r, st)
done(l::Layout, st) = done(l.r, st)
