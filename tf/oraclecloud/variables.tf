variable "ssh_public_key_path" {
  description = "Path to public key file"
  sensitive   = true
  default = null
}
variable "instance_count" {
  description = "Number of instances on Oracle Cloud Infrastructure"
  default = 0
}
variable "api_key_fingerprint" {
  sensitive   = true
  default = null
}
variable "api_private_key_path" {
  sensitive = true
  default = null
}
variable "compartment_ocid" {
  sensitive   = true
  default = null
}
variable "tenancy_ocid" {
  sensitive   = true
  default = null
}
variable "user_ocid" {
  sensitive   = true
  default = null
}
variable "region" {
  sensitive = true
  default = null
}
variable "free_tier_availability_domain" {
  sensitive = true
  default = null
}

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
