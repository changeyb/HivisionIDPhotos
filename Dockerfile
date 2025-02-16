FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt requirements-app.txt ./

RUN pip install --no-cache-dir -r requirements.txt -r requirements-app.txt \
    && rm -rf ~/.cache/pip

COPY . .

ENV PORT=9510
ENV PYTHONUNBUFFERED=1
ENV PYTHONOPTIMIZE=1
ENV MTCNN_RUNTIME_CACHE=0

EXPOSE 9510

CMD ["python3", "-u", "deploy_api.py"]