
resource "oci_core_instance" "WebServers" {
	#Required
        count=3
        availability_domain = "${lookup(data.oci_core_subnets.Websub.subnets[count.index],"availability_domain")}"
        compartment_id = "${var.compartment_ocid}"
	image = "ocid1.image.oc1.iad.aaaaaaaaxrqeombwty6jyqgk3fraczdd63bv66xgfsqka4ktr7c57awr3p5a"
        shape = "${var.InstanceShape}"
	display_name="APP-OEL-${count.index}"
	hostname_label="APP-OEL-${count.index}"


	# Optional
	create_vnic_details {
		#Required (subnet_id may also be specified at the root level)
		subnet_id = "${oci_core_subnet.WebSubnets.*.id[count.index]}"

		#Optional
		display_name = "vnic-${count.index}"
			}

	metadata {
		ssh_authorized_keys = "${var.ssh_public_key}"
		#This user data script adds chef server dns entry to /etc/hosts
		user_data = "${base64encode(file("user_data_dns.tpl"))}"
 	}

provisioner "chef" {
    server_url = "${var.chef_server}"
    node_name = "Web-OEL-${count.index}"
    run_list = ["role[web]"]
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

  #You will need knife.rb in your current path in order for this command to complete successfully.
  #provisioner "local-exec" {
  #  when = "destroy"
  #  on_failure = "continue"
  #  command = "knife node delete ${var.chef_node_name} -y",
  #}
}
