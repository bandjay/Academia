library(rtimes)
Sys.setenv(NYTIMES_AS_KEY = "4e7c325c6f1d44849eff1dbe583e265c")
articles=as_search(q="immigration", begin_date = "20160101", end_date = '20160131',page = 0,fl="lead_paragraph,abstract,headline,source",facet_feild="section_name,document_type,type_of_material",hl=TRUE)

