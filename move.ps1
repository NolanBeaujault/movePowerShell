# Définir l'encodage pour UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Add-Type -AssemblyName System.windows.forms

# Fonction pour sélectionner un dossier
Function Select-Folder($description, $defaultPath) {
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = $description
    $folderBrowser.ShowNewFolderButton = $true

    # Vérifier si le chemin par défaut existe et utiliser ce chemin si c'est le cas
    if (Test-Path -Path $defaultPath) {
        $folderBrowser.SelectedPath = $defaultPath
    }

    if ($folderBrowser.ShowDialog() -eq "OK") {
        return $folderBrowser.SelectedPath
    }
    else {
        return $null
    }
}

# Définir le chemin par défaut pour le dossier source
$defaultSourcePath = "path_to_source"
# Sélectionner le dossier source
$cheminSource = Select-Folder "Selectionnez le dossier de depart" $defaultSourcePath
if ($null -eq $cheminSource) {
    Write-Host "Aucun dossier source selectionne."
    exit
}

# Définir le chemin par défaut pour le dossier de destination
$defaultDestinationPath = "path_to_destination"
# Sélectionner le dossier de destination
$cheminDestination = Select-Folder "Selectionnez le dossier de destination" $defaultDestinationPath
if ($null -eq $cheminDestination) {
    Write-Host "Aucun dossier de destination selectionne."
    exit
}

# Copier le dossier
try {
    Copy-Item -Path $cheminSource -Destination $cheminDestination -Recurse -Force
    Write-Host "Le dossier a ete copie de '$cheminSource' vers '$cheminDestination'."
}
catch {
    Write-Host "Une erreur est survenue lors de la copie: $_"
}