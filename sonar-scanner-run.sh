#!/bin/sh

URL="http://35.163.188.144:9000/"
USER="public"
PASSWORD="public"
SONAR_PROJECT_SETTINGS="sonar-project.properties"
#SONAR_PROJECT_KEY="Test"

if [ -z "$SONAR_PROJECT_KEY" ]; then
  echo "Undefined \"projectKey\"" && exit 1
else
  COMMAND="sonar-scanner -Dsonar.host.url=\"$URL\" -Dsonar.login=\"$USER\" -Dsonar.password=\"$PASSWORD\" -Dsonar.projectKey=\"$SONAR_PROJECT_KEY\" -Dproject.settings=\"$SONAR_PROJECT_SETTINGS\""

  if [ ! -z "$SONAR_PROJECT_VERSION" ]; then
    COMMAND="$COMMAND -Dsonar.projectVersion=\"$SONAR_PROJECT_VERSION\""
  fi

  if [ ! -z "$SONAR_PROJECT_NAME" ]; then
    COMMAND="$COMMAND -Dsonar.projectName=\"$SONAR_PROJECT_NAME\""
  fi
  if [ ! -z $CI_BUILD_REF ]; then
    COMMAND="$COMMAND -Dsonar.gitlab.commit_sha=\"$CI_BUILD_REF\""
  fi
  if [ ! -z $CI_BUILD_REF_NAME ]; then
    COMMAND="$COMMAND -Dsonar.gitlab.ref_name=\"$CI_BUILD_REF_NAME\""
  fi
  if [ ! -z $SONAR_BRANCH ]; then
    COMMAND="$COMMAND -Dsonar.branch=\"$SONAR_BRANCH\""
  fi
  if [ ! -z $SONAR_ANALYSIS_MODE ]; then
    COMMAND="$COMMAND -Dsonar.analysis.mode=\"$SONAR_ANALYSIS_MODE\""
    if [ $SONAR_ANALYSIS_MODE="preview" ]; then
      COMMAND="$COMMAND -Dsonar.issuesReport.console.enable=true"
    fi
  fi

  eval $COMMAND
fi

