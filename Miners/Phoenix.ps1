

if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1; RegisterLoaded(".\Includes\Include.ps1")}

$Path = ".\\Bin\\NVIDIA-Phoenix\\PhoenixMiner.exe"
$Uri = "https://raw.githubusercontent.com/PhoenixMinerDevTeam/files/main/PhoenixMiner_5.6a_Windows.zip"
$Commands = [PSCustomObject]@{
    "ethash" = " -di $($($Config.SelGPUCC).Replace(',',''))" #Ethash(fastest)
	"ethashlowmemory" = " -di $($($Config.SelGPUCC).Replace(',',''))" #EthashLowMemory(fastest)
	"etchash" = " -di $($($Config.SelGPUCC).Replace(',',''))" #Etchash(fastest)
    "progpow" = " -coin bci -di $($($Config.SelGPUCC).Replace(',',''))" #Progpow 
    "ubqhash" = " -coin ubq -di $($($Config.SelGPUCC).Replace(',',''))" #ubqhash 
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands.PSObject.Properties.Name | ForEach-Object {
    $Algo =$_
    $AlgoNorm = Get-Algorithm($_)

    $Pools.($AlgoNorm) | foreach {
        $Pool = $_
        invoke-Expression -command ( $MinerCustomConfigCode )
        If ($AbortCurrentPool) {Return}

        $Arguments = "-nvdo 1 -esm 3 -allpools 1 -allcoins 1 -platform 2 -mport -$($Variables.NVIDIAMinerAPITCPPort) -epool $($Pool.Host):$($Pool.Port) -ewal $($Pool.User) -epsw $($Password)"

        [PSCustomObject]@{
            Type = "NVIDIA"
            Path = $Path
            Arguments = Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($AlgoNorm) = $Stats."$($Name)_$($AlgoNorm)_HashRate".Week * .99} # substract 1% devfee
            API = "ethminer"
            Port = $Variables.NVIDIAMinerAPITCPPort #3333
            Wrap = $false
            URI = $Uri
            User = $Pool.User
            Host = $Pool.Host
            Coin = $Pool.Coin
        }
    }
}
