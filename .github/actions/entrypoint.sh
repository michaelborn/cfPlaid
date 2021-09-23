#!/bin/sh

# Arguments are passed in from action.yml through the Dockerfile
API_KEY=$1
API_URL=$2
PATH=$3
CONFIDENCE=$4
SEVERITY=$5
AUTOFIX=$6
RESULTFILE=$7
RESULTFORMAT=$8
IGNOREPATHS=$9
FAILONISSUES=$10

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
FIXINATOR_ARGS="path=$PATH confidence=$CONFIDENCE severity=$SEVERITY autofix=$AUTOFIX resultFile=$RESULTFILE resultFormat=$RESULTFORMAT ignorePaths=$IGNOREPATHS failOnIssues=$FAILONISSUES"
box fixinator $FIXINATOR_ARGS