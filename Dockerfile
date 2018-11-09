ARG AWS_ECR=
FROM ${AWS_ECR}geo/tomcat85-minimal

#
# Set GeoServer version and data directory 
#
ENV GEONETWORK_VERSION=3.4.2
ENV GEONETWORK_DIR="/geonetwork_data"
ENV GEONETWORK_LUCENSE_DIR="/geonetwork_lucene"

#
# Additional Java settings to provide Geonetwork with more memory
#
ENV JAVA_OPTS -Xms256m -Xmx512m
ENV CATALINA_OPTS="-Dgeonetwork.dir=$GEONETWORK_DIR"

#
# Additional components needed to install geonetwork
#
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wget 

#
# Download and install GeoNetwork
# This will unpack the war and remove any sample data
# 
RUN cd $CATALINA_HOME/webapps \
    && mkdir ROOT \
    && cd ROOT \
    && wget --progress=bar:force:noscroll https://sourceforge.net/projects/geonetwork/files/GeoNetwork_opensource/v$GEONETWORK_VERSION/geonetwork.war \
    && unzip -q geonetwork.war \
    && rm geonetwork.war \
    && cd .. \
    && mkdir $GEONETWORK_DIR \
    && mkdir $GEONETWORK_LUCENSE_DIR

