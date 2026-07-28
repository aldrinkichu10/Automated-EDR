# Read the JSON playload from standard input passed by Wazuh
$inputJson = $input | out-String
if ([string]::IsNullOrWhiteSpace($inputJson)) { exit }

# Parse the JSON to extract the exact file path
$alert = $inputJson | ConvertFrom-Json
$filePath = $alert.parameters.alert.data.virustotal.source.file

# Verify the file exist, delete it, and write to the Wazuh log
if (Test-Path $filePath) {
   Remove-Item -Path $filePath -Force
   $logMessage = "Successfully removed threat: $filePath"
   Add-Content -Path "C:\Program Files (x86)\ossec-agent\active-response\active-responses.log" -Value $logMessage
}