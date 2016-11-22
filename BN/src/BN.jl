module BN

include("Factor.jl")
include("FactorOperations.jl")

export * # infix for FactorProduct
export Factor, FactorDropMargin, FactorKeepMargin, FactorNormalize
export FactorPermute, FactorProduct, FactorReduce

end
