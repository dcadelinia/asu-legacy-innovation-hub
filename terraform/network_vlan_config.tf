# ==============================================================================
# TERRAFORM PROVISIONING BLUEPRINT: ASU LEGACY & INNOVATION HUB NETWORK CORE
# ==============================================================================

terraform {
  required_providers {
    cisco = {
      source  = "ciscodevnet/cisco"
      version = "1.0.0"
    }
  }
}

provider "cisco" {
  host_url = "https://asurams.edu"
}

# Provision VLAN 10: Academic & Active Student Housing
resource "cisco_vlan" "student_housing" {
  vlan_id   = 10
  vlan_name = "ASU_Hub_Student_Housing"
  status    = "active"
}

# Provision VLAN 20: Secure Fintech Partnership Incubator
resource "cisco_vlan" "fintech_lab" {
  vlan_id   = 20
  vlan_name = "ASU_Hub_FinTech_Sandbox"
  status    = "active"
}

# Provision VLAN 30: High-Density WISPO Alumni Event Hub
resource "cisco_vlan" "alumni_event" {
  vlan_id   = 30
  vlan_name = "ASU_Hub_WISPO_Alumni_Gala"
  status    = "active"
}

# Inter-VLAN Routing Restriction (Enforcing Security Boundaries)
resource "cisco_access_list" "isolate_event_vlan" {
  acl_name = "BLOCK_GUEST_TO_INTERNAL_RECORDS"
  rules = [
    "deny ip 10.30.0.0 255.255.0.0 10.10.0.0 255.255.0.0",
    "deny ip 10.30.0.0 255.255.0.0 10.20.0.0 255.255.0.0",
    "permit ip any any"
  ]
}
