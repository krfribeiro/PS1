# PARA QUEM ESTÁ FARTO DE FAZER LOGIN NO SITE DAS FINANÇAS PARA SABER SE JA RECEBEU OU NAO! #
# FAZ-SE UM SCRIPT PARA LA IR VER #
# UM POBRE A AJUDAR POBRES :P

$URI = "https://www.acesso.gov.pt/jsp/loginRedirectForm.jsp?path=consultarDeclaracoesIRS.action&partID=M3SV"

$ie = New-Object -com InternetExplorer.Application
# Se meter $False estoira por nao carregar como deve ser as livrarias de Javascript! Whoops!
# Se conseguirem resolver a cena! Be my guest :)
$ie.visible=$true
$ie.navigate("$URI")
while($ie.ReadyState -ne 4) {start-sleep -m 100}

# ALTERAR AQUI OS DADOS PARA LOGIN #

$ie.document.getElementById('username').value = "NIF"
$ie.document.getElementById('password').value = "PASSWORD"

# NAO ALTERAR NADA A PARTIR DAQUI :D #

$ie.document.getElementById('sbmtLogin').Click()
start-sleep -m 100
$ie.document.getElementById('pesquisar').Click()
start-sleep -m 100
($ie.Document.links | ? { $_.href -like '*detalheDeclaracaoIRS*' }).Click()
start-sleep -m 100
$estado = $ie.Document.getElementById('dataRececao').IHTMLInputElement_value
if ($estado -notlike 'REEMBOLSO EMITIDO') {
    echo "You're still poor! - $ESTADO " }
Else { echo "You're probably rich! - $ESTADO" }
$ie.Quit() 
