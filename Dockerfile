FROM neo4j
#FROM neo4j:3.5.1-enterprise

#RUN apk --no-cache add --update bash curl tini
#RUN apk --no-cache add --update make

#COPY downloads/plugins/apoc-3.5.0.1-all.jar plugins/
#COPY downloads/plugins/graph-algorithms-algo-3.5.1.0.jar plugins/
#COPY downloads/plugins/graphaware-audit-3.5.1.52.2-SNAPSHOT.jar plugins/
#COPY downloads/plugins/graphaware-neo4j-to-elasticsearch-3.5.1.53.11.jar plugins/
#COPY downloads/plugins/graphaware-nlp-3.5.1.53.17-SNAPSHOT.jar plugins/
#COPY downloads/plugins/graphaware-nlp-enterprise-3.5.1.53.17-SNAPSHOT.jar plugins/
#COPY downloads/plugins/graphaware-server-enterprise-all-3.5.1.53.jar plugins/
#COPY downloads/plugins/graphaware-uuid-3.5.1.53.17.jar plugins/
#COPY downloads/plugins/nlp-stanfordnlp-3.5.1.53.17-SNAPSHOT.jar plugins/
#COPY downloads/plugins/nlp-stanfordnlp-ee-3.5.1.53.17-SNAPSHOT.jar plugins/
#COPY downloads/plugins/stanford-english-corenlp-2018-10-05-models.jar plugins/

#RUN rm -f /var/lib/neo4j/lib/slf4j-nop-1.7.25.jar
#COPY downloads/lib/slf4j-simple-1.7.25.jar lib/

#COPY custom.conf /

#COPY healthcheck.sh /
#RUN chmod +x /healthcheck.sh

#COPY init /init
#RUN chmod +x /init/deploy.sh

#RUN cat /docker-entrypoint.sh > /docker-entrypoint-upstream.sh
#COPY docker-entrypoint.sh /
#RUN chmod +x /docker-entrypoint*.sh
#ENTRYPOINT ["tini", "-v", "-g", "--", "/docker-entrypoint.sh"]

CMD ["neo4j"]



