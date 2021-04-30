function(input, output, session) {
  # Loader ----
  sever()
  Sys.sleep(0) #  something that takes time
  
  waiter_hide()
  
  f <- FirebaseUI$
    new()$ # instantiate
    set_providers( # define providers
      email = TRUE, 
      google = TRUE
    )$
    launch() # launch

  datafile <- callModule(File, "datafile",
                         stringsAsFactors = FALSE)
  
  df <- eventReactive(input$rfunc,{
    datafile()
  })
  
  observeEvent(input$refresh, {
    refresh()
  })
  
  observe({
    f$req_sign_in() # require sign in
    user <- f$get_signed_in() # get logged in user info
    print(user)
    noty(text = paste0("Welcome ",user$response$displayName," is logged in successfully"), type = "info")
  }) 
  
  
  observeEvent(input$signout, {
    f$sign_out()
  })
  output$pivot <- rpivotTable::renderRpivotTable({
    rpivotTable(data = df())
  })
  
  
  output$profileSummary <-renderUI({
    st_options()                      # display all global options values
    st_options('round.digits')        # display the value of a specific option
    st_options(style = 'rmarkdown')   # change one or several options' values
    st_options(footnote = NA)         # Turn off the footnote on all outputs.
    # This option was used prior to generating
    # the present document.
    out <- print(dfSummary(df(), 
                           style = "multiline",
                           display.labels=F,
                           headings=F,
                           ctable.totals=TRUE	,
                           graph.magnif = 0.8),
                 max.tbl.height = 500,
                 max.tbl.width = 300,
                 
                 method = 'render',
                 omit.headings = TRUE,
                 bootstrap.css = F)
    # out[[3]][[1]][[3]][[2]] <- NULL
    return(out)
  })
  
}