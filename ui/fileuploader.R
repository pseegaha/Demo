############################necessary libraries , javscript, html, css elements############################
library(esquisse)
library(rpivotTable)
library(ggplot2)
library(readr)
library(base)
library(shiny)
library(shinyLP)
library(DT)
library(shiny.info)
library(shinycssloaders)
library(utils)
library(hover)
library(shinyjs)
library(waiter) # For Loading Screens
library(sever) # For Waiting Screen
library(utils)
library(seasonalview)
library(summarytools)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(shinythemes)
library(plotly)
library(firebase)
library(shinypop)

checkjs1 <- 'function checkFileName1(fieldObj) {
    var FileName  = fieldObj.value;
    var FileBase = FileName.split(/[\\\\/]/).pop();
    if (! FileBase.startsWith("Random")) {
        fieldObj.value = "";
        alert("File does not start with Random");
        return false;
    }
    return true;
}'

attrib_replace <- function(x, cond, ...) {
  if (all(names(cond) %in% names(x)) && identical(cond, x[names(cond)])) x <- c(x, list(...))
  if ("attribs" %in% names(x)) x$attribs <- attrib_replace(x$attribs, cond = cond, ...)
  if ("children" %in% names(x)) x$children <- lapply(x$children, function(ch) attrib_replace(ch, cond = cond, ...))
  x
}
# Module UI function
FileInput <- function(id, label = "TSV file") {
  # Create a namespace function using the provided id
  
  ns <- NS(id)
  
  tagList(
    tags$script(checkjs1),
    attrib_replace(fileInput(ns("file"), label), list(id = ns("file"), type = "file"), onchange = "checkFileName1(this);")
    
    #fileInput(ns("file"), label)
  )
}

# Module server function
File <- function(input, output, session, stringsAsFactors) {
  
  # The selected file, if any
  userFile <- reactive({
    # If no file is selected, don't do anything
    validate(need(input$file, message = FALSE))
    input$file
  })
  
  # The user's data, parsed into a data frame
  dataframe <- reactive({
    read.table(userFile()$datapath, header = T)
  })
  
  # Return the reactive that yields the data frame
  return(dataframe)
}