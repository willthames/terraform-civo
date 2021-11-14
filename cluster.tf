resource "civo_network" "private" {
  label = "private"
}

# Create a firewall
resource "civo_firewall" "private" {
  network_id = civo_network.private.id
  name       = "private"
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
#
# Create a firewall rule
resource "civo_firewall_rule" "public" {
  firewall_id = civo_firewall.private.id
  protocol    = "tcp"
  start_port  = "443"
  end_port    = "443"
  cidr        = ["0.0.0.0/0"]
  direction   = "ingress"
  label       = "allow-public-access"
}

resource "civo_kubernetes_cluster" "cluster" {
  name              = var.cluster
  applications      = join(",", var.applications)
  num_target_nodes  = var.worker_node_count
  target_nodes_size = var.worker_node_size
  firewall_id       = civo_firewall.private.id
  network_id        = civo_network.private.id
}

resource "civo_kubernetes_node_pool" "public" {
  cluster_id        = civo_kubernetes_cluster.cluster.id
  num_target_nodes  = var.worker_node_count
  target_nodes_size = var.worker_node_size
}

resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig"
  content  = civo_kubernetes_cluster.cluster.kubeconfig
}

