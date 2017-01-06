#### Objective: Build a function template for easy function building ####
## Adapted from here: http://stackoverflow.com/questions/36513298/is-there-a-central-up-to-date-reference-for-roxygen2-tags
## Updated with tags from the roxygen2 manual: http://roxygen.org/roxygen2-manual.pdf
## Sadly tags are NOT provided in this CRAN manual: https://cran.r-project.org/web/packages/roxygen2/roxygen2.pdf

#-----------------------------------------------------------
my_function <- function (named_arguments) {
#-----------------------------------------------------------
#' @title put a title to the function here
#'
#' @description
#' \code{function_name} describe what the function does
#'
#' @usage
#'   describe how the function should be called
#'
#' @details
#'   provide important information of how the function
#'   operates
#'   @section Section title is only on line long:
#'   Put the paragraph of the details in this section.
#'   The section title must be followed by a ":" (colon).
#'   @section Warning:
#'   When calling this function make sure that ...
#'
#' @param param_name (type of the parameter)
#'   Describe what the parameter does,
#'   start with capital letter and end with fullstop,
#'   all parameters must be documented.
#'
#' @return describes the output of a function
#'
#' @examples
#'   provide executable R code showing how to use the
#'   function in practice
#'
#' @include filename.R to be loaded before this function
#'
#' @family  add appropriate lists/interlinks to seealso
#' @seealso point to other useful resources
#' @aliases add additional aliases through which the user
#'   can find the documentation with "?"
#' @concept add extra keywords that will be found with
#'   help.search()
#' @keywords keyword1 keyword2 ...
#'   to add standardised optional keywords which must be
#'   taken from the predefined list replicated in the
#'   keywords vignette
#'
#' @author Open Pencil
#'
#' @source give credits to those you provided code
#'
#' There are four tags for exporting objects from the package:
#' @export Roxygen guesses the directive: export for functions, exportMethod for S4 methods,
#' S3method for S3 methods, exportClass for S4 classes. This is the only directive you should
#' need for documented function, the other directives are useful if you want to export (e.g.)
#' methods but not document them.
#' @export f g ... overrides auto-detection and produces multiple export directives: export(f), export(g) ...
#' @exportClass x produces exportClasses(x) directive.
#' @exportMethod x produces exportMethods(x) directive.
#' @S3method generic class produces S3method(generic,class) directive

#' There are four tags for importing objects into the package:
#' @import package produces import(package) directive to import all functions from the given package
#' @importFrom package functiona functionb ... produces multiple importFrom(package, function) directives
#' to import selected functions from a package.
#' @importClassesFrom package classa classb ... produces multiple importClassesFrom(package, class)
#' directives to import selected classes from a package.
#' @importMethodsFrom package methoda methodb ... produces multiple importMethodsFrom(package, method)
#' directives to import selected methods from a package. Only unique directives are saved to the ‘NAMESPACE’ file,
#' so you can repeat them as needed to maintain a close link between the functions where they are needed and the
#' namespace file..
#'
#' @param name description Document a parameter. Documentation is required for every parameter.
#' @inheritParams source_function Alternatively, you can inherit parameter description from another function.
#' This tag will bring in all documentation for parameters that are undocumented in the current function, but
#' documented in the source function. The source can be a function in the current package, function, or another
#' package package::function.
#' @method generic class Required if your function is an S3 method. This helps R to distinguish between (e.g.) t.test
#' and the t method for the test class.
#'
#' @examples R code... Highly recommended: example code that demonstrates how to use
#' your function. Use \dontrun to tag code that should not automatically be run.
#' @example path/relative/to/packge/root Instead of including examples directly in
#' the documentation, you can include them as separate files, and use the @example tag to
#' insert them into the documentation.
#' @return Used to document the object returned by the function. For lists, use the \item{name a}{description a}
#' describe each component of the list
#' @author authors... A free text string describing the authors of the function. This is typically only necessary
#' if the author is not the same as the package author.
#' @note contents Create a note section containing additional information.
#' @section Name: contents Use to add to an arbitrary section to the documentation. The name of the section will be
#' the content before the first colon, and the contents will be everything after the colon.
#' @keywords keyword1 keyword2 ... Keywords are optional, but if present, must be taken from the list in
#' ‘file.path(R.home(), "doc/KEYWORDS")’. Use the internal keyword for functions that should not appear in the
#' main function listing
#'
#' Optional tags for cross-referencing
#' @aliases space separated aliases Add additional aliases, through which the user can
#' find the documentation with ?. The topic name is always included in the list of aliases.
#' @concepts space separated concepts Similar to @aliases but for help.search
#' @references free text reference Pointers to the literature related to this object.
#' @seealso Text with \code{\link{function}} Pointers to related R objects, and why you might be interested in them.
#' @family family name Automatically adds see-also cross-references between all functions in a family. A function can
#' belong to multiple families.
#'
#' Template tags: Templates make it possible to substantially reduce documentation duplication. A template is an ‘R’
#' file processed with brew and then inserted into the roxygen block. Templates can use variables, accessible from
#' within brew with <=% varname =>. Templates are not parsed recursively, so you can not include templates from
#' within other templates. Templates must be composed of complete tags - becuase all roxygen tags are current block
#' tags, they can not be used for inline insertions.
#' @template templateName Insert named template in current location.
#' @templateVar varname value Set up variables for template use.
#'
#' Optional tags that override defaults: These tags all override the default values that roxygen guess from inspecting
#' the source code.
#' @rdname filename Overrides the output file name (without extension). This is useful if your function has a name
#' that is not a valid filename (e.g. [[<-), or you want to merge documentation for multiple function into a single
#' file.
#' @title Topic title Specify the topic title, which by by default is taken from the first sentence of the roxygen
#' block.
#' @usage usage_string Override the default usage string. You should not need to use this tag if you are trying to
#' document multiple functions in the same topic, use @rdname.
#'
#' Tags for non-functions: These tags are useful when documenting things that aren’t functions, datasets and packages.
#' @name topicname Override the default topic name, which is taken by default from the object that is assigned to in
#' the code immediately following the roxygen block. This tag is useful when documenting datasets, and other
#' non-function elements.
#' @docType type Type of object being documented. Useful values are data and package.
#' @format description A textual description of the format of the object.
#' @source text The original source of the data.
#-----------------------------------------------------------
(argument_1 = "some_value",
 argument_2 = "another_value")
#-----------------------------------------------------------
{
  function_name <- "function_name_here"
  cat(paste(function_name, "...\n"))  # indicate start
  #---------------------------------------------------------

  # Function body

  #---------------------------------------------------------
  cat(paste("...", function_name, "\n"))  # indicate end
}
#-----------------------------------------------------------
