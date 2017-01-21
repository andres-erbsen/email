#!/bin/sh
set -eu

notmuch config set query.mention #SETUP
notmuch config set query.action '(action ADJ required) or (action ADJ requested)'
notmuch config set query.urgent 'subject:urgent'
notmuch config set query.responsibilities 'to:pika-important or to:iso-broadcast or to:dename or to:yfncc or (from:anneh and not to:eecs-jobs-announce@csail.mit.edu) or from:lindasul'
notmuch config set query._P1 'query:urgent or query:action or query:responsibilities'

#begin_categories
notmuch config set query.P0 'query:mention and query:_P1'
notmuch config set query.P1 'query:_P1 and not query:P0'
notmuch config set query.P2 'query:mention and not query:P1 or query:classes'
notmuch config set query.P 'query:P0 or query:P1 or query:P2'

#SETUP
#SETUP
notmuch config set query.6805 "6.805 or 6805 or remoteinfra"
notmuch config set query.6854 "6.854 or 6854 or to:6854-students or to:6854-staff"
notmuch config set query.6035 "6.035 or 6035 or lambda-cabal"
notmuch config set query.classes "query:6805 or query:6035 or query:6854"

notmuch config set query.social #SETUP

notmuch config set query.pika 'not tag:bogospam and (to:pika-important or to:in-house-pikans or to:pika-private or to:pika-summer or to:pika-commie or to:pika-food or to:nutso-flaming-pikans or to:pika-alum-talk or to:pika-social or from:yfnkm or from:yfncc or from:yfnhm or from:yfnht or from:ailg-sli-help or to:pika-big-cooks)'
notmuch config set query.ailg-it 'to:ailg-it'
notmuch config set query.sipb 'not tag:bogospam and (to:sipb or to:cluedump or to:athena-outages or to:xvm-announce)'
notmuch config set query.fiat-crypto 'to:mit.edu and to:fiat-crypto'
notmuch config set query.plv 'to:mit.edu and (to:plv or to:fiat) and not query:fiat-crypto'
notmuch config set query.pdos 'to:mit.edu and to:pdos'
notmuch config set query.coq 'to:coqdev or to:coq-club'
notmuch config set query.sport 'to:locksport or to:chaus or to:ork or to:ork-friend or to:communist-party or to:pi-17'
notmuch config set query.icare 'to:icare@mit.edu'
notmuch config set query.voodoo 'not tag:bogospam and to:voodoo'
notmuch config set query.github 'from:github.com'
notmuch config set query.random 'to:r-h-t or to:random-hall or to:black-hole or to:black-hole-singularity or to:peckerites or to:clam-hole or to:let-me-in'
notmuch config set query.ec "to:ec-discuss or to:im-having-a-personal-problem or to:tetazoo"
notmuch config set query.et "to:not-coffee or to:et-social or to:et-rush-chair"
notmuch config set query.libreboot "to:libreboot"
notmuch config set query.estobuntu "to:estobuntu.org"
notmuch config set query.talk "to:seminars@csail.mit.edu or to:seminars@lists.csail.mit.edu or to:calendar@csail.mit.edu"
notmuch config set query.arch-mirrors 'to:arch-mirrors'
notmuch config set query.csail "to:csail-related or to csail-all or to:csail-announce"
notmuch config set query.reuse "subject:reuse"
notmuch config set query.jiu-jitsu "to:jiu-jitsu"
notmuch config set query.eecs-jobs-announce "to:eecs-jobs-announce"
notmuch config set query.piazza "from:piazza.com"
notmuch config set query.undergrads "to:undergrads@mit.edu"
notmuch config set query.dormspam "to:mtg-announce or (to:exec and to:mit.edu) or to:peerears or to:pokemonmasters@mit.edu or to:wmbr-media@mit.edu or subject:audition or from:2017class@mit.edu or (subject:amphibious and subject:achievement) or to:firestorm@mit.edu or to:apo-pubdir or to:dynamit_chatter or to:ea-announce or to:mit-democrats-admin or to:2017class"
notmuch config set query.olympiaadid "to:olympiaadid@lists.ut.ee"
notmuch config set query.mailman "mailman.mit.edu and to:owner and to:mit.edu"
notmuch config set query.noise "to:noise@moderncrypto.org"
notmuch config set query.messaging "to:messaging@moderncrypto.org"
notmuch config set query.curves "to:curves@moderncrypto.org"
#SETUP

notmuch config set query.bogospam 'tag:bogospam'
#end_categories

categories="$(< $0 grep -A9999 begin_categories | grep -m1 -B99999 end_categories | grep -v '^#' |  cut -d' ' -f4 | grep . | tr '.' ':' | grep -v '^query:_')"
notmuch config set query.categorized "$(echo "$categories" | tr '\n' ' ' | sed 's/ / or /g' | sed 's/ or $//g')"
notmuch config set query.other "not query:categorized"

# generate emacs config
(
echo "(setq notmuch-saved-searches
	  '("
for c in $categories query:other
do
	name=$(echo "$c" | cut -d: -f2)
	echo "		(:name \"$name\" :query \"tag:inbox and $c\")"
done
echo "		))"
) > ~/.notmuch-queries.el
