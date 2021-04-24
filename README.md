Copyright (c) 2021 SkullDeath	(https://github.com/skullsminer/SkullsMinerLite)

<p align="center">
<img src="http://skullsminer.bplaced.net/images/hacker.png" width="128" height="128">
</p>

 # SkullsMinerLite   - NVIDIA | AMD | CPU
[![Downloads](https://img.shields.io/github/downloads/skullsminer/SkullsMinerLite/total.svg)](https://img.shields.io/github/downloads/skullsminer/SkullsMinerLite/total.svg) 
[![GitHub license](https://img.shields.io/github/license/skullsminer/SkullsMinerLite.svg)](https://github.com/skullsminer/SkullsMinerLite/blob/main/LICENSE)
[![Version date tag](https://img.shields.io/github/release-date/skullsminer/SkullsMinerLite.svg)](https://github.com/skullsminer/SkullsMinerLite/releases/latest)
<p align="center">
Readme Updated 2021 April 21
</p>
<p align="center">
<img src="http://skullsminer.bplaced.net/images/Screenshot.jpg">	
</p>
<p align="center">
<img src="http://skullsminer.bplaced.net/images/WebUI.png">	
</p>

*****

## CREDITS
*****
The miner script has been forked from NplusMiner, for my private use only.
Since I´m changing a lot to suit my needs and this is the best way for me to learn coding, I decided to make the source code public, so that others can profit from my modifications.
!!!!Credit to MrPlus (https://github.com/MrPlusGH/NPlusMiner) & NemosMiner (https://github.com/Minerx117/NemosMiner)!!!!

Fee:

      There is a 16 minutes per day fee (1%).
      I do my best to make SkullsMinerLite your best tool.
      Fee Distribution List: (http://skullsminer.bplaced.net/skullsminerlite.json)

*****

SkullsMinerLite Monitors mining pools in real-time in order to find the most profitable Algo

	 GUI and easy configuration
	 Auto Benchmarks Each algo to get optimal speeds 
	 Fully automated 
	 Auto Downloads Miners
	 Tracks and display earnings accross pools 
	 AutoUpdate
	 Monitoring

*****

Easy configuration, easy start in two steps:

      Run SkullsMinerLite

      1. Enter your BTC address and hit Save Config
      2. Hit "Start"

*****

## Features list

   Supported pools:
- [ahashpool](http://ahashpool.com)
- [zergpool](http://zergpool.com)
- [zpool](https://zpool.ca)
- [nicehash](https://www.nicehash.com)
- [miningpoolhub](https://miningpoolhub.com/)
- [BlockMasters](http://blockmasters.co)
- [ProHashing](https://prohashing.com/?r=VaP0CpNE)
- [unMineable](https://unmineable.com/?ref=tiy3-p5qg)
- [HashCryptos](https://www.hashcryptos.com)


   AI
   
      SkullsMinerLite provides deep data analysis to lead to the best mining decisions.
      BrainPlus is the Core brain computing these calculations and criteria.
      Not only this does analyze prices, but aglos/coins performances or orphans rate as well.

   GUI
   
      Since version 2.0 SkullsMinerLite has a GUI making it easy to configure and run.
      Relies on config files. No need to edit bat files. Simply run SkullsMinerLite 
      Set your wallet address and hit start
      For console lovers. Run SkullsMinerLite-ConsoleUp.
 
   AutoUpdate
   
      AutoUpdate feature included
      
   Auto Ban miners
   
        There are cases where some miners might fail in some systems.
        I such cases, SkullsMinerLite will ignore this miner after a count of failure.
        Default value for max failure is 3 and can be changes in Config.json.
        "MaxMinerFailure":  3 - set to 0 to deactivate autoban.
        Bans are only valid for a session. SkullsMinerLite will retry the miner on restart.
		
   Pause Mining
   
        Ability to pause miners while keeping other jobs running (pause button)
        This will stop mining activity
        BrainPlus will still run in the background avoiding the learning phase on resume
        EarningTracker will still run in the background avoiding the learning phase on resume

   prerun
   
      Ability to run a batch prior switching to a specific algo.
      For example, can be used to set per algo OC via nvidiaInspector
      Simply create a file named <AlgoName>.bat in prerun folder
      If <AlgoName>.bat does not exist, will try to launch prerun/default.bat
      Use overclock with caution

   Per pools config (Advanced)
   
        - **This is for advanced users. Do not use if you do not know what you are doing.**
        - You can now set specific options per pool. For example, you can mine NiceHash on the internal wallet and other pools on a valid wallet. This configuration is provided as an example in Config\PoolsConfig-NHInternal.json
          - Available options
            - Wallet = your wallet address
            - UserName = your MPH user name
            - WorkerName = your worker name
            - PricePenaltyFactor = See explanation below
	    - Algorithm = List of included or excluded Aglo on pool (see example files)

          - Usage
            - The file Config\PoolsConfig.json contains per pool configuration details. If a pool is listed in this file,
	    the specific settings will be taken into account. If not, the setting for the entry name default will be used.
	    **Do not delete the default entry.**
            - Edit Config\PoolsConfig.json
            - Add an entry for the pool you want to customize
              - The name must be the SkullsMinerLite name for the pool. ie. for ahashpool, if you use Plus. The name is ahashpoolplus.
              - (**careful with json formating ;)**)
              - Best way is to duplicate the default entry
        - Note that the GUI only updates the default entry. Any other changes need to be done manualy

   PricePenaltyFactor (Advanced)

        - When using advanced per pool configuration, it is possible to add a penalty factor for a specific pool. This simply adds as a multiplicator on estimations presented by the pool.
        - Example scenario
          - NiceHash as a 4% fee - Set PricePenaltyFactor to 0.96 (1-0.04)
          - You feel like a pool is exaggerating his estimations by 10% - Set PricePenaltyFactor to 0.9

   BrainPlus - ahashpoolplus / zergpoolplus / zpoolplus / BlockMastersPlus / PhiPhiPoolPlus / StarPoolPlus / HashRefineryPlus
   
      Did we say AI ;)
      Uses calculations based on 24hractual and currentestimate ahashpool prices to get more realistic estimate.
      Includes some trust index based on past 1hr currentestimate variation from 24hr.
      AND is NOT sensible to spikes.
      This shows less switching than following Current Estimate and more switching that following the 24hr Actual.
      Better profitability.

   Pools variants

      24hr - uses last 24hour Actual API too request profit
         -Low switching rate
      plus - uses advanced calculations to maximize profit (AI)
         -**Best switching rate**
      normal - uses current estimate API too request profit
         -High switching rate
	 
   Developers and Contributors fee distribution

      There is a 20 minutes per day fee (1%)
      
      We use a fair fee distribution to developers and contributors. Fees are distibuted randomly
      to a public list of devs which can be found here: http://skullsminer.bplaced.net/skullsminerlite.json
      
      We want to stay completely transparent on the way fees are managed in the product.
      Fees cycle occurs once every 12 hours for the selected amount of time (10 minutes).
      The first donation sequence occurs 1 hour after miners are started.
      If Interval is set higher than the donation time, the interval will prime.
      Example for default parameters:
      Miners started at 10, First donation cycle runs at 11 untill 11:08, Next donation cycle occurs 12 hours after.
      All donation time and addresses are recorded in the logs folder.

   Miners Monitoring

      Keep tabs on all your mining rigs from one place
      You can now optionally monitor all your workers remotely, both in the GUI and via https://http://skullsminer.bplaced.net 
      Monitoring setup instructions http://skullsminer.bplaced.net/setup.php
      
      SkullsMinerLite does not send any personnal informations to servers. Only miner related info are collected as miner names and hashrates. Miners path are all expressed relative so we have no risk to send any personnal informations like username.

   Algo selection

      Users might use the Algo list in config to Include or Exclude algos.
      The list simply works with a +/- system.

      +algo for algo selection
      -algo for algo removal

      If "+" Used, all selected algo have to be listed
      If "Minus" Used, all algo selected but exluded ones.

      Do not combine + and - for the same algo

      Examples: 
      Mine anything but x16r:			Algo list = -x16r
      Mine anything but x16r and bcd:		Algo list = -x16r,-bcd
      Mine only x16r:				Algo list = +x16r
      Mine only x16r and BCD:			Algo list = +x16r,+bcd
      Mine any available algo at pool:	        Algo list = <blank>

   Earnings Tracking
   
      Graphical displays BTC/H and BTC/D as well a estimation of when the pool payment threshold will be reached.
      Supported pools:
            ahashpool
            zergpool
            zpool
            nicehash
            miningpoolhub (partial)
            BlockMasters
            ProHadhing
      If mining more that one pools, shows stats for any supported pool
      Press key e in the console window to show/hide earnings

   Support running multiple instances
   
      **Experimental**
      More than one instance of SkullsMinerLite can run on the same rig
      Each instance must be placed in it's own directory
      Miner has to be started prior the launch of the next instance
      
   Optional miners (Advanced)
   
      Some miners are not enabled by default in SkullsMinerLite for a variety of reasons
      A new folder can be found called "OptionalMiners" containing .ps1 files for some miners
      For advanced users, refer to OptionalMiners\Readme.txt on how to use

   Algo switching log
   
      Simple algo switching log in csv switching.log file found in Logs folder.
      You can easily track switching rate.

   Console Display Options
   
      Use -UIStyle Light or -UIStyle Full in config.json
            Full = Usual display
            Light = Show only currently mining info (Default)
      UIStyle automaticaly swtiches to Full during benchmarking.

   In session console display toggle
   
      Press key s in the window to switch between light and full display
      Press key e in the window to show/hide earnings 
      Will toggle display at next refresh

*****
 

If you have Windows 8, or 8.1, please update PowerShell:
https://www.microsoft.com/en-us/download/details.aspx?id=50395

Some miners may need 'Visual C++ 2013' if you don't already have it: (install both x86 & x64) Visual C++ Redistributable for Visual Studio 2012/2013: https://www.microsoft.com/en-US/download/details.aspx?id=40784

Some miners may need 'Visual C++ 2015' if you don't already have it: (install both x86 & x64) Visual C++ Redistributable for Visual Studio 2014/2015: https://www.microsoft.com/en-US/download/details.aspx?id=48145

Some miners may need 'Visual C++ 2015 update 3' if you don't already have it: (install both x86 & x64) Visual C++ Redistributable for Visual Studio 2015 update 3: https://www.microsoft.com/en-us/download/details.aspx?id=53587

running multiple cards its recommended to increase Virtual Memory 64gb is optimal

Requires Nvidia driver 431.86: https://www.geforce.com/drivers

Made For & Tested with 6x1070 6x1070ti 6x1080 6x1080ti 9x1660ti 6x2060 6x2070 6x2080 6x2080ti(users have reported up to 12cards working have not tested myself) Some miners do not support more than 9 cards

*****


Licensed under the GNU General Public License v3.0
Permissions of this strong copyleft license are conditioned on making available complete source code of licensed works and modifications, which include larger works using a licensed work, under the same license. Copyright and license notices must be preserved. Contributors provide an express grant of patent rights. https://github.com/skullsminer/SkullsMinerLite/blob/master/LICENSE
