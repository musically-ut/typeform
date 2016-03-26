#' Fetch all available typeforms
#'
#' This functions returns a data frame containing your typeforms and their
#' associated UIDs.
#' @importFrom jsonlite fromJSON
#' @param api Your private api key.
#' @return A two column data frame
#' @export
#' @examples
#' \dontrun{
#' api = "XXXXX"
#' get_all_typeforms(api)
#' }
get_all_typeforms = function(api) {
  url = paste0("https://api.typeform.com/v1/forms?key=", api)
  jsonlite::fromJSON(url)
}


