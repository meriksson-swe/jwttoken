from jwt import (
    JWT,
    jwk_from_pem
)

instance = JWT()
token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiAiMTIzNDU2Nzg5MCIsICJuYW1lIjogIkpvaG4gRG9lIiwgImlhdCI6IDE1MTYyMzkwMjJ9.09Jp1l8tizHNWk9S6M0nRi80-n9SvAPy75N-zP6gxKg7xLu5r0qKjA98dmyMgG50wyn_-8P6edyKsGl8rQ9f7xTsqhfJOyOLpqZrSvG0bs7B6kzbliz_Q__Kx6rd0XweWeu9BidJcppuxqzFggsgqSshvs3XZ482YQnEZWoN4JWIt42_UZhm-Xegk4u6hv32RTALyxs-VRlTausfl0aNSk7sagDCyyv7oHJ-v2so4rCxTvKNRXkl-5HmGycjiG1-4PawPpJtngnfeqOxHsv-enx_IJHtHqKXC77FTMWxcB6X8fYXltwHVzjMAvZiP9jRzGFgULBSYisYV6DwuSGbIg'

# Din publika nyckel
with open('jwt_key.pub', 'rb') as fh:
    verifying_key = jwk_from_pem(fh.read())

message_received = instance.decode(token, verifying_key, ['RS256', ])

print(message_received)
