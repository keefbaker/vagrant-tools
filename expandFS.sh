#! /bin/bash
set -e
set -u
set -o pipefail
set -x

# Usage:
#  $ ./expandFS.sh [vbox name]
# Then use the instructions inside the VM at the end of this script to
# make the VM use the expanded FileSystem. (Last time I didn't need to do this)

vagrant halt

vm_dir="$HOME/VirtualBox VMs"
vm_name="${1:-$(cd "$vm_dir"/dpp-tooling-vm* && basename "$(pwd)")}"

disk_old="$(VBoxManage showvminfo "$vm_name" | grep cloudimg.vmdk | grep -o "[^ ]*$vm_dir[^ ]*.vmdk")"
disk_new="$disk_old.vdi"
echo "DISK: '$disk_old'"

cd "$vm_dir/$vm_name"

VBoxManage clonehd "$disk_old" "$disk_new" --format vdi
VBoxManage modifyhd "$disk_new" --resize 102400
VBoxManage storageattach "$vm_name" --storagectl "SCSI" --port 0 --device 0 --type hdd --medium "$disk_new"

# log in to the VM and sudo to root
# parted
# print
# resizepart 1
# yes
# 107G
# quit
# resize2fs /dev/sda1
