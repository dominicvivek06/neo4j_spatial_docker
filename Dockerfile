FROM alpine:latest
WORKDIR /tmp
ADD https://s3-eu-west-1.amazonaws.com/com.neo4j.graphalgorithms.dist/graph-data-science/neo4j-graph-data-science-1.1.6-standalone.zip /tmp
RUN unzip neo4j-graph-data-science-1.1.6-standalone.zip


FROM neo4j:3.5-enterprise
ENV NEO4J_ACCEPT_LICENSE_AGREEMENT=yes \
    NEO4J_HOME="/var/lib/neo4j"
    
ADD https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/3.5.0.13/apoc-3.5.0.13-all.jar "${NEO4J_HOME}"/plugins
ADD https://github.com/neo4j-contrib/spatial/releases/download/0.26.2-neo4j-3.5.2/neo4j-spatial-0.26.2-neo4j-3.5.2-server-plugin.jar "${NEO4J_HOME}"/plugins
COPY --from=0 /tmp/*.jar "${NEO4J_HOME}"/plugins
