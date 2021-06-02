alias startvpn='sudo openvpn --cd ~/ --config ~/.ovpn --daemon'
alias stopvpn='sudo kill $(pgrep -f openvpn)'
alias restartvpn='stopvpn;startvpn'
alias checkvpn='pgrep openvpn'

alias ssh_slave3='ssh ubuntu@jenkins-jobSlave3.ops.us-west-2.clearcollateral.com'
alias ssh_slave4='ssh ubuntu@jenkins-jobSlave4.ops.us-west-2.clearcollateral.com'

alias mfaiam="aws-mfa --duration 43200 --short-term-suffix iam --profile clearcapital"
alias mfamain="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::301792755408:role/DevOps --short-term-suffix main --no-mfa-prompt"
alias mfamain_prodk8s="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::301792755408:role/Prod_k8s --short-term-suffix main-prodk8s --no-mfa-prompt"
alias mfaccpnpe="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::115794596245:role/DevOps --short-term-suffix ccpnpe --no-mfa-prompt"
alias mfaccpprod="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::063578169992:role/DevOps --short-term-suffix ccpprod --no-mfa-prompt"
alias mfaprod="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::722407567653:role/DevOps --short-term-suffix prod --no-mfa-prompt"
alias mfabpnpe="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::403019993419:role/DevOps --short-term-suffix bpnpe --no-mfa-prompt"
alias mfabpprod="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::375832628898:role/DevOps --short-term-suffix bpprod --no-mfa-prompt"
alias mfabiwell="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::447582771975:role/DevOps --short-term-suffix biwell --no-mfa-prompt"
alias mfara="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::977427857772:role/DevOps --short-term-suffix ra --no-mfa-prompt"
alias mfadev="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::296857587692:role/DevOps --short-term-suffix dev --no-mfa-prompt"
alias mfaae="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::470225182719:role/DevOps --short-term-suffix ae --no-mfa-prompt"
alias mfaservicedesk="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::127555975495:role/DevOps --short-term-suffix servicedesk --no-mfa-prompt"
alias mfainstaclustr="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::862958688947:role/DevOps --short-term-suffix instaclustr --no-mfa-prompt"
alias mfadrops="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::759107157084:role/DevOps --short-term-suffix drops --no-mfa-prompt"
alias mfadrssot="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::464932029236:role/DevOps --short-term-suffix drssot --no-mfa-prompt"
alias mfadrccp="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::560868401279:role/DevOps --short-term-suffix drccp --no-mfa-prompt"
alias mfasecurity="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::763108605165:role/DevOps --short-term-suffix security --no-mfa-prompt"
alias mfadatadev="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::758725036624:role/DevOps --short-term-suffix datadev --no-mfa-prompt"
alias mfadatanpe="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::786545986622:role/DevOps --short-term-suffix datanpe --no-mfa-prompt"
alias mfadataprod="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::736018059497:role/DevOps --short-term-suffix dataprod --no-mfa-prompt"
alias mfaops="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::433331944320:role/DevOps --short-term-suffix ops --no-mfa-prompt"
alias mfamlnpe="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::176011176461:role/DevOps --short-term-suffix mlnpe --no-mfa-prompt"
alias mfamlprod="aws-mfa --duration 3600 --profile clearcapital --long-term-suffix iam --assume-role arn:aws:iam::291151831236:role/DevOps --short-term-suffix mlprod --no-mfa-prompt"

function mfaall() {
  aliasList=(${(ok)aliases})
  echo "mfaiam"
  mfaiam
  for thing in $aliasList ; do
    if [[ $thing =~ ^mfa.* ]]; then
      if ! [[ $thing == mfaall || $thing == mfaiam ]]; then
        echo "${thing}"
        eval ${thing}
      fi
    fi
  done
}

alias k="kubectl"
alias k1.9="kubectl-1.9"
alias kvu="kubectl view-utilization"

function watchpods() {watch "kubectl get pods -A | grep -E '$1'"}

alias ecrlogin_main="mfamain; aws ecr get-login-password --profile clearcapital-main --region us-west-2 | docker login --username AWS --password-stdin 301792755408.dkr.ecr.us-west-2.amazonaws.com"
alias ecrlogin_drops="mfadrops; aws ecr get-login --no-include-email --profile clearcapital-drops --region us-east-1 | source /dev/stdin"

function setAws() {eval "$(~/utils/set.sh $1 $2)"}

alias cd_Rlib="cd /usr/local/lib/R/3.6/site-library"
