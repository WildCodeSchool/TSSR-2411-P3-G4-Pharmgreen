
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

if (-not (Get-Module -ListAvailable -Name ImportExcel)) {
    Write-Error "Le module 'ImportExcel' est requis. Installez-le avec : Install-Module -Name ImportExcel"
    exit
}
Import-Module ImportExcel

$excelFilePath = "C:\Users\Administrator\Downloads\s01_Pharmgreen.xlsx"
if (-not (Test-Path $excelFilePath)) {
    Write-Error "Fichier Excel introuvable : $excelFilePath"
    exit
}
$excelData = Import-Excel -Path $excelFilePath

function Get-UniqueAccountName {
    param ([string]$BaseName)
    $UniqueName = $BaseName
    $Index = 1
    while (Get-ADUser -Filter {SamAccountName -eq $UniqueName} -ErrorAction SilentlyContinue) {
        $UniqueName = "$BaseName$($Index)"
        $Index++
    }
    return $UniqueName
}

function Generate-CustomPassword {
    param (
        [string]$FirstName,
        [string]$LastName,
        [string]$BirthDate
    )
    $CleanedBirthDate = $BirthDate -replace '/', ''
    return "$FirstName$LastName$CleanedBirthDate"
}

function Ensure-OU {
    param (
        [string]$OUName,
        [string]$ParentOU
    )
    $FullOUPath = "OU=$OUName,$ParentOU"
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$FullOUPath'" -ErrorAction SilentlyContinue)) {
        try {
            New-ADOrganizationalUnit -Name $OUName -Path $ParentOU -ProtectedFromAccidentalDeletion $true
            return "CRÉÉ : $OUName ($FullOUPath)"
        } catch {
            return "ERREUR : Impossible de créer $OUName ($FullOUPath)"
        }
    } else {
        return "EXISTANT : $OUName ($FullOUPath)"
    }
}

# Interface graphique
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Création Automatique dUtilisateurs AD'
$form.Size = New-Object System.Drawing.Size(900, 500)

# Contrôles GUI
$labelInstructions = New-Object System.Windows.Forms.Label
$labelInstructions.Text = "Cliquez sur 'Démarrer' pour créer les utilisateurs."
$labelInstructions.Location = New-Object System.Drawing.Point(20, 20)
$labelInstructions.Size = New-Object System.Drawing.Size(850, 20)
$form.Controls.Add($labelInstructions)

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(20, 60)
$progressBar.Size = New-Object System.Drawing.Size(850, 20)
$form.Controls.Add($progressBar)

$listBoxUsers = New-Object System.Windows.Forms.ListBox
$listBoxUsers.Location = New-Object System.Drawing.Point(20, 90)
$listBoxUsers.Size = New-Object System.Drawing.Size(850, 150)
$listBoxUsers.DrawMode = [System.Windows.Forms.DrawMode]::OwnerDrawFixed
$form.Controls.Add($listBoxUsers)

$listBoxOUs = New-Object System.Windows.Forms.ListBox
$listBoxOUs.Location = New-Object System.Drawing.Point(20, 250)
$listBoxOUs.Size = New-Object System.Drawing.Size(850, 150)
$listBoxOUs.DrawMode = [System.Windows.Forms.DrawMode]::OwnerDrawFixed
$form.Controls.Add($listBoxOUs)

# Gestion du rendu des couleurs corrigée
$listBoxUsers.add_DrawItem({
    param ($sender, $e)
    if ($e.Index -ge 0) {
        try {
            $item = $listBoxUsers.Items[$e.Index]
            $color = if ($item.StartsWith("SUCCÈS")) { "Green" }
                     elseif ($item.StartsWith("EXISTANT")) { "Blue" }
                     elseif ($item.StartsWith("ERREUR")) { "Red" }
                     else { "Black" }
            
            $e.DrawBackground()
            $bounds = New-Object System.Drawing.RectangleF(
                $e.Bounds.X,
                $e.Bounds.Y,
                $e.Bounds.Width,
                $e.Bounds.Height
            )
            $e.Graphics.DrawString($item, $e.Font, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::$color), $bounds)
            $e.DrawFocusRectangle()
        } catch {
            Write-Host "Erreur de rendu utilisateur : $_"
        }
    }
})

$listBoxOUs.add_DrawItem({
    param ($sender, $e)
    if ($e.Index -ge 0) {
        try {
            $item = $listBoxOUs.Items[$e.Index]
            $color = if ($item.StartsWith("CRÉÉ")) { "Green" }
                     elseif ($item.StartsWith("EXISTANT")) { "Blue" }
                     else { "Black" }
            
            $e.DrawBackground()
            $bounds = New-Object System.Drawing.RectangleF(
                $e.Bounds.X,
                $e.Bounds.Y,
                $e.Bounds.Width,
                $e.Bounds.Height
            )
            $e.Graphics.DrawString($item, $e.Font, [System.Drawing.SolidBrush]::new([System.Drawing.Color]::$color), $bounds)
            $e.DrawFocusRectangle()
        } catch {
            Write-Host "Erreur de rendu OU : $_"
        }
    }
})

