
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
    
  /*
   route_rules {
        cidr_block="192.168.0.0/16"
        network_entity_id="ocid1.localpeeringgateway.oc1.iad.aaaaaaaai5zki6i47u4iz3lq7f3d6tf6jngph2xjadcgqznrk4mvijj7tvba"
    }
 
*/
   route_rules {
        cidr_block = "0.0.0.0/0"
        network_entity_id = "${oci_core_internet_gateway.CompleteIG.id}"
    }
}

resource "oci_core_route_table" "PrivateRouteTable" {
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
    display_name = "PrivateRouteTable"
   
/*     route_rules {
        cidr_block="192.168.0.0/16"
        network_entity_id="ocid1.localpeeringgateway.oc1.iad.aaaaaaaai5zki6i47u4iz3lq7f3d6tf6jngph2xjadcgqznrk4mvijj7tvba"
    }
*/    
     route_rules {
        cidr_block = "0.0.0.0/0"
        network_entity_id = "${oci_core_private_ip.NatInstancePrivateIP.id}"
    }
 

}

/*

output "private_subnet_ids" {

   value = ["${oci_core_subnet.PrivateSubnets.*.id}"]

}

*/
