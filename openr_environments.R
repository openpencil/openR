#### Objective: Understand R Environments ####


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

# Here's another way to understand the "current" or "local" environment
# We create a function that calls environment() to query for the local environment.
# When R executes a function it automatically creates a new environment for that function.
# This is useful - variables/objects created inside the function will live in the new local environment.
# We call Test() to verify this.  We can see that Test() does NOT print R_GlobalEnv.
# We didn't created any objects within Test().  If we had, they would live in the "0x0000000006ce9b58"
# environment while Test() is running.  When the function completes executing, the environment dies.
test <-  function() {
  print(parent.env(environment()))
  }
test()
