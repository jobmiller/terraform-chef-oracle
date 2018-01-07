
resource "oci_core_subnet" "PrivateSubnetAD1" {
  cidr_block = "10.0.4.0/24"
  availability_domain = "${data.oci_identity_availability_domains.ADs.availability_domains.0.name}"
  display_name = "PrivateSubnetAD1"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
  #route_table_id = "${oci_core_route_table.RouteForComplete.id}"
  route_table_id = "${oci_core_route_table.PrivateRouteTable.id}"
  security_list_ids = ["${oci_core_security_list.PrivateSubnet.id}"]
  dhcp_options_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "true"
  
  dns_label="p1"
}

resource "oci_core_subnet" "PrivateSubnetAD2" {
  
  availability_domain = "${data.oci_identity_availability_domains.ADs.availability_domains.1.name}"
  cidr_block = "10.0.5.0/24"
  display_name = "PrivateSubnetAD2"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${oci_core_route_table.PrivateRouteTable.id}"
 #route_table_id = "${oci_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${oci_core_security_list.PrivateSubnet.id}"]
  dhcp_options_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "true"

  dns_label="p2"
}

resource "oci_core_subnet" "PrivateSubnetAD3" {
  availability_domain = "${data.oci_identity_availability_domains.ADs.availability_domains.2.name}"
  cidr_block = "10.0.6.0/24"
  display_name = "PrivateSubnetAD3"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${oci_core_route_table.PrivateRouteTable.id}"
 #route_table_id = "${oci_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${oci_core_security_list.PrivateSubnet.id}"]
  dhcp_options_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "true"

  dns_label="p3"
}
