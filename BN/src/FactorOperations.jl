include("Factor.jl")

function FactorPermute(A::Factor,v::Vector{Int})
    if length(A.var)!=length(v)
        error("Permute vector's dimension mismatch!")
    end

    valuespace = reshape(A.value, A.card...)
    newvaluespace = permutedims(valuespace, v)
    var = A.var[v]
    card = A.card[v]
    Factor(var,card,newvaluespace[:])
end


function FactorProduct(A::Factor, B::Factor)
    common_var = intersect(A.var, B.var)
    A_common_idx = indexin(common_var, A.var)
    B_common_idx = indexin(common_var, B.var)
    if A.card[A_common_idx] != B.card[B_common_idx]
        error("Inputs' common variables have mismatch cardinality!")
    end

    # Set the variables of C
    Cvar = union(A.var, B.var)

    Cvar_length = length(Cvar)

    mapA = indexin(A.var, Cvar)
    mapB = indexin(B.var, Cvar)

    # Set the cardinality of variables in C
    Ccard = zeros(Int, Cvar_length)
    Ccard[mapA] = A.card
    Ccard[mapB] = B.card

    Aarr0 = indexin(Cvar, A.var)
    Barr0 = indexin(Cvar, B.var)
    Aarr1 = Aarr0[Aarr0.>0]
    Barr1 = Barr0[Barr0.>0]

    A1 = FactorPermute(A, Aarr1)
    B1 = FactorPermute(B, Barr1)

    A1card = ones(Int, Cvar_length)
    B1card = ones(Int, Cvar_length)
    A1card[mapA] = A.card
    B1card[mapB] = B.card

    Avaluespace = reshape(A1.value, A1card...)
    Bvaluespace = reshape(B1.value, B1card...)

    Cvaluespace = Avaluespace .* Bvaluespace

    Factor(Cvar, Ccard, Cvaluespace[:])
end


*(A::Factor, B::Factor) = FactorProduct(A::Factor, B::Factor)


function FactorMargin(A::Factor, Remove_var::Vector{String}, Remain_var::Vector{String}, Remove_dims::Vector{Int}, Remain_dims::Vector{Int})
    Remain_card = A.card[Remain_dims]

    valuespace = reshape(A.value, A.card...)
    permute_dims = [Remain_dims,Remove_dims]
    permuted_valuespace = permutedims(valuespace, permute_dims)

    squeeze_dims = [length(Remain_dims)+1:length(permute_dims)]

    sumvaluespace = sum(permuted_valuespace, squeeze_dims)
    Remain_valuespace = squeeze(sumvaluespace, squeeze_dims)

    Factor(Remain_var, Remain_card, Remain_valuespace[:])
end


function FactorDropMargin(A::Factor, Remove_var::Vector{String})
    Remove_dims = indexin(Remove_var, A.var)
    if any(Remove_dims==0)
        error("Wrong variable!")
    end

    Remain_var = symdiff(A.var, Remove_var)
    Remain_dims = indexin(Remain_var, A.var)

    FactorMargin(A, Remove_var, Remain_var, Remove_dims, Remain_dims)
end


function FactorKeepMargin(A::Factor, Remain_var::Vector{String})
    Remain_dims = indexin(Remain_var, A.var)
    if any(Remain_dims==0)
        error("Wrong variable!")
    end

    Remove_var = symdiff(A.var, Remain_var)
    Remove_dims = indexin(Remove_var, A.var)

    FactorMargin(A, Remove_var, Remain_var, Remove_dims, Remain_dims)
end


function FactorReduce(A::Factor, Reduce_var::Vector{String}, Reduce_idx::Vector{Int})
    Reduce_dims = indexin(Reduce_var, A.var)
    if any(Reduce_dims.==0)
        error("Wrong variable!")
    end
    if any(A.card[Reduce_dims].<Reduce_idx)
        error("Index larger than cardinality!")
    end

    Bvar = deepcopy(A.var)
    Bcard = deepcopy(A.card)
    Bvar[Reduce_dims] = Bvar[Reduce_dims].*["_{$i}" for i in Reduce_idx]
    Bcard[Reduce_dims] = 1

    valuespace = reshape(A.value, A.card...)

    for i = 1:length(Reduce_dims)
        valuespace = slicedim(valuespace, Reduce_dims[i], Reduce_idx[i])
    end
    Factor(Bvar, Bcard, valuespace[:])
end

function FactorNormalize(A::Factor)
    Bvar = deepcopy(A.var)
    Bcard = deepcopy(A.card)
    tmpvalue = deepcopy(A.value)
    Z =  sum(tmpvalue)
    Bvalue = tmpvalue./Z
    Factor(Bvar, Bcard, Bvalue)
end
