#### Objective: Understand R Environments ####
#### a.k.a. totally unecessary but fascinating R plumbing ####

#' Create an environment
createdenvironment = new.env()
#' Print out environment
createdenvironment
#' <environment: 0x105e36358>

#' every environment (except R_EmptyEnv) has an enclosure.
#'  Find the enclosure of the created environment
parent.env(env = createdenvironment)
#' <environment: R_GlobalEnv>
#' Find the enclosure of the global environment
#' Option 1
parent.env(parent.env(createdenvironment))
#' Option 2
parent.env( .GlobalEnv )
#' <environment: 0x105e26518> | where the hash is the location of the environment in memory.
#'   attr(,"name")
#' [1] "tools:rstudio"
#' Option 3
parent.env(globalenv())
#' More parents | Environments are nested
parent.env(parent.env(parent.env(createdenvironment)))
#' <environment: package:stats>
#'   attr(,"name")
#' [1] "package:stats"
#' attr(,"path")
#' [1] "/Library/Frameworks/R.framework/Versions/3.3/Resources/library/stats"

# Access empty environments
emptyenv()
#' <environment: R_EmptyEnv>

#' Environments can have attributes
attr(createdenvironment , "name") = "some_name"
environmentName(createdenvironment)
#' [1] "some_name"

#' Created objects are automatically placed in the
#' "current" or "local" environment, accessible using environment()
some_object <- 12345
environment()
#' <environment: R_GlobalEnv>

#' Query an environment for all objects in the frame using ls().
ls(envir = environment())
#' [1] "createdenvironment" "some_object"

#' Use assign() function to create an object in the non-default environment
#' check contents of environment of interest
ls(envir = createdenvironment)
#' character(0)
assign(x = "some_logical_vector" , value = c( FALSE , TRUE ) , envir = createdenvironment)
ls(envir = createdenvironment)
#' [1] "some_logical_vector"

# Retrieve any named object from any given environment using the get() function
get(x = "some_logical_vector", envir = createdenvironment)
#' [1] FALSE  TRUE

#' How could I have known that the createdEnvironment's enclosure would be R_GlobalEnv
#' before I created the object? R uses the local environment as the default value.
newEnvironment = new.env()

#' Change an environment's enclosure using the replacement form of parent.env().
parent.env(env = newEnvironment) <- createdenvironment
parent.env(createdenvironment)

#' Functions inherit the environment in which they were created
#' You can also change the environment in which the function will run using the environment() function
#' Functions create their own environment to run the code within them. When the function completes
#' executing, the environment that it creates dies. This is called the "Scope" of the function.
#' However when a function is run within a function, it can come with its own environment specification.
#' So a function always runs in the default environment in which it is created or the environment that is
#' specified as an attribute of the function.
#'
#' Every package's function is created and run in the package's namespace environment by default.
#' For example, when R looks for the function ggplot(), if ggplot() is not stuffed into the package's
#' import environment, R will look in the packages environment, find ggplot in package:ggplot2 and
#' execute the ggplot function within namespace:ggplot2.
#' If a package has a function somefunction(), since all functions of package are run in the
#' namespace environment of the package, R will look for somefunction() in the namespace environment,
#' If the function is not found in the namespace environment of the package, R will look in the imports
#' environment, and then namespace environment of R base packages, followed by the R_Global environment
#' and finally the packages environment and finally the namespace of each of the packages loaded in the
#' running instance of R. It will run the function in the environment it finds the function. That is why it
#' is crucial to have your functions in the environment that has everything that your functions need
#' to run successfully and in the expected manner. (You can do this by including important dependencies
#' in the import environment)
#'
#' All this scoping can be skipped by using the :: operator. :: only fetches the EXPORTED functions from the package.
`::`
# function (pkg, name)
# {
#   pkg <- as.character(substitute(pkg))
#   name <- as.character(substitute(name))
#   getExportedValue(pkg, name)
# }
# <bytecode: 0x101c9b780>
#   <environment: namespace:base>
#' If the function is not exported, using ::: operator searches for the function in the namespace environment.
`:::`
# function (pkg, name)
# {
#   pkg <- as.character(substitute(pkg))
#   name <- as.character(substitute(name))
#   get(name, envir = asNamespace(pkg), inherits = FALSE)
# }
# <bytecode: 0x105b26470>
#   <environment: namespace:base>
#'
#'
#'
#'
test <-  function() {
  print(parent.env(environment()))
  }
test()

#
