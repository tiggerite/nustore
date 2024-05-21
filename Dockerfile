FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine as builder

COPY ./NuStore /NuStore
COPY ./NuStore.sln /NuStore.sln
COPY ./nuget.config /nuget.config

WORKDIR /
RUN dotnet build -c Release

FROM builder as packager

RUN mkdir /package
WORKDIR /
RUN dotnet pack -o /package -c Release -p:IncludeSymbols=true -p:SymbolPackageFormat=snupkg NuStore/NuStore.csproj

WORKDIR /package
CMD dotnet nuget push --skip-duplicate --source github '*.nupkg'