#!/bin/bash
echo "⚙️  evm-key-to-priv-vali-key.sh — thanks to BlockHunters for the idea!"

node <<'EOF'
const crypto = require('crypto');
const fs = require('fs');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Enter priv_hex: ', (privHex) => {
  if (!/^[0-9a-fA-F]{64}$/.test(privHex)) {
    console.error("❌ Invalid private key format.");
    process.exit(1);
  }

  const privBuf = Buffer.from(privHex, "hex");
  const ecdh = crypto.createECDH('secp256k1');
  ecdh.setPrivateKey(privBuf);
  const pubKey = ecdh.getPublicKey(null, 'compressed');

  const sha = crypto.createHash('sha256').update(pubKey).digest();
  const ripemd = crypto.createHash('ripemd160').update(sha).digest();
  const address = ripemd.toString('hex').toUpperCase();

  const result = {
    address,
    pub_key: {
      type: "tendermint/PubKeySecp256k1",
      value: pubKey.toString('base64')
    },
    priv_key: {
      type: "tendermint/PrivKeySecp256k1",
      value: privBuf.toString('base64')
    }
  };

  fs.writeFileSync("priv_validator_key.json", JSON.stringify(result, null, 2));
  console.log("✅ priv_validator_key.json saved:");
  console.log(JSON.stringify(result, null, 2));
  rl.close();
});
EOF
