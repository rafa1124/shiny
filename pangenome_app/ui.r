library(shiny)
source("chooser.r")

presence_table<-read.csv("data/374_clusters.csv",header=T,stringsAsFactors = FALSE)
presence_table[presence_table==" "]<-NA
product<-presence_table$Product
presence_table$Product<-NULL
presence_table<-presence_table[ , order(names(presence_table))]
presence_table<-cbind(product,presence_table)
xv<-ncol(presence_table)
allstrains<-names(presence_table)[2:xv]

# Define UI 
shinyUI(fluidPage(

	titlePanel("Streptococcus pneumoniae pan-genome project"),
	
	fluidRow(
	sidebarPanel(
		tags$small(paste0("Select the strains you want to examine from the left. ",
		"The selected strains will appear on the right-hand box. ")),
		uiOutput("make_selector"),
		fileInput('strainslist',"Upload strain selection"),
		downloadButton('current_selection',"Download selected strains list"),
		verbatimTextOutput("coreandpan")
	), #/sidebarPanel
	
	mainPanel(plotOutput("distance_phylogeny"),
	          downloadButton('dendrogram_dl',"Download dendrogram")
	          )#/mainpanel
	), #/fluidRow
	tabsetPanel(
	  tabPanel("Full Gene Table",
	 
		tags$h2("Gene table for the selected strains"),
		downloadButton('subtable_dl',"Download gene table"),
		dataTableOutput("selection")), #tabpanel1

	  tabPanel("Core Gene Table",
	           tags$h2("Gene table for the core genome of the selected strains"),
	           downloadButton('subtableCore_dl',"Download gene table"),
	           dataTableOutput("selectionCore")), #tabpanel2

	  tabPanel("Accessory Gene Table",
	           tags$h2("Gene table for the accessory genome of the selected strains"),
	           downloadButton('subtableAcc_dl',"Download gene table"),
	           dataTableOutput("selectionAcc")), #/tabpanel3
		
		tabPanel("Unique Genes",
		         #downloadButton('subtableAcc_dl',"Download gene table"),
		         uiOutput("unique_selector"),
		         downloadButton('subtableUniqu_dl',"Download gene table"),
		         dataTableOutput("unique_for_strain")) #/tabpanel4
	) #/tabsetpanel
))  #/fluidPage /shinyUI