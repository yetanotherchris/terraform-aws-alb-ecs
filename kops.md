#kops create cluster --cloud=aws --master-size=t2.medium  --master-zones=eu-west-1a  --network-cidr=10.0.0.0/22 --node-count=10  --node-size=t2.medium  --zones=eu-west-1a  --name=manet.k8s.local
kops create cluster --cloud=aws --master-size=t2.medium  --master-zones=eu-west-1a --node-count=10  --node-size=t2.medium  --zones=eu-west-1a  --name=manet.k8s.local