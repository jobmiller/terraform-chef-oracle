resource "oci_core_subnet" "BastionSubnetAD1" {
  availability_domain = "${data.oci_identity_availability_domains.ADs.availability_domains.0.name}"
  cidr_block = "10.0.7.0/24"
  display_name = "BastionSubnetAD1"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${oci_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${oci_core_security_list.BastionSubnet.id}"]
  dhcp_options_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"

  dns_label="b1"
}

resource "oci_core_subnet" "BastionSubnetAD2" {
  availability_domain = "${data.oci_identity_availability_domains.ADs.availability_domains.1.name}"
  cidr_block = "10.0.8.0/24"
  display_name = "BastionSubnetAD2"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${oci_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${oci_core_security_list.BastionSubnet.id}"]
  dhcp_options_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"

  dns_label="b2"
}

resource "oci_core_subnet" "BastionSubnetAD3" {
  availability_domain = "${data.oci_identity_availability_domains.ADs.availability_domains.2.name}"
  cidr_block = "10.0.9.0/24"
  display_name = "BastionSubnetAD3"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${oci_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${oci_core_security_list.BastionSubnet.id}"]
  dhcp_options_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"

  dns_label="b3"
}
