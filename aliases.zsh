alias awssso="aws sso login --profile clearcapital-iam"

alias k="kubectl"
alias kc="kubectl confirm"
alias kubectx="kubectl ctx"
alias kubens="kubectl ns"

alias tg="terragrunt"

function watchpods() {watch "kubectl get pods -A | grep -E '$1'"}

alias ecrlogin_main="aws ecr get-login-password --profile clearcapital-main --region us-west-2 | docker login --username AWS --password-stdin 301792755408.dkr.ecr.us-west-2.amazonaws.com"
alias ecrlogin_drops="aws ecr get-login --no-include-email --profile clearcapital-drops --region us-east-1 | source /dev/stdin"

alias calogin_mlprod="aws codeartifact login --tool pip --repository cc-pypi --domain clearcapital-com --domain-owner 977427857772 --profile clearcapital-mlprod"
function switchJava() {sdk use java $(sdk list java | grep  '\-amzn' | grep 'installed' | cut -d '|' -f 6 - | fzf)}

function setAws() {eval "$(~/utils/set.sh $1 $2)"}

alias cd_Rlib="cd /usr/local/lib/R/3.6/site-library"

function export_profile() {  
  echo "exporting profile $1"
  aws-export-credentials --profile "$1" -c "${1}-export" --cache-file "$HOME/.aws/aws-credentials-export/$1"
}

function export_profile_orig() {  
  echo "exporting profile $1"
  aws-export-credentials --profile "$1" -c "${1}" --cache-file "$HOME/.aws/aws-credentials-export/$1"
}

function export_profiles() {  
  echo "exporting profiles"
  for thing in $(aws configure list-profiles) ; do
    if ! [[ $thing =~ ^.*-export$ ]]; then
      aws-export-credentials --profile "$thing" -c "${thing}-export" --cache-file "$HOME/.aws/aws-credentials-export/$thing"
      echo "exporting from SSO profile: $thing-export"
    fi
  done
}

function export_profiles_orig() {  
  rm $HOME/.aws/credentials 
  echo "exporting profiles"
  for thing in $(aws configure list-profiles) ; do
    if ! [[ $thing =~ ^.*-export$ ]]; then
      aws-export-credentials --profile "$thing" -c "${thing}" --cache-file "$HOME/.aws/aws-credentials-export/$thing"
      echo "exporting from SSO profile: $thing"
    fi
  done
}

function kube-toggle() {
  if (( ${+POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND} )); then
    unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND
  else
    POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern'
  fi
  p10k reload
  if zle; then
    zle push-input
    zle accept-line
  fi
}

function idea() {
  nohup idea "$@" >/dev/null 2>&1 &
}

function k_getcertexp() {
  kubectl get secret $1 -o "jsonpath={.data['tls\.crt']}" | base64 -d | openssl x509 -enddate -noout
}
