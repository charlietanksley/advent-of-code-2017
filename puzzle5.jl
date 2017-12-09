using Base.Test


x = "0
3
0
1
-3"


function escape(str)
    offsets = map((s) -> parse(Int64, s),
                  split(str, "\n"))

    p = 1
    e = length(offsets)
    steps = 0

    while p <= e
        steps += 1

        jump = read_and_increment!(offsets, p)

        p += jump
    end

    steps
end

function read_and_increment!(arr, int)
    old = arr[int]
    arr[int] = old + 1
    old
end

escape(x)
