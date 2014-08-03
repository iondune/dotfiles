echo "Pulling changes from repository..."
echo "----------------------------------"
hg -R ~/Projects/ionWebsite/ pull -u
echo
echo "Synchronizing changes with webserver..."
echo "---------------------------------------"
rsync -a -e 'ssh -p 1157' --exclude=.hg --progress ~/Projects/ionWebsite/ iondunec@iondune.com:~/public_html/home
echo
echo "Applying file permissions..."
ssh -p 1157 iondunec@iondune.com 'find public_html/home/ -type d | xargs chmod 755'
ssh -p 1157 iondunec@iondune.com 'find public_html/home/ -type f | xargs chmod 644'
