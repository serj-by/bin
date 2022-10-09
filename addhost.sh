if [[ -z $1 ]]; then
echo "Please specify host to add as a parameter";
else
sudo -B echo "Host $1 will be added to /etc/hosts. Please enter your password." > /dev/null || echo "Root user requied. Please se sudo $0";
echo "127.0.0.1	$1" | sudo tee -a /etc/hosts & echo "Host $1 succesfully added"; 
fi
