using Base.Test

function Base.convert(Array, str::SubString{String})
    split(str, " ")
end

struct Passphrase
    components::Array
    Passphrase(x) = new(convert(Array, x))
end

function is_valid_passphrase(str::String)
    is_valid(Passphrase(str))
end

function is_valid(passphrase::Passphrase)
    components = []
    for component in passphrase.components
        if contains(==, components, component)
            return false
        else
            push!(components, component)
        end
    end

    true
end

function count_valid_passphrases(str)
    passphrases = split(str, "\n")#map((string) -> Passphrase(string),

    passphrases = map((x) -> Passphrase(x), passphrases)
    valid = map((x) -> is_valid(x),
                passphrases)

    length(filter((p) -> is_valid(p),
                  passphrases))
end

@test is_valid_passphrase("aa bb cc dd ee") == true
@test is_valid_passphrase("aa bb cc dd aa") == false
@test is_valid_passphrase("aa bb cc dd aaa") == true
