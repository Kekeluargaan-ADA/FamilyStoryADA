# FamilyStoryADA

This guide will help you set up ngrok and run your FastAPI server using a Conda environment.

## Prerequisites

Ensure you have the following installed:
- Conda (Anaconda/Miniconda)
- ngrok
- FastAPI and Uvicorn installed in your Conda environment

## Steps

### 1. Setup ngrok

First, create an external tunnel using ngrok:

```bash
ngrok http --url=working-epic-dodo.ngrok-free.app 8000 --region ap
```

- `--url=working-epic-dodo.ngrok-free.app`: Custom ngrok URL to access your server.
- `8000`: The local port where FastAPI will run.
- `--region ap`: Specify the region (Asia Pacific).

Keep this terminal window open as ngrok will run continuously to tunnel your FastAPI server.

### 2. Activate Conda Environment

In a new terminal, activate the Conda environment where FastAPI and Uvicorn are installed:

```bash
conda activate kekeluargaan
```

### 3. Start FastAPI Server

Now, run your FastAPI server using uvicorn:

```bash
uvicorn app:app --reload
```

This will start the server locally on `http://127.0.0.1:8000`, which is now accessible via the ngrok URL.

### 4. Access FastAPI via ngrok

Visit your FastAPI documentation by navigating to:

```
https://working-epic-dodo.ngrok-free.app/docs
```

Your FastAPI server is now publicly accessible via the ngrok tunnel.

## Note

Make sure to keep both terminal windows (ngrok and FastAPI server) open while you're working on your project. The ngrok URL will change if you restart the ngrok process, so update your access URL accordingly.

## Additional Information

- For more information on ngrok, visit [ngrok documentation](https://ngrok.com/docs).
- To learn more about FastAPI, check out the [FastAPI documentation](https://fastapi.tiangolo.com/).
- For Conda environment management, refer to the [Conda documentation](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).
