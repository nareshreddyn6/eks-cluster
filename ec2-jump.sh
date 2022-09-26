
# these are important

sudo curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl

sudo chmod +x ./kubectl
sudo mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

sudo mkdir -p ~/.kube

echo 'export KUBECONFIG=$KUBECONFIG:~/.kube/config' >> ~/.bashrc

sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# apt update
sudo apt install unzip -y
sudo unzip awscliv2.zip
sudo sudo ./aws/install


