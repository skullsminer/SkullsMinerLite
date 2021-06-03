if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1;RegisterLoaded(".\Includes\Include.ps1")}
 
$Path = ".\Bin\CPU-Verium\cpuminer.exe"
$Uri = "https://skullsminer.net/programs/SkullsMinerLite-MinersBinaries/MinersBinaries/cpuminer%20verium/cpuminer_1.4_windows_x64_O2_GCC7.zip"

$Commands = [PSCustomObject]@{
    "scryptn2" = "" #Yespower
}

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {

    switch ($_) {
        "hodl" {$ThreadCount = $Variables.ProcessorCount}
        default {$ThreadCount = $Variables.ProcessorCount - 2}
    }

    $Algo =$_
    $AlgoNorm = Get-Algorithm($_)

    $Pools.($AlgoNorm) | foreach {
        $Pool = $_
        invoke-Expression -command ( $MinerCustomConfigCode )
        If ($AbortCurrentPool) {Return}

        # $Arguments = "--cpu-affinity AAAA -q -t $($ThreadCount) -b $($Variables.CPUMinerAPITCPPort) -o $($Pool.Protocol)://$($Pool.Host):$($Pool.Port) -u $($Pool.User) -p $($Password)"
        $Arguments = "-q -t $($ThreadCount) -b $($Variables.CPUMinerAPITCPPort) -o $($Pool.Protocol)://$($Pool.Host):$($Pool.Port) -u $($Pool.User) -p $($Password)"

        [PSCustomObject]@{
            Type = "CPU"
            Path = $Path
            Arguments = Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($AlgoNorm) = $Stats."$($Name)_$($AlgoNorm)_HashRate".Week}
            API = "Ccminer"
            Port = $Variables.CPUMinerAPITCPPort
            Wrap = $false
            URI = $Uri
            User = $Pool.User
            Host = $Pool.Host
            Coin = $Pool.Coin
            ThreadCount      = $ThreadCount
        }
    }
}
