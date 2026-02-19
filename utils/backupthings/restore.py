#!/usr/bin/env python3
import os, tarfile, sys

if len(sys.argv) != 2:
    print("Usage: restore.py <backup_file>")
    exit(1)

backup_file = sys.argv[1]
if not os.path.exists(backup_file):
    print(f"Backup file not found: {backup_file}")
    exit(1)

with tarfile.open(backup_file, "r:gz") as tar:
    tar.extractall(path="/")

print(f"Backup restored from {backup_file}")
