docker run -it \
  --volume=/..app/config/fake-bundle.crt:/bundle.crt \
  --volume=/..app/config/fake-private-key.pem:/private.key \
  --volume=/..app/config/fake-dhparam.pem:/dhparam.pem \
  --publish=80:80 \
  --publish=443:443 \
  sebastianconcept/mup-frontend-server:latest /start.sh
