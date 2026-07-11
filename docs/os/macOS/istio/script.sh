# Check for Homebrew and install if we don't have it
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Make sure we are using the latest Homebrew.
  brew update
 
  # Check for Minikube and install if we don't have it
  echo "Installing Minikube to run a single-node Kubernetes Cluster locally..."
  brew cask install minikube
  echo "Minikube Installation Complete"
  
  # Check for Kubernetes Command Line Utility and install if we don't have it
  echo "Installing kubectl to manage components in your Kubernetes cluster..."
  brew install kubectl
  echo "kubectl Installation Complete"
  
  # Install Istio
  echo "Installation of Istio started..."
  curl -L https://git.io/getLatestIstio | sh -
  cd istio-1.0.0/
  export PATH=$PWD/bin:$PATH
  kubectl apply -f install/kubernetes/istio.yaml
  echo "Istio Installation Complete"
