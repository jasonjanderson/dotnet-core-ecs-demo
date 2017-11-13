#### Build Application
# Use Microsoft's .NET SDK container as our build environment
FROM microsoft/dotnet:2.0-sdk AS build-env

# Do our build work in the /app directory inside the build container
WORKDIR /app

# Copy the .csproj file into our working directory and fetch external dependancies (Nuget packages)
COPY *.csproj ./
RUN dotnet restore

# Copy our source code and build into the /app/out directory
COPY . ./
RUN dotnet publish -c Release -o out

#### Package
# Use Microsoft's .NET runtime container as our runtime environment
FROM microsoft/dotnet:2.0-runtime

# Copy the compiled app into our working directory (/app) 
WORKDIR /app
COPY --from=build-env /app/out ./

# Define the command that should run when the runtime container starts up
ENTRYPOINT ["dotnet", "dotnetapp.dll"]