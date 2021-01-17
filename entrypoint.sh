#!/usr/bin/env bash

# --- Parse Options ---

LATEX_MAIN_FILE="${1}"
WORKING_DIRECTORY="${2}"
LATEX_COMPILER="${3}"
LATEX_COMPILER_ARGUMENTS="${4}"
SYSTEM_PACKAGES="${5}"
PRE_TASK="${6}"
POST_TASK="${7}"

# --- Print Options ---
echo ""
echo "Displaying set options:"
echo "LATEX_MAIN_FILE: $LATEX_MAIN_FILE"
echo "WORKING_DIRECTORY: $WORKING_DIRECTORY"
echo "LATEX_COMPILER: $LATEX_COMPILER"
echo "LATEX_COMPILER_ARGUMENTS: $LATEX_COMPILER_ARGUMENTS"
echo "SYSTEM_PACKAGES: $SYSTEM_PACKAGES"
echo "PRE_TASK: $PRE_TASK"
echo "POST_TASK: $POST_TASK"

# --- Check Options ---
if [ -z "$LATEX_MAIN_FILE" ]; then
    echo "No main file option was set (or is empty)!"
    exit 1
fi

if [ -z "$LATEX_COMPILER" ]; then
    echo "The set LaTeX compiler is empty!"
    exit 1
fi

# --- Install packages ---
if [ ! -z "$SYSTEM_PACKAGES" ]; then
    pacman -Sy
    pacman -S --noconfirm "$SYSTEM_PACKAGES"
    if [ $? -ne 0 ]; then
        echo "Failed installing system packages!"
        echo "Check the package names and if they exist in Arch (not AUR!)."
        exit 1
    fi
fi

# --- Pre Task ---
if [ ! -z "$PRE_TASK" ]; then 
    eval "$PRE_TASK"
fi

# --- Compile Document ---
if [ ! -z "$WORKING_DIRECTORY" ]; then
    cd "$WORKING_DIRECTORY"
fi

eval "$LATEX_COMPILER $LATEX_COMPILER_ARGUMENTS $LATEX_MAIN_FILE"

# --- Post Task ---
if [ ! -z "$POST_TASK" ]; then 
    eval "$POST_TASK"
fi
