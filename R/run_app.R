#' Launch the Shiny App
#'
#' @export
run_app <- function() {
  # 1. Locate the app folder
  app_dir <- system.file("shiny", "myapp", package = "binompoiscont")

  # 2. Safety check: Handle devtools::load_all() vs installed package
  if (app_dir == "") {
    # If system.file fails (sometimes happens during dev), try local path
    app_dir <- "./inst/shiny/myapp"
  }

  if (!file.exists(app_dir)) {
    stop("Could not find app directory. Try re-installing `binompoiscont`.", call. = FALSE)
  }

  # 3. Run the app using explicit namespacing
  shiny::runApp(app_dir, display.mode = "normal")
}
