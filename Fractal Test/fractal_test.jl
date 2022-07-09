#Idea is to have the possibility to plug in the actual copied text (just a symbol at start) or copy the whole text typed yet.
#Copying or typing costs a certain amount of resources - what is the optimal sequence for reaching large texts fast?

#Functions
function fib(n::Int)
    n<0 && error("n must be non negative")
    n==0 && return 0
    n==1 && return 1
    fib(n-1) + fib(n-2)
end

function doall(iter::Int,calcstep::Int) #do iter iterations and look for the best path all calcstep steps
    if calcstep > 16
        error("calcstep must be smaller than 17!")
    end
    if iter > 118
        error("iter must be smaller than 119")
    end
    totalpaths = fib(calcstep+4) #fibonacci related
    ##[:,:,1] = 0 if empty, 1 if typed, 2 if copied, [:,:,2] = copied number, [:,:,3] = number 
    global pathboard = zeros(Int64,totalpaths,iter+1,3)
    for i = 1:iter
        if i == 1 #build the first (allways the same) best steps
            pathboard[1,1:2,1:2] .= 1
            pathboard[1,1,3] = 1
            pathboard[1,2,3] = 2
        else 
            for j = 1:totalpaths
                if pathboard[j,i,1] == 1 && pathboard[j,i+1,1] == 0 #previous was a type -> 2 following cases
                    #type case
                    pathboard[j,i+1,1] = 1
                    pathboard[j,i+1,2] = pathboard[j,i,2]
                    pathboard[j,i+1,3] = pathboard[j,i,3] + pathboard[j,i,2]
                    #copy case
                    k = findfirst(==(0),pathboard[:,1,1]) #find first empty line for the new case
                    pathboard[k,1:i,:] .= pathboard[j,1:i,:] #copy previous board
                    pathboard[k,i+1,1] = 2
                    pathboard[k,i+1,2] = pathboard[j,i,3]
                    pathboard[k,i+1,3] = pathboard[j,i,3]
                elseif pathboard[j,i,1] == 2 && pathboard[j,i+1,1] == 0 #previous was a copy -> one following case
                    #type case
                    pathboard[j,i+1,1] = 1
                    pathboard[j,i+1,2] = pathboard[j,i,2]
                    pathboard[j,i+1,3] = pathboard[j,i,3] + pathboard[j,i,2]
                end                    
            end
            if mod(i-1,calcstep) == 0 #keep best paths
                ##get indices of the best paths
                #all cases with a final type
                type_index = findall(==(1),pathboard[:,i+1,1])
                #all cases with maximum final type -> first maximum final type with maximum finaly copy
                type_maxtype_index = type_index[findall(==(maximum(pathboard[type_index,i+1,3])),pathboard[type_index,i+1,3])]
                type_maxtype_maxcopy_index = type_maxtype_index[findfirst(==(maximum(pathboard[type_maxtype_index,i+1,2])),pathboard[type_maxtype_index,i+1,2])]
                #all cases with maximum final copy -> first maximum final copy with maximum finaly type
                type_maxcopy_index = type_index[findall(==(maximum(pathboard[type_index,i+1,2])),pathboard[type_index,i+1,2])]
                type_maxcopy_maxtype_index = type_maxcopy_index[findfirst(==(maximum(pathboard[type_maxcopy_index,i+1,3])),pathboard[type_maxcopy_index,i+1,3])]
                #all cases with a final copy -> max copy case
                copy_index = findall(==(2),pathboard[:,i+1,1])
                copy_max_index = copy_index[findfirst(==(maximum(pathboard[copy_index,i+1,3])),pathboard[copy_index,i+1,3])]

                #reformate the pathboard only with the best cases
                pathboard[1,1:i+1,:] .= pathboard[type_maxtype_maxcopy_index,1:i+1,:]
                pathboard[2,1:i+1,:] .= pathboard[type_maxcopy_maxtype_index,1:i+1,:]
                pathboard[3,1:i+1,:] .= pathboard[copy_max_index,1:i+1,:]
                pathboard[4:end,:,:] .= 0
            end
        end
    end
    return pathboard[1:findfirst(==(0),pathboard[:,1,1])-1,:,3]
end

doall(118,3)
disp = pathboard[1:findfirst(==(0),pathboard[:,1,1])-1,end,:]
pathboard[4,:,:]
maximum(disp)

open("fractal_test_slopedata.txt","w") do io
    writedlm(io, pathboard[4,:,3])
end