import json
from datetime import date
from pathlib import Path

from fastapi import FastAPI

app = FastAPI()

QUOTES = json.loads((Path(__file__).parent / "quotes.json").read_text(encoding="utf-8"))

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/api/quote")
def quote_of_the_day():
    index = date.today().toordinal() % len(QUOTES)
    return QUOTES[index]