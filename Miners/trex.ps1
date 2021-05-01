if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1; RegisterLoaded(".\Includes\Include.ps1")}

$Path = ".\Bin\NVIDIA-trex\t-rex.exe"
$Uri = "https://github.com/trexminer/T-Rex/releases/download/0.20.3/t-rex-0.20.3-win.zip"

$Commands = [PSCustomObject]@{
    #"etchash" = "" 					#Etchash (new with 0.18.8)
    "ethash" = ""					#Ethash (new with v0.17.2, broken in v0.18.3, fixed with v0.18.5)
    #"ethashlowmemory" = ""			#Ethash for low memory coins
    "kawpow" = ""					#KawPOW (new with v0.15.2)
    "mtp" = ""						#MTP
    "mtp-tcr" = ""					#MTP-TCR (new with v0.15.2)
    "octopus" = ""					#Octopus  (new with v0.19.0)
    "progpow-veil" = ""				#ProgPowVeil (new with v0.18.1)
    "progpow-veriblock" = ""		#vProgPow (new with v0.18.1)
    "progpowsero" = "--coin sero"	#ProgPow  (new with v0.15.2)
    "progpowz" = "" 				#ProgpowZ (new with v0.17.2)
    "tensority" = ""				#Tensority
	
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands.PSObject.Properties.Name | ForEach-Object {
    $MinerAlgo = switch ($_){
        "Veil"    { "x16rt" }
        default    { $_ }
    }
    
    $fee = switch ($_){
        "octopus"   {0.02}
        default     {0.01}
    }

    $Algo =$_
    $AlgoNorm = Get-Algorithm($_)

    $Pools.($AlgoNorm) | foreach {
        $Pool = $_
        invoke-Expression -command ( $MinerCustomConfigCode )
        If ($AbortCurrentPool) {Return}

        $Arguments = "--no-watchdog --no-nvml -b 127.0.0.1:$($Variables.NVIDIAMinerAPITCPPort) -d $($Config.SelGPUCC) -a $($MinerAlgo) -o stratum+tcp://$($Pool.Host):$($Pool.Port) -u $($Pool.User) -p $($Password) --quiet -r 10 --cpu-priority 4"
        
        [PSCustomObject]@{
            Type      = "NVIDIA"
            Path      = $Path
            Arguments = Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($AlgoNorm) = $Stats."$($Name)_$($AlgoNorm)_HashRate".Week * (1-$fee)} # substract 1% devfee
            API       = "ccminer"
            Port      = $Variables.NVIDIAMinerAPITCPPort
            Wrap      = $false
            URI       = $Uri
            User = $Pool.User
            Host = $Pool.Host
            Coin = $Pool.Coin
        }
    }
}
