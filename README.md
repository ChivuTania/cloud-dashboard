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