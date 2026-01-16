#!/bin/sh
# ----------------------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Apache Maven Wrapper startup batch script, version 3.3.2
#
# Required ENV vars:
# ------------------
#   JAVA_HOME - location of a JDK home dir
#
# Optional ENV vars
# -----------------
#   MAVEN_OPTS - parameters passed to the Java VM when running Maven
#     e.g. to debug Maven itself, use
#       set MAVEN_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8000
#   MAVEN_SKIP_RC - flag to disable loading of mavenrc files
# ----------------------------------------------------------------------------

if [ -z "$MAVEN_SKIP_RC" ]; then

    if [ -f /usr/local/etc/mavenrc ]; then
        . /usr/local/etc/mavenrc
    fi

    if [ -f /etc/mavenrc ]; then
        . /etc/mavenrc
    fi

    if [ -f "$HOME/.mavenrc" ]; then
        . "$HOME/.mavenrc"
    fi

fi

# OS specific support.  $var _must_ be set to either true or false.
cygwin=false
darwin=false
mingw=false
case "$(uname)" in
    CYGWIN*) cygwin=true ;;
    MINGW*) mingw=true ;;
    Darwin*) darwin=true
        # Use /usr/libexec/java_home if available, otherwise fall back to /Library/Java/Home
        if [ -z "$JAVA_HOME" ]; then
            if [ -x "/usr/libexec/java_home" ]; then
                JAVA_HOME="$(/usr/libexec/java_home)"; export JAVA_HOME
            else
                JAVA_HOME="/Library/Java/Home"; export JAVA_HOME
            fi
        fi
        ;;
esac

if [ -z "$JAVA_HOME" ]; then
    if [ -r /etc/gentoo-release ]; then
        JAVA_HOME=$(java-config --jre-home)
    fi
fi

# traverses directory structure from process work directory to filesystem root
# first directory with .mvn subdirectory is considered project base directory
find_maven_basedir() {
    if [ -z "$1" ]; then
        echo "Path not specified to find_maven_basedir"
        return 1
    fi

    basedir="$1"
    wdir="$1"
    while [ "$wdir" != '/' ]; do
        if [ -d "$wdir"/.mvn ]; then
            basedir=$wdir
            break
        fi
        # workaround for JBEAP-8937 (on Solaris 10/Sparc)
        if [ -d "${wdir)}/.mvn" ]; then
            basedir=${wdir}
            break
        fi
        wdir=$(cd "$wdir/.." || exit 1; pwd)
    done
    printf '%s' "$basedir"
}

abs_path() {
    # shellcheck disable=SC2164
    (cd "$(dirname "$1")" && printf '%s/%s' "$(pwd)" "$(basename "$1")")
}

MAVEN_PROJECTBASEDIR="$(find_maven_basedir "$(pwd)")"
MAVEN_WRAPPERJAR="$MAVEN_PROJECTBASEDIR/.mvn/wrapper/maven-wrapper.jar"

if [ -z "$MAVEN_OPTS" ]; then
    MAVEN_OPTS="-Xmx512m"
fi

# For Cygwin, switch paths to Windows format before running java
if $cygwin; then
    [ -n "$JAVA_HOME" ] &&
        JAVA_HOME=$(cygpath --path --windows "$JAVA_HOME")
    [ -n "$CLASSPATH" ] &&
        CLASSPATH=$(cygpath --path --windows "$CLASSPATH")
    [ -n "$MAVEN_PROJECTBASEDIR" ] &&
        MAVEN_PROJECTBASEDIR=$(cygpath --path --windows "$MAVEN_PROJECTBASEDIR")
fi

# Provide a "standardized" way to retrieve the CLI args that will
# work with both Windows and non-Windows executions.
MAVEN_CMD_LINE_ARGS="$*"
export MAVEN_CMD_LINE_ARGS

WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain

# shellcheck disable=SC2086
exec "$JAVA_HOME/bin/java" \
    $MAVEN_OPTS \
    $MAVEN_DEBUG_OPTS \
    -classpath "$MAVEN_WRAPPERJAR" \
    "-Dmaven.multiModuleProjectDirectory=$MAVEN_PROJECTBASEDIR" \
    $WRAPPER_LAUNCHER "$@"
