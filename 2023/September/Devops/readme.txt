dotnet tool install --global dotnet-ef
dotnet tool update --global dotnet-ef

dotnet new webapi -n dotnetcore-api-crud

cd dotnetcore-api-crud
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package AspNetCore.HealthChecks.UI.Client
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.AspNetCore.OpenApi
dotnet add package Microsoft.AspNetCore.Cors
dotnet add package Microsoft.Extensions.Diagnostics.HealthChecks
dotnet add package Microsoft.AspNetCore.Diagnostics.HealthChecks
dotnet add package Microsoft.Extensions.Diagnostics.HealthChecks.Abstractions
dotnet add package Bogus

dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet run

dotnet ef migrations add CreateTables
dotnet ef database update  

docker build -t docker.io/sunlight4d/dotnetcoreapi:1.0 .

docker rm -f aspnetcoreapi
docker run --name aspnetcoreapi -p 5005:80 -d docker.io/sunlight4d/dotnetcoreapi:1.0


docker rm -f sqlserver2022
docker rm -f sqlserver2017
docker rm -f aspnetcoreapi
docker rmi -f dotnetcore-api-crud-aspnetcoreapi  
docker rmi -f sunlight4d/dotnetcoreapi  
docker-compose -f ./deployment.yml down 
docker-compose -f ./deployment.yml up -d
