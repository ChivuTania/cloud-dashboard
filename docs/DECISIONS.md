2026-08-20 
	- Stack (backend): Python/FastAPI, quotes in JSON, no DB. 
	Reason: minimize app effort, maximize platform learning.

	- Logic for data: Loading data for quotes when the app is started (not on every request):
		->trade off: editing quotes.json requires a restart (the dev server does it automatically; in production, a redeploy)


2026-08-24:
	- Stack (frontend): static HTML file served by FastAPI, calling the backend via fetch

2026-10-12:
	- Open-Meteo as the API used for weather pannel, called from the backend
	- Location set using environment variables

2026-10-19:

	- Scope: dedicated rg for dashboard stack (ACR, Container Apps Environment, Container App, Log Analytics, Identity)

	- Image Pull auth: user assigned managed identity with AcrPull (exists before the CA and its lifecycle is independent of the app)

	- Naming convention: <project>-<env>-<region>-<type>. Where a resource type forbids dashes, drop them and keep the same order (Cloud Azure Framework abbreviations, env included from day one because Azure names can't be changed later)

	- State isolation: Tf state lives in its own rg (the config that uses the state must never manage the state’s storage, or a destroy could wipe the record of what exists). Protections: delete lock, blob versioning + soft delete, pipeline gets blob-data access on the state container only.

