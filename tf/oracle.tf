variable "oci_api_key_fingerprint" {
  sensitive   = true
}
variable "oci_api_private_key_path" {}
variable "oci_compartment_ocid" {
  sensitive   = true
}
variable "oci_tenancy_ocid" {
  sensitive   = true
}
variable "oci_user_ocid" {
  sensitive   = true
}
variable "oci_region" {}
variable "oci_free_tier_availability_domain" {}

variable "vcn_cidr_block" {
  default = "10.10.0.0/16"
}

variable "availability_domain_number" {
  default = 1
}

variable "instance_shape" {
  # Free-Tier is VM.Standard.E2.1.Micro
  default = "VM.Standard.E2.1.Micro"
}

variable "instance_image_ocid" {
  type = map

  default = {
    # See https://docs.oracle.com/en-us/iaas/images/image/f54a6c52-ce85-4265-93c8-3f73a04e0417/
    # Oracle-provided image "Canonical-Ubuntu-20.04-2020.07.16-0"
    ap-chuncheon-1   = "ocid1.image.oc1.ap-chuncheon-1.aaaaaaaa3zfnhwiz6wdivsde25sqbyino77xiagiwsodskuumewh2ntkkjoq"
    ap-hyderabad-1   = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaaobit2prcrljmondr3yb76cxlm32vvzgivuzadufywsikxc37xmua"
    ap-melbourne-1   = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaaergegjvauetlcqr27vkhtzjj7bjv3g232jks6yykzf5dpe6rifia"
    ap-mumbai-1      = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaagcwv5tqqucwd6lfhb3voyvy33u6ffrgciw4rutzunfg6huddb75q"
    ap-osaka-1       = "ocid1.image.oc1.ap-osaka-1.aaaaaaaaq2gdoqc2gsxyci2dgean3ngqucmbq7emwq3lim7675qxmdepzc2q"
    ap-seoul-1       = "ocid1.image.oc1.ap-seoul-1.aaaaaaaadgbnqkhsypsk7mqqbjwsffanjyjrtypnrcbduj7jax6b4mk4dhia"
    ap-sydney-1      = "ocid1.image.oc1.ap-sydney-1.aaaaaaaahgmfxhthbf5v7hrnffdacqgcx6usyj3nxvvhevxnenlboqr22h5a"
    ap-tokyo-1       = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaafum27fx3f6wzkukxnjpjouymk3fkfscn36vprst5wb3dyqc64x5a"
    ca-montreal-1    = "ocid1.image.oc1.ca-montreal-1.aaaaaaaaoleccuhxasjp4ghmznvnvuzmkrexmws2bwfgmw2huqaxkfu3tn7a"
    ca-toronto-1     = "ocid1.image.oc1.ca-toronto-1.aaaaaaaaqjysbltuqafsakcjuawtppajt4glidrrdtn2z3wy3fk2egoqhnmq"
    eu-amsterdam-1   = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaazymbvno77imz4cj7kmpen6f3f2sbao62v3ug7isopreuuvekcpdq"
    eu-frankfurt-1   = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaqto22mifcsemfb6soqca47ufyqread73zbz44ct7kra5csgy7hka"
    eu-zurich-1      = "ocid1.image.oc1.eu-zurich-1.aaaaaaaattkas6klgyh4xzduoam47fwhvkte5ajsnpg2d4avmrgl3irrrcwa"
    me-dubai-1       = "ocid1.image.oc1.me-dubai-1.aaaaaaaam4ybeug25ztp7kdrisxeb7w3bzlbvy2cg2usj5vj4rj33xkuid6a"
    me-jeddah-1      = "ocid1.image.oc1.me-jeddah-1.aaaaaaaa77w36aq2izaqq2hyazvqaapytfhxsavfjcjfobuxot4d642xny2a"
    sa-santiago-1    = "ocid1.image.oc1.sa-santiago-1.aaaaaaaagczeuvnxfsbgzjsytmlv343dezqhcfvyh24euuozyysygwf4qpha"
    sa-saopaulo-1    = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaandbj5tu656nigjgejj2xudkuywlk7t37aft5uki72l5y3fr4yimq"
    uk-cardiff-1     = "ocid1.image.oc1.uk-cardiff-1.aaaaaaaajchhm62wlpdqw6s4ukp5gonlmtmqosg4tu5kt3wxkfyiwdouunpq"
    uk-london-1      = "ocid1.image.oc1.uk-london-1.aaaaaaaaxkpxtvbm2av6y7jvnyw7ife4usywqyx3niu5y6msmgewqxsu2hdq"
    us-ashburn-1     = "ocid1.image.oc1.iad.aaaaaaaa3lgud4qd5op4euavw7ilyeaie7fiakvs64khlswok4llmcsasmiq"
    us-gov-ashburn-1 = "ocid1.image.oc3.us-gov-ashburn-1.aaaaaaaaz6fvfik6o4pn2y5sfickqc54erwjdw3y2m4zqronv5qkchbslw5a"
    us-gov-chicago-1 = "ocid1.image.oc3.us-gov-chicago-1.aaaaaaaafamrtv7tme35flm6rh7np57tpy3kpjoynlbdawchgkkir5vjfdwa"
    us-gov-phoenix-1 = "ocid1.image.oc3.us-gov-phoenix-1.aaaaaaaamvyue7nluogi6hpe5t4mtb2k2n3xzwdmuva4kkhhcfagevmg42uq"
    us-langley-1     = "ocid1.image.oc2.us-langley-1.aaaaaaaamfqdjpirigiwupd2ky3eupvkib7tstra2ppr4q772dlt5ncdc77q"
    us-luke-1        = "ocid1.image.oc2.us-luke-1.aaaaaaaaiz2j5woo3qiqfenc4fjus2lqozyjsniq2o4crop3tq6qy5crj3pa"
    us-phoenix-1     = "ocid1.image.oc1.phx.aaaaaaaapchgdasb7cqxmalialeb4zifuwfplpaxtntuoyswxvqrinr3uvwa"
    us-sanjose-1     = "ocid1.image.oc1.us-sanjose-1.aaaaaaaan4g4q527bljtyczck6xrsutbzps6h7mut2xcfhnbzw66sbbsvwoq"
  }
}

