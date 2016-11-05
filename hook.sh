#!/bin/sh

deploy_challenge() {
	local DOMAIN="${1}" TOKEN_VALUE="${3}"

	local hosted_zone_id=$(aws route53 list-hosted-zones | sed -nr 's/.*hostedzone\/(.*)".*/\1/p')

	cat <<-EOF > create-record.json
	{
		"Comment": "dns-01 challenge for ACME",
		"Changes": [
			{
				"Action": "CREATE",
				"ResourceRecordSet": {
					"Name": "*.$DOMAIN",
					"Type": "TXT",
					"TTL": 5,
					"ResourceRecords": [
						{
							"Value": "\"$TOKEN_VALUE\""
						}
					]
				}
			}
		]
	}
	EOF

	aws route53 change-resource-record-sets --hosted-zone-id $hosted_zone_id --change-batch file:///$(pwd)/create-record.json
	sleep 30
}

clean_challenge() {
	local DOMAIN="${1}" TOKEN_VALUE="${3}"

	local hosted_zone_id=$(aws route53 list-hosted-zones | sed -nr 's/.*hostedzone\/(.*)".*/\1/p')

	cat <<-EOF > delete-record.json
	{
		"Comment": "dns-01 challenge for ACME",
		"Changes": [
			{
				"Action": "DELETE",
				"ResourceRecordSet": {
					"Name": "*.$DOMAIN",
					"Type": "TXT",
					"TTL": 5,
					"ResourceRecords": [
						{
							"Value": "\"$TOKEN_VALUE\""
						}
					]
				}
			}
		]
	}
	EOF

	aws route53 change-resource-record-sets --hosted-zone-id $hosted_zone_id --change-batch file:///$(pwd)/delete-record.json

	rm create-record.json
	rm delete-record.json
}

deploy_cert() {
	local DOMAIN="${1}" KEYFILE="${2}" CERTFILE="${3}" FULLCHAINFILE="${4}" CHAINFILE="${5}" TIMESTAMP="${6}"

	mkdir -p kubryant.in/certs/kubryant.in

	cp -rf accounts kubryant.in
	cp -rL certs/kubryant.in/cert.csr kubryant.in/certs/kubryant.in
	cp -rL certs/kubryant.in/cert.pem kubryant.in/certs/kubryant.in
	cp -rL certs/kubryant.in/chain.pem kubryant.in/certs/kubryant.in
	cp -rL certs/kubryant.in/fullchain.pem kubryant.in/certs/kubryant.in
	cp -rL certs/kubryant.in/privkey.pem kubryant.in/certs/kubryant.in

	aws s3 cp ./kubryant.in s3://kubryant-secure --recursive

	rm -rf kubryant.in

	local CERTNAME=$(aws acm import-certificate --region us-east-1 --certificate "$(cat $CERTFILE)" --private-key "$(cat $KEYFILE)" --certificate-chain "$(cat $CHAINFILE)" | sed -nr 's/.*CertificateArn": "(.*)".*/\1/p')
	aws elb set-load-balancer-listener-ssl-certificate --region us-east-1 --load-balancer-name kubryant-lb --load-balancer-port 443 --ssl-certificate-id $CERTNAME
}

unchanged_cert() {
	local DOMAIN="${1}" KEYFILE="${2}" CERTFILE="${3}" FULLCHAINFILE="${4}" CHAINFILE="${5}"
}

HANDLER="$1"; shift
"$HANDLER" "$@"
