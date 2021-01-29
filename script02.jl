using Random
using CSV

# Test Case
# BOOKS = ["book" * string(i) for i in 1:4]

# External CSV
csv_file = "books.csv"
csv_out = "sorted_books.csv"

books_table = CSV.read(csv_file)
BOOKS = books_table.Title

function getc1()
    ret = ccall(:jl_tty_set_mode, Int32, (Ptr{Cvoid},Int32), stdin.handle, true)
    ret == 0 || error("unable to switch to raw mode")
    c = read(stdin, Char)
    ccall(:jl_tty_set_mode, Int32, (Ptr{Cvoid},Int32), stdin.handle, false)
    c
end

order = shuffle(1:length(BOOKS))
RANKS = [order[1]]
for i in order[2:end]

    lb = 1
    ub = length(RANKS)
    this_book = BOOKS[i]

    while true

        # Get a random possible rank preceder
        comp = rand(lb:ub)
        comp_book = BOOKS[RANKS[comp]]

        println("(a): ", comp_book, "     or     (b): ", this_book)
        ui = getc1()
        println(ui)

        # Need to catch the case where we have no preceder
        if comp==lb && ui=='b'
            insert!(RANKS,lb,i)
            break
        end

        # Catch the tail case
        if comp==ub && ui=='a'
            insert!(RANKS,ub+1,i)
            break
        end


        if ui=='b'
            ub = comp-1
        elseif ui=='a'
            lb = comp+1
        elseif ui=='q'
            break
        else
            println("Press 'a' or 'b'")
        end


    end


end



println("\nOrdered List:")
[println(BOOKS[i]) for i in RANKS]

println("\nRanks:")
println(RANKS)


# Write ordered csv
books_table = books_table[RANKS,:]
books_table["Rank"] = 1:length(RANKS)
CSV.write(csv_out, books_table)