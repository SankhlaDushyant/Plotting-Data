#subset 10000 values
b<-read.csv("Service_Requests_2015_-_Present.csv",header = TRUE,na.strings ="NA",nrows = 10000)
names(b)
#useful columns for this analysis
b<-b[,c(4,6)]
c<-table(b$Agency,b$Complaint.Type)
c<-as.data.frame(c)
colnames(c)<-c("Agency","Complains","Number_Request")
#request more than 10 
c<-c[c$Number_Request>10,]
write.table(c, file = "test.csv", sep = ",", col.names = names(c))

png("test.png",width=1024,height=1024)
ggp <- ggplot(c,aes(Agency,Number_Request,fill=Complains))+
       geom_bar(stat = "identity")+
       theme_bw()+
       labs(title=expression("Number of Request from Different Agencies having Count>10"))+
       scale_fill_discrete(guide = "legend")+
       theme(legend.position="bottom")
print(ggp)
dev.off()



