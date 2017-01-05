#### Commonly used text-processing functions ####


#### Convert to sentence case ####
tosentencecase <- function(inputstring){
  #'
  #' @param inputstring a string to be converted to sentence-case
  #'
  substr(inputstring, start = 1, 1) <- toupper(substr(inputstring, start = 1, 1))
  substr(inputstring, start = 2, nchar(inputstring)) <- tolower(substr(inputstring, start = 2, nchar(inputstring)))
  return(inputstring)
}
