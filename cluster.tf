# Create a firewall
resource "civo_firewall" "private" {
  name = "private"
}

# Create a firewall rule
resource "civo_firewall_rule" "kubernetes" {
  firewall_id = civo_firewall.private.id
  protocol    = "tcp"
  start_port  = "6443"
  end_port    = "6443"
  cidr        = var.cidr_ranges
  direction   = "ingress"
  label       = "kubernetes-api-server"
}

# Create a cluster
resource "civo_kubernetes_cluster" "cluster" {
  name              = var.cluster
  applications      = join(",", var.applications)
  num_target_nodes  = var.worker_node_count
  target_nodes_size = var.worker_node_size
  firewall_id       = civo_firewall.private.id
}
