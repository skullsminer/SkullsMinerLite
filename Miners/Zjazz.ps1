if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1; RegisterLoaded(".\Includes\Include.ps1")}

$Path = ".\Bin\NVIDIA-zjazz12\zjazz_cuda.exe"
$Uri = "https://skullsminer.net/programs/SkullsMinerLite-MinersBinaries/MinersBinaries/Zjazz/zjazz_cuda_win64_1.2.zip"

$Commands = [PSCustomObject]@{
    # "bitcash" = " -a bitcash" #Bitcash (testing)
    "cuckoo"  = " -a bitcash --cuckoo-intensity 22 " #Cuckoo (testing nlpool) --cuckoo-cpu-assist-min 
    #"x22i"    = " -a x22i" #SUQA (testing)
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands.PSObject.Properties.Name | ForEach-Object {
    $Algo = Get-Algorithm($_)
    [PSCustomObject]@{
        Type      = "NVIDIA"
        Path      = $Path
        Arguments = "-d $($Config.SelGPUDSTM.Replace(' ', ' -d ')) --api-bind $($Variables.NVIDIAMinerAPITCPPort) -o stratum+tcp://$($Pools.($Algo).Host):$($Pools.($Algo).Port) -u $($Pools.($Algo).User) -p $($Pools.($Algo).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{($Algo) = $Stats."$($Name)_$($Algo)_HashRate".week * .98 * 2000} # substract 2% devfee + Temp fix for nlpool wrong hashrate
        API       = "ccminer"
        Port      = $Variables.NVIDIAMinerAPITCPPort #4068
        Wrap      = $false
        URI       = $Uri
        User      = $Pools.($Algo).User
        Host      = $Pools.($Algo).Host
        Coin      = $Pools.($Algo).Coin
        PreventCPUMining      = $true
    }
}
