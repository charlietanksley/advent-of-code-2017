using Base.Test

function distance(int)
    upper_x = 0
    upper_y = 0
    lower_x = 0
    lower_y = 0

    m = [(0, 0)]
    direction = :right

    if int == 1
        return 0
    end

    for i in range(2, int - 1)
        last = m[end]
        x = last[1]
        y = last[2]

        if direction == :right
            if x <= upper_x
                x += 1
            else
                direction = :up
                upper_x +=1
                y += 1
            end
        elseif direction == :up
            if y <= upper_y
                y += 1
            else
                upper_y +=1
                direction = :left
                x -= 1
            end
        elseif direction == :left
            if x >= lower_x
                x -= 1
            else
                lower_x -= 1
                direction = :down
                y -= 1
            end
        elseif direction == :down
            if y >= lower_y
                y -= 1
            else
                lower_y -= 1
                direction = :right
                x += 1
            end
        end

        push!(m, (x, y))
    end
    coord = m[end]
    abs(0 - coord[1]) + abs(0 - coord[2])
end

@test distance(1) == 0
@test distance(12) == 3
@test distance(23) == 2
@test distance(1024) == 31
distance(368078)
