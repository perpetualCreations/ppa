#!/bin/bash
# from tutorial here, https://assafmo.github.io/2019/05/02/ppa-repo-hosted-on-github.html

# Packages & Packages.gz
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

# Release, Release.gpg & InRelease
apt-ftparchive release . > Release
gpg --default-key "tchen0584@gmail.com" -abs -o - Release > Release.gpg
gpg --default-key "tchen0584@gmail.com" --clearsign -o - Release > InRelease

# Forward Changes to Git Repository
git pull 
git add *
git commit -m "Updated PPA for new Debian package."
git push