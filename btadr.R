#Hente inn data
btadr <- read.table('data/btadr.csv', sep=",", header=TRUE, stringsAsFactors=FALSE)
sider <- read.table('data/sidev.csv', sep=",", header=TRUE, stringsAsFactors=FALSE)
source('scrape.R')

print(sider)

# Hent inn nye data
new.data1 <- as.integer(paste0(2015,uke))
new.data2 <- adrnett
new.data3 <- adrmob
new.data4 <- btnett
new.data5 <- btmob
new.data8 <- sadrnett
new.data9 <- sadrmob
new.data10 <- sbtnett
new.data11 <- sbtmob

#Regn ut Adressa total og BT total
new.data6 <- new.data2 + new.data3
new.data7 <- new.data4 + new.data5
new.data12 <- new.data8 + new.data9
new.data13 <- new.data10 + new.data11

#Legg nye data til matrisen
new.data <- c(new.data1, new.data2, new.data3, new.data4, new.data5, new.data6, new.data7)
new.sdata <- c(new.data1, new.data8, new.data9, new.data10, new.data11, new.data12, new.data13)
btadr <- rbind(btadr, new.data)
sider <- rbind(sider, new.sdata)

uker <- t(btadr[,1])
btmobil <- t(btadr[,5])
adrmobil <- t(btadr[,3])
btnett <- t(btadr[,4])
adrnett <- t(btadr[,2])
bttot <- t(btadr[,7])
adrtot <- t(btadr[,6])
sbtmobil <- t(sider[,5])
sadrmobil <- t(sider[,3])
sbtnett <- t(sider[,4])
sadrnett <- t(sider[,2])
sbttot <- t(sider[,7])
sadrtot <- t(sider[,6])

#Funksjon for å lage tekststrenger av data
    get.txt <- function(x){
    txt <- character()
    for (i in 1:length(x)) {
            txt <- paste0(txt, x[i], ", ")
            }
            return(txt)
            }
    
#Klistre sammen javascript-fil som rommer alle data
    jsfil <- paste(
            'var btmobil = { name: ',"'",'BT Mobil', "',",' data: [',get.txt(btmobil),']};\n\n',
            'var adrmobil = { name: ',"'",'Adressa Mobil', "',",' data: [',get.txt(adrmobil),']};\n\n',
            'var btnett = { name: ',"'",'BT Desktop', "',",' data: [',get.txt(btnett),']};\n\n',
            'var adrnett = { name: ',"'",'Adressa Desktop', "',",' data: [',get.txt(adrnett),']};\n\n',
            'var bttot = { name: ',"'",'BT total', "',",' data: [',get.txt(bttot),']};\n\n',
            'var adrtot = { name: ',"'",'Adressa total', "',",' data: [',get.txt(adrtot),']};\n\n',
            'var sbtmobil = { name: ',"'",'BT Mobil', "',",' data: [',get.txt(sbtmobil),']};\n\n',
            'var sadrmobil = { name: ',"'",'Adressa Mobil', "',",' data: [',get.txt(sadrmobil),']};\n\n',
            'var sbtnett = { name: ',"'",'BT Desktop', "',",' data: [',get.txt(sbtnett),']};\n\n',
            'var sadrnett = { name: ',"'",'Adressa Desktop', "',",' data: [',get.txt(sadrnett),']};\n\n',
            'var sbttot = { name: ',"'",'BT total', "',",' data: [',get.txt(sbttot),']};\n\n',
            'var sadrtot = { name: ',"'",'Adressa total', "',",' data: [',get.txt(sadrtot),']};\n\n',
            'var uker = [',get.txt(uker),'];',
            sep="")

#Skriv ut dataene
write.table(btadr, 'data/btadr.csv', sep=",", col.names=TRUE, row.names=FALSE)
write.table(sider, 'data/sidev.csv', sep=",", col.names=TRUE, row.names=FALSE)
write.table(jsfil, 'data/data.js', row.names=FALSE, col.names=FALSE, quote=FALSE)

source('ratio.R')