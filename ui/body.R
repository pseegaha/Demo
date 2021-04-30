fluidPage(
  shiny.info::busy( position = "bottom right"),
  useShinydashboardPlus(),
  # useShinydashboard(),
  useFirebase(), # import firebase dependencies
  useFirebaseUI(),
  useShinyjs(),
  use_hover(),
  use_sever(),
  use_waiter(), 
  use_steward(),
  use_noty(),
  use_push(),
  use_notiflix_notify(),
  waiter_show_on_load(spin_hexdots()),
  # 1.1.0 JUMBOTRON COMPONENT ----
div(
    class = "container-fluid",
    style = "padding:0;",
    id = "jumbotron",
    
    div( # component
      class = "jumbotron",
      style = "background-image:url('hex-pmake.png');  
               background-repeat: no-repeat;
               background-size: 20% 100%;
               background-position: right center;margin-bottom:0;",
      div(
        class = "jumbotron-ui-box text-default bg-primary bg-default",
        style = "color:white; background-color:rgba(0,0,0,0.5); padding:15px;",
        h1("Simple EDA",align = 'center',style = "color: white;"),
      )
    )
  ),
 
  navbarPage(   
 title=div(img(src="hex-pmake.png", width = 30,height=30), ""),     
    id = "tabs",
    tabPanel("Data Structure", icon = icon("fas fa-table"),            
             
             ################main body##############
             sidebarLayout(
               sidebarPanel(
                 FileInput("datafile", "File Upload Station (.tsv format)"),
                 hr(),
                 hover_action_button(
                   inputId = ("refresh"),
                   style = "background-color:#8EDAED;
                      color:#75493E;
                      border-color:#BEBEBE;
                      border-style:double;
                      border-width:1px;
                      border-radius:100%;
                      font-size:18px;",
                   icon = icon('refresh'),
                   width = '100%',
                   label = "Refresh App",
                   #rotate,push,fade,shrink,float,bob,sink,bounce,radial-in,radial-out,curl-top-left,
                   #grow-shadow,shutter-in-vertical
                   button_animation = "fade", 
                   #spin,pulse,grow
                   icon_animation = "rotate"
                 )
               ),
               mainPanel(
                 
                 reqSignin(  hover_action_button(
                   inputId = ("rfunc"),
                   #class = "btn-success",
                   style = "background-color:#3069D1;
                      color:#E3DCDC;
                      border-color:#BEBEBE;
                      border-style:solid;
                      border-width:1px;
                      border-radius:26%;
                      font-size:42px;",
                   icon = icon('paper-plane'),
                   width = '100%',
                   label = "Run",
                   #rotate,push,fade,shrink,float,bob,sink,bounce,radial-in,radial-out,curl-top-left,
                   #grow-shadow,shutter-in-vertical
                   button_animation = "grow-shadow", 
                   #spin,pulse,grow
                   icon_animation = "rotate"
                 )),
                 hr(),
                 uiOutput("profileSummary")%>% withSpinner(),
                 reqSignin(actionButton("signout", "Sign out",icon = icon("fas fa-sign-out-alt")))
               )
             )
    ),
    tabPanel("Data", icon = icon("fas fa-chart-line"),reqSignin(rpivotTableOutput("pivot")%>% withSpinner()))
  
  )
)