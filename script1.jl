using Random
run(`stty raw`)


BOOKS = ["bk" * string(i) for i in 1:10]


order = shuffle(1:length(BOOKS))
RANKED_BOOKS = [BOOKS[order[1]]]
for book in BOOKS[order[2:end]]
    
    pos_spots = 1:length(RANKED_BOOKS)
    
    while length(pos_spots) > 0
        # Pick a book
        comp_book = rand(pos_spots)

        # Ask user if higher lower
        println(book, " or ", RANKED_BOOKS[comp_book])
        user_response = read(stdin, Char)
        println(user_response)

        if comp_book == 1 && user_response == "higher"
            #Book is new number 1

        end

    end
end





