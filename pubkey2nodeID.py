#!/usr/bin/python2.7
import hashlib
from base64 import b64decode
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("publickey")
args = parser.parse_args()

pubkey = args.publickey.decode('hex')
nodeid = hashlib.sha256('\xc6\xb4\x13\x48' + pubkey).hexdigest()
print(nodeid)
