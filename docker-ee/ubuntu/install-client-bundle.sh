#Download client certificates by using the REST API
#You can also download client bundles by using the UCP REST API. In this example, we use curl to make the web requests to the API, jq to parse the responses, and unzip to unpack the zip archive.

#To install these tools on an Ubuntu distribution, you can run:

sudo apt-get update && sudo apt-get install curl jq unzip

# Create an environment variable with the user security token
AUTHTOKEN=$(curl -sk -d '{"username":"<username>","password":"<password>"}' https://<ucp-ip>/auth/login | jq -r .auth_token)

# Download the client certificate bundle
curl -k -H "Authorization: Bearer $AUTHTOKEN" https://<ucp-ip>/api/clientbundle -o bundle.zip

# Unzip the bundle.
unzip bundle.zip

# Run the utility script.
eval "$(<env.sh)"
