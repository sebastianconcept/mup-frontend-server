docker run -it \
  --volume=/..app/config/staging/bundle.crt:/bundle.crt \
  --volume=/..app/config/staging/private-key.pem:/private.key \
  --publish=443:443 \
  sebastianconcept/mup-server:latest /start.sh
