# Install Docker, Kubeadm, Kubelet, and Kubectl 
sudo apt-get update 
sudo apt-get install -y docker-ce kubelet kubeadm kubectl 
# Enable net.bridge.bridge-nf-call-iptables
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf 
sudo sysctl -p 
