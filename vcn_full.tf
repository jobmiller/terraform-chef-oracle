
variable "VPC-CIDR" {
  default = "10.0.0.0/16"
}

variable "VPC-Utilities-Peer-CIDR" {
  default = "192.168.0.0/16"
}

resource "oci_core_virtual_network" "CompleteVCN" {
  cidr_block = "${var.VPC-CIDR}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "CompleteVCN"
  dns_label="MyServers"
}

resource "oci_core_default_dhcp_options" "default-dhcp-options" {
  manage_default_resource_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"

  // required
  options {
    type = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

}
resource "oci_core_internet_gateway" "CompleteIG" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "CompleteIG"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
}


resource "oci_core_route_table" "RouteForComplete" {
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
    display_name = "RouteTableForComplete"
    
    route_rules {
        cidr_block="192.168.0.0/16"
        network_entity_id="ocid1.localpeeringgateway.oc1.iad.aaaaaaaai5zki6i47u4iz3lq7f3d6tf6jngph2xjadcgqznrk4mvijj7tvba"
    }
    route_rules {
        cidr_block = "0.0.0.0/0"
        network_entity_id = "${oci_core_internet_gateway.CompleteIG.id}"
    }
}

resource "oci_core_route_table" "PrivateRouteTable" {
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
    display_name = "PrivateRouteTable"
    route_rules {
        cidr_block = "0.0.0.0/0"
        network_entity_id = "${oci_core_private_ip.NatInstancePrivateIP.id}"
    }
    
     route_rules {
        cidr_block="192.168.0.0/16"
        network_entity_id="ocid1.localpeeringgateway.oc1.iad.aaaaaaaai5zki6i47u4iz3lq7f3d6tf6jngph2xjadcgqznrk4mvijj7tvba"
    }


}

/*

output "bastion_subnet_ids" {
  value   = ["${oci_core_subnet.BastionSubnetAD1.id}", "${oci_core_subnet.BastionSubnetAD2.id}","${oci_core_subnet.BastionSubnetAD3.id}"]
}
output "public_subnet_ids" {
  value   = ["${oci_core_subnet.WebSubnetAD1.id}", "${oci_core_subnet.WebSubnetAD2.id}","${oci_core_subnet.WebSubnetAD3.id}"]
}

output "private_subnet_ids" {

   value = ["${oci_core_subnet.PrivateSubnetAD1.id}", "${oci_core_subnet.PrivateSubnetAD2.id}","${oci_core_subnet.PrivateSubnetAD3.id}"]

}

output "data_sources" {
  value = "${data.oci_core_subnets.sub.subnets}"
}

output "nic_info" {
   value = "${data.oci_core_vnic_attachments.NatInstanceVnics.vnic_attachments}"
}

output "data_source_test" {
  value = ["${data.oci_core_subnets.sub.id}"]
}


output "data_source_info0" {
  value = "${data.oci_core_subnets.sub.subnets.0.id}"

}

output "data_source_info1" {
  value = "${data.oci_core_subnets.sub.subnets.1.id}"

}

output "data_source_info2" {

  value = "${data.oci_core_subnets.sub.subnets.2.id}"

}

output "private_ip_nat" {
  value= "${oci_core_private_ip.NatInstancePrivateIP}"
}


*/
