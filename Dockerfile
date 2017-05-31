FROM alpine

MAINTAINER Bill Harris (https://github.com/SDShooter)

RUN apk update && \
  apk add --update snort openssl ca-certificates wget && \
  update-ca-certificates

  # alpine-sdk linux-headers libpcap-dev libdnet-dev daq-static-dev pcre-dev tcpdump tcpflow cvs bison flex     
  
ENV snortversion=2990
ENV oinkcode=8a5779d51c126491421ae468864f54b468b06e0f

#RUN wget --quiet -O snort.tar.gz https://snort.org/downloads/snort/snort-2.9.9.0.tar.gz && \
#    wget --quiet -O daq.tar.gz https://snort.org/downloads/snort/daq-2.0.6.tar.gz && \
#    mkdir /usr/src/ && \
#   tar -xzf snort.tar.gz -C /usr/src && \
#   tar -xzf daq.tar.gz -C /usr/src && \
   
RUN wget -O snort-rules.tar.gz https://www.snort.org/rules/snortrules-snapshot-$snortversion.tar.gz?oinkcode=$oinkcode && \
	tar -xzf snort-rules.tar.gz -C /etc/snort
	
#cp -rfv /tmp/snort/etc* /etc/snort

#RUN ls -al /etc/snort/
#Copy rules (tar left a mess extracting directly, but snort.config has ..\path references that force the extra /etc folder) 
#RUN cp -rfv /etc/snort/etc/preproc_rules /etc/snort && \
#	cp -rfv /etc/snort/etc/rules /etc/snort && \
#	cp -rfv /etc/snort/etc/so_rules /etc/snort

##link some direcories
RUN ln -sv /usr/lib/snort_dynamicpreprocessor/ /usr/local/lib/ && \   
	ln -s /usr/lib/snort_dynamicengine /usr/local/lib/ && \
	ln -s /usr/lib/snort_dynamicrules /usr/local/lib/ 

#RUN ls -al /usr/lib/snort_dynamicpreprocessor/
#RUN ls -al /usr/local/lib/snort_dynamicpreprocessor/
#RUN ls -al /etc/snort/*

#ls -al /usr/local/lib/snort_dynamicrules/
#RUN find / -name  "snort_dynamicpreprocesso*"
	
RUN ls -al etc/snort/etc
#RUN mv /tmp/snort/
#etc/
#etc/classification.config
#etc/reference.config
#etc/sid-msg.map
#etc/snort.conf
#etc/threshold.conf
#etc/unicode.map
#preproc_rules/
#preproc_rules/decoder.rules
#preproc_rules/preprocessor.rules
#preproc_rules/sensitive-data.rules
 
#RUN wget https://www.snort.org/documents/classification-config && \
# 	mkdir /var/lib/snort/etc && \
#    mv ./classification-config /etc/snort/community-rules/classification.config

#RUN wget https://www.snort.org/documents/reference-config && \
#    mv ./reference-config /etc/snort/community-rules/reference.config

#RUN wget https://github.com/SDShooter/docker-snort-ids/raw/master/rules.tar.gz && \
#	mkdir /etc/snort/rules/ && \
#	tar -xzvf ./rules.tar.gz -C /etc/snort/rules/

#RUN wget https://www.snort.org/downloads/community/community-rules.tar.gz && \	
#tar -xzv ./community-rules.tar.gz -C /etc/snort/rules/ 
#RUN cat /etc/snort/rules/community-rules/community.rules
RUN rm -rf /tmp/* /etc/apk/cache/*
	

  
#Symlink some files
#RUN ln -s /usr/lib/snort_dynamicpreprocessor/ /usr/local/lib/ && \   
#	ln -s /usr/lib/snort_dynamicengine/ /usr/local/lib/ && \
#	ln -s /usr/lib/snort_dynamicrules/ /usr/local/lib/ 

#RUN find / -name  "threshold.*"
#RUN ls -al /var/lib/snort/etc/threshold.config
#RUN ln -s 
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