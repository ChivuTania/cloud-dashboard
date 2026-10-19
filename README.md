# Learning project: Cloud Dashboard

**v1:** daily motivational quote + daily links, served locally.

## Repo layout

- `/app` — FastAPI backend + static frontend
- `/infra` — empty for now; Terraform lands here later
- `/docs` — decision log and learning notes

## First run (after cloning)

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r app/requirements.txt
cd app
fastapi dev main.py
```

## Subsequent runs

```powershell
.\.venv\Scripts\Activate.ps1
cd app
fastapi dev main.py
```

Dashboard: http://127.0.0.1:8000/

## Configuration

| Variable | Default | Purpose |
|---|---|---|
| `WEATHER_LAT` | `44.43` | Weather panel latitude |
| `WEATHER_LON` | `26.10` | Weather panel longitude |
| `WEATHER_CITY` | `Bucharest` | Label shown on the panel |

## Build and run the container

```bash
docker build -t cloud-dashboard:<tag> app
docker run -d -p 8080:8000 cloud-dashboard:<tag>
```

The app listens on port **8000** inside the container.