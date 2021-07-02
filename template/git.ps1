
# <%=$PLASTER_PARAM_GitRepoUri%>

Set-Location $env:USERPROFILE
Set-Location Documents
Set-Location WindowsPowerShell
Set-Location Modules
Set-Location "<%=$PLASTER_PARAM_Name%>"

git init -b <%=$PLASTER_PARAM_DefaultGitBranchName%>
git remote add origin <%=$PLASTER_PARAM_GitRepoUri%>
git fetch
git add .
git commit -m "Initial commit (scaffold)"
git push origin --all
