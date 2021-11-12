terraform {
  required_providers {
    civo = {
      source  = "civo/civo"
      version = "1.0.5"
    }
  }
}

provider "civo" {
  token  = file("./.civotoken")
  region = var.region
}
