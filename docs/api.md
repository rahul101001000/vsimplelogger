# API Documentation for vsimplelogger

## API Endpoint

### Log Action

- **URL**: `/log`
- **Method**: `POST`
- **Content-Type**: `application/json`
- **Request Body**:
  ```json
  {
    "user": "<username>",
    "action": "<action_description>",
    "timestamp": "<ISO_8601_timestamp>"
  }
  ```
- **Response**:
  - **Status**: `200 OK`
  - **Body**: `{"message": "Log recorded successfully"}`

## Sample Usage

### Using curl

```sh
curl -X POST http://<server_address>/log \
     -H "Content-Type: application/json" \
     -d '{"user": "john_doe", "action": "login", "timestamp": "2023-10-01T12:34:56Z"}'
```

### Using JavaScript (fetch)

```javascript
fetch('http://<server_address>/log', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    user: 'john_doe',
    action: 'login',
    timestamp: '2023-10-01T12:34:56Z'
  })
})
.then(response => response.json())
.then(data => console.log(data));
```
```
