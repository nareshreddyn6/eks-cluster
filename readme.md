
# these are important

aws eks update-kubeconfig --name self-managed-cluster --region us-east-1
ssh-keygen -m pem -f sshkey 

copy .pub key file conetnt and paste in aws_key_pair public_key


terraform output kubeconfig
terraform output kubeconfig >~/.kube/config




