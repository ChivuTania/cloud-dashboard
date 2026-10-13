import json
from datetime import date
from pathlib import Path
import os
import httpx
from fastapi import FastAPI, HTTPException
from fastapi.staticfiles import StaticFiles

app = FastAPI()

QUOTES = json.loads((Path(__file__).parent / "quotes.json").read_text(encoding="utf-8"))

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/api/quote")
def quote_of_the_day():
    index = date.today().toordinal() % len(QUOTES)
    return QUOTES[index]

WEATHER_LAT = float(os.getenv("WEATHER_LAT", "44.43"))
WEATHER_LON = float(os.getenv("WEATHER_LON", "26.10"))
WEATHER_CITY = os.getenv("WEATHER_CITY", "Bucharest")

WMO_CODES = {
    0: "Clear sky", 1: "Mainly clear", 2: "Partly cloudy", 3: "Overcast",
    45: "Fog", 48: "Rime fog", 51: "Light drizzle", 53: "Drizzle", 55: "Dense drizzle",
    61: "Light rain", 63: "Rain", 65: "Heavy rain", 71: "Light snow", 73: "Snow",
    75: "Heavy snow", 80: "Rain showers", 81: "Rain showers", 82: "Violent showers",
    95: "Thunderstorm", 96: "Thunderstorm with hail", 99: "Thunderstorm with heavy hail",
}

@app.get("/api/weather")
async def weather():
    params = {
        "latitude": WEATHER_LAT,
        "longitude": WEATHER_LON,
        "current": "temperature_2m,weather_code,wind_speed_10m",
        "timezone": "Europe/Bucharest",
    }
    try:
        async with httpx.AsyncClient(timeout=5.0) as client:
            r = await client.get("https://api.open-meteo.com/v1/forecast", params=params)
            r.raise_for_status()
    except httpx.HTTPError:
        raise HTTPException(status_code=502, detail="Weather service unavailable")
    current = r.json()["current"]
    return {
        "city": WEATHER_CITY,
        "temperature": current["temperature_2m"],
        "condition": WMO_CODES.get(current["weather_code"], "Unknown"),
        "wind": current["wind_speed_10m"],
        "observed_at": current["time"],
    }

app.mount("/", StaticFiles(directory="static", html=True), name="static")