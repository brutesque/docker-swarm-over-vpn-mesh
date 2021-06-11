resource "oci_core_vcn" "primary" {
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.compartment_ocid
  display_name   = format("%s VCN", var.project_name)
  dns_label      = format("%sVCN", regex("[[:alnum:]]+", var.project_name))
}

resource "oci_core_subnet" "primary" {
  availability_domain = var.free_tier_availability_domain
  cidr_block          = var.vcn_cidr_block
  display_name        = format("%sSubnet", var.project_name)
  dns_label           = format("%sSubnet", regex("[[:alnum:]]+", var.project_name))
  security_list_ids   = [oci_core_security_list.primary.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.primary.id
  route_table_id      = oci_core_vcn.primary.default_route_table_id
  dhcp_options_id     = oci_core_vcn.primary.default_dhcp_options_id
}

resource "oci_core_internet_gateway" "primary" {
  compartment_id = var.compartment_ocid
  display_name   = format("%s Internet Gateway", var.project_name)
  vcn_id         = oci_core_vcn.primary.id
}

resource "oci_core_default_route_table" "test_route_table" {
  manage_default_resource_id = oci_core_vcn.primary.default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.primary.id
  }
}

resource "oci_core_security_list" "primary" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.primary.id
  display_name   = format("%s Security List", var.project_name)

  // allow all outbound traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  // allow inbound ssh traffic
  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      source_port_range {
        min = 1
        max = 65535
      }
      min = 22
      max = 22
    }
  }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    description = "icmp_inbound"
    protocol    = 1
    source      = "0.0.0.0/0"
    stateless   = false

    icmp_options {
      type = 3
      code = 4
    }
  }

  // allow inbound tinc traffic
  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 655
      max = 655
    }
  }

  ingress_security_rules {
    protocol = "17" # UDP
    source   = "0.0.0.0/0"
    udp_options {
      min = 655
      max = 655
    }
  }

  // allow inbound web traffic
  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 443
      max = 443
    }
  }

}

resource "oci_core_instance" "instances" {
  count               = var.instance_count
  availability_domain = var.free_tier_availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = format("oci-instance-%02d", count.index + 1)
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id        = oci_core_subnet.primary.id
    display_name     = format("%s VNIC", var.project_name)
    assign_public_ip = true
    hostname_label   = format("oci-instance-%02d", count.index + 1)
  }

  source_details {
    source_type = "image"
    source_id   = var.instance_image_ocid[var.region]
  }

  metadata = {
    ssh_authorized_keys = trimspace(file(var.ssh_public_key_path))
  }

  timeouts {
    create = "60m"
  }

  is_pv_encryption_in_transit_enabled = "true"
}
