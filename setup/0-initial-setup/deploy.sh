#!/bin/bash
if [[ "$EUID" -ne 0 ]]; then
  printf "\n## Please run this script with sudo $(realpath $0)\n\n"
  exit 1
fi


main() {
#install_prerequisite "nfs-common"
#install_prerequisite "cifs-utils"

install_prerequisite "mc"

mkdir $LP_SHARED $LP_STORAGE

#echo "user=
#password=
#domain=
#" > $LP_HOME/.smb


chown $LP_USER:$LP_USER $LP_SHARED
chown $LP_USER:$LP_USER $LP_STORAGE
#chmod 600 $LP_HOME/.smb

#echo "$LP_SMB_JORMANAGER_SHARE $LP_HOME/jormanager/storage cifs nolock,credentials=$LP_SMB_CREDS,uid=$LP_USER,gid=$LP_USER,iocharset=utf8,vers=3.0,noperm 0 0" >> /etc/fstab
#echo "$LP_SMB_SHARE  $LP_SHARED   cifs  nolock,credentials=$LP_SMB_CREDS,uid=$LP_USER,gid=$LP_USER,iocharset=utf8,vers=3.0,noperm 0 0" >> /etc/fstab
echo "$LP_SHARED_P9_MOUNT_TAG                         $LP_SHARED   9p    trans=virtio,version=9p2000.L,_netdev,rw 0 0" >> /etc/fstab
echo "$LP_NVME_DEV                          $LP_STORAGE  xfs   defaults,noatime 0 2" >> /etc/fstab
mount -a


git config --global user.email "$LP_GIT_EMAIL"
git config --global user.name "$LP_GIT_NAME"

}

install_prerequisite() {
  app=$1
  if [[ -z $(command -v ${app}) ]]; then
    # special case for dig, replace with correct package for debian vs redhat based distros
    if [[ ! -z $(command -v apt) ]]; then
      #[[ "${app}" == "dig" ]] && app="dnsutils" # Handle special case
      apt -q -y install ${app}
    elif [[ ! -z $(command -v dnf) ]]; then
      #[[ "${app}" == "dig" ]] && app="bind-utils" # Handle special case
      dnf -q -y install ${app}
    elif [[ ! -z $(command -v yum) ]]; then
      #[[ "${app}" == "dig" ]] && app="bind-utils" # Handle special case
      yum -q -y install ${app}
    else
      printf "\n## Couldn't find any package manager on system."
      printf "\n## Install $1 prerequisite manually and relaunch script.\n\n"
      exit 1
    fi
    if [[ -z $(command -v $1) && "${app}" != "cifs-utils" && "${app}" != "nfs-common" ]]; then
      printf "\n## Unable to install $1, either not available in repository or failure during installation."
      printf "\n## Install $1 prerequisite manually and relaunch script.\n\n"
      exit 1
    else
      printf "\n## $1 installed.\n\n"
    fi
  fi
}

main
