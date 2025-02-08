from fastapi import FastAPI, Request
import uvicorn
import os
from datetime import datetime, timedelta
import json
import glob

app = FastAPI()

LOG_DIR = "./logs"
LOG_RETENTION_DAYS = 7

if not os.path.exists(LOG_DIR):
    os.makedirs(LOG_DIR)

@app.post("/log")
async def log_action(request: Request):
    data = await request.json()
    user = data.get("user")
    action = data.get("action")
    timestamp = data.get("timestamp", datetime.utcnow().isoformat())
    log_entry = {
        "user": user,
        "action": action,
        "timestamp": timestamp
    }
    log_file = os.path.join(LOG_DIR, f"{datetime.utcnow().date()}.log")
    with open(log_file, "a") as f:
        f.write(json.dumps(log_entry) + "\n")
    purge_old_logs()
    return {"message": "Log recorded successfully"}


def purge_old_logs():
    cutoff_date = datetime.utcnow() - timedelta(days=LOG_RETENTION_DAYS)
    for log_file in glob.glob(os.path.join(LOG_DIR, "*.log")):
        file_date = datetime.strptime(os.path.basename(log_file).split(".")[0], "%Y-%m-%d")
        if file_date < cutoff_date:
            os.remove(log_file)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
