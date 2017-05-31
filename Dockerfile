FROM alpine

MAINTAINER Bill Harris (https://github.com/SDShooter)

RUN apk update && \
  apk add --update snort openssl ca-certificates wget && \
  update-ca-certificates
  
ENV snortversion=2990
#Oink code is no longer valid, but hoping it will serve non-licensed files
ENV oinkcode=8a5779d51c126491421ae468864f54b468b06e0f
   
RUN wget -O snort-rules.tar.gz https://www.snort.org/rules/snortrules-snapshot-$snortversion.tar.gz?oinkcode=$oinkcode && \
	tar -xzf snort-rules.tar.gz -C /etc/snort

##link some direcories
RUN ln -sv /usr/lib/snort_dynamicpreprocessor/ /usr/local/lib/ && \   
	ln -s /usr/lib/snort_dynamicengine /usr/local/lib/ && \
	ln -s /usr/lib/snort_dynamicrules /usr/local/lib/ 

	
#RUN ls -al /etc/snort/*
#ls -al /usr/local/lib/snort_dynamicrules/
#RUN find / -name  "snort_dynamicpreprocesso*"
	

ENTRYPOINT ["snort"]
CMD ["--help"]