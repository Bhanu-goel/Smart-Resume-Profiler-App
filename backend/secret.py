import secrets

# Generate a random 256-bit key (32 bytes)
secret_key = secrets.token_hex(32)
print("Generated JWT Secret Key:", secret_key)
