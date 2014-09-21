## Trying to mimic OOP approach with language without objects.
## We store a list of functions declared in single scope
## of another function and thus having access to its 
## internal ("private") variables.
##
## In this variables we store a matrix and its inverse matrix.
## We control access to both variables, so we can track 
## their changes and we calculate inverse matrix on demand and only once
## (if matrix variable wasn't changed since our last calculation)
## 


## Constructor of "matrix-with-inverse object"
## Returns a list of access functions, "set"
## and "get" give access to matrix variable
## "set_inverse" and "get_inverse" give access 
## to inverse matrix variable

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    
    set <- function(m) {
        x <<- m
        inv <<- NULL
    }
    get <- function(){
        x  
    } 
    set_inverse <- function(value){
        inv <<- value  
    } 
    get_inverse <- function() {
        inv
    }
    list(set = set, get = get,
         set_inverse = set_inverse,
         get_inverse = get_inverse)
    
}


## Calculates inverse matrix on demand.
## In fact this code should be inside of "get_inverse" function, 
## but Assignment declared it outside, so I made it this way 

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inv<-x$get_inverse()
    if (is.null(inv)){
        data_matrix <- x$get()
        inv <- solve(data_matrix)
        x$set_inverse(inv)
    }    
    
    inv
}
