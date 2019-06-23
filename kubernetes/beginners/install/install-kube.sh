sudo apt-get update && sudo apt-get install -y apt-transport-https curl 
# Add the Docker Repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable" 
# Add the Kubernetes repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - 
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list 
deb https://apt.kubernetes.io/ kubernetes-xenial main 
EOF 
# Install Docker, Kubeadm, Kubelet, and Kubectl 
sudo apt-get update 
sudo apt-get install -y docker-ce kubelet kubeadm kubectl 
# Enable net.bridge.bridge-nf-call-iptables
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf 
sudo sysctl -p 
