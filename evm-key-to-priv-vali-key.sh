#!/bin/bash
echo "⚙️  evm-key-to-priv-vali-key.sh — thanks to BlockHunters for the idea!"

# Step 1: Ensure Python 3 is installed
if ! command -v python3 >/dev/null 2>&1; then
  echo "🐍 Python3 not found. Installing..."
  apt update && apt install -y python3
fi

# Step 2: Run Python logic
python3 - <<'EOF'
import base64, hashlib, json, subprocess, sys

# Step 3: Ensure pip
try:
    import pip
except ImportError:
    print("🛠 Installing pip...")
    try:
        subprocess.check_call([sys.executable, "-m", "ensurepip", "--upgrade"])
    except Exception:
        subprocess.check_call(["apt", "update"])
        subprocess.check_call(["apt", "install", "-y", "python3-pip"])

# Step 4: Ensure ecdsa
try:
    from ecdsa import SigningKey, SECP256k1
except ImportError:
    print("📦 Installing 'ecdsa'...")
    subprocess.check_call([sys.executable, "-m", "pip", "install", "--quiet", "ecdsa"])
    from ecdsa import SigningKey, SECP256k1

# Step 5: Prompt for input
try:
    priv_hex = input("Enter priv_hex: ").strip()
except EOFError:
    print("❌ No input provided.")
    sys.exit(1)

if not (len(priv_hex) == 64 and all(c in '0123456789abcdefABCDEF' for c in priv_hex)):
    print("❌ Invalid private key format.")
    sys.exit(1)

priv_bytes = bytes.fromhex(priv_hex)
sk = SigningKey.from_string(priv_bytes, curve=SECP256k1)
vk = sk.get_verifying_key()

prefix = b'\x02' if vk.pubkey.point.y() % 2 == 0 else b'\x03'
pubkey = prefix + vk.pubkey.point.x().to_bytes(32, 'big')

sha = hashlib.sha256(pubkey).digest()
ripemd = hashlib.new('ripemd160', sha).digest()
address = ripemd.hex().upper()

data = {
    "address": address,
    "pub_key": {
        "type": "tendermint/PubKeySecp256k1",
        "value": base64.b64encode(pubkey).decode()
    },
    "priv_key": {
        "type": "tendermint/PrivKeySecp256k1",
        "value": base64.b64encode(priv_bytes).decode()
    }
}

with open("priv_validator_key.json", "w") as f:
    json.dump(data, f, indent=2)

print("✅ priv_validator_key.json created:")
print(json.dumps(data, indent=2))
EOF
