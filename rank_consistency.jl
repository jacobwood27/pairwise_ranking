using Plots
using Statistics
using CSV, DataFrames

csv_file = "books.csv"
books_table = CSV.read(csv_file, DataFrame)

ranking_1 = [64, 54, 53, 58, 8, 65, 12, 36, 38, 42, 49, 52, 60, 2, 51, 35, 24, 9, 18, 37, 4, 59, 28, 20, 3, 30, 7, 15, 48, 66, 17, 23, 29, 21, 39, 31, 40, 25, 61, 46, 11, 67, 10, 22, 14, 57, 50, 44, 32, 1, 5, 33, 43, 55, 16, 26, 19, 56, 13, 34, 62, 27, 41, 45, 47, 63, 6]
ranking_2 = [64, 54, 53, 49, 60, 8, 65, 52, 58, 38, 2, 51, 36, 42, 40, 9, 4, 24, 35, 18, 28, 67, 59, 29, 20, 30, 31, 3, 10, 66, 12, 22, 11, 7, 37, 23, 25, 14, 5, 46, 21, 39, 26, 61, 16, 48, 33, 17, 50, 15, 32, 57, 1, 44, 55, 43, 19, 56, 27, 34, 45, 13, 41, 62, 63, 47, 6]
ranking_3 = [64, 54, 53, 49, 52, 60, 65, 38, 58, 51, 36, 8, 12, 42, 2, 35, 59, 4, 29, 40, 9, 28, 24, 25, 67, 30, 20, 66, 7, 48, 33, 23, 37, 31, 22, 18, 15, 17, 39, 46, 14, 43, 21, 10, 26, 11, 32, 3, 5, 50, 19, 57, 55, 1, 27, 44, 61, 56, 16, 34, 45, 13, 41, 62, 47, 63, 6]

rnk_1 = sortperm(ranking_1)
books_table[!,"Rnk1"] = rnk_1
rnk_2 = sortperm(ranking_2)
books_table[!,"Rnk2"] = rnk_2
rnk_3 = sortperm(ranking_3)
books_table[!,"Rnk3"] = rnk_3

rnk_mean = [mean([r1,r2,r3]) for (r1,r2,r3) in zip(rnk_1, rnk_2, rnk_3)]
books_table[!,"Rnk_mean"] = rnk_mean
rnk_std = [std([r1,r2,r3]) for (r1,r2,r3) in zip(rnk_1, rnk_2, rnk_3)]
books_table[!,"Rnk_std"] = rnk_std


scatter(rnk_mean, rnk_1, label="Ranking 1", legend=:topleft)
scatter!(rnk_mean, rnk_2, label="Ranking 2")
scatter!(rnk_mean, rnk_3, label="Ranking 3")
plot!(1:length(rnk_1), 1:length(rnk_1), label=nothing)

sort!(books_table, "Rnk_mean")
CSV.write("ranked_books.csv", books_table)
