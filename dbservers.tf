
resource "oci_core_instance" "DBServers" {
	#Required
        count=1
        availability_domain = "${lookup(data.oci_core_subnets.DBsub.subnets[count.index],"availability_domain")}"
        compartment_id = "${var.compartment_ocid}"
	image = "ocid1.image.oc1.iad.aaaaaaaaxrqeombwty6jyqgk3fraczdd63bv66xgfsqka4ktr7c57awr3p5a"
        shape = "${var.InstanceShape}"
	display_name="DB-OEL-${count.index}"
	hostname_label="DB-OEL-${count.index}"


	# Optional
	create_vnic_details {
		#Required (subnet_id may also be specified at the root level)
		subnet_id = "${lookup(data.oci_core_subnets.DBsub.subnets[count.index],"id")}"

		#Optional
		assign_public_ip = false
		display_name = "vnic-${count.index}"
			}

	metadata {
		ssh_authorized_keys = "${var.ssh_public_key}"
		#This user data script adds chef server dns entry to /etc/hosts
		user_data = "${base64encode(file("user_data_dns.tpl"))}"
 	}


provisioner "chef" {
    server_url = "${var.chef_server}"
    node_name ="DB-OEL-${count.index}"
    run_list =["role[oracle_database_12102]"]
    user_name = "${var.chef_user}"
    user_key = "${file(var.chef_key)}"
    recreate_client = true
    fetch_chef_certificates = true
    connection {
      host = "${self.private_ip}"
      type = "ssh"
      user = "opc"
      private_key = "${var.ssh_private_key}"
      timeout = "3m"
    }
  }
}
