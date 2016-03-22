get_linux_time = function(x) {
  if(class(x) == "Date") x = as.POSIXct(x)
  if(any(class(x) %in% c("POSIXct","POSIXt"))) x = as.numeric(x)
  x
}

get_order_by = function(order_by) {
  if(is.null(order_by)) return("")

  order_bys = c("completed", "date_land_desc", "date_land_incr",
                "date_submit_desc", "date_submit_incr")
  if(!(order_by %in% order_bys))
    stop("order_by should be one of:\n", paste(order_bys, collapse = "\n"))

  end = switch(order_by,
               completed="completed",
               date_land_desc = "[date_land,desc]",
               date_land_incr = "date_land",
               date_submit_desc = "[date_submit,desc]",
               date_submit_incr = "date_submit")

  paste0("&order_by=", end)
}

#' Download results
#'
#' Download results for a particular typeform.
#' @inheritParams get_all_typeforms
#' @param uid The UID (unique identifier) of the typeform you want the results for.
#' @param completed, default \code{NULL}, return all results.
#' Fetch only completed results (\code{TRUE}), or only not-completed results
#' (=\code{FALSE}).
#' @param since, default \code{NULL}
#' @param until, default \code{NULL}
#' @param offset Fetch all results except the first \code{offset}.
#' i.e. Start listing results from result #\code{offset} onwards.
#' @param limit, default \code{NULL}
#' @param order_by One of "completed", "date_land_desc", "date_land_incr",
#' "date_submit_desc", "date_submit_incr"
#' @param simplify, Logical. By default, \code{TRUE}, and returns only the questionnaire
#' responses as a data frame.
#' @export
get_results = function(uid, api,
                       completed=NULL, since=NULL, until=NULL, offset=NULL, limit=NULL,
                       order_by = NULL,
                       simplify=TRUE) {
  url = paste0("https://api.typeform.com/v1/form/", uid, "?key=", api)
  if(!is.null(completed)) {
    if(isTRUE(completed)) url = paste0(url, "&completed=true")
    else url = paste0(url, "&completed=false")
  }

  if(!is.null(since)) url = paste0(url, "&since=", get_linux_time(since))
  if(!is.null(until)) url = paste0(url, "&until=", get_linux_time(until))
  if(!is.null(offset)) url = paste0(url, "&offset=", offset)
  if(!is.null(limit)) url = paste0(url, "&limit=", limit)

  url = paste0(url , get_order_by(order_by))
  return(url)
  results = jsonlite::fromJSON(url)
  if(simplify)
    return(results$response)
  else
    return(results)
}
