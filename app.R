
#step 1 follow the below link with instructions
#https://firebase.john-coene.com/articles/get-started.html
#step 2 follow the following shiny syntax
#https://firebase.john-coene.com/articles/ui.html
#place the #firebase::create_config(api_key = "AIzaSyApAxpakup_4vXa377RI-og5s9YKIFZelw", project_id = "fireblaze-r-1daba")
# above the ui fluidpage globally like the libraries to call in.
#once the firebase.rds is created...uncomment the above config command
#firebase::create_config(api_key = "AIzaSyDGdrifMEj3-rSMt7uyHCjUvEiu6_JkEY0", project_id = "modulardemo-125ac")

#sourcing the fileupload module
source("ui/fileuploader.R")

####################################################################################################################
#Sourced frontend code
ui <-(body = source('ui/body.R', local = TRUE)$value)

#Sourced backend code
server <-(body = source('ui/backend.R', local = TRUE)$value) 

#calling the whole app
shinyApp(ui, server)