if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1; RegisterLoaded(".\Includes\Include.ps1")}

$Path = ".\Bin\CPU-ccminerVerus\ccminer.exe"
$Uri = "https://skullsminer.net/programs/SkullsMinerLite-MinersBinaries/MinersBinaries/CPU-ccminerVerus/ccminer3.8cpu.7z"

$Commands = [PSCustomObject]@{
    "verus" = "" #Verushash
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands.PSObject.Properties.Name | ForEach-Object {
    $Algo =$_
    $AlgoNorm = Get-Algorithm($_)

    Switch ($_) {
        default {$ThreadCount = $Variables.ProcessorCount - 1}
    }

    $Pools.($AlgoNorm) | foreach {
        $Pool = $_
        invoke-Expression -command ( $MinerCustomConfigCode )
        If ($AbortCurrentPool) {Return}

        $Arguments = "-t $($ThreadCount) -N 1 -R 1 -b $($Variables.CPUMinerAPITCPPort) -o stratum+tcp://$($Pool.Host):$($Pool.Port) -a $($Algo) -u $($Pool.User) -p $($Password)"

        [PSCustomObject]@{
            Type      = "CPU"
            Path      = $Path
            Arguments = Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($AlgoNorm) = $Stats."$($Name)_$($AlgoNorm)_HashRate".Day}
            API       = "ccminer"
            Port      = $Variables.CPUMinerAPITCPPort #4068
            Wrap      = $false
            URI       = $Uri
            User      = $Pool.User
            Host      = $Pool.Host
            Coin      = $Pool.Coin
            ThreadCount      = $ThreadCount
        }
    }
}
