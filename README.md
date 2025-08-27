# csf-after-eol
Script for setting a repo for CSF-Firewall after end of life (After 31st August)

dependencies: wget, rsync, modern bash :)

## generate-csf-repo.sh
# Download
```
wget https://raw.githubusercontent.com/makemegit/csf-after-eol/refs/heads/main/generate-csf-repo.sh
```
# Change Varibles
```
# Variables
PUBLIC='/var/www/html/'
DOMAIN='download.DOMAIN.COM' # download subdomain is mandatory !!!
APACHEUSER='admin'
APACHEGROUP='www-data'
ORIGINALCSF='https://raw.githubusercontent.com/makemegit/csf-after-eol/refs/heads/main/csf.tgz' # Change with you own archive backup for safety
```
# Run
```
chmod +x generate-csf-repo.sh
./generate-csf-repo.sh
```
