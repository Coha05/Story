## Automate Snapshot for Story

# Snapshot Download and Extraction Guide

This guide provides the steps to download and extract snapshots for the Story and Story Geth services.

## 1. Install Aria2

First, ensure your system is up to date and install `aria2`:

```bash
sudo apt update
sudo apt install aria2 -y
```
## 2. Stop Services
```
sudo systemctl stop story
sudo systemctl stop story-geth
```
## 3. Download Snapshots

Use aria2c to download the snapshots with high speed:

**Geth Snapshot:**
```
aria2c -x 16 -s 16 https://snapshot.tech-coha05.xyz/geth-story_latest_snapshot.lz4
```

**Story Snapshot:**
```
aria2c -x 16 -s 16 https://snapshot.tech-coha05.xyz/story_latest_snapshot.lz4
```

## 4. Remove Old Data
Delete the old data directories:

```
rm -rf $HOME/.story/story/data
rm -rf $HOME/.story/geth/iliad/geth/chaindata
```

## 5. Extract Snapshots to Correct Folders
Create the necessary directories and extract the snapshots:

**Story Snapshot:**
```
sudo mkdir -p $HOME/.story/story/data
lz4 -d story_latest_snapshot.lz4 | pv | sudo tar xv -C $HOME/.story/story/
```

**Story Geth Snapshot:**
```
sudo mkdir -p $HOME/.story/geth/iliad/geth/chaindata
lz4 -d geth-story_latest_snapshot.lz4 | pv | sudo tar xv -C $HOME/.story/geth/iliad/geth/
```

## 6. Remove Snapshot Files

```
sudo rm -rf story_latest_snapshot.lz4
sudo rm -rf geth-story_latest_snapshot.lz4
```
## 7. Restart Services

Restart the services to apply the changes:

```
sudo systemctl start story
sudo systemctl start story-geth
```

## 8. Check Logs
Monitor the logs to ensure the services are running smoothly:
```
sudo journalctl -u story-geth -f -o cat
sudo journalctl -u story -f -o cat
```
