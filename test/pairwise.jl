@testset "Pairwise" begin
  𝒟 = PointSet(Matrix(1.0I, 3, 3))
  Γ = Variography.pairwise(GaussianVariogram(), 𝒟)
  @test eltype(Γ) == Float64
  @test issymmetric(Γ)

  𝒟 = PointSet(Matrix(1.0f0I, 3, 3))
  Γ_f = Variography.pairwise(GaussianVariogram(range=1f0, sill=1f0, nugget=0f0), 𝒟)
  @test eltype(Γ_f) == Float32
  @test issymmetric(Γ_f)

  grid = CartesianGrid(10, 10)
  Γ = Variography.pairwise(GaussianVariogram(), view(grid, 1:5))
  @test size(Γ) == (5, 5)
  @test issymmetric(Γ)
  Γ = Variography.pairwise(GaussianVariogram(), view(grid, 1:3), view(grid, 7:10))
  @test size(Γ) == (3, 4)
  @test all(Γ .> 0)
end
