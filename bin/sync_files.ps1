# https://github.com/WhyAskWhy/automated-tickets-dev

# Purpose: Sync files over from host to test VM

$target_vm = "Ubuntu-16.04"

$base_dir = 'T:\github\automated-tickets-dev'

$return_path = $pwd

$path_mappings = @{

    "$base_dir\bin" = '/home/ubuntu/Desktop/'

}

# http://stackoverflow.com/questions/9015138/powershell-looping-through-a-hash-or-using-an-array
foreach ($d in $path_mappings.GetEnumerator()) {

    Set-Location $d.Name
    Write-Output "`nCopying files from $($base_dir) to VM $($target_vm):"
    Get-ChildItem | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object {
        $file_source_path = "$($pwd)\$($_.Name)"
        $file_destination_path = $d.Value
        Write-Output "* $($_.Name)"
        Copy-VMFile $target_vm -SourcePath $file_source_path -DestinationPath $file_destination_path -CreateFullPath -FileSource Host -Force
    }
}

Set-Location $return_path
