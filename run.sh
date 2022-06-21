#!/bin/sh

BIN=${ECHIDNA:-echidna-test}

$BIN . --contract T --test-mode assertion --test-limit 10
