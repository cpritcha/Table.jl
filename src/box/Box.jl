immutable Point{T}
    x::T
    y::T
end

immutable Box{T}
    p1::Point{T}
    p2::Point{T}

    function Box(p1, p2)
        if (p1.x <= p2.x) && (p1.y <= p2.y)
            return new(p1, p2)
        else
            error("p1 > p2")
        end
    end
end

typealias Boxes{T} Set{Box{T}}
