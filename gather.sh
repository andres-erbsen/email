#!/bin/sh
set -euo pipefail

cp ~/imap-idle.sh imap-idle.sh
cp ~/.mbsyncrc mbsyncrc
cp ~/mail/.notmuch/hooks/post-new notmuch-hooks-post-new
sed 's/`#PRIVATE`.*/#SETUP/' < ~/.notmuch-queries.sh > notmuch-queries.sh
cp ~/.emacs emacs
cp ~/.msmtprc msmtprc

cp ~/.notmuch-spam.sh notmuch-spam.sh
cp ~/.gnupg/gpg.conf gpg.conf
