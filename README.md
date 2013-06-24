# K Nearest Neighbour (in Typed Racket)

I just wrote an implementation of the K Nearest Neighbour algorithm in C++11. As I did previously with the Regression machine, I'm going to quickly re-write it in Racket to see how it compares (and also to keep my Racket-fu fresh).

### Post completion update:

This was not quick, but 90% of the time was implementing an nth element algorithm (rather than unnecessarily sorting all the data).

Some other thoughts:
+ Creating and using an Opt type to represent data read from the CSV was unnecessary and just added cruft. 
+ The resulting code in the Typed Racket version is naturally more widely applicable than the C++11 version.
