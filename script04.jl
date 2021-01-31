using Random
using CSV, DataFrames

# External CSV
csv_in = "books.csv"
csv_out = "sorted_books.csv"

BOOKS = CSV.read(csv_in, DataFrame)

##
function getc1()
    ret = ccall(:jl_tty_set_mode, Int32, (Ptr{Cvoid},Int32), stdin.handle, true)
    ret == 0 || error("unable to switch to raw mode")
    c = read(stdin, Char)
    ccall(:jl_tty_set_mode, Int32, (Ptr{Cvoid},Int32), stdin.handle, false)
    c
end

function a_lt_b(a,b)
    println("  (a): ", a, "  or  (b): ", b)
    if getc1() == 'a' 
        return false 
    else
        return true
    end
end

## 
v = shuffle(1:size(BOOKS,1))
sort!(v, alg=QuickSort, by=x->BOOKS.Title[x], lt=a_lt_b, rev=true)
# sort!(v, alg=MergeSort, by=x->BOOKS.Title[x], lt=a_lt_b, rev=true)
# sort!(v, alg=InsertionSort, by=x->BOOKS.Title[x], lt=a_lt_b, rev=true)

## 
println("\nRanks:")
println(v)

println("\nOrdered List:")
println.(BOOKS[v])

## Write ordered csv
BOOKS = BOOKS[v,:]
BOOKS[!, "Rank"] = 1:length(v)
CSV.write(csv_out, BOOKS)