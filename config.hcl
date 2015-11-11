backend "s3" {
  bucket = "vault.jgillich"
  region = "eu-central-1"
}

listener "tcp" {
  address = "0.0.0.0:4321"
  tls_disable = 1
}

disable_mlock = true
