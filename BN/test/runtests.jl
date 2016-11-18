using BN
using Base.Test

@testset "Define, permute factor, and call (var, card, val)" begin

  X = Factor(["B", "A"], [2, 3], rand(6))
  X.var
  X.card
  X.value
  Y = FactorPermute(X, [2, 1])

end

@testset "Multiply and marginalize factor" begin

  A=Factor(["a", "b"],[3, 2],[0.5, 0.1, 0.3, 0.8, 0, 0.9])
  B=Factor(["b", "c"],[2, 2],[0.5, 0.1, 0.7, 0.2])
  C = FactorProduct(A, B)
  FactorDropMargin(C, ["c"])
  FactorKeepMargin(C, ["b", "a"])
  FactorPermute(ans, [2, 1])
  FactorKeepMargin(C, ["a", "b"])

end

@testset "Reduce and normalize factor" begin

  FactorReduce(C, ["c"], [1])
  FactorReduce(C, ["b","c"], [1,1])
  FactorNormalize(C)
  sum(ans.value)

end
