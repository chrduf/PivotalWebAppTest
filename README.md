# PivotalWebAppTest

This projects pupose is to explore pushing a ASP.NET Core 2.0 application to Pivotal Cloud Foundry.

The application was created using the ASP.NET Core 2.0 MVC template. 

Two methods of deployment are possible with .NETCore

- **Framework-dependent deployment.** As the name implies, framework-dependent deployment (FDD) relies on the presence of a shared system-wide version of .NET Core on the target system. Because .NET Core is already present, your app is also portable between installations of .NET Core. Your app contains only its own code and any third-party dependencies that are outside of the .NET Core libraries. FDDs contain .dll files that can be launched by using the dotnet utility from the command line. 
- **Self-contained deployment.** Unlike FDD, a self-contained deployment (SCD) doesn't rely on the presence of shared components on the target system. All components, including both the .NET Core libraries and the .NET Core runtime, are included with the application and are isolated from other .NET Core applications.

## Scenario 1 - Self-Contained ASP.NETCore2.0 deployment targeting Windows2012R2

**Buildpack:** [HWC Buildpack](https://github.com/cloudfoundry/hwc-buildpack/releases) v2.3.2 (March 15, 2017)

**Stack:** Windows2012R2

**Status:** Working

- Open a command prompt at the root of the website. \PivotalWebAppTest\PivotalWebAppTest
- Delete previous publish

```
rmdir /s /q .\bin\publish-windows-sc
```
- Publish the application

```
dotnet publish -f netcoreapp2.0 -r win10-x64 -o %CD%\bin\publish-windows-sc --self-contained true
```

- Push the application

```
cf push -f manifest-windows-sc.yml -p .\bin\publish-windows-sc
```

## Scenario 2 - Self-Contained ASP.NETCore2.0 deployment targeting cflinuxfs2

**Buildpack:** [Dotnet Core Buildpack](https://github.com/cloudfoundry/dotnet-core-buildpack/releases) v1.0.13 (March 15, 2017)

**Stack:** cflinuxfs2

**Status:** Working

- Open a command prompt at the root of the website. \PivotalWebAppTest\PivotalWebAppTest
- Delete previous publish

```
rmdir /s /q .\bin\publish-linux-sc
```
- Publish the application

```
dotnet publish -f netcoreapp2.0 -r ubuntu-x64 -o %CD%\bin\publish-linux-sc --self-contained true
```

- Push the application

```
cf push -f manifest-linux-sc.yml -p .\bin\publish-linux-sc
```


## Scenario 3 - Framework-Dependent ASP.NETCore2.0 deployment targeting Windows2012R2

**Buildpack:** [HWC Buildpack](https://github.com/cloudfoundry/hwc-buildpack/releases) v2.3.2 (March 15, 2017)

**Stack:** Windows2012R2

**Status:** Failed

- Open a command prompt at the root of the website. \PivotalWebAppTest\PivotalWebAppTest
- Delete previous publish

```
rmdir /s /q .\bin\publish-windows-fd
```
- Publish the application

```
dotnet publish -f netcoreapp2.0 -r win10-x64 -o %CD%\bin\publish-windows-fd --self-contained false
```

- Push the application

```
cf push -f manifest-windows-fd.yml -p .\bin\publish-windows-fd
```

CF error log:

```
   2017-09-15T16:01:36.79-0400 [API/0] OUT Created app with guid 1dd0b33d-0086-44e2-8a07-637df3512fd3
   2017-09-15T16:01:38.75-0400 [API/0] OUT Updated app with guid 1dd0b33d-0086-44e2-8a07-637df3512fd3 ({"route"=>"60162e75-76b7-447b-8698-6f287b5f3b09", :verb=>"add", :relation=>"routes", :related_guid=>"60162e75-76b7-447b-8698-6f287b5f3b09"})
   2017-09-15T16:01:50.26-0400 [STG/0] OUT Downloading hwc_buildpack...
   2017-09-15T16:01:50.27-0400 [STG/0] OUT Creating container
   2017-09-15T16:01:50.27-0400 [STG/0] OUT Downloaded hwc_buildpack
   2017-09-15T16:01:50.55-0400 [API/0] OUT Updated app with guid 1dd0b33d-0086-44e2-8a07-637df3512fd3 ({"state"=>"STARTED"})
   2017-09-15T16:01:53.00-0400 [STG/0] OUT Successfully created container
   2017-09-15T16:01:53.00-0400 [STG/0] OUT Downloading app package...
   2017-09-15T16:01:53.65-0400 [STG/0] OUT Downloaded app package (2.9M)
   2017-09-15T16:01:53.65-0400 [STG/0] OUT Staging...
   2017-09-15T16:01:53.83-0400 [STG/0] OUT -----> Hwc Buildpack version 2.3.2
   2017-09-15T16:01:53.83-0400 [STG/0] OUT        HWC version 1.0.1
   2017-09-15T16:01:53.83-0400 [STG/0] OUT        Copy [C:\containerizer\49979D0C8416D3E589\user\tmp\buildpacks\A95F05F0C1EAEB333ACDACC5A27DD328\dependencies\https___buildpacks.cloudfoundry.org_dependencies_hwc_hwc-1.0.1-windows-amd64-2f9df10f.zip]
   2017-09-15T16:01:53.83-0400 [STG/0] OUT -----> Installing HWC
   2017-09-15T16:01:53.83-0400 [STG/0] OUT        to [C:\Windows\TEMP\downloads312181999\archive]
   2017-09-15T16:01:54.77-0400 [STG/0] OUT Uploading droplet...
   2017-09-15T16:01:54.77-0400 [STG/0] OUT Uploading build artifacts cache...
   2017-09-15T16:01:54.77-0400 [STG/0] OUT Staging complete
   2017-09-15T16:01:54.77-0400 [STG/0] OUT Exit status 0
   2017-09-15T16:01:54.77-0400 [STG/0] OUT Uploading droplet, build artifacts cache...
   2017-09-15T16:01:54.82-0400 [STG/0] OUT Uploaded build artifacts cache (169B)
   2017-09-15T16:01:56.08-0400 [STG/0] OUT Uploading complete
   2017-09-15T16:01:56.08-0400 [STG/0] OUT Uploaded droplet (3.1M)
   2017-09-15T16:01:56.11-0400 [STG/0] OUT Destroying container
   2017-09-15T16:01:56.43-0400 [STG/0] OUT Successfully destroyed container
   2017-09-15T16:01:56.57-0400 [CELL/0] OUT Creating container
   2017-09-15T16:01:59.37-0400 [CELL/0] OUT Successfully created container
   2017-09-15T16:02:00.12-0400 [APP/PROC/WEB/0] OUT Running cmd /c .\\PivotalWebAppTest --server.urls http://*:%PORT%
   2017-09-15T16:02:00.12-0400 [APP/PROC/WEB/0] ERR '.\\PivotalWebAppTest' is not recognized as an internal or external command,
   2017-09-15T16:02:00.12-0400 [APP/PROC/WEB/0] ERR operable program or batch file.
   2017-09-15T16:02:00.13-0400 [APP/PROC/WEB/0] OUT Exit status 1
   2017-09-15T16:02:00.82-0400 [CELL/0] OUT Exit status -26
   2017-09-15T16:02:00.87-0400 [CELL/0] OUT Destroying container
   2017-09-15T16:02:01.26-0400 [API/0] OUT Process has crashed with type: "web"
   2017-09-15T16:02:01.28-0400 [CELL/0] OUT Successfully destroyed container
   2017-09-15T16:02:01.31-0400 [API/0] OUT App instance exited with guid 1dd0b33d-0086-44e2-8a07-637df3512fd3 payload: {"instance"=>"", "index"=>0, "reason"=>"CRASHED", "exit_description"=>"2 error(s) occurred:\n\n* Exited with status 1\n* cancelled", "crash_count"=>1, "crash_timestamp"=>1505505721189270850, "version"=>"3f73c4fd-e2bb-44b5-9661-5b3444c2bd8b"}
   2017-09-15T16:02:02.85-0400 [CELL/0] OUT Creating container
   2017-09-15T16:02:05.71-0400 [CELL/0] OUT Successfully created container
   2017-09-15T16:02:06.62-0400 [APP/PROC/WEB/0] OUT Running cmd /c .\\PivotalWebAppTest --server.urls http://*:%PORT%
   2017-09-15T16:02:06.63-0400 [APP/PROC/WEB/0] ERR operable program or batch file.
   2017-09-15T16:02:06.63-0400 [APP/PROC/WEB/0] ERR '.\\PivotalWebAppTest' is not recognized as an internal or external command,
   2017-09-15T16:02:07.39-0400 [CELL/0] OUT Creating container
   2017-09-15T16:02:07.54-0400 [APP/PROC/WEB/0] OUT Exit status 1
   2017-09-15T16:02:07.74-0400 [API/0] OUT Process has crashed with type: "web"
   2017-09-15T16:02:07.76-0400 [API/0] OUT App instance exited with guid 1dd0b33d-0086-44e2-8a07-637df3512fd3 payload: {"instance"=>"", "index"=>0, "reason"=>"CRASHED", "exit_description"=>"2 error(s) occurred:\n\n* Exited with status 1\n* cancelled", "crash_count"=>2, "crash_timestamp"=>1505505727665173427, "version"=>"3f73c4fd-e2bb-44b5-9661-5b3444c2bd8b"}
   2017-09-15T16:02:09.19-0400 [CELL/0] OUT Exit status -26
   2017-09-15T16:02:09.24-0400 [CELL/0] OUT Destroying container
   2017-09-15T16:02:09.70-0400 [CELL/0] OUT Successfully destroyed container
   2017-09-15T16:02:10.08-0400 [CELL/0] OUT Successfully created container
   2017-09-15T16:02:11.61-0400 [APP/PROC/WEB/0] OUT Running cmd /c .\\PivotalWebAppTest --server.urls http://*:%PORT%
   2017-09-15T16:02:11.62-0400 [APP/PROC/WEB/0] ERR '.\\PivotalWebAppTest' is not recognized as an internal or external command,
   2017-09-15T16:02:11.62-0400 [APP/PROC/WEB/0] ERR operable program or batch file.
   2017-09-15T16:02:11.62-0400 [APP/PROC/WEB/0] OUT Exit status 1
   2017-09-15T16:02:11.76-0400 [CELL/0] OUT Exit status -26
   2017-09-15T16:02:11.78-0400 [CELL/0] OUT Destroying container
   2017-09-15T16:02:12.17-0400 [API/0] OUT Process has crashed with type: "web"
   2017-09-15T16:02:12.19-0400 [API/0] OUT App instance exited with guid 1dd0b33d-0086-44e2-8a07-637df3512fd3 payload: {"instance"=>"", "index"=>0, "reason"=>"CRASHED", "exit_description"=>"2 error(s) occurred:\n\n* Exited with status 1\n* cancelled", "crash_count"=>3, "crash_timestamp"=>1505505732131668223, "version"=>"3f73c4fd-e2bb-44b5-9661-5b3444c2bd8b"}
   2017-09-15T16:02:12.45-0400 [CELL/0] OUT Successfully destroyed container
   2017-09-15T16:03:03.78-0400 [CELL/0] OUT Creating container
   2017-09-15T16:03:06.72-0400 [CELL/0] OUT Successfully created container
   2017-09-15T16:03:07.52-0400 [APP/PROC/WEB/0] OUT Running cmd /c .\\PivotalWebAppTest --server.urls http://*:%PORT%
   2017-09-15T16:03:07.53-0400 [APP/PROC/WEB/0] ERR '.\\PivotalWebAppTest' is not recognized as an internal or external command,
   2017-09-15T16:03:07.53-0400 [APP/PROC/WEB/0] ERR operable program or batch file.
   2017-09-15T16:03:07.53-0400 [APP/PROC/WEB/0] OUT Exit status 1
   2017-09-15T16:03:08.67-0400 [CELL/0] OUT Exit status -26
   2017-09-15T16:03:08.69-0400 [CELL/0] OUT Destroying container
   2017-09-15T16:03:09.08-0400 [API/0] OUT Process has crashed with type: "web"
   2017-09-15T16:03:09.10-0400 [API/0] OUT App instance exited with guid 1dd0b33d-0086-44e2-8a07-637df3512fd3 payload: {"instance"=>"", "index"=>0, "reason"=>"CRASHED", "exit_description"=>"2 error(s) occurred:\n\n* Exited with status 1\n* cancelled", "crash_count"=>4, "crash_timestamp"=>1505505789044614382, "version"=>"3f73c4fd-e2bb-44b5-9661-5b3444c2bd8b"}
   2017-09-15T16:03:09.13-0400 [CELL/0] OUT Successfully destroyed container
```

## Scenario 4 - Framework-Dependent ASP.NETCore2.0 deployment targeting cflinuxfs2

**Buildpack:** [Dotnet Core Buildpack](https://github.com/cloudfoundry/dotnet-core-buildpack/releases) v1.0.13 (March 15, 2017)

**Stack:** cflinuxfs2

**Status:** Failed

- Open a command prompt at the root of the website. \PivotalWebAppTest\PivotalWebAppTest
- Delete previous publish

```
rmdir /s /q .\bin\publish-linux-fd
```
- Publish the application

```
dotnet publish -f netcoreapp2.0 -r ubuntu-x64 -o %CD%\bin\publish-linux-fd --self-contained false
```

- Push the application

```
cf push -f manifest-linux-fd.yml -p .\bin\publish-linux-fd
```

CF error log:

```
   2017-09-15T16:12:31.78-0400 [API/0] OUT Created app with guid 99921f33-97ba-456d-8800-24b54495cc87
   2017-09-15T16:12:33.70-0400 [API/0] OUT Updated app with guid 99921f33-97ba-456d-8800-24b54495cc87 ({"route"=>"1eb1917e-ef80-4c15-8482-ad3afb2c61ff", :verb=>"add", :relation=>"routes", :related_guid=>"1eb1917e-ef80-4c15-8482-ad3afb2c61ff"})
   2017-09-15T16:12:44.81-0400 [API/0] OUT Updated app with guid 99921f33-97ba-456d-8800-24b54495cc87 ({"state"=>"STARTED"})
   2017-09-15T16:12:44.87-0400 [STG/0] OUT Downloading dotnet_core_buildpack...
   2017-09-15T16:12:44.87-0400 [STG/0] OUT Downloaded dotnet_core_buildpack
   2017-09-15T16:12:44.87-0400 [STG/0] OUT Creating container
   2017-09-15T16:12:45.17-0400 [STG/0] OUT Successfully created container
   2017-09-15T16:12:45.17-0400 [STG/0] OUT Downloading app package...
   2017-09-15T16:12:45.34-0400 [STG/0] OUT Downloaded app package (2.9M)
   2017-09-15T16:12:45.34-0400 [STG/0] OUT Staging...
   2017-09-15T16:12:45.53-0400 [STG/0] OUT -----> Buildpack version 1.0.13
   2017-09-15T16:12:45.60-0400 [STG/0] OUT ASP.NET Core buildpack version: 1.0.13
   2017-09-15T16:12:45.60-0400 [STG/0] OUT ASP.NET Core buildpack starting compile
   2017-09-15T16:12:45.60-0400 [STG/0] OUT -----> Restoring files from buildpack cache
   2017-09-15T16:12:45.60-0400 [STG/0] OUT        OK
   2017-09-15T16:12:45.60-0400 [STG/0] OUT -----> Restoring NuGet packages cache
   2017-09-15T16:12:45.60-0400 [STG/0] OUT        OK
   2017-09-15T16:12:45.60-0400 [STG/0] OUT -----> Extracting libunwind
   2017-09-15T16:12:45.60-0400 [STG/0] OUT        libunwind version: 1.2
   2017-09-15T16:12:45.70-0400 [STG/0] OUT        file:///tmp/buildpacks/f04af8bc88cb8dcb13879b37e1aef9af/dependencies/https___buildpacks.cloudfoundry.org_dependencies_manual-binaries_dotnet_libunwind-1.2-linux-x64-f56347d4.tgz
   2017-09-15T16:12:45.82-0400 [STG/0] OUT        OK
   2017-09-15T16:12:45.82-0400 [STG/0] OUT -----> Installing .NET SDK
   2017-09-15T16:12:45.89-0400 [STG/0] OUT        .NET SDK version: 1.0.1
   2017-09-15T16:12:46.39-0400 [STG/0] OUT        file:///tmp/buildpacks/f04af8bc88cb8dcb13879b37e1aef9af/dependencies/https___buildpacks.cloudfoundry.org_dependencies_dotnet_dotnet.1.0.1.linux-amd64-99324ccc.tar.gz
   2017-09-15T16:12:49.11-0400 [STG/0] OUT        OK
   2017-09-15T16:12:49.11-0400 [STG/0] OUT        Detected .NET Core runtime version 2.0.0 in /tmp/app/PivotalWebAppTest.runtimeconfig.json
   2017-09-15T16:12:49.11-0400 [STG/0] OUT -----> Installing required .NET Core runtime(s)
   2017-09-15T16:12:49.11-0400 [STG/0] OUT        Downloading and installing .NET Core runtime 2.0.0
   2017-09-15T16:12:49.20-0400 [STG/0] OUT        DEPENDENCY_MISSING_IN_MANIFEST: dotnet-framework.2.0.0.linux-amd64.tar.gz
   2017-09-15T16:12:49.21-0400 [STG/0] OUT        FAILED: command failed, exit status 1
   2017-09-15T16:12:49.21-0400 [STG/0] OUT        FAILED: Installing required .NET Core runtime(s) failed, command failed, exit status 1
   2017-09-15T16:12:49.21-0400 [STG/0] ERR Failed to compile droplet
   2017-09-15T16:12:49.21-0400 [STG/0] OUT Exit status 223
   2017-09-15T16:12:49.22-0400 [STG/0] ERR Staging failed: Exited with status 223
   2017-09-15T16:12:49.24-0400 [STG/0] OUT Destroying container
   2017-09-15T16:12:52.07-0400 [STG/0] OUT Successfully destroyed container
```




