#!/bin/bash

DEBUG="${DEBUG}"
if [[ ! -z "${DEBUG}" ]]
then
  set -x
fi

source ~/.bash_profile

tree /root/.dotnet/tools

PROJECT_KEY="${PROJECT_KEY:-ConsoleApplication1}"
PROJECT_NAME="${PROJECT_NAME:-ConsoleApplication1}"
PROJECT_VERSION="${PROJECT_VERSION:-1.0}"
SONAR_HOST="${HOST:-http://localhost:9000}"
SONAR_LOGIN_KEY="${LOGIN_KEY:-admin}"
SONAR_LOGIN_USER="${LOGIN_USER}"
SONAR_LOGIN_PASSWORD="${LOGIN_PASSWORD}"
SONAR_DOTNET_FRAMEWORK="${SONAR_DOTNET_FRAMEWORK}"
DOTNET_SOLUTION_DIR="${DOTNET_SOLUTION_DIR}"
DOTNET_TEST_DIR="${DOTNET_TEST_DIR}"

if [[ ! -z "$LOGIN_KEY" ]]
then
  dotnet sonarscanner begin /d:sonar.host.url=$SONAR_HOST /d:sonar.login="$SONAR_LOGIN_KEY" /k:$PROJECT_KEY /n:"$PROJECT_NAME" /v:$PROJECT_VERSION
else
  dotnet sonarscanner begin /d:sonar.host.url=$SONAR_HOST /d:sonar.login="$SONAR_LOGIN_USER" /d:sonar.password="$SONAR_LOGIN_PASSWORD" /k:$PROJECT_KEY /n:"$PROJECT_NAME" /v:$PROJECT_VERSION
fi

dotnet restore ${DOTNET_SOLUTION_DIR}

if [[ ! -z "$DOTNET_TEST_DIR" ]]
then
  dotnet test ${DOTNET_TEST_DIR} --no-build
fi

dotnet build ${DOTNET_SOLUTION_DIR}

if [[ ! -z "$LOGIN_KEY" ]]
then
  dotnet sonarscanner end /d:sonar.login="$SONAR_LOGIN_KEY"
else
  dotnet sonarscanner end /d:sonar.login="$SONAR_LOGIN_USER" /d:sonar.password="$SONAR_LOGIN_PASSWORD"
fi
