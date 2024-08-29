![image](https://github.com/user-attachments/assets/3bf762e2-7269-4a41-ba74-be588c0733e0)

[Story](https://www.story.foundation/) is a blockchain making IP protection and licensing programmable and efficient. It automates IP management, allowing creators to easily license, remix, and monetize their work. With Story, traditional legal complexities are replaced by on-chain smart contracts and off-chain legal agreements, simplifying the entire process.
## System Requirements

| **Hardware** | **Minimum Requirement** |
|--------------|-------------------------|
| **CPU**      | 4 Cores                 |
| **RAM**      | 8 GB                    |
| **Disk**     | 200 GB                  |
| **Bandwidth**| 10 MBit/s               |


## Auto Install with systemd
```
source <(curl -s https://raw.githubusercontent.com/Coha05/Story/main/auto-install-story.sh)
```

## Register your Validator 

Make sure `catching_up = false` ![image](https://github.com/user-attachments/assets/ab9bdfc4-5410-4ba8-921a-0d5049424740)

1. Export wallet:
```
story validator export --export-evm-key
```
2. Get wallet key and import to Metamask wallet
```
sudo nano ~/.story/story/config/private_key.txt
```
3. Import wallet to Metamask and faucet

 ```
 https://faucet.story.foundation
```

4. You need at least have 1 IP on wallet before go to last step
5. Register validator
   
```
story validator create --stake 1000000000000000000 --private-key "your_private_key"
```
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

