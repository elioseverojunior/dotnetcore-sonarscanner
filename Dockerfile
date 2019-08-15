#FROM mcr.microsoft.com/dotnet/core/sdk:2.2-alpine3.9
FROM mcr.microsoft.com/dotnet/core/sdk:2.2

LABEL maintaner="Elio Severo Junior <elioseverojunior@gmail.com>"

ENV DOTNET_SDK_VERSION=2.2 \
    DOTNET_PROJECT_DIR=/project \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true \
    DOTNET_CLI_TELEMETRY_OPTOUT=true \
    DOTNET_SOLUTION_DIR="" \
    DOTNET_TEST_DIR=""

RUN dotnet tool install --global dotnet-sonarscanner --version 4.6.2
RUN dotnet tool install --global GitVersion.Tool --version 5.0.0 
# \ 
#   && echo "alias gitversion=\"/root/.dotnet/tools/dotnet-gitversion\"" >> ~/.bash_profile
# RUN /bin/bash -c "source ~/.bash_profile"

ENV PATH="PATH=$PATH:/root/.dotnet/tools:${PATH}"

COPY run.sh /usr/bin/sonnar
RUN chmod u=+x /usr/bin/sonnar

VOLUME $DOTNET_PROJECT_DIR
WORKDIR $DOTNET_PROJECT_DIR

ENTRYPOINT ["sonnar"]
