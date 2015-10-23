library(RCurl)
library(RJSONIO)

#Sett uke og medium
uke <- c(1:42)
adrnettref <- '<a href="http://www.bt.no">Bergens Tidende</a>'
adrmobref <- '<a href="http://mobil.bt.no/bt.mob">Bt Mobil</a>'
adr <- data.frame()

#Funksjon for å renske data
rensk.data <- function(x) {
  tns <- unlist(strsplit(x, split='var all = ', fixed=TRUE))[2]
  tns <- unlist(strsplit(tns, split='\nfunction check_fix_value(a_val)', fixed=TRUE))[1]
  json <- fromJSON(tns)
  tns <- do.call("rbind", json$data)
  tns <- as.data.frame(tns)
  tns$Graf <- NULL
  return(tns)
}

for (i in uke) {
        urlnett <- paste0('http://tnslistene.no/?metric=uv&list_id=1&year=2015&week=',i)
        urlmob <- paste0('http://tnslistene.no/?metric=uv&list_id=6&year=2015&week=',i)
        tnsnett <- getURL(urlnett)
        tnsmob <- getURL(urlmob)
        tnsnett <- rensk.data(tnsnett)
        tnsmob <- rensk.data(tnsmob)
        adrnett <- subset(tnsnett, tnsnett[,2] %in% adrnettref)
        adrnett <- as.integer(unlist(adrnett[5]))
        adrmob <- subset(tnsmob, tnsmob[,2] %in% adrmobref)
        adrmob <- as.integer(unlist(adrmob[5]))
        adruke <- c(adrnett, adrmob)
        adr <- rbind(adr, adruke)
        }


