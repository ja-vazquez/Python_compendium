######################################################################
######## Calling Compiled Code (C/C++/Fortran)
######################################################################

## R example for comparison
x <- 1:100
sum(x^2)
# [1] 338350



## Compiling and loading a library (C/Fortran)
system("R CMD SHLIB f_ex.f90 -o fex_lib.so") # Compile Fortran example
dyn.load("fex_lib.so")                       # Load shared library
sumsq_f <- function(x){                      # Wrap into function
  f <- .Fortran("sum_xsq",
                x = as.integer(x),
                n = as.integer(length(x)),
                s = as.integer(0)
                )
  return(f$s)
}

sumsq_f(x)
# [1] 338350


## Inlining compiled code (C/Fortran) using 'inline'
library(inline)
f_c <- cfunction(signature(x="integer", n="integer", s="integer"),
                 ## Example C function
                 "
                  int i;
                  for (i = 0; i < *n; i++)
                    *s = *s + x[i]*x[i];
                 ",
                 language = "C", convention = ".C")
sumsq_c <- function(x){
  f_c(x, length(x), 0)$s
}

sumsq_c(x)
# [1] 338350


## Inlining C++ code using 'Rcpp'
library(Rcpp)
cppFunction("
    int sumsq_cpp(IntegerVector x) {
      int n = x.size();
      int s = 0;
      for(int i = 0; i < n; i++)
        s += x[i]*x[i];
      return s;
    }
   ")

sumsq_cpp(x)
# [1] 338350


## Can also call R functions from C++
## Example from: http://gallery.rcpp.org/articles/r-function-from-c++/
set.seed(1234)
x <- rnorm(1e4, 3, 1.5)

sourceCpp("cpp_ex.cpp")                 # Example C++ code

sd(x)
callFunction(x, sd)

summary(x)
callFunction(x, summary)


######################################################################
######## Calling Python Code
######################################################################
install.packages("rPython")
library(rPython)

## from: example(python.call)

python.call( "len", 1:3 )

a <- 1:4
b <- 5:8
python.exec( "def concat(a,b): return a+b" )
python.call( "concat", a, b)

python.assign( "a", "hola hola" )
python.method.call( "a", "split", " " )

#to load a python file
#python.load(file)

