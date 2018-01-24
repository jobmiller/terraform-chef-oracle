resource "oci_core_security_list" "WebSubnet" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "Public"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
    egress_security_rules = [{
        destination = "0.0.0.0/0"
        protocol = "6"
    }]
    ingress_security_rules = [{
        tcp_options {
            "max" = 80
            "min" = 80
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
	{
	protocol = "6"
	source = "${var.VPC-CIDR}"
    },
       {
        protocol="6"
	source = "${var.VPC-Utilities-Peer-CIDR}"
        tcp_options {
                "min" = 22
                "max" = 22
        }
      }]
}

resource "oci_core_security_list" "PrivateSubnet" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "PrivateSecurityList"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
    egress_security_rules = [{
	protocol = "6"
	destination = "${var.VPC-CIDR}"
    },
    {	protocol="6"
	destination = "${var.VPC-Utilities-Peer-CIDR}"
    },
 
   {
        protocol = "all"
        destination = "0.0.0.0/0"
    }
	
]
    ingress_security_rules = [{
        protocol = "6"
        source = "${var.VPC-CIDR}"
       },
       {protocol="6"
	source = "${var.VPC-Utilities-Peer-CIDR}"
        tcp_options {
                "min" = 22
                "max" = 22
             }
     }]
}

resource "oci_core_security_list" "BastionSubnet" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "Bastion"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
    egress_security_rules = [{
	protocol = "6"
        destination = "0.0.0.0/0"
    }]
    ingress_security_rules = [{
        tcp_options {
            "max" = 22
            "min" = 22
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
	{
	protocol = "6"
        source = "${var.VPC-CIDR}"
    }]	

}


