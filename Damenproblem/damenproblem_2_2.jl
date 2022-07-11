function restart()
    global board = ones(Int8,22)
    board[1:7] .= -20
    board[16:22] .= -20
    board[8:15]
    fi = -7:-1
    se = 1:7
    global vec = vcat(fi,se)
    return nothing
end

function no_collision()
    isit = true
    if length(unique(board[8:15])) < 8
        isit = false
    end
    #check for the diagonal
    for i = 1:8
        for j = vec
            if board[i+7] == board[i+7+j]+j
                isit = false
            end
        end
    end 
    return isit
end

function dostep()
    ### do this next
end

function dowork()
    restart()
    counter = 0
    while count(==(8),board[8:15]) != 8

        if no_collision()
            count += 1
            display(board[8:15])
        end
    end    
    return counter
end

dowork()

restart()
board[8:15]
no_collision()
