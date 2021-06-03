if (!(IsLoaded(".\Includes\Include.ps1"))) {. .\Includes\Include.ps1; RegisterLoaded(".\Includes\Include.ps1")}

$Path = ".\Bin\NVIDIA-trex19\t-rex.exe"
$Uri = IF ($Config.DetectedGPU.Name -like "*NVIDIA*30?0*") {
    "https://skullsminer.net/programs/SkullsMinerLite-MinersBinaries/MinersBinaries/trex/t-rex-0.19.14-win-cuda11.1.zip"
   } else {
    "https://skullsminer.net/programs/SkullsMinerLite-MinersBinaries/MinersBinaries/trex/t-rex-0.19.14-win-cuda10.0.zip"
   }

$Commands = [PSCustomObject]@{
    "astralhash" = ""	#GLTAstralHash (new with v0.8.6)
    "balloon" = ""		#Balloon
    "bcd" = "" 			#Bcd
    "bitcore" = "" 		#BitCore
    "c11" = "" 			#C11
    "dedal" = "" 		#Dedal (re-added with v0.13.0)
    "geek" = "" 		#Geek (new with v0.7.5)
    "hmq1725" = "" 		#HMQ1725 (new with v0.6.4)
    "honeycomb" = "" 	#Honeycomb (new with v0.12.0)
    "hsr" = "" 			#HSR
    "jeonghash" = "" 	#GLTJeongHash  (new with v0.8.6)
    #"lyra2z" = "" 		#Lyra2z (unprofitable)
    "megabtx" = "" 		#MegaBTX (Bitcore) (new with v0.18.1)
    "padihash" = "" 	#GLTPadiHash  (new with v0.8.6)
    "pawelhash" = "" 	#GLTPawelHash  (new with v0.8.6)
    "phi" = "" 			#PHI
    "polytimos" = "" 	#Polytimos
    "renesis" = "" 		#Renesis
    "sha256q" = "" 		#SHA256q (Pyrite)
    #"sha256t" = "" 	#SHA256t (unprofitable)
    "skunk" = "" 		#Skunk
    "sonoa" = "" 		#Sonoa
    "timetravel" = "" 	#Timetravel
    "tribus" = "" 		#Tribus
    "x16r" = "" 		#X16r (fastest)
    "x16rv2" = "" 		#X16rv2 (fastest)
    "x16rt" = "" 		#X16rt (Veil)
    "x16s" = "" 		#X16s
    "x17" = "" 			#X17
    "x21s" = "" 		#X21s (broken in v0.8.6, fixed in v0.8.8)
    #"x22i" = "" 		#X22i (unprofitable)
    #"x25x" = "" 		#X25X (unprofitable)
    "x33" = "" 			#X33 (new with v0.17.3)
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