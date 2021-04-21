#Rules DGV Click Function 
function RulesDGVClick(){
    $rowIndex = $This.CurrentRow.Index
    $columnIndex = $This.CurrentCell.ColumnIndex
    
    ($PanelEdit.Controls | ? {($_.gettype()).Name -eq "TextBox"}) | foreach {$_.Text = $null}
    ($PanelEdit.Controls | ? {($_.gettype()).Name -eq "CheckBox"}) | foreach {$_.Checked = $null}

    $Row = $This.Rows[$rowIndex].DataBoundItem
    $SelectedRule = $MinerCustomConfig | ? { $_.algo -eq $Row.algo -and $_.pool -eq $Row.pool -and $_.miner -eq $Row.miner -and $_.coin -eq $Row.coin }

    $SelectedRule.PSObject.Properties.Name | foreach {
        $PropertyName = $_
        
        If ($SelectedRule.$_ -is [String]) {
            ($PanelEdit.Controls | ? {($_.gettype()).Name -eq "TextBox" -and $_.Tag -eq $PropertyName}).Text = $SelectedRule.$PropertyName
        }
        If ($SelectedRule.$_ -is [Boolean]) {
            ($PanelEdit.Controls | ? {($_.gettype()).Name -eq "CheckBox" -and $_.Tag -eq $PropertyName}).Checked = $SelectedRule.$PropertyName
        }
        If ($SelectedRule.$_ -is [Array]) {
            ($PanelEdit.Controls | ? {($_.gettype()).Name -eq "TextBox" -and $_.Tag -eq $PropertyName}).Text = $SelectedRule.$PropertyName -Join "," 
        }
    }
}
 
