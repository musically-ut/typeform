# API to typeform data sets
[![Build Status](https://travis-ci.org/csgillespie/typeform.svg?branch=master)](https://travis-ci.org/csgillespie/typeform)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/typeform)](http://cran.r-project.org/package=typeform)

[Typeform](typeform.com) is a company that specializes in online form building. 
This R package allows users to download their form results through the exposed API.

This R package is still under development.

## Installation

The package can be installed via devtools

```
devtools::install_github("csgillespie/typeform")
```

The package can the be loaded in the usual way

```
library("typeform")
```

## Using the package

To use this package, you will need a [data API](https://www.typeform.com/help/data-api/)
key. With this key in position, you can then list your available forms

```
api = "XXXXX"
typeforms = get_all_typeforms(api)
```

You can download data from a particular typeform via
```
## uid can be obtained from the typeforms data set 
## above
get_results(uid, api)
```

There are a number of options for downloading the data. For example

```
## Only completed forms
get_results(uid, api, completed=TRUE)
## Results since the 1st Jan
get_results(uid, api, since=as.Date("2016-01-01"))
```

See the `?get_results` help page for other options.

## Example: Multiple Filters / Order

Imagine we only want to fetch only the last 10 completed responses.

  * We only want completed results, so we add the parameter `completed=TRUE`.
  * The results need to be ordered by newest results first, so we add the parameter `order_by="date_submit_desc"`
  * We only want 10 results maximum, so we add the parameter `limit=10`
  
This gives the function call

```
get_results(uid, api, completed=TRUE, order_by="date_submit_desc", limit=10)
```
