FROM alpine

MAINTAINER Bill Harris (https://github.com/SDShooter)

RUN apk update && \
  apk add --no-cache snort && \
  apk add --no-cache ca-certificates wget && \             
  update-ca-certificates && \   
  apk add --no-cache --update openssl
  
RUN wget https://www.snort.org/rules/community && \                                                                                                                                                                                                          
  tar -xzvf ./community -C /etc/snort && \
  rm -f /tmp/* /etc/apk/cache/* ./community
  
ENTRYPOINT ["snort"]
CMD ["-v -b -c /etc/snort/snort.conf"]
#