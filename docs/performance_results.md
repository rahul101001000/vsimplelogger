# Performance Test Results

## Test Configuration
- Number of requests: 1000
- Tested concurrency levels: 1, 5, 10, 20, 50
- Test tool: Apache Benchmark (ab)

## Results

| Implementation | Concurrency | Requests/sec | Mean Latency (ms) | P95 Latency (ms) |
|----------------|-------------|--------------|------------------|-----------------|
| Nodejs | 1 | 893.49 | 1.12 | 2.00 |
| Nodejs | 10 | 1401.37 | 7.14 | 12.00 |
| Nodejs | 20 | 1631.06 | 12.26 | 20.00 |
| Nodejs | 5 | 1330.82 | 3.76 | 6.00 |
| Nodejs | 50 | 1806.29 | 27.68 | 43.00 |
| Fastapi | 1 | 713.93 | 1.40 | 2.00 |
| Fastapi | 10 | 1121.73 | 8.91 | 12.00 |
| Fastapi | 20 | 1118.43 | 17.88 | 20.00 |
| Fastapi | 5 | 1077.55 | 4.64 | 7.00 |
| Fastapi | 50 | 1093.13 | 45.74 | 84.00 |

## Analysis

Overall, the Node.js implementation showed better performance with an average of 1412.61 requests per second, 
approximately 37.8% faster than the other implementation.
