# luminapool-scripts
This is a collection of scripts that help deployment of LuminaPool. These will be gradually worked on to automate the process further.

## Deployment

### Apply env vars

The deployment script will need an initial set of env vars. These are not stored here due to them storing potentially sensitive data.

### Get and run the deployment script

`deploy.sh` will install basic prerequisites for our server to function. Cardano-node dependencies are not included, those will be installed later on.
To get and run the script, do 
```
wget https://github.com/thevictor13/luminapool-scripts/raw/master/setup/0-initial-setup/deploy.sh
chmod u+x deploy.sh
./deploy.sh

```
