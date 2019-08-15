FROM mcr.microsoft.com/dotnet/core/sdk:2.2

LABEL maintaner="Elio Severo Junior <elioseverojunior@gmail.com>"

ENV DOTNET_SDK_VERSION=2.2 \
    DOTNET_HOME=/root/.dotnet \
    DOTNET_PROJECT_DIR=/project \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true \
    DOTNET_CLI_TELEMETRY_OPTOUT=true \
    SONAR_DOTNET_FRAMEWORK="" \
    DOTNET_SOLUTION_DIR="" \
    SONAR_BRANCH_NAME="" \
    SONAR_TARGET_BRANCH_NAME="" \
    DOTNET_TEST_DIR=""

RUN dotnet tool install --global dotnet-sonarscanner --version 4.6.2
RUN dotnet tool install --global GitVersion.Tool

ENV PATH="PATH=$PATH:${DOTNET_HOME}:${DOTNET_HOME}/tools:${PATH}"

COPY run.sh /usr/bin/sonarscanner
RUN chmod u=+x /usr/bin/sonarscanner

VOLUME $DOTNET_PROJECT_DIR

WORKDIR $DOTNET_PROJECT_DIR

ENTRYPOINT ["sonarscanner"]
