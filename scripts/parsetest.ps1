$path = '/mnt/c/Users/sebastian/.zcode/workspace/default/AA-AssessM365Status.ps1'
try {
    [scriptblock]::Create((Get-Content -Raw $path)) | Out-Null
    'PARSE OK'
} catch {
    'PARSE FAIL: ' + $_.Exception.Message
}