resource "oci_core_subnet" "BastionSubnet" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[count.index],"name")}"
  cidr_block = "10.0.${count.index+7}.0/24"
  display_name = "BastionSubnetAD-${count.index+1}"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${oci_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${oci_core_security_list.BastionSubnet.id}"]
  dhcp_options_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"

  dns_label="b${count.index+1}"
}
