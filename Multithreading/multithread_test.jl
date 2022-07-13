#get number of active threads
Threads.nthreads()

#work
a = zeros(7)
#write thread ID to a
Threads.@threads for i = 1:length(a)
    a[i] = Threads.threadid()
end

a

#avoid race conditions (where different threads want to access the same variable and therefore the result is not the right one.)