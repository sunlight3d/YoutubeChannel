# Use the .NET Core SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the csproj file to the working directory
COPY testapp/*.csproj ./

# Restore NuGet packages
RUN dotnet restore

# Copy the entire source code to the working directory
COPY testapp/ .

# Build the app
RUN dotnet build -c Release -o out

# Stage 2: Create a runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

WORKDIR /app

# Copy the built files from the previous stage
COPY --from=build /app/out ./

# Define the port the app will listen on
EXPOSE 5000

# Start the app when the container runs
ENTRYPOINT ["dotnet", "testapp.dll"]
