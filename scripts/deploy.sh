#!/bin/bash
function usage()
 {
    echo "INFO:"
    echo "Usage: deploy.sh [storage-account-name] [storage-account-key] [ansible user]"
}

error_log()
{
    if [ "$?" != "0" ]; then
        log "$1" "1"
        log "Deployment ends with an error" "1"
        exit 1
    fi
}

function log()
{
	
  mess="$(date) - $(hostname): $1"

  logger -t "${BASH_SCRIPT}" "${mess}"
   
  echo "$(date) : $1"
}

function ssh_config()
{
  # log "tld is ${tld}"
  log "Configure ssh..." "0"
  
  log "Create ssh configuration for ${ANSIBLE_USER}" "0"
  cat << 'EOF' >> /home/${ANSIBLE_USER}/.ssh/config
Host *
    user devops
    StrictHostKeyChecking no
EOF
  error_log "Unable to create ssh config file for user ${ANSIBLE_USER}"

}

function install_ansible()
{
    apt-get --yes --force-yes install software-properties-common
    apt-add-repository ppa:ansible/ansible
    apt-get --yes --force-yes update
    apt-get --yes --force-yes install ansible
    # install sshpass
    apt-get --yes --force-yes install sshpass
    # install Git
    apt-get --yes --force-yes install git
    # install python
    apt-get --yes --force-yes install python-pip
}


function generate_sshkeys()
{
  echo -e 'y\n'|ssh-keygen -b 4096 -f id_rsa -t rsa -q -N ''
}

function put_sshkeys()
 {
    log "INFO:Retrieving ssh keys from Azure Storage"
    pip install azure-storage

    # Download both Private and Public Key
    python WriteSSHToPrivateStorage.py "${STORAGE_ACCOUNT_NAME}" "${STORAGE_ACCOUNT_KEY}" id_rsa
    python WriteSSHToPrivateStorage.py "${STORAGE_ACCOUNT_NAME}" "${STORAGE_ACCOUNT_KEY}" id_rsa.pub

}


## Variables
BASH_SCRIPT="${0}"
STORAGE_ACCOUNT_NAME="${1}"
STORAGE_ACCOUNT_KEY="${2}"
ANSIBLE_USER="${3}"

##

ssh_config
install_ansible
generate_sshkeys
put_sshkeys