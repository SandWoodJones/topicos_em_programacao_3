#!/usr/bin/env python3

import json, os, subprocess, sys, threading

try:
    with open(os.environ["LTEX_SETTINGS"]) as fh:
        SETTINGS = json.load(fh)
except Exception:
    SETTINGS = {}

srv = subprocess.Popen([os.environ.get("LTEX_SERVER", "ltex-ls-plus")] + sys.argv[1:], stdin=subprocess.PIPE, stdout=subprocess.PIPE)

def frame(obj):
    b = json.dumps(obj).encode()
    return b"Content-Length: %d\r\n\r\n" % len(b) + b

def read_msg(stream):
    n = 0
    while True:
        line = stream.readline()
        if not line:
            return None
        if line.lower().startswith(b"content-length:"):
            n = int(line.split(b":")[1])
        elif line in (b"\r\n", b"\n"):
            return json.loads(stream.read(n))

def lookup(section):
    val = SETTINGS
    for part in (section or "").split("."):
        if part:
            val = val.get(part) if isinstance(val, dict) else None
    return val

def client_to_server():
    while (msg := read_msg(sys.stdin.buffer)) is not None:
        srv.stdin.write(frame(msg)); srv.stdin.flush()

def server_to_client():
    while(msg := read_msg(srv.stdout)) is not None:
        if msg.get("method") == "workspace/configuration":
            result = [lookup(i.get("section")) for i in msg["params"]["items"]]
            srv.stdin.write(frame({"jsonrpc": "2.0", "id": msg["id"], "result": result}))
            srv.stdin.flush()
            continue
        sys.stdout.buffer.write(frame(msg))
        sys.stdout.buffer.flush()

threading.Thread(target=client_to_server, daemon=True).start()
server_to_client()
        
