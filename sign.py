from jwt import (
    JWT,
    jwk_from_pem,
)

instance = JWT()

# Ditt JWT-payload, till exempel användardata eller annan information
payload = {
    "sub": "1234567890",
    "name": "John Doe",
    "iat": 1516239022
}

# Din privata nyckel
with open('jwt_key.pem', 'rb') as fh:
    signing_key = jwk_from_pem(fh.read())

# Skapa JWT med signatur
jwt_token = instance.encode(payload, signing_key, alg='RS256')

print(jwt_token)
