
resource "oci_core_subnet" "WebSubnets" {
  count=3
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[count.index],"name")}"
  cidr_block = "10.0.${count.index+1}.0/24"
  display_name = "WebSubnetAD-${count.index+1}"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${oci_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${oci_core_security_list.WebSubnet.id}"]
  dhcp_options_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"

  dns_label="w${count.index+1}"
}

/*
resource "oci_core_subnet" "WebSubnetAD2" {
  availability_domain = "${data.oci_identity_availability_domains.ADs.availability_domains.1.name}"
  cidr_block = "10.0.2.0/24"
  display_name = "WebSubnetAD2"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${oci_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${oci_core_security_list.WebSubnet.id}"]
  dhcp_options_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"

  dns_label="w2"
}

resource "oci_core_subnet" "WebSubnetAD3" {
  availability_domain = "${data.oci_identity_availability_domains.ADs.availability_domains.2.name}"
  cidr_block = "10.0.3.0/24"
  display_name = "WebSubnetAD3"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${oci_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${oci_core_security_list.WebSubnet.id}"]
  dhcp_options_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
    
  dns_label="w3"
}
*/

