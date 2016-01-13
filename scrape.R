library(RCurl)
library(RJSONIO)

#Sett uke
#uke <- as.integer(readline("Uke : "))

#Skrap data
urlnett <- paste0('http://tnslistene.no/?metric=uv&list_id=1&year=2016&week=',uke)
urlmob <- paste0('http://tnslistene.no/?metric=uv&list_id=6&year=2016&week=',uke)
tnsnett <- getURL(urlnett)
tnsmob <- getURL(urlmob)

#Se etter disse linjene i dataene
btnettref <- '<a href="http://www.bt.no">Bergens Tidende</a>'
adrnettref <- '<a href="http://www.adressa.no">Adressa.no</a>'
btmobref <- '<a href="http://mobil.bt.no/bt.mob">Bt Mobil</a>'
adrmobref <- '<a href="">Adressa Mobil</a>'

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

tnsnett <- rensk.data(tnsnett)
tnsmob <- rensk.data(tnsmob)

btnett <- subset(tnsnett, tnsnett[,2] %in% btnettref)
btnett <- as.integer(unlist(btnett[3]))
adrnett <- subset(tnsnett, tnsnett[,2] %in% adrnettref)
adrnett <- as.integer(unlist(adrnett[3]))

btmob <- subset(tnsmob, tnsmob[,2] %in% btmobref)
btmob <- as.integer(unlist(btmob[3]))
adrmob <- subset(tnsmob, tnsmob[,2] %in% adrmobref)
adrmob <- as.integer(unlist(adrmob[3]))

sbtnett <- subset(tnsnett, tnsnett[,2] %in% btnettref)
sbtnett <- as.integer(unlist(sbtnett[5]))
sadrnett <- subset(tnsnett, tnsnett[,2] %in% adrnettref)
sadrnett <- as.integer(unlist(sadrnett[5]))

sbtmob <- subset(tnsmob, tnsmob[,2] %in% btmobref)
sbtmob <- as.integer(unlist(sbtmob[5]))
sadrmob <- subset(tnsmob, tnsmob[,2] %in% adrmobref)
sadrmob <- as.integer(unlist(sadrmob[5]))
