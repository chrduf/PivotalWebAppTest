:: This needs to be run from the application root

:: Scenario 1 - Self-Contained ASP.NETCore2.0 deployment targeting Windows2012R2
rmdir /s /q .\bin\publish-windows-sc
dotnet publish -f netcoreapp2.0 -r win10-x64 -o %CD%\bin\publish-windows-sc --self-contained true
cf push -f manifest-windows-sc.yml -p .\bin\publish-windows-sc

:: Scenario 2 - Self-Contained ASP.NETCore2.0 deployment targeting cflinuxfs2
rmdir /s /q .\bin\publish-linux-sc
dotnet publish -f netcoreapp2.0 -r ubuntu-x64 -o %CD%\bin\publish-linux-sc --self-contained true
cf push -f manifest-linux-sc.yml -p .\bin\publish-linux-sc

:: Scenario 3 - Framework-Dependent ASP.NETCore2.0 deployment targeting Windows2012R2 
rmdir /s /q .\bin\publish-windows-fd
dotnet publish -f netcoreapp2.0 -r win10-x64 -o %CD%\bin\publish-windows-fd --self-contained false
cf push -f manifest-windows-fd.yml -p .\bin\publish-windows-fd

:: Scenario 4 - Framework-Dependent ASP.NETCore2.0 deployment targeting cflinuxfs2
rmdir /s /q .\bin\publish-linux-fd
dotnet publish -f netcoreapp2.0 -r ubuntu-x64 -o %CD%\bin\publish-linux-fd --self-contained false
cf push -f manifest-linux-fd.yml -p .\bin\publish-linux-fd
