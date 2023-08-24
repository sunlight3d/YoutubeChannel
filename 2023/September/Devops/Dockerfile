# Use the .NET Core SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY testapp/*.csproj ./testapp/
RUN dotnet restore

# copy everything else and build app
COPY testapp/. ./testapp/
WORKDIR /source/testapp
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app ./

# Define the port the app will listen on
EXPOSE 5000
ENTRYPOINT ["dotnet", "testapp.dll"]
