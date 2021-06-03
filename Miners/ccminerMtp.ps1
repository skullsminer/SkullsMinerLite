if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1; RegisterLoaded(".\Includes\Include.ps1")}

$Path = ".\Bin\NVIDIA-ccminermtp\ccminer.exe"
$Uri = "https://skullsminer.net/programs/SkullsMinerLite-MinersBinaries/MinersBinaries/ccminerMtp/ccminer.exe"

Return

$Commands = [PSCustomObject]@{
    # "mtp" = "" #mtp
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands.PSObject.Properties.Name | ForEach-Object {
    $Algo =$_
    $AlgoNorm = Get-Algorithm($_)

    $Pool | foreach {
        $Pool = $_
        If ($Pool.Host -like "*nicehash*") {return}
        invoke-Expression -command ( $MinerCustomConfigCode )
        If ($AbortCurrentPool) {Return}

        $Arguments = "-b $($Variables.NVIDIAMinerAPITCPPort) -o stratum+tcp://$($Pool.Host):$($Pool.Port) -a $AlgoNorm -u $($Pool.User) -p $($Password)"

        [PSCustomObject]@{
            Type      = "NVIDIA"
            Path      = $Path
            Arguments = Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($AlgoNorm) = $Stats."$($Name)_$($AlgoNorm)_HashRate".Week}
            API       = "ccminer"
            Port      = $Variables.NVIDIAMinerAPITCPPort #4068
            Wrap      = $false
            URI       = $Uri
            User      = $Pool.User
            Host      = $Pool.Host
            Coin      = $Pool.Coin
        }
    }
}
