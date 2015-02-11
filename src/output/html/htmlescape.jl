immutable HTML
   s::String
end

writemime(io::IO, ::MIME"text/html", html::HTML) = print(io, html.s)

const _htmlescape_chars = ['<'=>"&lt;", '>'=>"&gt;",
                               '"'=>"&quot;", '\''=>"&#39",
                               '`'=>"`&#96;", # ' '=>"&nbsp;",
                               '!'=>"&#33;", '@'=>"&#64;",
                               '$'=>"&#36;", '%'=>"&#37;",
                               '('=>"&#40;", ')'=>"&#41;",
                               '='=>"&#61;", '+'=>"&#43;",
                               '{'=>"&#123;", '}'=>"&#124;",
    '['=>"&#91;", ']'=>"&#91;"]
function htmlescape(s::String)
    s1 = replace(s, r"&(?!(\w+|\#\d+);)", "&amp;")
    join([get(_htmlescape_chars, ch, ch) for ch in s1])
end
