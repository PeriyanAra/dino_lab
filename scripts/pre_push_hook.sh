#!/bin/sh

print_results() {
    echo '\n'
    printf "\e[33;1m%s\e[0m\n" '========================================'

    if [[ $FORMAT_EXIT_CODE -ne 0 ]]; then
        printf "\e[0;32m%s\e[0m\n" 'format: some files have been formatted'
    fi

    if [[ $ANALYZE_EXIT_CODE -ne 0 ]]; then
        printf "\e[0;31m%s\e[0m\n" 'analyze: failed'
    fi

    if [[ $TESTS_EXIT_CODE -ne 0 ]]; then
        printf "\e[0;31m%s\e[0m\n" 'tests: failed'
    fi

    printf "\e[33;1m%s\e[0m\n" '========================================'
}

pop_stash_files () {
    if [ -n "$hasChanges" ]; then
        printf "\e[33;1m%s\e[0m\n" '=== Applying git stash changes ==='
        git stash pop
    fi
}

# Stash unstaged files
hasChanges=$(git diff)
if [ -n "$hasChanges" ]; then
    printf "\e[33;1m%s\e[0m\n" 'Stashing unstaged changes'
    git stash push --keep-index
fi

printf "\e[33;1m%s\e[0m\n" 'Running: flutter format'
find . -not -path './.git/*' -not -path '*/.dart_tool/*' -name "*.dart" ! -name "*.g.dart" ! -name "*_test.dart" ! -name '*.swagger.*' ! -name '*.config.dart' ! -name '*.chopper.dart' ! -name '*.freezed.dart' ! -name '*.gr.dart' | tr '\n' ' ' | xargs fvm flutter format --line-length=100 --set-exit-if-changed
FORMAT_EXIT_CODE=$?

printf "\e[33;1m%s\e[0m\n" 'Running: flutter analyze'
fvm flutter analyze .
ANALYZE_EXIT_CODE=$?

printf "\e[33;1m%s\e[0m\n" 'Running: flutter test'
fvm flutter test && fvm flutter test packages
TESTS_EXIT_CODE=$?

pop_stash_files

if [[ $TESTS_EXIT_CODE -ne 0 || $FORMAT_EXIT_CODE -ne 0 || $ANALYZE_EXIT_CODE -ne 0 ]]
then
    print_results
    exit 1
else
    echo "No errors detected."
fi

exit 0