provider "oci" {
  tenancy_ocid     = var.oci_tenancy_ocid
  user_ocid        = var.oci_user_ocid
  fingerprint      = var.oci_api_key_fingerprint
  private_key_path = var.oci_api_private_key_path
  region           = var.oci_region
}

resource "oci_core_vcn" "swarm_vcn" {
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.oci_compartment_ocid
  display_name   = "SwarmVCN"
  dns_label      = "SwarmVCN"
}

resource "oci_core_subnet" "swarm_subnet" {
  availability_domain = var.oci_free_tier_availability_domain
  cidr_block          = var.vcn_cidr_block
  display_name        = "SwarmSubnet"
  dns_label           = "SwarmSubnet"
  security_list_ids   = [oci_core_security_list.swarm_security_list.id]
  compartment_id      = var.oci_compartment_ocid
  vcn_id              = oci_core_vcn.swarm_vcn.id
  route_table_id      = oci_core_vcn.swarm_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.swarm_vcn.default_dhcp_options_id
}

resource "oci_core_internet_gateway" "swarm_internet_gateway" {
  compartment_id = var.oci_compartment_ocid
  display_name   = "Swarm_IG"
  vcn_id         = oci_core_vcn.swarm_vcn.id
}

resource "oci_core_default_route_table" "test_route_table" {
  manage_default_resource_id = oci_core_vcn.swarm_vcn.default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.swarm_internet_gateway.id
  }
}

resource "oci_core_security_list" "swarm_security_list" {
  compartment_id = var.oci_compartment_ocid
  vcn_id         = oci_core_vcn.swarm_vcn.id
  display_name   = "Swarm Security List"

  // allow all outbound traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    protocol  = "all"
    source    = "0.0.0.0/0"
    stateless = false

  }

  // allow inbound ssh traffic
//  ingress_security_rules {
//    protocol  = "6" // tcp
//    source    = "0.0.0.0/0"
//    stateless = false
//
//    tcp_options {
//      source_port_range {
//        min = 1
//        max = 65535
//      }
//
//      // These values correspond to the destination port range.
//      min = 22
//      max = 22
//    }
//  }

  // allow inbound icmp traffic of a specific type
//  ingress_security_rules {
//    description = "icmp_inbound"
//    protocol    = 1
//    source      = "0.0.0.0/0"
//    stateless   = false
//
//    icmp_options {
//      type = 3
//      code = 4
//    }
//  }

//  ingress_security_rules {
//    protocol = "6" # TCP
//    source   = "0.0.0.0/0"
//    tcp_options {
//      min = 655
//      max = 655
//    }
//  }

//  ingress_security_rules {
//    protocol = "17" # UDP
//    source   = "0.0.0.0/0"
//    udp_options {
//      min = 655
//      max = 655
//    }
//  }

//  ingress_security_rules {
//    protocol = "6" # TCP
//    source   = "0.0.0.0/0"
//    tcp_options {
//      min = 80
//      max = 80
//    }
//  }

//  ingress_security_rules {
//    protocol = "6" # TCP
//    source   = "0.0.0.0/0"
//    tcp_options {
//      min = 443
//      max = 443
//    }
//  }

}

resource "oci_core_instance" "instances" {
  count               = var.oci_instance_count
  availability_domain = var.oci_free_tier_availability_domain
  compartment_id      = var.oci_compartment_ocid
  display_name        = format("oci-instance-%02d", count.index + 1)
  shape               = var.instance_shape

  create_vnic_details {
    subnet_id        = oci_core_subnet.swarm_subnet.id
    display_name     = "PrimaryVNIC"
    assign_public_ip = true
    hostname_label   = format("oci-instance-%02d", count.index + 1)
  }

  source_details {
    source_type = "image"
    source_id   = var.instance_image_ocid[var.oci_region]
  }

  metadata = {
    ssh_authorized_keys = trimspace(file(var.ssh_public_key_path))
  }

  timeouts {
    create = "60m"
  }

  is_pv_encryption_in_transit_enabled = "true"
}