#Generated Form Function 
function GenerateForm { 

######################################################################## 
# Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.0.7.0 
# Generated On: 3/2/2010 5:46 PM 
# Generated By: Ravikanth Chaganti (http://www.ravichaganti.com/blog) 
######################################################################## 
 
#region Import the Assemblies 
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null 
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null 
#endregion 
 
#region Generated Form Objects 
$form1 = New-Object System.Windows.Forms.Form 
$HelpLabel = New-Object System.Windows.Forms.LinkLabel 
$label4 = New-Object System.Windows.Forms.Label 
$label3 = New-Object System.Windows.Forms.Label 
$label2 = New-Object System.Windows.Forms.Label 
$button1 = New-Object System.Windows.Forms.Button 
$richTextBox1 = New-Object System.Windows.Forms.RichTextBox 
$treeView1 = New-Object System.Windows.Forms.TreeView 
$treeView2 = New-Object System.Windows.Forms.TreeView 
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState 
$PoolConfigPanel = New-Object Windows.Forms.Panel
#endregion Generated Form Objects 
 
#---------------------------------------------- 
#Generated Event Script Blocks 
#---------------------------------------------- 
#Provide Custom Code for events specified in PrimalForms. 
$button1_OnClick=  
{ 
$form1.Close() 
 
} 

$buttonSave_OnClick=  
{ 
 
} 
 
$OnLoadForm_StateCorrection= 
{
    $ButtonLoadRules.PerformClick()
} 
 
$HelpLabel_OpenLink= 
{ 
    [system.Diagnostics.Process]::start($HelpLabel.Tag) 
} 
#---------------------------------------------- 
#region Generated Form Code 
$form1.Text = "SkullsMinerLite Custom Miners Configuration Editor" 
$SKMLIcon = New-Object system.drawing.icon (".\Includes\SKML.ICO")
$form1.Icon                  = $SKMLIcon
$form1.Name = "form1" 
$form1.DataBindings.DefaultDataSourceUpdateMode = 0 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = 740 
$System_Drawing_Size.Height = 450 
$form1.ClientSize = $System_Drawing_Size 
$form1.TopMost               = $false
$form1.FormBorderStyle       = 'Fixed3D'
$form1.MaximizeBox           = $false

$form1Controls = @()
$PanelEditControls = @()


    # $pictureBoxLogo = new-object Windows.Forms.PictureBox
    # $pictureBoxLogo.Width = 47 #$img.Size.Width
    # $pictureBoxLogo.Height = 47 #$img.Size.Height
    # $pictureBoxLogo.Image = $Logo
    # $pictureBoxLogo.SizeMode = 1
    # $pictureBoxLogo.ImageLocation = $Branding.LogoPath
    # $form1Controls += $pictureBoxLogo
 
 
    #$HelpLabel.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",9,0,3,0) 
    #$System_Drawing_Size = New-Object System.Drawing.Size 
    #$System_Drawing_Size.Width = 100 
    #$System_Drawing_Size.Height = 20 
    #$HelpLabel.Size = $System_Drawing_Size 
    #$HelpLabel.TabIndex = 10 
    #$HelpLabel.Text = "Need help?" 
    #$HelpLabel.Tag = "https://discord.gg/" 
    #$System_Drawing_Point = New-Object System.Drawing.Point 
    #$System_Drawing_Point.X = 0 
    #$System_Drawing_Point.Y = 0 
    #$HelpLabel.Location = $System_Drawing_Point 
    #$HelpLabel.TabStop = $True 
    #$HelpLabel.DataBindings.DefaultDataSourceUpdateMode = 0 
    #$HelpLabel.Name = "HelpLabel" 
    #$HelpLabel.add_click($HelpLabel_OpenLink) 
 
#$form1Controls += $HelpLabel

    $LabelAlgorithm                          = New-Object system.Windows.Forms.Label
    $LabelAlgorithm.text                     = "Algorithm"
    $LabelAlgorithm.AutoSize                 = $false
    $LabelAlgorithm.width                    = 100
    $LabelAlgorithm.height                   = 20
    $LabelAlgorithm.location                 = New-Object System.Drawing.Point(10,40)
    $LabelAlgorithm.Font                     = 'Microsoft Sans Serif,10'
    $PanelEditControls += $LabelAlgorithm

    $TBAlgorithm                          = New-Object system.Windows.Forms.TextBox
    $TBAlgorithm.Tag                      = "Algo"
    $TBAlgorithm.MultiLine                = $False
    # $TBAddress.Scrollbars             = "Vertical" 
    $TBAlgorithm.text                     = ""
    $TBAlgorithm.AutoSize                 = $false
    $TBAlgorithm.width                    = 240
    $TBAlgorithm.height                   = 20
    $TBAlgorithm.location                 = New-Object System.Drawing.Point(112,40)
    $TBAlgorithm.Font                     = 'Microsoft Sans Serif,10'
    # $TBAddress.TextAlign                = "Right"
    $PanelEditControls += $TBAlgorithm

    $LabelPool                          = New-Object system.Windows.Forms.Label
    $LabelPool.text                     = "Pool"
    $LabelPool.AutoSize                 = $false
    $LabelPool.width                    = 100
    $LabelPool.height                   = 20
    $LabelPool.location                 = New-Object System.Drawing.Point(10,62)
    $LabelPool.Font                     = 'Microsoft Sans Serif,10'
    $PanelEditControls += $LabelPool

    $TBPool                          = New-Object system.Windows.Forms.TextBox
    $TBPool.Tag                      = "Pool"
    $TBPool.MultiLine                = $False
    # $TBPool.Scrollbars             = "Vertical" 
    $TBPool.text                     = ""
    $TBPool.AutoSize                 = $false
    $TBPool.width                    = 240
    $TBPool.height                   = 20
    $TBPool.location                 = New-Object System.Drawing.Point(112,62)
    $TBPool.Font                     = 'Microsoft Sans Serif,10'
    # $TBPool.TextAlign                = "Right"
    $PanelEditControls += $TBPool

    $LabelMiner                          = New-Object system.Windows.Forms.Label
    $LabelMiner.text                     = "Miner"
    $LabelMiner.AutoSize                 = $false
    $LabelMiner.width                    = 100
    $LabelMiner.height                   = 20
    $LabelMiner.location                 = New-Object System.Drawing.Point(10,84)
    $LabelMiner.Font                     = 'Microsoft Sans Serif,10'
    $PanelEditControls += $LabelMiner

    $TBMiner                          = New-Object system.Windows.Forms.TextBox
    $TBMiner.Tag                      = "Miner"
    $TBMiner.MultiLine                = $False
    # $TBMiner.Scrollbars             = "Vertical" 
    $TBMiner.text                     = ""
    $TBMiner.AutoSize                 = $false
    $TBMiner.width                    = 240
    $TBMiner.height                   = 20
    $TBMiner.location                 = New-Object System.Drawing.Point(112,84)
    $TBMiner.Font                     = 'Microsoft Sans Serif,10'
    # $TBPool.TextAlign                = "Right"
    $PanelEditControls += $TBMiner
    
    $LabelCoin                          = New-Object system.Windows.Forms.Label
    $LabelCoin.text                     = "Coin"
    $LabelCoin.AutoSize                 = $false
    $LabelCoin.width                    = 100
    $LabelCoin.height                   = 20
    $LabelCoin.location                 = New-Object System.Drawing.Point(10,106)
    $LabelCoin.Font                     = 'Microsoft Sans Serif,10'
    $PanelEditControls += $LabelCoin

    $TBCoin                          = New-Object system.Windows.Forms.TextBox
    $TBCoin.Tag                      = "Coin"
    $TBCoin.MultiLine                = $False
    # $TBCoin.Scrollbars             = "Vertical" 
    $TBCoin.text                     = ""
    $TBCoin.AutoSize                 = $false
    $TBCoin.width                    = 240
    $TBCoin.height                   = 20
    $TBCoin.location                 = New-Object System.Drawing.Point(112,106)
    $TBCoin.Font                     = 'Microsoft Sans Serif,10'
    # $TBCoin.TextAlign                = "Right"
    $PanelEditControls += $TBCoin
    
    $LabelCustomPasswordAdds                          = New-Object system.Windows.Forms.Label
    $LabelCustomPasswordAdds.text                     = "Custom Password additions"
    $LabelCustomPasswordAdds.AutoSize                 = $false
    $LabelCustomPasswordAdds.width                    = 350
    $LabelCustomPasswordAdds.height                   = 20
    $LabelCustomPasswordAdds.location                 = New-Object System.Drawing.Point(10,128)
    $LabelCustomPasswordAdds.Font                     = 'Microsoft Sans Serif,10'
    $PanelEditControls += $LabelCustomPasswordAdds

    $TBCustomPasswordAdds                          = New-Object system.Windows.Forms.TextBox
    $TBCustomPasswordAdds.Tag                      = "CustomPasswordAdds"
    $TBCustomPasswordAdds.MultiLine                = $False
    # $TBCustomPasswordAdds.Scrollbars             = "Vertical" 
    $TBCustomPasswordAdds.text                     = ""
    $TBCustomPasswordAdds.AutoSize                 = $false
    $TBCustomPasswordAdds.width                    = 240
    $TBCustomPasswordAdds.height                   = 20
    $TBCustomPasswordAdds.location                 = New-Object System.Drawing.Point(112,150)
    $TBCustomPasswordAdds.Font                     = 'Microsoft Sans Serif,10'
    # $TBCustomPasswordAdds.TextAlign                = "Right"
    $PanelEditControls += $TBCustomPasswordAdds
    
    $LabelCustomCommandAdds                          = New-Object system.Windows.Forms.Label
    $LabelCustomCommandAdds.text                     = "Custom Command additions"
    $LabelCustomCommandAdds.AutoSize                 = $false
    $LabelCustomCommandAdds.width                    = 350
    $LabelCustomCommandAdds.height                   = 20
    $LabelCustomCommandAdds.location                 = New-Object System.Drawing.Point(10,172)
    $LabelCustomCommandAdds.Font                     = 'Microsoft Sans Serif,10'
    $PanelEditControls += $LabelCustomCommandAdds

    $TBCustomCommandAdds                          = New-Object system.Windows.Forms.TextBox
    $TBCustomCommandAdds.Tag                      = "CustomCommandAdds"
    $TBCustomCommandAdds.MultiLine                = $False
    # $TBCustomCommandAdds.Scrollbars             = "Vertical" 
    $TBCustomCommandAdds.text                     = ""
    $TBCustomCommandAdds.AutoSize                 = $false
    $TBCustomCommandAdds.width                    = 240
    $TBCustomCommandAdds.height                   = 20
    $TBCustomCommandAdds.location                 = New-Object System.Drawing.Point(112,194)
    $TBCustomCommandAdds.Font                     = 'Microsoft Sans Serif,10'
    # $TBCustomCommandAdds.TextAlign                = "Right"
    $PanelEditControls += $TBCustomCommandAdds
    
    $LabelIncludeCoins                          = New-Object system.Windows.Forms.Label
    $LabelIncludeCoins.text                     = "Include Coins"
    $LabelIncludeCoins.AutoSize                 = $false
    $LabelIncludeCoins.width                    = 100
    $LabelIncludeCoins.height                   = 20
    $LabelIncludeCoins.location                 = New-Object System.Drawing.Point(10,218)
    $LabelIncludeCoins.Font                     = 'Microsoft Sans Serif,10'
    $PanelEditControls += $LabelIncludeCoins

    $TBIncludeCoins                          = New-Object system.Windows.Forms.TextBox
    $TBIncludeCoins.Tag                      = "IncludeCoins"
    $TBIncludeCoins.MultiLine                = $False
    # $TBIncludeCoins.Scrollbars             = "Vertical" 
    $TBIncludeCoins.text                     = ""
    $TBIncludeCoins.AutoSize                 = $false
    $TBIncludeCoins.width                    = 240
    $TBIncludeCoins.height                   = 20
    $TBIncludeCoins.location                 = New-Object System.Drawing.Point(112,218)
    $TBIncludeCoins.Font                     = 'Microsoft Sans Serif,10'
    # $TBIncludeCoins.TextAlign                = "Right"
    $PanelEditControls += $TBIncludeCoins
    
    $LabelExcludeCoins                          = New-Object system.Windows.Forms.Label
    $LabelExcludeCoins.text                     = "Exclude Coins"
    $LabelExcludeCoins.AutoSize                 = $false
    $LabelExcludeCoins.width                    = 100
    $LabelExcludeCoins.height                   = 20
    $LabelExcludeCoins.location                 = New-Object System.Drawing.Point(10,240)
    $LabelExcludeCoins.Font                     = 'Microsoft Sans Serif,10'
    $form1Controls += $LabelExcludeCoins

    $TBExcludeCoins                          = New-Object system.Windows.Forms.TextBox
    $TBExcludeCoins.Tag                      = "ExcludeCoins"
    $TBExcludeCoins.MultiLine                = $False
    # $TBExcludeCoins.Scrollbars             = "Vertical" 
    $TBExcludeCoins.text                     = ""
    $TBExcludeCoins.AutoSize                 = $false
    $TBExcludeCoins.width                    = 240
    $TBExcludeCoins.height                   = 20
    $TBExcludeCoins.location                 = New-Object System.Drawing.Point(112,240)
    $TBExcludeCoins.Font                     = 'Microsoft Sans Serif,10'
    # $TBExcludeCoins.TextAlign                = "Right"
    $PanelEditControls += $TBExcludeCoins
    
    $LabelCode                          = New-Object system.Windows.Forms.Label
    $Labelcode.text                     = "Code"
    $Labelcode.AutoSize                 = $false
    $Labelcode.width                    = 100
    $Labelcode.height                   = 20
    $Labelcode.location                 = New-Object System.Drawing.Point(10,262)
    $Labelcode.Font                     = 'Microsoft Sans Serif,10'
    $PanelEditControls += $Labelcode

    $TBcode                          = New-Object system.Windows.Forms.TextBox
    $TBcode.Tag                      = "code"
    $TBcode.MultiLine                = $true
    # $TBcode.Scrollbars             = "Vertical" 
    $TBcode.text                     = ""
    $TBcode.AutoSize                 = $false
    $TBcode.width                    = 240
    $TBcode.height                   = 150
    $TBcode.location                 = New-Object System.Drawing.Point(112,262)
    $TBcode.Font                     = 'Microsoft Sans Serif,10'
    # $TBcode.TextAlign                = "Right"
    $PanelEditControls += $TBcode

    $CheckBoxEnabled                       = New-Object system.Windows.Forms.CheckBox
    $CheckBoxEnabled.Tag                   = "Enabled"
    $CheckBoxEnabled.text                  = "Enabled"
    $CheckBoxEnabled.AutoSize              = $false
    $CheckBoxEnabled.width                 = 140
    $CheckBoxEnabled.height                = 20
    $CheckBoxEnabled.location              = New-Object System.Drawing.Point(10,420)
    $CheckBoxEnabled.Font                  = 'Microsoft Sans Serif,10'
    # $CheckBoxEnabled.Checked               =   $Config.DisableGPU0
    $PanelEditControls += $CheckBoxEnabled

    $ButtonLoadRules                         = New-Object system.Windows.Forms.Button
    $ButtonLoadRules.text                    = "Load rules"
    $ButtonLoadRules.width                   = 85
    $ButtonLoadRules.height                  = 30
    $ButtonLoadRules.location                = New-Object System.Drawing.Point(360,2)
    $ButtonLoadRules.Font                    = 'Microsoft Sans Serif,10'
    $form1Controls += $ButtonLoadRules

    $ButtonLoadRules.Add_Click({
        If (Test-Path ".\Config\MinerCustomConfig.json") {$Script:MinerCustomConfig = Get-Content ".\Config\MinerCustomConfig.json" | ConvertFrom-Json}
        $RulesDGV.DataSource = [System.Collections.ArrayList]@($MinerCustomConfig | Sort enabled,algo,pool,miner,coin -Descending | select enabled,algo,pool,miner,coin)
    })

    $ButtonAddRule                         = New-Object system.Windows.Forms.Button
    $ButtonAddRule.text                    = "Add Rule"
    $ButtonAddRule.width                   = 85
    $ButtonAddRule.height                  = 30
    $ButtonAddRule.location                = New-Object System.Drawing.Point(447,2)
    $ButtonAddRule.Font                    = 'Microsoft Sans Serif,10'
    $form1Controls += $ButtonAddRule

    $ButtonAddRule.Add_Click({
        $NewRule = [PSCustomObject]@{}
        $PanelEditControls | foreach {
            if ($_.gettype().Name -eq "TextBox" -and $_.tag -Notlike "*cludeCoins") {
                $NewRule | Add-Member @{$_.Tag = $_.Text}
            }
            if ($_.gettype().Name -eq "TextBox" -and $_.tag -like "*cludeCoins") {
                $NewRule | Add-Member @{$_.Tag = $_.Text.Split(",")}
            }
            if ($_.gettype().Name -eq "CheckBox") {
                $NewRule | Add-Member @{$_.Tag = $_.Checked}
            }
        }
        
        If (($NewRule | group algo,pool,miner,coin).Name -in ($MinerCustomConfig | group algo,pool,miner,coin).Name) {
            [System.Windows.Forms.MessageBox]::Show("Duplicate rules are not allowed", "Cannot add rule" , "OK", 16)
        } else {
            $MinerCustomConfig = $MinerCustomConfig + $NewRule
            ConvertTo-Json @($MinerCustomConfig) | out-file ".\Config\MinerCustomConfig.json"
            $ButtonLoadRules.PerformClick()
        }
    })

    $ButtonDelRule                         = New-Object system.Windows.Forms.Button
    $ButtonDelRule.text                    = "Delete Rule"
    $ButtonDelRule.width                   = 85
    $ButtonDelRule.height                  = 30
    $ButtonDelRule.location                = New-Object System.Drawing.Point(534,2)
    $ButtonDelRule.Font                    = 'Microsoft Sans Serif,10'
    $form1Controls += $ButtonDelRule

    $ButtonDelRule.Add_Click({
        $Row = $RulesDGV.Rows[$RulesDGV.CurrentRow.Index].DataBoundItem
        $SelectedRule = $MinerCustomConfig | ? { $_.algo -eq $Row.algo -and $_.pool -eq $Row.pool -and $_.miner -eq $Row.miner -and $_.coin -eq $Row.coin }
        If (!$SelectedRule) {
            [System.Windows.Forms.MessageBox]::Show("Rule not found", "Cannot delete rule" , "OK", 16)
        } else {
            $MinerCustomConfig = $MinerCustomConfig | ? { -not ($_.algo -eq $SelectedRule.algo -and $_.pool -eq $SelectedRule.pool -and $_.miner -eq $SelectedRule.miner -and $_.coin -eq $SelectedRule.coin) }
            ConvertTo-Json @($MinerCustomConfig) | out-file ".\Config\MinerCustomConfig.json"
            $ButtonLoadRules.PerformClick()
        }
       
    })

    $ButtonUpdateRule                         = New-Object system.Windows.Forms.Button
    $ButtonUpdateRule.text                    = "Update Rule"
    $ButtonUpdateRule.width                   = 90
    $ButtonUpdateRule.height                  = 30
    $ButtonUpdateRule.location                = New-Object System.Drawing.Point(621,2)
    $ButtonUpdateRule.Font                    = 'Microsoft Sans Serif,10'
    $form1Controls += $ButtonUpdateRule

    $ButtonUpdateRule.Add_Click({
        $ButtonDelRule.PerformClick()
        $ButtonAddRule.PerformClick()
    })

    $PanelEdit = New-Object Windows.Forms.Panel 
    $PanelEdit.Name = "PanelMinerDetails" 
    $System_Drawing_Size = New-Object System.Drawing.Size 
    $System_Drawing_Size.Width = 350
    $System_Drawing_Size.Height = 450
    $System_Drawing_Point = New-Object System.Drawing.Point 
    $System_Drawing_Point.X = 0 
    $System_Drawing_Point.Y = 0
    $PanelEdit.Size = $System_Drawing_Size 
    $PanelEdit.Location = $System_Drawing_Point 
    $PanelEdit.Controls.AddRange($PanelEditControls)
    $form1Controls += $PanelEdit

   
    $RulesDGV                                            = New-Object system.Windows.Forms.DataGridView
    $RulesDGV.width                                      = 360
    # $RulesDGV.height                                     = 305
    # $RulesDGV.height                                     = 170
    $RulesDGV.height                                     = 400
    $RulesDGV.location                                   = New-Object System.Drawing.Point(360,40)
    $RulesDGV.DataBindings.DefaultDataSourceUpdateMode   = 0
    $RulesDGV.AutoSizeColumnsMode                        = "Fill"
    $RulesDGV.RowHeadersVisible                          = $False
    $form1Controls += $RulesDGV
    
    $RulesDGV.Add_CellMouseClick({RulesDGVClick})
    
$form1.controls.AddRange($form1Controls)
 
#endregion Generated Form Code 
 
#Save the initial state of the form 
$InitialFormWindowState = $form1.WindowState 
#Init the OnLoad event to correct the initial state of the form 
$form1.add_Load($OnLoadForm_StateCorrection) 
#Show the Form 
$form1.ShowDialog()| Out-Null 
 
} #End Function 
 
#Call the Function 
GenerateForm
