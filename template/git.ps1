
# <%=$PLASTER_PARAM_GitRepoUri%>

# Tell Plaster where the modules are located
$ModulesPath = Get-ModulesPath
Set-Location $ModulesPath

$brName = '<%=$PLASTER_PARAM_DefaultGitBranchName%>'
$repoUri = '<%=$PLASTER_PARAM_GitRepoUri%>'
git init $brName
git remote add origin $repoUri
git fetch
git add .
git commit -m "Initial commit (scaffold)"
git push origin --all
