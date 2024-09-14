![image](https://github.com/user-attachments/assets/3bf762e2-7269-4a41-ba74-be588c0733e0)

[Story](https://www.story.foundation/) is a blockchain making IP protection and licensing programmable and efficient. It automates IP management, allowing creators to easily license, remix, and monetize their work. With Story, traditional legal complexities are replaced by on-chain smart contracts and off-chain legal agreements, simplifying the entire process.
## System Requirements

| **Hardware** | **Minimum Requirement** |
|--------------|-------------------------|
| **CPU**      | 4 Cores                 |
| **RAM**      | 8 GB                    |
| **Disk**     | 200 GB                  |
| **Bandwidth**| 10 MBit/s               |

## Service 

**- Cosmos RPC**: https://story-cosmos-testnet-rpc.tech-coha05.xyz

**- Metamask RPC:** https://story-evm-testnet-rpc.tech-coha05.xyz

**- Validator assdress**: https://testnet.story.explorers.guru/validator/storyvaloper15a4fph700vr0t0arfsrleeyh4al9087ee3evct

**- Peer:** b37eff82c86e867f8bf4df1199fbd90cc411b9dd@story-testnet-peer.tech-coha05.xyz:36656


## LIVE PEERS
**- Story Peers:**
```
PEERS=$(curl -sS https://story-cosmos-testnet-rpc.tech-coha05.xyz/net_info | jq -r '.result.peers[] | "\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr)"' | awk -F ':' '{print $1":"$(NF)}' | paste -sd, -)
echo $PEERS
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.story/story/config/config.toml
```
**- Geth Peer:**
```
story-geth --exec 'admin.addPeer("enode://fadb83227922096e59346a8b6ea442de0468ef2d3d10555ca2689596be967cc426acc6a885c0997a092164928aac5ea035e0a28039da1db4701c6cbc70e64992@story-testnet-peer-geth.tech-coha05.xyz:30303")' attach ~/.story/geth/iliad/geth.ipc
```
## Snapshot 

Visit service page: https://services.tech-coha05.xyz/networks/story/snapshot.html

## Auto Install with systemd
```
source <(curl -s https://raw.githubusercontent.com/Coha05/Story/main/auto-install-story.sh)
```

## Register your Validator 
```
curl localhost:26657/status | jq
```

Make sure `catching_up = false` ![image](https://github.com/user-attachments/assets/ab9bdfc4-5410-4ba8-921a-0d5049424740)

### 1. Export wallet:
```
story validator export --export-evm-key
```
### 2. Get wallet key and import to Metamask wallet
```
sudo nano ~/.story/story/config/private_key.txt
```
### 3. Import wallet to Metamask and faucet

```
https://faucet.story.foundation
```

### 4. You need at least have 1 IP on wallet before go to last step
### 5. Register validator
   
```
story validator create --stake 1000000000000000000 --private-key "your_private_key"
```
![image](https://github.com/user-attachments/assets/3a6971ca-6b7c-4463-9a59-7a9c33d94dcc)

## BACK UP FILE

1. Wallet private key:
```
sudo nano ~/.story/story/config/private_key.txt
```
2. Validator key:

```
sudo nano ~/.story/story/config/priv_validator_key.json
```
## That all good luck!

