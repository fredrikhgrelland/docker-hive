provider "nomad" {
  address = "http://127.0.0.1:4646"
}


resource "nomad_job" "minio_s3" {
  jobspec = file("${path.cwd}/../nomad/minio-connect.hcl")
  detach = false
}

resource "nomad_job" "hive" {
  jobspec = file("${path.cwd}/../nomad/hive-connect.hcl")
  detach = false
}