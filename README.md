# jenkins-slave

Jenkins slave docker image with Python 2.7.12/pip, Python 3.5.2/pip3, Nodejs 6.9.1, Java 8/maven 3.0.5, Docker 1.12.2, vim

## RUN

```
docker pull srvz/jenkins-slave

docker run -d --name jenkins-slave \
    -v {/your/path}:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    srvz/jenkins-slave -master http://192.168.111.111:8080 \
    -username name -password password \
    -tunnel 192.168.111.111:50000  \
    -label slave1 \
    -name slave1 \
    -executors 2
```

## jenkins swarm client usage

```
% java -jar swarm-client-jar-with-dependencies.jar -help
 -autoDiscoveryAddress VAL      : Use this address for udp-based auto-discovery
                                  (default 255.255.255.255)
 -candidateTag VAL              : Show swarm candidate with tag only
 -deleteExistingClients         : Deletes any existing node with the same name.
 -description VAL               : Description to be put on the slave
 -disableClientsUniqueId        : Disables Clients unique ID.
 -disableSslVerification        : Disables SSL verification in the HttpClient.
 -executors N                   : Number of executors
 -fsroot FILE                   : Directory where Jenkins places files
 -help (--help)                 : Show the help screen
 -labels VAL                    : Whitespace-separated list of labels to be
                                  assigned for this slave. Multiple options are
                                  allowed.
 -master VAL                    : The complete target Jenkins URL like
                                  'http://server:8080/jenkins/'. If this option
                                  is specified, auto-discovery will be skipped
 -mode MODE                     : The mode controlling how Jenkins allocates
                                  jobs to slaves. Can be either 'normal'
                                  (utilize this slave as much as possible) or
                                  'exclusive' (leave this machine for tied jobs
                                  only). Default is normal.
 -name VAL                      : Name of the slave
 -noRetryAfterConnected         : Do not retry if a successful connection gets
                                  closed.
 -password VAL                  : The Jenkins user password
 -passwordEnvVariable VAL       : Environment variable that the password is
                                  stored in
 -retry N                       : Number of retries before giving up. Unlimited
                                  if not specified.
 -showHostName (--showHostName) : Show hostnames instead of IP address
 -t (--toolLocation)            : A tool location to be defined on this slave.
                                  It is specified as 'toolName=location'
 -tunnel VAL                    : Connect to the specified host and port,
                                  instead of connecting directly to Jenkins.
                                  Useful when connection to Hudson needs to be
                                  tunneled. Can be also HOST: or :PORT, in
                                  which case the missing portion will be
                                  auto-configured like the default behavior
 -username VAL                  : The Jenkins username for authentication
 -t (--toolLocation)            : A tool location to be defined on this slave.
```