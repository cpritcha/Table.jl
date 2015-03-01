#=
All DataElements should have a size and a getindex method
=#
abstract AbstractDataElement

lengths(x) = [length(el) for el in x.data]
function spansizes(data::Vector)
  lens = [length(el) for el in data]
  n = length(lens)
  res = fill(1, n)
  acc = 1
  if n > 0
    res[n] = 1
    for i=(n-1):-1:1
      acc *= lens[i+1]
      res[i]=acc
    end
  end
  return res
end
immutable CartesianDataElement <: AbstractDataElement
  data::Vector{Vector}
  isvertical::Bool
  spansizes::Vector{Int}

  function CartesianDataElement(data, isvertical)
    spsz = spansizes(data)
    return new(data, isvertical, spsz)
  end
end

isvertical(x::CartesianDataElement) = x.isvertical
function size(x::CartesianDataElement)
  if isvertical(x)
    n = length(x.data)
    m = prod(lengths(x))
  else
    n = prod(lengths(x))
    m = length(x.data)
  end
  return n, m
end

function getindex(x::CartesianDataElement, i::Int, j::Int)
#   println("i, j: $i, $j")
  spsz = x.spansizes
  lens = lengths(x)
  if isvertical(x)
    idx = mod(div(j-1, spsz[i]), lens[i]) + 1
    res = x.data[i][idx]
  else
    idx = mod(div(i-1, spsz[j]), lens[j]) + 1
    res = x.data[j][idx]
  end
  return res
end

immutable ExpandDataElement <: AbstractDataElement
  data
  n::Int
  m::Int
end

size(x::ExpandDataElement) = (x.n, x.m)
function size(x::ExpandDataElement, dim::Int)
  if dim==1
    return x.n
  elseif dim==2
    return x.m
  else
    error("dim must be 1|2")
  end
end
getindex(x::ExpandDataElement, i::Int, j::Int) = x.data
