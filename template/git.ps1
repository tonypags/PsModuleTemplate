
# <%=$PLASTER_PARAM_GitRepoUri%>

# Delete this file before commit
Remove-Item git.ps1 -confirm:$false -ea 0 -Force

$brName = '<%=$PLASTER_PARAM_DefaultGitBranchName%>'
$repoUri = '<%=$PLASTER_PARAM_GitRepoUri%>'
git init --initial-branch $brName

if ($repoUri -match ':.*?\/') {
    git remote add origin $repoUri
    git fetch
    git add .
    git commit -m "Initial commit (scaffold)"
    git push origin --all
}
