#!/bin/sh

dotnet build -c Release
dotnet pack -c Release -o ./bin/publish/console --force -v d
