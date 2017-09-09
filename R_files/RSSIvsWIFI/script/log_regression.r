######## IPAD ####### 
#generating the data

x = ipad_pos$rssi
y = ipad_pos$rx
#plot the data
plot(y~x)
    
#fit log model
fit <- lm(y~log(x))
#Results of the model
summary(fit)
    

lm(formula = y ~ log(x))

#plot 
x=seq(from=1,to=n,length.out=1000)
y=predict(fit,newdata=list(x=seq(from=1,to=n,length.out=1000)), interval="confidence")
matlines(x,y,lwd=2)
      
######## lg ####### 
#generating the data

ggplot(data = lg_pos,aes(x = rssi,y = rx)) + stat_sum() + ggtitle("LG precisione decimo secondi")

x = lg_pos$rssi
y = lg_pos$rx
#plot the data
plot(y~x)

#fit log model
fit <- lm(y~log(x))
#Results of the model
summary(fit)


lm(formula = y ~ log(x))

#plot 
x=seq(from=1,to=n,length.out=1000)
y=predict(fit,newdata=list(x=seq(from=1,to=n,length.out=1000)), interval="confidence")
matlines(x,y,lwd=2)



      