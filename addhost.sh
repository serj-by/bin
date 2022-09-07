if [[ -z $1 ]]; then
echo "Please specify host to add as a parameter";
else
echo "Host $1 will be added to /etc/hosts. Root password may be required.";
echo "127.0.0.1	$1" | sudo tee -a /etc/hosts & echo "Host $1 succesfully added"; 
fi
