#!/bin/bash
# 
## name: generate-csf-repo.sh
## Script for setting a repo for CSF-Firewall after end of life (After 31st August)
## by @makeme v.2025-08-27
#

# Variables
PUBLIC='/var/www/html/'
DOMAIN='download.DOMAIN.COM' # download subdomain is mandatory !!!
APACHEUSER='admin'
APACHEGROUP='www-data'
ORIGINALCSF='https://raw.githubusercontent.com/makemegit/csf-after-eol/refs/heads/main/csf.tgz' # Change with you own archive backup for safety

# Download original csf files (change the link with your backup archive):
echo ""

# Creating directory tree:
echo "Creating directory tree..."
mkdir -p $PUBLIC/csf_original
mkdir -p $PUBLIC/csf

echo "Download original csf files..."
echo "--------------------------------------------------------------------"
#wget -O https://download.configserver.com/csf.tgz -P $PUBLIC/csf_original
wget $ORIGINALCSF -O $PUBLIC/csf_original/csf.tgz

# Downloading all txt files
#wget https://download.configserver.com/version.txt -P $PUBLIC/
#wget https://download.configserver.com/csf/changelog.txt -P $PUBLIC/csf
#wget https://download.configserver.com/csf/install.txt -P $PUBLIC/csf
#wget https://download.configserver.com/csf/license.txt -P $PUBLIC/csf
#wget https://download.configserver.com/csf/readme.txt -P $PUBLIC/csf
#wget https://download.configserver.com/csf/version.txt -P $PUBLIC/csf
echo "--------------------------------------------------------------------"

# Extract original files:
echo "Extracting original files..."
tar -xzf $PUBLIC/csf_original/csf.tgz -C $PUBLIC/csf_original/

# Fix servers:
echo "Changing the domain..."
sed -i "s|download.configserver.com|$DOMAIN|g" `grep -rHnl download.configserver.com $PUBLIC/csf_original/csf/`
echo $DOMAIN > $PUBLIC/csf_original/csf/downloadservers

# Disable autou-pdate:
echo "Disableing auto-updates.."
sed -i 's|AUTO_UPDATES = "1"|AUTO_UPDATES = "0"|g' `grep -rHnl 'AUTO_UPDATES = "1"' $PUBLIC/csf_original/csf/`

# Update uninstall scripts to clean /usr/src/csf files (commen lines below if you don't liske that):
echo "Update the uninstall script to clean /usr/src/csf files..."
sed -i 's|/var/lib/csf|/var/lib/csf /usr/src/csf*|g' $PUBLIC/csf_original/csf/uninstall.sh
sed -i 's|/var/lib/csf|/var/lib/csf /usr/src/csf*|g' $PUBLIC/csf_original/csf/uninstall.generic.sh
sed -i 's|/var/lib/csf|/var/lib/csf /usr/src/csf*|g' $PUBLIC/csf_original/csf/uninstall.directadmin.sh
sed -i 's|/var/lib/csf|/var/lib/csf /usr/src/csf*|g' $PUBLIC/csf_original/csf/uninstall.cyberpanel.sh

# Generating new archive:
echo "Generating new archive..."
cd $PUBLIC/csf_original && tar -czf csf_gen.tgz csf

# Provisioning the new archives:
echo "Provisioning..."
rsync -a $PUBLIC/csf_original/csf_gen.tgz $PUBLIC/csf.tgz
rsync -a $PUBLIC/csf_original/csf_gen.tgz $PUBLIC/csf/csf.tgz
rsync -a $PUBLIC/csf_original/csf/changelog.txt $PUBLIC/csf/
rsync -a $PUBLIC/csf_original/csf/license.txt $PUBLIC/csf/
rsync -a $PUBLIC/csf_original/csf/readme.txt $PUBLIC/csf/
rsync -a $PUBLIC/csf_original/csf/version.txt $PUBLIC/csf/
rsync -a $PUBLIC/csf_original/csf/install.txt $PUBLIC/csf/

# Fixing permissions:
echo "Fixing premissions..."
chown -R $APACHEUSER:$APACHEUSER $PUBLIC
chown $APACHEUSER:$APACHEGROUP $PUBLIC

# Cleaning (comment rm lines bellow if you want to edit manually files):
echo "Cleaning..."
rm -rf $PUBLIC/csf_original/csf
rm -rf $PUBLIC/csf_original/csf_gen.tgz

echo ""
echo "Check your instalation guide: http://$DOMAIN/install.txt"
echo ""
echo "DONE"
echo ""
