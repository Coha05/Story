#!/bin/bash
echo "⚙️  evm-key-to-priv-vali-key.sh — thanks to BlockHunters for the idea!"
read -p "Enter priv_hex: " PRIV_HEX

node <<EOF
const crypto = require('crypto');
const secp256k1 = require('secp256k1');

const privHex = "$PRIV_HEX";
const privBuf = Buffer.from(privHex, "hex");

if (!secp256k1.privateKeyVerify(privBuf)) {
  console.error("❌ Invalid private key.");
  process.exit(1);
}

const pubKey = secp256k1.publicKeyCreate(privBuf, true);
const sha = crypto.createHash('sha256').update(pubKey).digest();
const ripemd = crypto.createHash('ripemd160').update(sha).digest();
const address = ripemd.toString('hex').toUpperCase();

const result = {
  address: address,
  pub_key: {
    type: "tendermint/PubKeySecp256k1",
    value: pubKey.toString('base64')
  },
  priv_key: {
    type: "tendermint/PrivKeySecp256k1",
    value: privBuf.toString('base64')
  }
};

console.log(JSON.stringify(result, null, 2));
EOF
