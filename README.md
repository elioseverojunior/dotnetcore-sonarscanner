# .Net Core Sonar Scanner on Docker Container

Sonar Scanner MsBuild Dockerfile for .Net Core Projects

[![Docker Pulls](https://img.shields.io/docker/pulls/elioseverojunior/dotnetcore-sonarscanner.svg)](https://hub.docker.com/r/elioseverojunior/dotnetcore-sonarscanner/) [![Docker Automated build](https://img.shields.io/docker/automated/elioseverojunior/dotnetcore-sonarscanner.svg)](https://hub.docker.com/r/elioseverojunior/dotnetcore-sonarscanner/) [![Docker Build Status](https://img.shields.io/docker/build/elioseverojunior/dotnetcore-sonarscanner.svg)](https://hub.docker.com/r/elioseverojunior/dotnetcore-sonarscanner/)

## This Image Using

|                                     | Name          | Version       |
| ------------------------------------|:-------------:| -------------:|
| OS                                  | Debian        |   Stretch (9) |
| .NET SDK                            | .NET Core SDK | 2.2 (2.2.401) |
| Sonar Scanner    (DotNet Core Tool) | CLI           |         4.6.2 |
| Git Version Tool (DotNet Core Tool) | CLI           |         5.0.1 |

Please check [Releases Page](https://github.com/elioseverojunior/dotnetcore-sonarscanner/releases) for details.

## Latest Versions

[Latest Debian](https://www.debian.org/releases/stable/)
[Latest .Net SDK](https://www.microsoft.com/net/download/all)
[Latest Sonar Scanner](https://www.nuget.org/packages/dotnet-sonarscanner)
[Latest Git Version](https://www.nuget.org/packages/dotnet-gitversion)

## Using Example

First of all you need a sonarqube server. If you haven't one, run this code;

```
docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube
```

And then you need .Net Core project. If you haven't one, run this codes;

```
mkdir ConsoleApplication1
cd ConsoleApplication1

dotnet new console
dotnet new sln
dotnet sln ConsoleApplication1.sln add ConsoleApplication1.csproj
```

Take login token from sonarqube server, change working directory to project directory and run this code;

```
docker run --name dotnet-scanner -it --rm -v $(pwd):/project \
  -e PROJECT_KEY=ConsoleApplication1 \
  -e PROJECT_NAME=ConsoleApplication1 \
  -e PROJECT_VERSION=1.0 \
  -e HOST=http://localhost:9000 \
  -e LOGIN_KEY=CHANGE_THIS_ONE \
  elioseverojunior/dotnetcore-sonarscanner
```

If you are using login and password on sonarqube:

```
docker run --name dotnet-scanner -it --rm -v $(pwd):/project \
  -e PROJECT_KEY=ConsoleApplication1 \
  -e PROJECT_NAME=ConsoleApplication1 \
  -e PROJECT_VERSION=1.0 \
  -e HOST=http://localhost:9000 \
  -e LOGIN_USER="admin" \
  -e LOGIN_PASSWORD="admin" \
  elioseverojunior/dotnetcore-sonarscanner
```

To turn on debug and see the environment variables passed to docker DEBUG=1:
```
docker run --name dotnet-scanner -it --rm -v $(pwd):/project \
  -e PROJECT_KEY=ConsoleApplication1 \
  -e PROJECT_NAME=ConsoleApplication1 \
  -e PROJECT_VERSION=1.0 \
  -e HOST=http://localhost:9000 \
  -e LOGIN_USER="admin" \
  -e LOGIN_PASSWORD="admin" \
  -e DEBUG=1 \
  elioseverojunior/dotnetcore-sonarscanner
```


Note: If you have sonarqube as docker container, you must inspect sonarqube's bridge network IP address and use it in HOST variable.

```
docker network inspect bridge
```