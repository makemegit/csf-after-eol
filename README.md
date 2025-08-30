# csf-after-eol
Scripts for csf after end of life (After 31st August)
Official guide: https://github.com/centminmod/configserver-scripts/blob/main/README-gpl-csf.md

## generate-csf-repo.sh
Script for setting a repo for CSF-Firewall after end of life (After 31st August)

dependencies: wget, rsync, modern bash
### Download
```
wget https://raw.githubusercontent.com/makemegit/csf-after-eol/refs/heads/main/generate-csf-repo.sh
```
### Change Varibles
```
# Variables
PUBLIC='/var/www/html/'
DOMAIN='download.DOMAIN.COM' # download subdomain is mandatory !!!
APACHEUSER='admin'
APACHEGROUP='www-data'
ORIGINALCSF='https://raw.githubusercontent.com/makemegit/csf-after-eol/refs/heads/main/csf.tgz' # Change with you own archive backup for safety
```
### Run
```
chmod +x generate-csf-repo.sh
./generate-csf-repo.sh
```
## fix-existing-csf.sh

Disable updates and change the repo with your own.

### Download
```
wget https://raw.githubusercontent.com/makemegit/csf-after-eol/refs/heads/main/fix-existing-csf.sh

```

### Change Varibles
```
# Variables
DOMAIN='download.DOMAIN.COM' # download subdomain is mandatory !!!
```
### Run
```
chmod +x 
./fix-existing-csf.sh
```
