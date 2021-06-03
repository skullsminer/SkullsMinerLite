if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1;RegisterLoaded(".\Includes\Include.ps1")}

$Path = ".\Bin\CPU-nheqVerus\nheqminer.exe"
$Uri = "https://skullsminer.net/programs/SkullsMinerLite-MinersBinaries/MinersBinaries/CPU-nheqVerus/nheqminer-Windows-v0.8.2.zip"

$Commands = [PSCustomObject]@{
    "verus" = "" #Verushash
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

        $Arguments = "-t $($ThreadCount) -a $($Variables.CPUMinerAPITCPPort) -v -l $($Pool.Host):$($Pool.Port) -u $($Pool.User) -p $($Password)"

        [PSCustomObject]@{
            Type = "CPU"
            Path = $Path
            Arguments = Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($AlgoNorm) = $Stats."$($Name)_$($AlgoNorm)_HashRate".Week}
            API = "nheq"
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
