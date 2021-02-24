# Install Azdata CLI
# https://docs.microsoft.com/en-us/sql/azdata/install/deploy-install-azdata-linux-package?toc=%2Fazure%2Fazure-arc%2Fdata%2Ftoc.json&bc=%2Fazure%2Fazure-arc%2Fdata%2Fbreadcrumb%2Ftoc.json&view=sql-server-ver15

sudo apt-get update
sudo apt-get install gnupg ca-certificates curl wget software-properties-common apt-transport-https lsb-release -y

curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null

sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/prod.list)"

sudo apt-get update
sudo apt-get install -y azdata-cli

if [[ -z "${CONNECTEDK8S_SOURCE}" ]];
then
  az extension add --name connectedk8s --yes
else
  az extension add --source $CONNECTEDK8S_SOURCE --yes
fi

if [[ -z "${K8SCONFIGURATION_SOURCE}" ]];
then
  az extension add --name k8sconfiguration --yes
else
  az extension add --source $K8SCONFIGURATION_SOURCE --yes
fi

if [[ "${K8S_EXTENSION_SOURCE}" ]];
then
az extension add --source $K8S_EXTENSION_SOURCE --yes
fi

cp -R $HOME/.azure /home/azureuser
sudo chown -R azureuser:azureuser /home/azureuser

# Install Helm 3

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
