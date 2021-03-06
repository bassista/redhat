#!/usr/bin/env bash
set +x

### Set the maven repository and create the profiles for the application
ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"fabric:profile-edit --pid io.fabric8.agent/org.ops4j.pax.url.mvn.repositories=$MAVEN_REPOSITORY default\""

# create profile
ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"fabric:profile-create --parents jboss-fuse-minimal --parents feature-cxf decision-service\""

# add feature repos
#ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"fabric:profile-edit --#repositories mvn:application/application-common-features/$APP_VERSION/xml/features decision-service\""
##ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"fabric:profile-edit --repositories mvn:application/applicaton-features/$APP_VERSION/xml/features decision-service\""

ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"fabric:profile-edit --repositories mvn:uk.gov.scotland.afrc.core/batch-decision-service/1.0.0-SNAPSHOT/xml/features decision-service\""

## add features from repos
## ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"fabric:profile-edit -- features mq-fabric-camel application\""
ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"fabric:profile-edit --features batch-decision-service decision-service\""

# Create the upgraded application profiles for the release version

#ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"fabric:profile-edit --repositories mvn:application/application-common-features/$APP_VERSION/xml/features application $RELEASE_VERSION\""
#ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"fabric:profile-edit --repositories mvn:application/application-features/$APP_VERSION/xml/features application $RELEASE_VERSION\""
#ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"profile-edit --features application-feature application\""

ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"fabric:profile-edit --repositories mvn:org.jboss.quickstarts.fuse/jms/$APP_VERSION/xml/features decision-service $RELEASE_VERSION\""

ssh fuse@$ROOT_NODE "set +x;$HOST_RH_HOME/scripts/commands/karaf-client.sh $DEPLOYMENT_ENVIRONMENT \"fabric:profile-edit --features quickstart-jms decision-service $RELEASE_VERSION\""

