#cloud-config
    

runcmd:
  - sed -i -e '$a192.168.1.2 chefserver.pubsubnet.utilitiesvcn.oraclevcn.com chefserver' /etc/hosts 


