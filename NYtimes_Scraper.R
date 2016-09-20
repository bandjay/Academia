library(rtimes)
Sys.setenv(NYTIMES_AS_KEY = "4e7c325c6f1d44849eff1dbe583e265c")

Date="2016/01/01"
Date <- as.Date(Date, '%Y/%m/%d')
#gsub("-","",Date)
Date_mat=matrix(NA,10,nrow=7)
for (i in 1:2)
{
  for (j in 1:7)
  {
    
    for (k in 1:10)
    {
     x<- sample(1:52, 20, replace=F)
     Date_mat[j,k]=format(Date+(x[k]*7), format="%Y/%m/%d")
    }
    Date=Date+1
  }
  Date=Date+(365*i)
}

articles=as_search(q="immigration", begin_date ="20160101" , end_date = "20160131",page = 1,
                   fl="web_url,snippet,lead_paragraph,abstract,headline,source,document_type,word_count",
                   facet_field="section_name,type_of_material",hl=TRUE)
begin_date ="20160101"
date=c(rep(NA,10))
web_url=c(rep(NA,10))
snippet=rep(NA,10)
lead_paragraph=rep(NA,10)
abstract=c(rep(NA,10))
headline=rep(NA,10)
document_type=rep(NA,10)
word_count=rep(NA,10)
section_name=rep(NA,10)
type_of_material=rep(NA,10)
for (i in 1:10)
{
  date[i]=begin_date
  web_url[i]=ifelse(is.null(articles$data$docs[[i]]$web_url),"NA",articles$data$docs[[i]]$web_url)
  snippet[i]=ifelse(is.null(articles$data$docs[[i]]$snippet),"NA",articles$data$docs[[i]]$snippet)
  lead_paragraph[i]=ifelse(is.null(articles$data$docs[[i]]$lead_paragraph),"NA",articles$data$docs[[i]]$lead_paragraph)
  abstract[i]=ifelse(is.null(articles$data$docs[[i]]$abstract),"NA",articles$data$docs[[i]]$abstract)
  headline[i]=ifelse(is.null(articles$data$docs[[i]]$headline$main),"NA",articles$data$docs[[i]]$headline$main)
  document_type[i]=ifelse(is.null(articles$data$docs[[i]]$document_type),"NA",articles$data$docs[[i]]$document_type)
  word_count[i]=ifelse(is.null(articles$data$docs[[i]]$word_count),"NA",articles$data$docs[[i]]$word_count)
  #section_name[i]=ifelse(is.null(articles$data$facets$section_name$terms[[i]]$term),"NA",articles$data$facets$section_name$terms[[i]]$term)
  #type_of_material[i]=ifelse(is.null(articles$data$facets$type_of_material$terms[[i]]$term),"NA",articles$data$facets$type_of_material$terms[[i]]$term)
}












