#Hente inn data
btadr <- read.table('data/btadr.csv', sep=",", header=TRUE, stringsAsFactors=FALSE)
source('scrape.R')

#Fikse på dataene
#names(btba) <- c('uke', 'btmob', 'bamob', 'prosmob', 'btmob1år', 'bamob1år', 'btnett', 'banett', 'prosnett', 'btnett1år', 'banett1år', 'bttotal', 'batotal', 'btmobvsba')


# Gjør tall om fra character til numeric
#fiks.kol <- c(2,3,4,5,6,7,8,9,10,11,12,13)
#for (i in fiks.kol[1]:fiks.kol[12]) {
#        btba[,i] <- as.numeric(btba[,i])
#        }

print(btadr)

# Hent inn nye data
new.data <- as.integer(readline("Uke: "))
new.data <- as.integer(paste0(2015,uke))
new.data2 <- adrnett
new.data3 <- adrmob
new.data4 <- btnett
new.data5 <- btmob

#Regn ut Adressa total og BT total
new.data6 <- new.data2 + new.data3
new.data7 <- new.data4 + new.data5

#Legg nye data til matrisen
new.data <- c(new.data, new.data2, new.data3, new.data4, new.data5, new.data6, new.data7)
btadr <- rbind(btadr, new.data)

uker <- t(btadr[,1])
btmobil <- t(btadr[,5])
adrmobil <- t(btadr[,3])
btnett <- t(btadr[,4])
adrnett <- t(btadr[,2])
bttot <- t(btadr[,7])
adrtot <- t(btadr[,6])

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
            'var uker = [',get.txt(uker),'];',
            sep="")

#Skriv ut dataene
write.table(btadr, 'data/btadr.csv', sep=",", col.names=TRUE, row.names=FALSE)
write.table(jsfil, 'data/data.js', row.names=FALSE, col.names=FALSE, quote=FALSE)
print(btadr)