# Bouton de démarrage
$buttonStart = New-Object System.Windows.Forms.Button
$buttonStart.Text = 'Démarrer'
$buttonStart.Location = New-Object System.Drawing.Point(400, 420)
$form.Controls.Add($buttonStart)

# Fonction de nettoyage du SamAccountName
function Clean-SamAccountName {
    param (
        [string]$FirstName,
        [string]$LastName
    )

    function Remove-Diacritics {
        param([string]$Text)
        $normalized = $Text.Normalize([System.Text.NormalizationForm]::FormD)
        $sb = [System.Text.StringBuilder]::new()
        foreach ($c in $normalized.ToCharArray()) {
            if ([System.Globalization.CharUnicodeInfo]::GetUnicodeCategory($c) -ne [System.Globalization.UnicodeCategory]::NonSpacingMark) {
                [void]$sb.Append($c)
            }
        }
        $sb.ToString().Normalize([System.Text.NormalizationForm]::FormC)
    }

    $cleanFirstName = Remove-Diacritics $FirstName
    $firstInitial = $cleanFirstName[0].ToString().ToLower()

    $cleanLastName = Remove-Diacritics $LastName -replace '[^a-zA-Z0-9]', '.' -replace '\.+', '.' -replace '^\.|\.$', ''
    $samAccountName = "$firstInitial.$($cleanLastName.ToLower())".Substring(0, [Math]::Min(20, "$firstInitial.$cleanLastName".Length))

    return $samAccountName.TrimEnd('.')
}

# Logique principale
$buttonStart.Add_Click({
    $buttonStart.Enabled = $false
    $totalUsers = $excelData.Count
    $progressBar.Maximum = $totalUsers
    $progressBar.Value = 0

    foreach ($row in $excelData) {
        try {
            # Extraction des données
            $FirstName = $row.Prénom
            $LastName = $row.Nom
            $Societe = $row.Société
            $Site = $row.Site
            $Department = $row.Département
            $Service = $row.Service
            $Fonction = $row.Fonction
            $ManagerPrenom = $row.'Manager - prénom'
            $ManagerNom = $row.'Manager - nom'
            $BirthDate = $row.'Date de naissance'

            # Génération des identifiants
            $FullName = "$FirstName $LastName".Trim()
            $BaseLogonName = Clean-SamAccountName -FirstName $FirstName -LastName $LastName
            $UserLogonName = Get-UniqueAccountName $BaseLogonName
            $Password = Generate-CustomPassword -FirstName $FirstName -LastName $LastName -BirthDate $BirthDate

            # Création de la hiérarchie d'OU
            $RootOUPath = "DC=pharmgreen,DC=intra"
            $currentParent = $RootOUPath
            $ouStructure = @($Societe, $Site, $Department, $Service, $Fonction)

            foreach ($ou in $ouStructure.Where({-not [string]::IsNullOrWhiteSpace($_)})) {
                $log = Ensure-OU -OUName $ou -ParentOU $currentParent
                $listBoxOUs.Items.Add($log) | Out-Null
                $currentParent = "OU=$ou,$currentParent"
            }

            # Configuration de l'utilisateur
            $userParams = @{
                SamAccountName        = $UserLogonName
                UserPrincipalName     = "$UserLogonName@pharmgreen.intra"
                Name                  = $FullName
                GivenName             = $FirstName
                Surname               = $LastName
                DisplayName           = $FullName
                Path                  = $currentParent
                AccountPassword       = (ConvertTo-SecureString $Password -AsPlainText -Force)
                Enabled               = $true
                ChangePasswordAtLogon = $true
                Company               = $Societe
                Office                = $Site
                Department            = $Department
                Title                 = $Fonction
            }

            # Gestion du manager
            if (-not [string]::IsNullOrWhiteSpace($ManagerPrenom) -and -not [string]::IsNullOrWhiteSpace($ManagerNom)) {
                $managerName = "$ManagerPrenom $ManagerNom"
                if ($manager = Get-ADUser -Filter "Name -eq '$managerName'" -ErrorAction SilentlyContinue) {
                    $userParams['Manager'] = $manager.DistinguishedName
                }
            }

            # Création de l'utilisateur
            if (-not (Get-ADUser -Filter "SamAccountName -eq '$UserLogonName'" -ErrorAction SilentlyContinue)) {
                New-ADUser @userParams
                $listBoxUsers.Items.Add("SUCCÈS : $FullName ($UserLogonName)") | Out-Null
            } else {
                $listBoxUsers.Items.Add("EXISTANT : $FullName ($UserLogonName)") | Out-Null
            }

        } catch {
            $errorMessage = $_.Exception.Message
            $listBoxUsers.Items.Add("ERREUR : $FullName - $errorMessage") | Out-Null
        }

        $progressBar.Value++
    }

    [System.Windows.Forms.MessageBox]::Show("Opération terminée !", "Statut", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    $buttonStart.Enabled = $true
})

$form.ShowDialog()
