#!/bin/bash

echo "Starting performance tests..."

# Ensure both servers are running
docker ps | grep vsimplelogger_nodejs > /dev/null
if [ $? -ne 0 ]; then
    echo "Starting Node.js server..."
    docker run -d -p 3000:3000 vsimplelogger_nodejs
    sleep 5
fi

docker ps | grep vsimplelogger_fastapi > /dev/null
if [ $? -ne 0 ]; then
    echo "Starting FastAPI server..."
    docker run -d -p 8000:8000 vsimplelogger_fastapi
    sleep 5
fi

# Run tests with different concurrency levels
REQUESTS=1000
CONCURRENCIES=(1 5 10 20 50)

echo "Testing Node.js server..."
mkdir -p test_results
for c in "${CONCURRENCIES[@]}"; do
    echo "Testing with concurrency $c"
    ab -n $REQUESTS -c $c -p post_data.json -T application/json http://localhost:3000/log/ > test_results/nodejs_c${c}.txt
done

echo "Testing FastAPI server..."
for c in "${CONCURRENCIES[@]}"; do
    echo "Testing with concurrency $c"
    ab -n $REQUESTS -c $c -p post_data.json -T application/json http://localhost:8000/log/ > test_results/fastapi_c${c}.txt
done

# Extract and format results
echo "Processing results..."
python3 - << 'EOF' > docs/performance_results.md
import glob
import re

def extract_metrics(file_path):
    with open(file_path, 'r') as f:
        content = f.read()
        rps = re.search(r'Requests per second:\s+(\d+\.\d+)', content)
        mean_time = re.search(r'Time per request:\s+(\d+\.\d+)', content)
        p95 = re.search(r'95%\s+(\d+)', content)
        return {
            'rps': float(rps.group(1)) if rps else 0,
            'mean_time': float(mean_time.group(1)) if mean_time else 0,
            'p95': float(p95.group(1)) if p95 else 0
        }

def format_results():
    results = []
    results.append("# Performance Test Results\n")
    results.append("## Test Configuration")
    results.append("- Number of requests: 1000")
    results.append("- Tested concurrency levels: 1, 5, 10, 20, 50")
    results.append("- Test tool: Apache Benchmark (ab)\n")
    
    results.append("## Results\n")
    results.append("| Implementation | Concurrency | Requests/sec | Mean Latency (ms) | P95 Latency (ms) |")
    results.append("|----------------|-------------|--------------|------------------|-----------------|")
    
    for impl in ['nodejs', 'fastapi']:
        for file in sorted(glob.glob(f'test_results/{impl}_*.txt')):
            conc = re.search(r'c(\d+)', file).group(1)
            metrics = extract_metrics(file)
            results.append(f"| {impl.title()} | {conc} | {metrics['rps']:.2f} | {metrics['mean_time']:.2f} | {metrics['p95']:.2f} |")
    
    results.append("\n## Analysis\n")
    
    # Calculate averages for comparison
    nodejs_files = glob.glob('test_results/nodejs_*.txt')
    fastapi_files = glob.glob('test_results/fastapi_*.txt')
    
    nodejs_avg_rps = sum(extract_metrics(f)['rps'] for f in nodejs_files) / len(nodejs_files)
    fastapi_avg_rps = sum(extract_metrics(f)['rps'] for f in fastapi_files) / len(fastapi_files)
    
    winner = "Node.js" if nodejs_avg_rps > fastapi_avg_rps else "FastAPI"
    diff_percent = abs(nodejs_avg_rps - fastapi_avg_rps) / min(nodejs_avg_rps, fastapi_avg_rps) * 100
    
    results.append(f"Overall, the {winner} implementation showed better performance with an average of {max(nodejs_avg_rps, fastapi_avg_rps):.2f} requests per second, ")
    results.append(f"approximately {diff_percent:.1f}% faster than the other implementation.")
    
    return "\n".join(results)

print(format_results())
EOF

echo "Performance test results have been saved to docs/performance_results.md"