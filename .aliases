alias startvpn='sudo openvpn --cd ~/ --config ~/.ovpn --daemon'
alias stopvpn='sudo kill $(pgrep -f openvpn)'
alias restartvpn='stopvpn;startvpn'
alias checkvpn='pgrep openvpn'

alias ssh_slave3='ssh ubuntu@jenkins-jobSlave3.ops.us-west-2.clearcollateral.com'
alias ssh_slave4='ssh ubuntu@jenkins-jobSlave4.ops.us-west-2.clearcollateral.com'

alias mfaiam="aws-mfa --duration 3600 --short-term-suffix iam --profile clearcapital"
alias mfabpprod="aws-mfa --duration 3600 --assume-role arn:aws:iam::375832628898:role/DevOps --short-term-suffix bpprod --profile clearcapital"
alias mfaprod="aws-mfa --duration 3600 --assume-role arn:aws:iam::722407567653:role/DevOps --short-term-suffix prod --profile clearcapital"
alias mfadev="aws-mfa --duration 3600 --assume-role arn:aws:iam::296857587692:role/DevOps --short-term-suffix dev --profile clearcapital"
alias mfamain="aws-mfa --duration 3600 --assume-role arn:aws:iam::301792755408:role/DevOps --short-term-suffix main --profile clearcapital"
alias mfabpnpe="aws-mfa --duration 3600 --assume-role arn:aws:iam::403019993419:role/DevOps --short-term-suffix bpnpe --profile clearcapital"
alias mfaae="aws-mfa --duration 3600 --assume-role arn:aws:iam::470225182719:role/DevOps --short-term-suffix ae --profile clearcapital"
alias mfabiwell="aws-mfa --duration 3600 --assume-role arn:aws:iam::447582771975:role/DevOps --short-term-suffix biwell --profile clearcapital"
alias mfara="aws-mfa --duration 3600 --assume-role arn:aws:iam::977427857772:role/DevOps --short-term-suffix ra --profile clearcapital"
alias mfaservicedesk="aws-mfa --duration 3600 --assume-role arn:aws:iam::127555975495:role/DevOps --short-term-suffix servicedesk --profile clearcapital"
alias mfainstaclustr="aws-mfa --duration 3600 --assume-role arn:aws:iam::862958688947:role/DevOps --short-term-suffix instaclustr --profile clearcapital"
alias mfadrops="aws-mfa --duration 3600 --assume-role arn:aws:iam::759107157084:role/DevOps --short-term-suffix drops --profile clearcapital"
alias mfadrssot="aws-mfa --duration 3600 --assume-role arn:aws:iam::464932029236:role/DevOps --short-term-suffix drssot --profile clearcapital"
alias mfadrccp="aws-mfa --duration 3600 --assume-role arn:aws:iam::560868401279:role/DevOps --short-term-suffix drccp --profile clearcapital"
alias mfaall="mfabpprod;mfaprod;mfadev;mfamain;mfabpnpe;mfaae;mfabiwell;mfara;mfainstaclustr;mfaservicedesk"

alias k="kubectl"

alias ecrlogin_main="mfamain; aws ecr get-login --no-include-email --profile clearcapital-main --region us-west-2 | source /dev/stdin"
alias ecrlogin_drops="mfadrops; aws ecr get-login --no-include-email --profile clearcapital-drops --region us-east-1 | source /dev/stdin"
