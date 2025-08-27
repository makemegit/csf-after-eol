#!/bin/bash
# 
## name: fix-existing-csf.sh
## Script for fixing existing csf instalations with your own repo
## by @makeme v.2025-08-27
#

# Variables
DOMAIN='download.DOMAIN.COM' # download subdomain is mandatory !!!

cd /etc/csf

# Disable autou-pdate:
echo "Disableing auto-updates.."
sed -i 's|AUTO_UPDATES = "1"|AUTO_UPDATES = "0"|g' `grep -rHnl 'AUTO_UPDATES = "1"' /etc/csf/`

# Fix servers:
echo "Changing the domain..."
sed -i "s|download.configserver.com|$DOMAIN|g" `grep -rHnl download.configserver.com /etc/csf/`

# Restart csf and lfd
csf -r
systemctl restart lfd

echo ""
echo "DONE"
echo ""
