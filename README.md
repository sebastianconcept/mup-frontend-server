# Frontend Server for Meteor Up

Docker container with nginx customized to proxy to a meteor app

## SSL Support

This container adds SSL support to the meteor-up setup. The way we are configuring nginx makes it to redirect all `http` traffic to `https`.

Here's how to run this in the target host:

~~~shell
docker run \
  --volume=/opt/<appname>/config/bundle.crt:/bundle.crt \
  --volume=/opt/<appname>/config/private.key:/private.key \
  --volume=/opt/<appname>/config/dhparam.pem:/dhparam.pem \
  --link=<appname>:backend \
  --publish=80:80 \
  --publish=443:443 \
  sebastianconcept/mup-frontend-server /start.sh
~~~

As you've noticed, we need to add two volumes for the `bundle.crt` and `private.key`.

#### bundle.crt

This is a bundle containing all of your certificates including the provided CA certificates. To create this file you need to concatenate all certificates starting from your domain certificate to the top level CA certificates. Here's an example:

~~~shell
cat \
    bulletproofmeteor_com.crt \
    COMODORSADomainValidationSecureServerCA.crt \
    COMODORSAAddTrustCA.crt \
    AddTrustExternalCARoot.crt > bundle.crt
~~~

#### private.key

This is the private key you've used to generate the above certficate.

### Verify Configuration

You can verify the SSL configuration like this:

~~~shell
docker run \
  --volume=/opt/<appname>/config/bundle.crt:/bundle.crt \
  --volume=/opt/<appname>/config/private.key:/private.key \
  meteorhacks/mup-frontend-server /verify.sh
~~~

### Why Nginx?

There's the question why we've chosen nginx for the SSL termination. We could've used something like `stud` or `bud`.

We need to get the correct IP address of the real connection, which is required for certain apps such as Sikka. Normally SSL terminators like `stud` and `bud` do not support this or support it only partially.

## For Static File Caching

We've not implemented this yet!
