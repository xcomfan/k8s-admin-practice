# k8s-admin-practice

K8s admin certification practice

## Bring up resources in AWS for labs

```bash
terraform init
terraform plan
terraform apply
```

## Destroy resources when done with lab work

```bash
terraform destroy
```

## Configure Kubectl to work with EKS cluster

Once Terraform completes running y ou will output similar to below

```text
cluster_endpoint = "https://..."
cluster_name = "eks-practice-cluster-randomstring"
cluster_security_group_id = "sg-XXXX"
region = "us-west-2"
```

Use the above output in the configuration commands below.

```bash
aws sts get-caller-identity
aws eks update-kubeconfig --region <region_from_terraform_output> --name <name_from_terraform_output>
kubectl get svc # To verify
```

## Create new namespace and configure kubectl to default to that namespace

```bash
kubectl create namespace <name_of_namespace>
kubectl config set-context --current --namespace <name_of_namespace>
```
