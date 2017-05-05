docker run -it \
  --volume=/..app/config/staging/fake-bundle.crt:/bundle.crt \
  --volume=/..app/config/staging/fake-private-key.pem:/private.key \
  --publish=80:80 \
  sebastianconcept/mup-frontend-server:latest /start.sh
