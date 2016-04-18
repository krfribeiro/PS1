# by KikO!
#
# Script para ver se já recebemos ou não do IRS!
#
# Porque o pobre não precisa mais de fazer F5 de 10 em 10 minutos no site das finanças!
#

$URI = "https://www.acesso.gov.pt/jsp/loginRedirectForm.jsp?path=consultarDeclaracoesIRS.action&partID=M3SV"
$ie = New-Object -com InternetExplorer.Application
$ie.visible=$true
$ie.navigate("$URI")

while($ie.ReadyState -ne 4) { start-sleep -m 1000 }

$ie.document.getElementById('username').value = "NIF"
$ie.document.getElementById('password').value = "Password"
$ie.document.getElementById('sbmtLogin').Click()
start-sleep -m 3000
$ie.document.getElementById('pesquisar').Click()
start-sleep -m 1000
($ie.Document.links | ? { $_.href -like '*detalheDeclaracaoIRS*' }).Click()
start-sleep -m 1000
# Win10
$estado = $ie.Document.IHTMLDocument3_getElementById('dataRececao').defaultValue
# Win7+
# $estado = $ie.Document.getElementById('dataRececao').IHTMLInputElement_value
$wshell = New-Object -ComObject Wscript.Shell
$ie.Quit()
if ($estado -like '*REEMBOLSO EMITIDO*') {
    (new-object -ComObject wscript.shell).Popup("You're probably rich! - $ESTADO",0,"IRSState | K")
}
Else { (new-object -ComObject wscript.shell).Popup("You're still poor! - $ESTADO ",0,"IRSState | K") }
