autostyle{T <: Integer}(tp::Type{T}) = generate_formatter("%i")
autostyle{T <: FloatingPoint}(tp::Type{T}) = generate_formatter("%.2f")
autostyle(tp::Type{String}) = generate_formatter("%s")
# autostyle(tp::Any) = generate_formatter("%s")

function autostyle{T}(tp::Type{Nullable{T}})
  g(content) = autostyle(T)(content)
  function f(content)
    if isnull(content)
      return ""
    else
      return g(get(content))
    end
  end
  return f
end

function joinkeyvalpairs(dict)
  buf = IOBuffer()
  for (k,v) in dict
    print(buf, " $k=\"$v\"")
  end
  return takebuf_string(buf)
end

function htmlclasses(s, default)
  if haskey(s.d, :html)
    htmlkey = s.d[:html]
    return joinkeyvalpairs(htmlkey)
  end
  return default
end

function style(::Type{HTMLStyleElement}, data, s::UniformStyleElement)
  classes = htmlclasses(s, "datael")
  f = autostyle(eltype(data))
  HTMLStyleElement(TextProp(f), StaticSpanProp(), classes)
end

function style(::Type{HTMLStyleElement}, data, s::ExpandStyleElement)
  classes = htmlclasses(s, "datael")
  f = generate_formatter("%s")
  HTMLStyleElement(TextProp(f), ExpandSpanProp(), classes)
end

function style(::Type{HTMLStyleElement}, data, s::CartesianStyleElement)
  classes = htmlclasses(s, "datael")
  f = generate_formatter("%s")
  HTMLStyleElement(TextProp(f), CartesianSpanProp(), classes)
end
