# by KikO!
#
# Script para ver se já recebemos ou não do IRS!
#
# Porque o pobre não precisa mais de fazer F5 de 10 em 10 minutos no site das finanças!
#
# É necessário mais abaixo editar o NIF e Password conforme :)
#

$URI = "https://www.acesso.gov.pt/jsp/loginRedirectForm.jsp?path=consultarDeclaracoesIRS.action&partID=M3SV"

$ie = New-Object -com InternetExplorer.Application
$ie.visible=$true
$ie.navigate("$URI")

while($ie.ReadyState -ne 4) { start-sleep -m 1000 }

# Edit here only :)

$ie.document.getElementById('username').value = "NIF"
$ie.document.getElementById('password').value = "PASSWORD"

$ie.document.getElementById('sbmtLogin').Click()
start-sleep -m 6000

$ie.document.getElementById('pesquisar').Click()

start-sleep -m 1000

($ie.Document.links | ? { $_.href -like '*detalheDeclaracaoIRS*' }).Click()

start-sleep -m 1000

$estado = $ie.Document.getElementById('dataRececao').IHTMLInputElement_value

$wshell = New-Object -ComObject Wscript.Shell
$ie.Quit()

if ($estado -notlike 'REEMBOLSO EMITIDO') {
    
    (new-object -ComObject wscript.shell).Popup("You're still poor! - $ESTADO ",0,"Done")
}
Else { (new-object -ComObject wscript.shell).Popup("You're probably rich! - $ESTADO",0,"Done") }

exit
