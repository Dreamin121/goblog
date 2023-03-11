@echo off

set /p message="Enter commit message: "

git add . 
git commit -m "%message%" 
git push -f

echo Pushed to remote repository.