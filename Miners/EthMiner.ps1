if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1; RegisterLoaded(".\Includes\Include.ps1")}
 
$Path = ".\Bin\NVIDIA-Ethminer\ethminer.exe"
$Uri = "https://github.com/RainbowMiner/miner-binaries/releases/download/v0.19.0-ethminer/ethminer-0.19.0-18-cuda10.0-windows-amd64.zip"
$Commands = [PSCustomObject]@{
    "ethash" = "" #Ethash(fastest)
	"ethashlowmemory" = "" #EthashLowMemory(fastest)
}
$Port = $Variables.NVIDIAMinerAPITCPPort
$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    $Algo =$_
    $AlgoNorm = Get-Algorithm($_)

    $Pools.($AlgoNorm) | foreach {
        $Pool = $_
        invoke-Expression -command ( $MinerCustomConfigCode )
        If ($AbortCurrentPool) {Return}

        If ($Algo -eq "ethash" -and $Pool.Host -like "*miningpoolhub*") {
            $Protocol = "stratum+tcp://"
        } Else {
            $Protocol = "stratum2+tcp://"
        }

        $Arguments = "--cuda-devices $($Config.SelGPUDSTM) --api-port -$Port -U -P $($Protocol)$($Pool.User):$($Password)@$($Pool.Host):$($Pool.Port)"

        [PSCustomObject]@{
            Type      = "NVIDIA"
            Path      = $Path
            Arguments = Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($AlgoNorm) = $Stats."$($Name)_$($AlgoNorm)_HashRate".Week} 
            API       = "ethminer"
            Port      = $Variables.NVIDIAMinerAPITCPPort
            Wrap      = $false
            URI       = $Uri    
            User      = $Pool.User
            Host = $Pool.Host
            Coin = $Pool.Coin
        }
    }
}
