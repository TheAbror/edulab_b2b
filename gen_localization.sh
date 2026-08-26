#!/bin/sh
CWD=$(pwd)

# Generating ARB files from local translation assets (assets/translations/*.json)
cd $CWD && dart run tool/generate_arb.dart

# Generating AppLocalizations variables
cd $CWD && flutter gen-l10n
