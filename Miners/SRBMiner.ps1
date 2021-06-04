If (-not (IsLoaded(".\Includes\include.ps1"))) { . .\Includes\include.ps1; RegisterLoaded(".\Includes\include.ps1") }

$Path = ".\Bin\cpu-SRBMiner\SRBMiner-MULTI.exe"
# $Uri = "https://github.com/doktor83/SRBMiner-Multi/releases/download/0.7.1/SRBMiner-Multi-0-7-1-win64.zip"
$Uri = "https://skullsminer.net/programs/SkullsMinerLite-MinersBinaries/MinersBinaries/SRBMiner-Multi/SRBMiner-Multi-0-7-5-win64.zip"

$Commands = [PSCustomObject]@{ 
  	"balloon_zentoshi" = "" #BalloonZentoshi
	"circcash"  = "" #Circcash/CIRC
	"cpupower" = #CPUpower
    "curvehash"  = #Curvehash
    "heavyhash"  = #HeavyHash/OBTC
     "minotaur"  = #Minotaur/RING Coin
     "panthera"  = #Panthera
     "randomarq"  = "" #RandomArq
     "randomepic" = "" #RandomEPIC
     "randomhash2" = "" #RandomHash2/PASC
     "randomkeva" = "" #RandomKEVA
     "randomsfx"  = "" #RandomSFX
     "randomwow"  = "" #RandomWow
     "randomx"   = "" #RandomX
     "randomxl"  = "" #RandomXL
     "rx2"       = "" #RX2/Luxcoin
     "scryptn2"  = #scyptn2/Verium
     "yescryptr16"  = "" #yescryptr16
     "yescryptr32"  = "" #yescryptr32
     "yescryptr8" = #yescryptr8
     "yespower"  = #yespower
     "yespower2b" = #yespower2b
     "yespoweric" = #yespoweric
     "yespoweriots" = "" #yespoweriots
     "yespoweritc"  = "" #yespoweritc
     "yespowerlitb" = "" #yespowerlitb
     "yespowerltncg" = "" #yespowerltncg
     "yespowermgpc" = "" #YespowerMGPC/MagPieCoin
     "yespowerr16"  = "" #yespowerr16
     "yespowerres"  = "" #yespowerRES
     "yespowersugar" = "" #yespowersugar
     "yespowertide" = ""#yespowertide
     "yespowerurx"  = "" #yespowerurx
     "argon2d_dynamic"= "" #Argon2Dyn
     "argon2id_chukwa" = ""#Argon2Chukwa
     "argon2id_chukwa2" = "" #Argon2Chukwa2
     "argon2id_ninja"  = "" #Argon2Ninja
     "autolykos2" = "" #Autolykos2/ERGO
     "bl2bsha3"  = "" #blake2b+sha3/HNS
     "blake2b"   = "" #blake2b
    # "blake2s"  = "" #blake2s
     "cryptonight_cache" = "" #CryptonightCache
     "cryptonight_ccx" = "" #CryptonightCCX
     "cryptonight_gpu" = "" #CryptonightGPU
     "cryptonight_heavyx" = "" #CryptonightHeavyX
     "cryptonight_talleo" = "" #CryptonightTalleo
     "cryptonight_upx" = "" #CryptonightUPX
     "cryptonight_xhv" = "" #CryptonightXHV
     "eaglesong"  = "" #eaglesong
     "etchash" = "" #ethash
     "ethash" = "" #ethash
     "ethashlowmemory" = "" #ethash for low memory coins
     "heavyhash"  = "" #HeavyHash/OBTC
     "k12"       = "" #kangaroo12/AEON from 2019-10-25
     "kadena"    = "" #blake2s / Kadena
     "keccak"    = "" #keccak
     "phi5"      = "" #PHI5/CBE
     "ubqhash"   = "" #ubqhash
     "verthash"  = "" #Verthash
     "verushash"  = "" #Verushash
     "yescrypt"  = "" #yescrypt
	
	
	
}

$Name = Get-Item $MyInvocation.MyCommand.Path | Select-Object -ExpandProperty BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object { 
    switch ($_) { 
        default { $ThreadCount = $Variables.ProcessorCount - 2 }
    }

    $Algo =$_
    $AlgoNorm = Get-Algorithm($_)

    $Pools.($AlgoNorm) | foreach {
        $Pool = $_
        invoke-Expression -command ( $MinerCustomConfigCode )
        If ($AbortCurrentPool) {Return}
        
        #Curve diff doesn't play well on ZPool
        If ($Pool.Host -like "*zpool*" -and $AlgoNorm -eq "curvehash") {Return}

        $Arguments = "--algorithm $($AlgoNorm) --pool stratum+tcp://$($Pool.Host):$($Pool.Port) --cpu-threads $($ThreadCount) --nicehash true --send-stales true --api-enable --api-port $($Variables.CPUMinerAPITCPPort) --disable-gpu --wallet $($Pool.User) --password $($Password)"

        [PSCustomObject]@{
            Type = "CPU"
            Path = $Path
            Arguments = Merge-Command -Slave $Arguments -Master $CustomCmdAdds -Type "Command"
            HashRates = [PSCustomObject]@{($AlgoNorm) = $Stats."$($Name)_$($AlgoNorm)_HashRate".Week * .9915 } # substract 0.85% devfee
            API = "SRB"
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

