import sys
import os
import time
import logging
from dotenv import load_dotenv
from mcrcon import MCRcon

# ─── Config ─────────────────────────────────────────────────────────────────────
CONFIG_PATH = os.path.join(os.path.dirname(__file__), "rcon_config.env")
load_dotenv(dotenv_path=CONFIG_PATH)

RCON_HOST = os.getenv("RCON_HOST", "127.0.0.1")
RCON_PORT = int(os.getenv("RCON_PORT", "25575"))
RCON_PASSWORD = os.getenv("RCON_PASSWORD", "Ank3lz100")
DELAY_BETWEEN_COMMANDS = 2

# ─── Logging ─────────────────────────────────────────────────────────────────────
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[logging.StreamHandler()]
)

# ─── Command Queue ───────────────────────────────────────────────────────────────
COMMANDS = [
    "/broadcast Server automation initiated.",
    "/players",
    "/save",
    "/broadcast Save complete. Preparing shutdown.",
    "/stop"
]

def dispatch_commands():
    try:
        with MCRcon(RCON_HOST, RCON_PASSWORD, RCON_PORT) as mcr:
            for cmd in COMMANDS:
                response = mcr.command(cmd)
                logging.info(f"Sent: {cmd} → Response: {response}")
                time.sleep(DELAY_BETWEEN_COMMANDS)
    except Exception as e:
        logging.error(f"❌ RCON dispatch failed: {e}")

# ─── Main ───────────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    logging.info(f"Using interpreter: {sys.executable}")
    dispatch_commands()