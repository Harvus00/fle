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
RETRY_INTERVAL = 5  # seconds
MAX_RETRIES = 5

# ─── Logging ─────────────────────────────────────────────────────────────────────
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[logging.StreamHandler()]
)

# ─── Healthcheck ────────────────────────────────────────────────────────────────
def check_rcon():
    for attempt in range(1, MAX_RETRIES + 1):
        try:
            with MCRcon(RCON_HOST, RCON_PASSWORD, RCON_PORT) as mcr:
                response = mcr.command("/players")
                logging.info(f"✅ RCON connected (attempt {attempt})")
                logging.info(f"Server response: {response}")
                return True
        except Exception as e:
            logging.warning(f"❌ RCON attempt {attempt} failed: {e}")
            time.sleep(RETRY_INTERVAL)
    logging.error("❌ RCON healthcheck failed after max retries")
    return False

# ─── Main ───────────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    check_rcon()