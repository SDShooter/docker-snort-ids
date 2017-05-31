FROM alpine

MAINTAINER Bill Harris (https://github.com/SDShooter)
##link some direcories to prepare for running with subscriber/registered user profile.
##TO use, take the public rules from snort.org (register to access) and extract them to /etc/snort.. Then run the container with -c ./etc/snort/etc/snort.conf 

RUN apk update && \
  apk add --update snort openssl ca-certificates wget && \
  update-ca-certificates
   
#RUN wget -O snort-rules.tar.gz https://www.snort.org/rules/snortrules-snapshot-$snortversion.tar.gz?oinkcode=$oinkcode && \
#RUN wget -O snort-rules.tar.gz https://www.snort.org/rules/community.tar.gz && \
#	tar -xzf snort-rules.tar.gz -C /etc/snort

RUN ln -sv /usr/lib/snort_dynamicpreprocessor/ /usr/local/lib/ && \   
	ln -s /usr/lib/snort_dynamicengine /usr/local/lib/ && \
	ln -s /usr/lib/snort_dynamicrules /usr/local/lib/ 

	
#RUN ls -al /etc/snort/*
#ls -al /usr/local/lib/snort_dynamicrules/
#RUN find / -name  "snort_dynamicpreprocesso*"
	

ENTRYPOINT ["snort"]
CMD ["--help"]