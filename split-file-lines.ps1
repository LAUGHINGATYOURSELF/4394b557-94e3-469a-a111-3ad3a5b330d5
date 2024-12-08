# Set-ExecutionPolicy RemoteSigned

$inputFilePath = ".\wow-sounds-community-listfile.txt"
$outputDirectory = ".\wow-sounds-community-listfile\"
$linesPerFile = 12000

if (-not (Test-Path -Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory
}
$content = Get-Content -Path $inputFilePath
$totalLines = $content.Count

$fileCount = [math]::Ceiling($totalLines / $linesPerFile)
echo "$($inputFilePath)`nTOTAL LINES:$($totalLines)/$($linesPerFile), FILES:$($fileCount)"
for ($index = 0; $index -lt $fileCount; $index++) {
    $startLine = $index * $linesPerFile
    $lines = $content[$startLine..([math]::Min($startLine + $linesPerFile - 1, $totalLines - 1))]

    # Construct the new file name
    $newFileName = "$($index + 1).txt"
    $newFilePath = Join-Path -Path $outputDirectory -ChildPath $newFileName

    # Write the lines to the new file
    $lines | Set-Content -Path $newFilePath
}

# Set-ExecutionPolicy Restricted