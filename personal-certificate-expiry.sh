#!/bin/bash

# List of certificate ARNs
certificate_arns=(
arn:aws:acm:eu-west-2:416591745024:certificate/a3e55f8c-bfb7-411a-8508-08690eece298
)



for arn in "${certificate_arns[@]}";

do

# Split the certificate entry into ARN and domain name
    IFS=' ' read -ra cert_info <<< "$arn"
    arn="${cert_info[0]}"
    domain="${cert_info[1]}"

    certificate_info=$(aws acm describe-certificate --certificate-arn "$arn")

    # Extract and display the NotAfter timestamp using jq
    not_after_timestamp=$(echo "$certificate_info" | jq -r '.Certificate.NotAfter')
    not_before_timestamp=$(echo "$certificate_info" | jq -r '.Certificate.NotBefore')

    # Display the results
    echo "Certificate ARN: $arn"
    echo "Domain Name: $domain"
    echo "NotAfter Timestamp: $not_after_timestamp"
    echo "NotBefore Timestamp: $not_before_timestamp"
    echo "------------------------"
done