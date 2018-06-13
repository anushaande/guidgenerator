FROM microsoft/windowsservercore:10.0.14393.206
MAINTAINER anushaande24@gmail.com

# docker push alexellisio/msbuild:12.0

SHELL ["powershell"]

# Note: Get MSBuild 12.
RUN Invoke-WebRequest "'https://www.visualstudio.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=15/'" -OutFile "$env:TEMP\vsbuild.exe" -UseBasicParsing
RUN &  "$env:TEMP\vsbuild.exe" /Silent /Full
# Todo: delete the BuildTools_Full.exe file in this layer

# Note: Add .NET + ASP.NET
RUN Install-WindowsFeature NET-Framework-47-ASPNET ; \
    Install-WindowsFeature Web-Asp-Net47

# Note: Add NuGet
RUN Invoke-WebRequest "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" -OutFile "C:\windows\nuget.exe" -UseBasicParsing
WORKDIR "C:\Program Files (x86)\MSBuild\Microsoft\VisualStudio\v14.0"

# Note: Install Web Targets
RUN &  "C:\windows\nuget.exe" Install MSBuild.Microsoft.VisualStudio.Web.targets -Version 14.0.0.3
RUN mv 'C:\Program Files (x86)\MSBuild\Microsoft\VisualStudio\v12.0\MSBuild.Microsoft.VisualStudio.Web.targets.12.0.4\tools\VSToolsPath\*' 'C:\Program Files (x86)\MSBuild\Microsoft\VisualStudio\v12.0\'
# Note: Add Msbuild to path
RUN setx PATH '%PATH%;C:\\Program Files (x86)\\MSBuild\\12.0\\Bin\\msbuild.exe'
CMD ["C:\\Program Files (x86)\\MSBuild\\14.0\\Bin\\msbuild.exe"]
