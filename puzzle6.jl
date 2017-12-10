using Base.Test
import Base.==

struct MemoryBank
    blocks::Int64
    MemoryBank(str::SubString{String}) = new(parse(Int64, str::SubString{String}))
    MemoryBank(blocks::Int64) = new(blocks)
end

struct MemoryArea
    banks::Array{MemoryBank}
    MemoryArea(str::String) = new(map((x) -> MemoryBank(x), split(str, " ")))
    MemoryArea(arr::Array{Int64, 1}) = new(map((x) -> MemoryBank(x), arr))
end

function layout(area)
    map((bank) -> bank.blocks,
        area.banks)
end

function ==(area1::MemoryArea, area2::MemoryArea)
    function layout(area)
        map((bank) -> bank.blocks,
            area.banks)
    end

    layout(area1) == layout(area2)
end

function includes(arr::Array{MemoryArea}, area::MemoryArea)
    any((memory_area) -> memory_area == area,
        arr)
end

function largest(area::MemoryArea)
    indmax(layout(area))
end

function redistribute(area::MemoryArea)
    i = largest(area)
    blocks = layout(area)
    increment = blocks[i]
    blocks[i] = 0
    last = length(blocks)
    if i == last
        i = 1
    else
        i += 1
    end

    for s in range(1, increment)
        blocks[i] += 1
        if i == last
            i = 1
        else
            i += 1
        end
    end
    blocks
end

function full_cycle_redistribution_count(area::MemoryArea)
    previous_distributions = [area]
    cycles = 0

    while true
        cycles += 1
        current_area = previous_distributions[end]

        new_distribution = MemoryArea(redistribute(current_area))

        if includes(previous_distributions, new_distribution)
            return cycles
        else
            push!(previous_distributions, new_distribution)
        end
    end
end

function solver(str)
    full_cycle_redistribution_count(MemoryArea(str))
end

input = "11 11 13 7 0 15 5 5 4 4 1 1 7 1 15 11"

solver(input)


