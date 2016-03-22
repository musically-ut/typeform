#' Fetch all available typeforms
#'
#' Returns a data frame containing your typeforms and their UIDs.
#' @importFrom jsonlite fromJSON
#' @param api Your private api key.
#' @export
get_all_typeforms = function(api) {

  url = paste0("https://api.typeform.com/v1/forms?key=", api)
  jsonlite::fromJSON(url)
}


