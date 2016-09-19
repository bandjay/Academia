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
     x<- sample(1:52, 10, replace=F)
     Date_mat[j,k]=format(Date+(x[k]*7), format="%Y/%m/%d")
    }
    Date=Date+1
  }
  Date=Date+(365*i)
}

articles=as_search(q="immigration", begin_date =gsub("-","",Date) , end_date = "20160131",page = 0,fl="lead_paragraph,abstract,headline,source",facet_feild="section_name,document_type,type_of_material",hl=TRUE)

