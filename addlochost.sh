if [[ -z $1 ]]; then
echo "Please specify host to add as a parameter";
else
host="$1.locamp"
sudo -B echo "Host $host will be added to /etc/hosts. Please enter your password." > /dev/null || echo "Root user requied. Please use sudo $0";
echo "127.0.0.1	$host" | sudo tee -a /etc/hosts & echo "Host $host succesfully added"; 
fi
