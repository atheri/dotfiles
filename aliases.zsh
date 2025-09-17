alias vim="nvim"
alias awssso="aws sso login --profile sandbox"
alias piplogin="aws codeartifact login --region us-west-2 --tool pip --repository redwood-pypi --domain redwood --domain-owner 250982523368 --profile infra"
alias twinelogin="aws codeartifact login --region us-west-2 --tool twine --repository redwood-pypi --domain redwood --domain-owner 250982523368 --profile infra"
function uvlogin() {
  AWS_DOMAIN="redwood"
  AWS_ACCOUNT_ID="250982523368"
  AWS_REGION="us-west-2"
  AWS_CODEARTIFACT_REPOSITORY="redwood-pypi"
  AWS_CODEARTIFACT_TOKEN="$(
      aws codeartifact get-authorization-token \
      --domain $AWS_DOMAIN \
      --domain-owner $AWS_ACCOUNT_ID \
      --query authorizationToken \
      --output text \
      --profile infra
  )"
  export UV_INDEX_PRIVATE_REGISTRY_USERNAME=aws
  export UV_INDEX_PRIVATE_REGISTRY_PASSWORD="$AWS_CODEARTIFACT_TOKEN"
  cat > ~/.config/uv/uv.toml <<FILE
[[index]]
url = "https://aws:${AWS_CODEARTIFACT_TOKEN}@${AWS_DOMAIN}-${AWS_ACCOUNT_ID}.d.codeartifact.${AWS_REGION}.amazonaws.com/pypi/${AWS_CODEARTIFACT_REPOSITORY}/simple/"
default = true
FILE
}

alias va="source .venv/bin/activate"
alias vc="uv pip list --format json | jq -r '.[].name' | grep -v '^pip$' | xargs uv pip uninstall"

alias k="kubectl"
alias kc="kubectl confirm"
alias kubectx="kubectl ctx"
alias kubens="kubectl ns"

alias docker_remove='docker stop $(docker ps -aq); docker rm -f $(docker ps -aq)'

alias vpnc="sudo -i exit; nohup sudo gpclient connect rno03-gw1.redwoodmaterials.com -g rno03-gw1.redwoodmaterials.com --browser chrome &> /dev/null &"
alias vpnd="pgrep -f gpclient | head -n 1 | awk '{print \"kill -9 \" \$1}' | sh"

function watchpods() {watch "kubectl get pods -A | grep -E '$1'"}

alias ecrlogin="aws ecr get-login-password --profile infra --region us-west-2 | docker login --username AWS --password-stdin 250982523368.dkr.ecr.us-west-2.amazonaws.com"

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

function pycharm() {
  nohup pycharm "$@" >/dev/null 2>&1 &
}

function k_getcertexp() {
  kubectl get secret $1 -o "jsonpath={.data['tls\.crt']}" | base64 -d | openssl x509 -enddate -noout
}

