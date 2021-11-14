# Creating a cluster

* Create a file called .civotoken containing your Civo API token
* Create a variables file containing any variables without defaults or that you wish to override. For instance:
    ```
    region      = "NYC1"
    cluster     = "civo-hackathon"
    cidr_ranges = ["1.2.3.4/32"]
    domain_name = "civo-hackathon.link"
    ```
* Run `terraform init`
* Run `terraform plan -out plan.out -var-file my.tfvars`
* Run `terraform apply plan.out` if you're happy with the plan

# Using the cluster

Running the above steps will create a kubeconfig file in the directory

To use the kubeconfig with `kubectl`, you can run:

* `export KUBECONFIG=$(pwd)/kubeconfig:~/.kube/config:$KUBECONFIG`
