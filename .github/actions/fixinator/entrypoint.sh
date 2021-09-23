#!/bin/sh

# Arguments are passed in from action.yml through the Dockerfile
API_KEY=$1
API_URL=$2
FIXINATOR_PATH=$3
FIXINATOR_CONFIDENCE=$4
FIXINATOR_SEVERITY=$5
FIXINATOR_AUTOFIX=$6
FIXINATOR_RESULTFILE=$7
FIXINATOR_RESULTFORMAT=$8
FIXINATOR_IGNOREPATHS=$9
FIXINATOR_FAILONISSUES="${10}"

###
# CONFIGURATION
# Since Fixinator uses underscores in its module configuration, we can't do this with a simple env var substitution.
###
CONFIG_SETTINGS="modules.fixinator.api_key=$API_KEY"
if [[ -n $API_URL ]]; then
    CONFIG_SETTINGS="$CONFIG_SETTINGS modules.fixinator.api_key=$API_URL"
fi
box config set $CONFIG_SETTINGS

###
# RUN IT
###
FIXINATOR_ARGS="path=$FIXINATOR_PATH confidence=$FIXINATOR_CONFIDENCE \
    severity=$FIXINATOR_SEVERITY autofix=$FIXINATOR_AUTOFIX resultFile=$FIXINATOR_RESULTFILE \
    resultFormat=$FIXINATOR_RESULTFORMAT ignorePaths=$FIXINATOR_IGNOREPATHS \
    failOnIssues=$FIXINATOR_FAILONISSUES"
box fixinator $FIXINATOR_ARGS