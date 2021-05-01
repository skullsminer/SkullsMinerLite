if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1; RegisterLoaded(".\Includes\Include.ps1")}
 
$Path = ".\Bin\NVIDIA-AMD-lolMiner\lolMiner.exe"
$Uri = "https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.26/lolMiner_v1.26_Win64.zip"

$Commands = [PSCustomObject]@{
    "BeamHash3"  = "" 		#BeamHash III
    "Cuckaroo29b"= "" 		#Cuckaroo29b
    "Cuckaroo29i" = "" 		#Cuckaroo29i
    "Cuckaroo29s" = "" 		#Cuckaroo29s
    "Cuckaroo30" = "" 		#Cuckaroo30
    "Cuckatoo31"= "--coin GRIN-C31" 		#Cuckatoo31
    "Cuckatoo32"= "--coin GRIN-C32" 		#Cuckatoo32
    "Cuckarood29" = "" 		#Cuckarood29
    "Cuckaroom29" = "" 		#Cuckaroom29
    "CuckooCycle" = "" 		#CuckooCycle/AEternity
    "Equihash21x9" = "" 	#Equihash 210,9
    "Equihash24x5" = "--coin AUTO144_5" 	#Equihash 144,5
    "Equihash24x7" = "--coin AUTO192_7" 	#Equihash 192,7
    "EquihashR25x4" = ""  	#Equihash 125,4,0
    "EquihashR25x5" = "" 	#Equihash 150,5
    "EquihashR25x5x3" = "" 	#Equihash 150,5,3
    "EtcHash" = "" 			#Etchash
    "Ethash" = "" 			#Ethash
    "Ethashlowmemory" = ""  #Ethashlowmemory

    }
$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName
$WinningCustomConfig = [PSCustomObject]@{}

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    $Algo =$_
    $AlgoNorm = Get-Algorithm($_)

    $Pools.($AlgoNorm) | foreach {
        $Pool = $_
        invoke-Expression -command ( $MinerCustomConfigCode )
        If ($AbortCurrentPool) {Return}

        $Arguments = "--user $($Pool.User) --pool $($Pool.Host) --port $($Pool.Port) --devices $($Config.SelGPUCC) --apiport $($Variables.NVIDIAMinerAPITCPPort) --tls 0 --digits 2 --longstats 60 --shortstats 5 --connectattempts 3 --pass $($Password)"
        [PSCustomObject]@{
            Type      = "NVIDIA"
            Path      = $Path
            Arguments =  Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($Algo) = $Stats."$($Name)_$($Algo)_HashRate".Week * 0.99} # 1% dev fee
            API       = "LOL"
            Port      = $Variables.NVIDIAMinerAPITCPPort
            Wrap      = $false
            URI       = $Uri    
            User = $Pool.User
            Host = $Pool.Host
            Coin = $Pool.Coin
        }
        
        $Arguments = "--user $($Pool.User) --pool $($Pool.Host) --port $($Pool.Port) --devices $($Config.SelGPUCC) --apiport $($Variables.AMDMinerAPITCPPort) --tls 0 --digits 2 --longstats 60 --shortstats 5 --connectattempts 3 --pass $($Password)"
        [PSCustomObject]@{
            Type      = "AMD"
            Path      = $Path
            Arguments =  Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($Algo) = $Stats."$($Name)_$($Algo)_HashRate".Week * 0.99} # 1% dev fee
            API       = "LOL"
            Port      = $Variables.AMDMinerAPITCPPort
            Wrap      = $false
            URI       = $Uri    
            User = $Pool.User
            Host = $Pool.Host
            Coin = $Pool.Coin
        }
    }
}