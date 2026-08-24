#!/bin/sh
CWD=$(pwd)
LOCALIZATION_RELATIVE_PATH="assets/localization"
LOCALIZATION_DIR="$CWD/$LOCALIZATION_RELATIVE_PATH"

# Replace DOC_ID and SHEET_ID if you have another Google sheets url
DOC_ID="1pdHmnwn2Q8P0V-lt1YJSd5PfcTooyChiYSYRZIMJ8fY"
SHEET_ID="1308175285"
DOWNLOAD_URL="https://docs.google.com/spreadsheets/d/$DOC_ID/export?format=csv&gid=$SHEET_ID"
OUTPUT_FILE_NAME="localization.csv"

# Downloading CSV file from URL and saving it to LOCALIZATION_DIR
cd $LOCALIZATION_DIR; curl -L $DOWNLOAD_URL  -o $OUTPUT_FILE_NAME

# Generating ARB files for each language
cd $CWD && dart run arb_generator

# Generating AppLocalizations variables
cd $CWD && flutter gen-l10n