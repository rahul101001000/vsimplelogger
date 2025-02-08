# vsimplelogger

A simple, efficient text logging service with implementations in both FastAPI (Python) and Node.js Express. The service provides a straightforward API for logging actions and includes automatic log rotation to maintain only the last 7 days of logs.

## Features

- Simple HTTP API for logging actions
- Automatic 7-day log retention and rotation
- Docker support
- Sample HTML frontend included
- Comprehensive test suite
- Available in both Python (FastAPI) and Node.js implementations

## Quick Start

### Prerequisites

- Docker
- Node.js (for local development)
- Python (for local development)

### Node.js Version (Recommended)

```bash
# Build Docker image
docker build -t vsimplelogger_nodejs ./vsimplelogger_nodejs

# Run container
docker run -d -p 3000:3000 vsimplelogger_nodejs
```

### FastAPI Version

```bash
# Build Docker image
docker build -t vsimplelogger_fastapi ./vsimplelogger_fastapi

# Run container
docker run -d -p 8000:8000 vsimplelogger_fastapi
```

## Testing

### Node.js Version
```bash
cd vsimplelogger_nodejs
npm install
npm test
```

### FastAPI Version
```bash
cd vsimplelogger_fastapi
pip install -r requirements.txt
pytest
```

## Performance

Performance testing was conducted using ApacheBench (ab) with 1000 requests and 10 concurrent connections. The Node.js version showed slightly better performance metrics and is the recommended implementation.

## Documentation

For more detailed information, check out:
- [API Documentation](docs/api.md)
- [Design Documentation](docs/design.md)
- [Full Project Documentation](docs/project_documentation.md)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the GNU General Public License v3.0 (GPL-3.0). See the LICENSE file for more details.