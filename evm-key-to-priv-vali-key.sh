#!/bin/bash
echo "⚙️  evm-key-to-priv-vali-key.py — thanks to BlockHunters for the idea!"

python3 - <<EOF
import base64, hashlib, json
from subprocess import Popen, PIPE

try:
    from ecdsa import SigningKey, SECP256k1
except ImportError:
    print("❌ Missing 'ecdsa' module. Installing...")
    import subprocess, sys
    subprocess.check_call([sys.executable, "-m", "pip", "install", "ecdsa"])
    from ecdsa import SigningKey, SECP256k1

priv_hex = input("Enter priv_hex: ").strip()
if not (len(priv_hex) == 64 and all(c in '0123456789abcdefABCDEF' for c in priv_hex)):
    print("❌ Invalid private key format.")
    exit(1)

priv_bytes = bytes.fromhex(priv_hex)
sk = SigningKey.from_string(priv_bytes, curve=SECP256k1)
vk = sk.get_verifying_key()
compressed_prefix = b'\x02' if vk.pubkey.point.y() % 2 == 0 else b'\x03'
compressed_pubkey = compressed_prefix + vk.pubkey.point.x().to_bytes(32, 'big')

sha256 = hashlib.sha256(compressed_pubkey).digest()
ripemd160 = hashlib.new('ripemd160', sha256).digest()
address = ripemd160.hex().upper()

output = {
    "address": address,
    "pub_key": {
        "type": "tendermint/PubKeySecp256k1",
        "value": base64.b64encode(compressed_pubkey).decode()
    },
    "priv_key": {
        "type": "tendermint/PrivKeySecp256k1",
        "value": base64.b64encode(priv_bytes).decode()
    }
}

with open("priv_validator_key.json", "w") as f:
    json.dump(output, f, indent=2)
print("✅ priv_validator_key.json generated:")
print(json.dumps(output, indent=2))
EOF
