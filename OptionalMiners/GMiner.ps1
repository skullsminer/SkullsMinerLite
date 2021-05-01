if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1; RegisterLoaded(".\Includes\Include.ps1")}

$Path = ".\Bin\NVIDIA-Gminer\miner.exe"
$Uri = "https://github.com/develsoftware/GMinerRelease/releases/download/2.54/gminer_2_54_windows64.zip"

$Commands = [PSCustomObject]@{
    "cuckoocycle"    = " --algo aeternity --pers auto" #Aeternity 
    "eaglesong"       = " --algo eaglesong" #eaglesong
    "ethash"          = " --algo ethash" #Ethash
    "ethashlowmemory"  = " --algo ethashlowmemory" #Ethashlowmemory
    "grincuckaroo29b"  = " --algo cuckaroo29b --pers auto" #Grincuckaroo29b (fastest)
    "grincuckaroo29s"  = " --algo swap --pers auto" #Grincuckaroo29s (fastest)
    "Cortex"         = " --algo cortex " #cortex (fastest)
    "Aeternity"       = " --algo aeternity" #Aeternity
    "beamv3"           = " -a BeamHashIII" #Equihash150,5,3 (NiceHash)
    "equihash125"    = " --devices $($Config.SelGPUDSTM) --algo 125_4 --pers auto" #Equihash125
    "equihash144"      = " --devices $($Config.SelGPUDSTM) --algo 144_5 --pers auto" #Equihash144 (fastest)
    "equihash192"  = " --devices $($Config.SelGPUDSTM) --algo 192_7 --pers auto" #Equihash192 (fastest)
    "grincuckatoo31"  = " --devices $($Config.SelGPUDSTM) --algo grin31 --pers auto" #Cuckatoo31 requires 7.4GB VRam, will work on 8GB cards under Linux and Windows 7, will not work under Windows 10
    # "zhash"        = " --devices $($Config.SelGPUDSTM) --algo 144_5 --pers auto" #Zhash (fastest)
    "cuckaroom"       = " --algo grin29" #Cuckaroom 
    "grincuckatoo32"   = " --algo grin32 --pers auto" #Grincuckatoo32
    "kawpow"           = " --algo kawpow" #KAWPOW [RVN fork]
    "cuckaroo29bfc"    = " --algo bfc" #Cuckaroo29bfc
    "cuckarooz29"      = " --algo cuckarooz29" #Cuckarooz29
}
 
$Port = $Variables.NVIDIAMinerAPITCPPort
$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName
$WinningCustomConfig = [PSCustomObject]@{}

$Commands.PSObject.Properties.Name | ForEach-Object {
    $Algo =$_
    $AlgoNorm = Get-Algorithm($_)

    $Pools.($AlgoNorm) | foreach {
        $Pool = $_

        If ($Algo -eq "ethash" -and ($Pool.Host -like "*nicehash*" -or $Pool.Host -like "*miningpoolhub*")) {
            $Commands.$Algo += " --proto stratum"
        } else {

        }

        invoke-Expression -command ( $MinerCustomConfigCode )
        If ($AbortCurrentPool) {Return}

        $Arguments = " --devices $($Config.SelGPUDSTM) -t 95 --watchdog 0 --api $($Variables.NVIDIAMinerAPITCPPort) --server $($Pool.Host) --port $($Pool.Port) --user $($Pool.User) --pass $($Password)"
        
        [PSCustomObject]@{
            Type      = "NVIDIA"
            Path      = $Path
            Arguments = Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($AlgoNorm) = $Stats."$($Name)_$($AlgoNorm)_HashRate".Day * .98} # substract 2% devfee
            API       = "gminer"
            Port      = $Variables.NVIDIAMinerAPITCPPort
            Wrap      = $false
            URI       = $Uri    
            User = $Pool.User
            Host = $Pool.Host
            Coin = $Pool.Coin
        }
    }
}
