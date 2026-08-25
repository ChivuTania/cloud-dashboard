2026-08-20 
	- Stack (backend): Python/FastAPI, quotes in JSON, no DB. 
	Reason: minimize app effort, maximize platform learning.

	- Logic for data: Loading data for quotes when the app is started (not on every request):
		->trade off: editing quotes.json requires a restart (the dev server does it automatically; in production, a redeploy)


1026-08-24:
	- Stack (frontend): static HTML file served by FastAPI, calling the backend via fetch



