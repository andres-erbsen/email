# email, my way

This is a dump of the mostly-reusable bits of my email setup. All mail is
downloaded first, then spam filtering and search indexing and are performed
locally. Mail can be read and composed (but not sent) while operating without an
internet connection.  The configuration uses one program per task, so it is
completely plausible that one might want to mimic only parts of this. To explain
how all of this works, let's follow the path of an incoming message and a reply
to it.

1. `imap-idle.sh` notices that a new message has arrived to the server-side
   mailbox.
2. `mbsync` downloads the mail over IMAP and stores it to maildir `~/mail/account@remote.server`
3. `notmuch` indexes the new mail for searching
4. `notmuch-hooks-post-new` process the mail:
	- `bogofilter` is used to tag each message as "bogospam" or "bogoham"
	- messages in muted threads bypass inbox
5. The user reads the mail using `emacs -f notmuch`
	- `a` to hide from inbox as "ham"
	- `k` to hide from inbox as "ham" and mute the thread
	- `s` to hide from inbox as "spam"
6. The user composes a reply (`r`), a new message in emacs (`m`) or a message from the command line `echo hi | msmtp -a default to@example.com`
7. `msmtp` hands the outgoing mail over to the corresponding SMTP relay

In addition, the user may choose to perform these two tasks at any time:

- edit and then execute `.notmuch-queries.sh` to change the categories displayed
  by `emacs -f notmuch`
- run `.notmuch-spam.sh` to re-train `bogofilter` based on the "spam" and "ham"
  tags

All dependencies of this setup are available in Arch Linux official repositories.

To set up this email flow, one would probably use `.mbsyncrc` and `.mbsyncrc` as
templates, replacing most of their content with actual account information. To
configure `notmuch`, just run `notmuch` and follow the instructions; however the
following options are required for this setup to work nicely.

	[new]
	tags=new;unread;inbox;
	ignore=.offlineimap;.git;.mbsyncstate;.uidvalidity

The remaining files are annotated with "SETUP" in places where they most likely
need editing, so run `grep -C3 SETUP *` in this directory and change what you
feel needs changing. As usual, refer to the `man` pages of the tools in
question as appropriate.

One would probably want to automatically run `imap-idle.sh account@exampl.com`
for all accounts while internet connectivity is present, and stop it when not.
This script has not been tested with intermittent internet connectivity -- in
particular, if you start the script, then lose and regain internet connectivity,
you have reached uncharted territory -- I have no idea whether the script would
keep working.

Alternatively, to bulk-download mail from all accounts in parallel, the
following command can be used: `cat ~/.mbsyncrc | grep '^Channel' | cut -d' '
-f2 | xargs -n1 -P99 mbsync -q ; notmuch new`
