#=
Styles for

Head
Subhead
DataEl
=#

abstract AbstractStyleElement
abstract AbstractPresentationStyleElement <: AbstractStyleElement

# const stylenames = [:EmptyStyleElement, :HeadStyleElement, :SubheadStyleElement, :DataStyleElement]
const stylenames = [:ExpandStyleElement, :CartesianStyleElement, :UniformStyleElement]

for r in stylenames
  @eval begin
    immutable $r <: AbstractPresentationStyleElement
      d::Dict{Symbol, Any}
    end
    $r() = $r(Dict{Symbol, Any}())
  end
end

style(::Type{AbstractStyleElement}, data,
      styleel::AbstractPresentationStyleElement) = error("styleel must be concrete")
