# docker-snort-ids

This installation expects to use the snort subscriber rule set. Before you can use this image, 
you need to download and extract the latest snort rules/configuration to your host system, make any changes as required/desired.

This gives you control of your configuration with the minor inconvenience of not being able to update automatically.  I'm not sure how
automatic updates would even work, since the update includes snort.conf, which doesn't work out of the box and even if it did. 
it would revert any changes you have made.

<b>Run snort in IDS mode</b>
docker run -v //c/snort/etc:/etc/snort/etc -v //c/snort/rules:/etc/snort/rules --network=host fd90 -b -c /etc/snort/etc/snort.conf


Currently the 2990 subscriber rules required the following changes to work: 

 File: snort-rules-2990.tar.gz/etc/snort.conf
   1)  Workaround: Comment a couple things that aren't installed.  It looks like 'deflate' is not installed/available   
   #     decompress_swf { deflate lzma } 
   #    decompress_pdf { deflate }
   # remove \ from the line before these statements, as there is no longer a continuation line

   2) Temporary fix required: search for 'black' and ensure all references to /rules/blacklist.rules are consistently spelled.
   (currently has mixed references where some lines refer to black_list.rules)

File: /rules/whitelist.rules 
Create this empty file.. Or add things to it as you please.

