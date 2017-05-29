FROM alpine

MAINTAINER Bill Harris (https://github.com/SDShooter)

RUN apk update && \
  apk add --no-cache snort && \
  apk add --no-cache ca-certificates wget && \             
  update-ca-certificates && \   
  apk add --no-cache --update openssl

RUN wget https://www.snort.org/rules/community && \                                                                                                                                                                                                          
  tar -xzvf ./community -C /etc/snort

RUN wget https://www.snort.org/documents/classification-config && \
 	mkdir /var/lib/snort/etc && \
    mv ./classification-config /etc/snort/community-rules/classification.config

RUN wget https://www.snort.org/documents/reference-config && \
    mv ./reference-config /etc/snort/community-rules/reference.config

RUN wget https://www.snort.org/downloads/community/community-rules.tar.gz && \
	mkdir /etc/snort/rules/ && \
	tar -xzvf ./community-rules.tar.gz -C /etc/snort/rules/ 
RUN cat /etc/snort/rules/community-rules/community.rules
RUN rm -f /tmp/* /etc/apk/cache/* ./community ./community-rules.tar.gz
	
#RUN find / -name  "browser-chrome.rules"
  
#Symlink some files
RUN ln -s /usr/lib/snort_dynamicpreprocessor/ /usr/local/lib/ && \   
	ln -s /usr/lib/snort_dynamicengine/ /usr/local/lib/ && \
	ln -s /usr/lib/snort_dynamicrules/ /usr/local/lib/ && \
	mkdir ./etc/snort/rules && \
#	touch /etc/snort/rules/local.rules && \
#	touch /etc/snort/rules/app-detect.rules && \
#	touch /etc/snort/rules/attack-responses.rules && \
#	touch /etc/snort/rules/backdoor.rules && \
#	touch /etc/snort/rules/bad-traffic.rules && \
#	touch /etc/snort/rules/blacklist.rules && \
#	touch /etc/snort/rules/botnet-cnc.rules && \
# 	touch /etc/snort/rules/browser-chrome.rules && \
#	touch /etc/snort/rules/browser-firefox.rules && \
#	touch /etc/snort/rules/browser-ie.rules && \
#	touch /etc/snort/rules/browser-other.rules && \
#	touch /etc/snort/rules/browser-plugings.rules

#RUN ls -al /etc/snort/community-rules/../rules
#RUN ln
#RUN ls -al /var/lib/snort/
#/etc/snort/reference.config -> /var/lib/snort/etc/reference.config

#etc/snort/community-rules/classification.config requested
#/etc/snort/community-rules/classification.config is a symlink pointing to /var/lib/snort/etc/classification.config
#/etc/snort/classification.config is a symlink to /var/lib/snort/etc/classification.config (which doesn't yet exist)
#/etc/snort/classification.config the real file
#RUN cat /etc/snort/community-rules/classification.config
#RUN cat /etc/snort/community-rules/snort.conf
#RUN ls -al /etc/snort/

ENTRYPOINT ["snort"]
CMD ["--help"]