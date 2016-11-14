abstract Node

type Factor <: Node
    var::Vector{ASCIIString} # vector of variables in the factor
    card::Vector{Int} # vector of cardinalities corresponding to var
    value::Vector{Float64} # table of size prod(card)
end

function Factor (var::Vector{ASCIIString}, card::Vector{Int}, value::Vector{Float64})
    if prod(card) != length(value)
      error("Cardinalities and values do not match!")
    elseif length(var) != length(card)
      error("Variables and cardinalities do not match!")
    else
      new(var, card, value)
    end
end

include("FactorOperations.jl")

export * # infix for FactorProduct
export Factor, FactorDropMargin, FactorKeepMargin, FactorNormalize
export FactorPermute, FactorProduct, FactorReduce

end
