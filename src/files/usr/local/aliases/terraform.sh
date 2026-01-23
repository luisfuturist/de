# Terraform shortcuts
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfo='terraform output'

alias tfl='terraform login'
alias tfv='terraform validate'
alias tff='terraform fmt -recursive'
alias tfsh='terraform show'

alias tfs='terraform state'
alias tfsa='terraform state list'
alias tfsi='terraform state inspect'

alias tfiw='terraform init -upgrade'
alias tfpl='terraform plan -out=tfplan'
alias tfap='terraform apply tfplan'

# Terraform workspace shortcuts
alias tfw='terraform workspace'
alias tfwsh='terraform workspace show'         
alias tfwa='terraform workspace list'         
alias tfwn='terraform workspace new'          
alias tfwe='terraform workspace select'       
