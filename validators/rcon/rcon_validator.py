import os
import logging
from dotenv import load_dotenv
from mcrcon import MCRcon

# ─── Load Config ────────────────────────────────────────────────────────────────
CONFIG_PATH = os.path.join(os.path.dirname(__file__), "rcon_config.env")
load_dotenv(dotenv_path=CONFIG_PATH)

RCON_HOST = os.getenv("RCON_HOST", "127.0.0.1")
RCON_PORT = int(os.getenv("RCON_PORT", "25575"))
RCON_PASSWORD = os.getenv("RCON_PASSWORD", "yourSecurePassword")

# ─── Setup Logging ──────────────────────────────────────────────────────────────
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[logging.StreamHandler()]
)

# ─── RCON Command Dispatcher ────────────────────────────────────────────────────
def send_rcon_command(command: str) -> str:
    try:
        with MCRcon(RCON_HOST, RCON_PASSWORD, RCON_PORT) as mcr:
            response = mcr.command(command)
            logging.info(f"Command sent: {command}")
            logging.info(f"Response received: {response}")
            return response
    except Exception as e:
        logging.error(f"RCON command failed: {e}")
        return ""

# ─── Main Execution ─────────────────────────────────────────────────────────────
if __name__ == "__main__":
    test_command = "/players"
    result = send_rcon_command(test_command)
    print(f"RCON Response: {result}")