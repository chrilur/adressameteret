## Beregne forholdet mellom unike brukere og sidevisninger i 
## Adressa og BT
ratio.adrtot <- round(sider$adrtotal / btadr$adrtotal, digits=2)
ratio.bttot <- round(sider$bttotal / btadr$bttotal, digits=2)
ratio.adrnett <- round(sider$A.sidev.nett / btadr$Adressa.nett, digits=2)
ratio.btnett <- round(sider$BT.sidev.nett / btadr$BT.nett, digits=2)
ratio.adrmob <- round(sider$A.sidev.mob / btadr$Adressa.mobil, digits=2)
ratio.btmob <- round(sider$BT.sidev.mob / btadr$BT.mobil, digits=2)

#Klistre sammen javascript-fil som rommer alle data
ratiofil <- paste(
  'var ratiobtmob = { name: ',"'",'BT Mobil', "',",' data: [',get.txt(ratio.btmob),']};\n\n',
  'var ratioadrmob = { name: ',"'",'Adressa Mobil', "',",' data: [',get.txt(ratio.adrmob),']};\n\n',
  'var ratiobtnett = { name: ',"'",'BT Desktop', "',",' data: [',get.txt(ratio.btnett),']};\n\n',
  'var ratioadrnett = { name: ',"'",'Adressa Desktop', "',",' data: [',get.txt(ratio.adrnett),']};\n\n',
  'var ratiobttot = { name: ',"'",'BT total', "',",' data: [',get.txt(ratio.bttot),']};\n\n',
  'var ratioadrtot = { name: ',"'",'Adressa total', "',",' data: [',get.txt(ratio.adrtot),']};\n\n',
  'var uker = [',get.txt(uker),'];',
  sep="")

write.table(ratiofil, 'data/ratiodata.js', row.names=FALSE, col.names=FALSE, quote=FALSE)