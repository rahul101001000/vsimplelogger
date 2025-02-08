# vsimplelogger Project Documentation

## Prompts and Responses

### Initial Prompt

```
Write a very simple text logger service called vsimplelogger. It should expose a very simple API that I can call from a frontend or from curl to log actions. It should log user actions into a text file. Keep it generic so I can decide what goes into it. Keep only 7 days of logs at any time and keep purging the last file. Go step by step asking me at every stage.

Before you start, create a github repo for this named vsimplelogger.

First I'd like you to give me a sequence diagram and a functional block diagram for this. Use mermaid.js for it and give me code in mermaid. Add this as the design document in the docs folder. Next, create a doc describing API endpoint and sample usage. Next, give me skeleton code. Next, expand and complete the code, include a sample HTML file to call this from. Next, write tests for it. Next, run it using Docker.

I'm not sure whether to use Python with FastAPI or Javascript with Nodejs express. Create both versions. Write some performance tests. Give me plots of latency against load. And let me pick one of the two approaches basis that.

Can you do this for me?
```

### Design Document

Created a design document with a sequence diagram and a functional block diagram using mermaid.js and added it to the `docs` folder.

### API Documentation

Created a document describing the API endpoint and sample usage, and added it to the `docs` folder.

### Skeleton Code

Created the skeleton code for both Python FastAPI and JavaScript Node.js Express versions of the logger service.

### Expanded Code

Expanded and completed the code for both versions, including the log retention functionality.

### Sample HTML Files

Created sample HTML files to call the logger service from both versions.

### Tests

Wrote tests for both versions of the logger service.

### Docker

Created Dockerfiles for both versions and built the Docker images.

### Performance Tests

Ran performance tests using ApacheBench (ab) for both versions and documented the results.

## Final Recommendation

Based on the performance test results, the JavaScript Node.js Express version of the logger service performed slightly better than the Python FastAPI version. Therefore, I recommend using the JavaScript Node.js Express version.

## Quick Start Guide

### Prerequisites

- Docker
- Node.js (for local development)
- Python (for local development)

### Running the JavaScript Node.js Express Version

1. Build the Docker image:

```sh
docker build -t vsimplelogger_nodejs ./vsimplelogger_nodejs
```

2. Run the Docker container:

```sh
docker run -d -p 3000:3000 vsimplelogger_nodejs
```

3. Access the sample HTML file to log actions:

Open `vsimplelogger_nodejs/index.html` in a web browser.

### Running the Python FastAPI Version

1. Build the Docker image:

```sh
docker build -t vsimplelogger_fastapi ./vsimplelogger_fastapi
```

2. Run the Docker container:

```sh
docker run -d -p 8000:8000 vsimplelogger_fastapi
```

3. Access the sample HTML file to log actions:

Open `vsimplelogger_fastapi/index.html` in a web browser.

### Running Tests

#### JavaScript Node.js Express Version

1. Install dependencies:

```sh
npm install
```

2. Run tests:

```sh
npm test
```

#### Python FastAPI Version

1. Install dependencies:

```sh
pip install -r requirements.txt
```

2. Run tests:

```sh
pytest
```

### Performance Tests

1. Ensure both Docker containers are running.

2. Run ApacheBench (ab) for the JavaScript Node.js Express version:

```sh
ab -n 1000 -c 10 -p post_data.json -T application/json http://localhost:3000/log/
```

3. Run ApacheBench (ab) for the Python FastAPI version:

```sh
ab -n 1000 -c 10 -p post_data.json -T application/json http://localhost:8000/log/
```

## Conclusion

The JavaScript Node.js Express version of the logger service is recommended based on the performance test results. Follow the quick start guide to set up and run the service.
