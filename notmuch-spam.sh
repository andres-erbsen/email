#!/bin/sh
set -euo pipefail
rm -rf .bogofilter

notmuch search --output=threads -- \
	"tag:ham or `#SETUP` (from:andres.erbsen or from:andreser) or (query:P and from:mit.edu)" \
	| xargs -n100 notmuch search --output=files -- \
	| bogofilter -bn

notmuch search --output=files -- \
	"tag:spam" \
	| bogofilter -bs
