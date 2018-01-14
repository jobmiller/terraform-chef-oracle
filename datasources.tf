# Gets a list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

# Gets the OCID of the image. This technique is for example purposes only. The results of oci_core_images may
# change over time for Oracle-provided images, so the only sure way to get the correct OCID is to supply it directly.
data "oci_core_images" "OLImageOCID" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "${var.InstanceImageDisplayName}"
}

#FIND the VCN ID for the Complete VCN if Exists

data "oci_core_virtual_networks" "vcn" {
  compartment_id = "${var.compartment_ocid}"

  filter {
    name="display_name"
    values= ["CompleteVCN"]
    regex = true
  }
depends_on=["oci_core_virtual_network.CompleteVCN"]
}

#FIND the PRIVATE Subnets for the Complete VCN identified above.
#Should only be one VCN with this name

data "oci_core_subnets" "DBsub" {
      compartment_id = "${var.compartment_ocid}"
      vcn_id = "${data.oci_core_virtual_networks.vcn.0.virtual_networks.0.id}"
   filter {
     name="display_name"
     values=["\\w*Private\\w*"]
     regex=true
    }

}

#Find the WebSubnets.   The data source approach groups the Subnets with their corresponding ADs.
#That makes it easy to reference AD and Subnet with the same index for multiple instance creation 

data "oci_core_subnets" "Websub" {
      compartment_id = "${var.compartment_ocid}"
      vcn_id = "${data.oci_core_virtual_networks.vcn.0.virtual_networks.0.id}"
   filter {
     name="display_name"
     values=["\\w*Web\\w*"]
     regex=true
    }
depends_on = ["oci_core_subnet.WebSubnets"]
}


