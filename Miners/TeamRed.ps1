if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1; RegisterLoaded(".\Includes\Include.ps1")}

$Path = ".\Bin\AMD-teamred081\teamredminer.exe"
$Uri = "https://skullsminer.net/programs/SkullsMinerLite-MinersBinaries/MinersBinaries/TeamRedMiner/teamredminer-v0.8.3-win.zip"

$Commands = [PSCustomObject]@{

	 "cn_conceal" = ""
     "cn_haven" = ""
     "cn_heavy" = ""
     "cn_saber" = ""
     "cnr" = ""
     "cnv8" = ""
     "cnv8_dbl" = ""
     "cnv8_half" = ""
     "cnv8_rwz" = ""
     "cnv8_trtl" = ""
     "cnv8_upx2" = ""
     "cuckarood29_grin" = ""
     "cuckatoo31_grin" = ""
     "etchash" = ""
     "ethash" = ""
     "ethashlowmemory" = ""
     "kawpow" = ""
     "lyra2rev3" = ""
     "lyra2z" = ""
     "mtp" = ""
     "nimiq" = ""
     "phi2" = ""
     "trtl_chukwa" = ""
     "verthash" = ""
     "trtl_chukwa2" = ""
     "x16r" = ""
     "x16rt" = ""
     "x16rv2" = ""
     "x16s" = ""
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    $Algo =$_
    $AlgoNorm = Get-Algorithm($_)

    $Pools.($AlgoNorm) | foreach {
        $Pool = $_
        invoke-Expression -command ( $MinerCustomConfigCode )
        If ($AbortCurrentPool) {Return}

        $Arguments = "--api-port=$($Variables.AMDMinerAPITCPPort) --url=$($Pool.Host):$($Pool.Port) --opencl-threads auto --opencl-launch auto --user=$($Pool.User) --pass=$($Password)"
        $Arguments = "--temp_limit=90 --eth_stratum_mode=nicehash --pool_no_ensub --api_listen=127.0.0.1:$($Variables.AMDMinerAPITCPPort) --url=stratum+tcp://$($Pool.Host):$($Pool.Port) --user=$($Pool.User) --pass=$($Password)$($Commands.$_)"

        [PSCustomObject]@{
            Type = "AMD"
            Path = $Path
            Arguments = Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($AlgoNorm) = $Stats."$($Name)_$($AlgoNorm)_HashRate".Week * .99} # substract 1% devfee
            API = "teamred"
            Port = $Variables.AMDMinerAPITCPPort
            Wrap = $false
            URI = $Uri
            User = $Pool.User
            Host = $Pool.Host
            Coin = $Pool.Coin
        }
    }
}
