x <- read.csv(file=file.choose(), header=TRUE)
x1<-x[,1]
y1<-x[,2]
x1<-x1[!is.na(x1)]
y1<-y1[!is.na(y1)]
n1<-length(x1)
n2<-length(y1)
CSK<-as.character(x[1,3])
DI<-as.character(x[2,3])
x1y1<-c(x1,y1)

anyOutliers <- function(x) { #check quantile function
  q <- quantile(x)
  range <- IQR(x)
  min <- q[2] - (range * 1.5)
  max <- q[4] + (range * 1.5)
  
  for (i in 1:length(x)) {
    if(x[i] < min || x[i] > max) {
      return(TRUE)
    }
  }
  return(FALSE)
}

isDependent<-function(){DI=='D'}

isNormal<-function(vec){
  pVal<-shapiro.test(vec)$p.value
  return(pVal > 0.05)
}

isEqualVar<-function(){
  sdX <- sd(x1)
  sdY <- sd(y1)
  if (sdX > sdY){
    return ((sdX/sdY) < 2)
  }
  else{
    return ((sdY/sdX) < 2)
  }
}

