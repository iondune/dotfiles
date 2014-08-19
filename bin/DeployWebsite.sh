echo "Pulling changes from repository..."
echo "----------------------------------"
hg -R ~/Projects/ionJekyll/ pull -u
echo
echo "Synchronizing changes with webserver..."
echo "---------------------------------------"
cd ~/Projects/ionJekyll/
jekyll build
rsync -a _site/ /var/www/iondune.com/public_html/
