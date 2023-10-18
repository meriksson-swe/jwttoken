#!/bin/bash

base64url_decode() {
  local input="${1//_//+}"  # Replace '_' with '+' (URL-safe character conversion)
  input="${input//-//}"     # Replace '-' with '/' (URL-safe character conversion)
  local padding=$((4 - ${#input} % 4))  # Calculate the number of padding characters
  input="${input}${padding//?/=}"  # Add padding characters if needed
  echo "$input" | base64 -d
}

# Ange din token
JWT='eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiAiMTIzNDU2Nzg5MCIsICJuYW1lIjogIkpvaG4gRG9lIiwgImlhdCI6IDE1MTYyMzkwMjJ9.09Jp1l8tizHNWk9S6M0nRi80-n9SvAPy75N-zP6gxKg7xLu5r0qKjA98dmyMgG50wyn_-8P6edyKsGl8rQ9f7xTsqhfJOyOLpqZrSvG0bs7B6kzbliz_Q__Kx6rd0XweWeu9BidJcppuxqzFggsgqSshvs3XZ482YQnEZWoN4JWIt42_UZhm-Xegk4u6hv32RTALyxs-VRlTausfl0aNSk7sagDCyyv7oHJ-v2so4rCxTvKNRXkl-5HmGycjiG1-4PawPpJtngnfeqOxHsv-enx_IJHtHqKXC77FTMWxcB6X8fYXltwHVzjMAvZiP9jRzGFgULBSYisYV6DwuSGbIg'

# Hämta tokenets header
#HEADER=$(echo -n $JWT | cut -d'.' -f1 | base64 -d)
HEADER=$(echo $JWT | cut -d'.' -f1)

# Hämta tokenets payload
#PAYLOAD=$(echo -n $JWT | cut -d'.' -f2 | base64 -d)
PAYLOAD=$(echo $JWT | cut -d'.' -f2)

# Hämta signaturen
SIGNATURE=$(echo $JWT | cut -d'.' -f3)

PUBLIC_KEY=$(cat jwt_key.pub)

# Skapa en temporär fil med tokenets header och payload
echo "$HEADER.$PAYLOAD" > temp_input.txt

# Skapa en temporär fil med tokenets signatur
base64url_decode $(echo "$SIGNATURE") > temp_signature.txt

# Verifiera signaturen
openssl dgst -sha256 -verify jwt_key.pub -signature temp_signature.txt temp_input.txt

# Rensa upp temporära filer
rm temp_input.txt temp_signature.txt