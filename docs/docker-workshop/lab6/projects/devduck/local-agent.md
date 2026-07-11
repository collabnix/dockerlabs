---
title: "Local Agent Tasks"
---

The Local Agent is your system's fast-response specialist, designed for quick processing tasks, code completion, and immediate assistance. In this lab, you'll explore its capabilities, learn optimization techniques, and understand when to leverage local processing versus cloud-based AI.

:::info[Learning Focus]
Master local agent capabilities, model management, and performance optimization for immediate response scenarios.
:::

## Understanding the Local Agent

### 🏠 Local Agent Architecture

The Local Agent operates within your Docker container using:

- **Local Models**: Cached language models (1-7B parameters)
- **Fast Processing**: Sub-second response times for common tasks
- **Offline Capability**: Works without internet connectivity
- **Resource Efficient**: Optimized for container environments

### Key Capabilities

#### ✅ **Strengths**
- Code completion and simple explanations
- Quick syntax help and debugging
- Basic conversation and Q&A
- Template generation and boilerplate code
- Fast pattern matching and simple analysis

#### ⚠️ **Limitations**
- Limited context window (compared to cloud models)
- Reduced knowledge depth
- Less sophisticated reasoning
- Smaller training data scope


## Quick Test

```
Prompt 1: How many agents are available in this system?
```

```
Prompt 2: Can I talk to Local Agent?
```

```
Prompt 3: Show me code for todo list app
```




## Hands-On Local Agent Exploration

### 🧪 Exercise 1: Direct Local Agent Testing

Let's interact directly with the Local Agent to understand its capabilities:

#### Force Local Agent Routing

**Method 1: Using Query Patterns**

The Local Agent typically handles these types of queries:

```
You: Quick JavaScript syntax question - how do I create an arrow function?
```

```
You: Simple Python loop example please
```

```
You: Basic HTML template for a webpage
```

#### **Method 2: Simulate Offline Mode**

Temporarily disable internet to force local processing:

```bash
# Block external API access (temporary)
docker compose exec devduck-agent sh -c "echo '127.0.0.1 api.cerebras.ai' >> /etc/hosts"

# Now test with complex queries
# They should fallback to Local Agent
```

**Test Query:**
```
You: Explain object-oriented programming concepts
```

**Restore connectivity:**
```bash
docker compose exec devduck-agent sh -c "sed -i '/api.cerebras.ai/d' /etc/hosts"
```

### 🔍 Exercise 2: Local Agent Performance Analysis

#### Response Time Comparison

```python
# Create local_agent_benchmark.py
import requests
import time
import statistics

def benchmark_local_agent():
    """Benchmark Local Agent response times."""
    
    # Queries likely to route to Local Agent
    local_queries = [
        "Hello",
        "What is a variable in Python?",
        "Show me a basic for loop",
        "Simple HTML template",
        "How to declare a JavaScript function?"
    ]
    
    times = []
    
    print("🏠 Benchmarking Local Agent...")
    
    for query in local_queries:
        print(f"Testing: {query[:30]}...")
        
        start_time = time.time()
        
        response = requests.post(
            'http://localhost:8000/chat',
            json={
                "message": query,
                "conversation_id": f"benchmark-{int(time.time())}",
                "force_local": True  # If supported
            },
            timeout=30
        )
        
        duration = time.time() - start_time
        times.append(duration)
        
        print(f"  Response time: {duration:.3f}s")
        time.sleep(0.5)
    
    # Statistics
    avg_time = statistics.mean(times)
    median_time = statistics.median(times)
    min_time = min(times)
    max_time = max(times)
    
    print(f"\n📊 Local Agent Performance:")
    print(f"  Average: {avg_time:.3f}s")
    print(f"  Median:  {median_time:.3f}s")
    print(f"  Min:     {min_time:.3f}s")
    print(f"  Max:     {max_time:.3f}s")
    
    return times

if __name__ == '__main__':
    benchmark_local_agent()
```

**Run the benchmark:**
```bash
python local_agent_benchmark.py
```

### 🎯 Exercise 3: Local Agent Specialization

#### Code Generation Tasks

Test the Local Agent's code generation capabilities:

**Template Generation:**
```
You: Generate a basic Express.js server template
```

**Simple Functions:**
```
You: Create a function to validate an email address in JavaScript
```

**Quick Fixes:**
```
You: Fix this Python code: 
print("Hello World"
```

#### Documentation and Explanations

**Concept Explanations:**
```
You: Explain what is a REST API in simple terms
```

**Quick References:**
```
You: List common Git commands
```

## Local Model Management

### 📦 Model Configuration

#### Viewing Current Model

```bash
# Check current local model configuration
docker compose exec devduck-agent env | grep LOCAL_MODEL

# View model cache directory
docker compose exec devduck-agent ls -la /app/models/

# Check model size and usage
docker compose exec devduck-agent du -sh /app/models/*
```

#### Model Switching

You can experiment with different local models:

```bash
# Stop the current system
docker compose down

# Edit your .env file with different model
cat > .env.local-model << 'EOF'
# Lightweight model (faster, less capable)
LOCAL_MODEL_NAME=microsoft/DialoGPT-small

# Medium model (balanced)
LOCAL_MODEL_NAME=microsoft/DialoGPT-medium

# Larger model (slower, more capable)
LOCAL_MODEL_NAME=microsoft/DialoGPT-large

# Alternative: GPT-2 based models
LOCAL_MODEL_NAME=gpt2
EOF

# Update your main .env file
cp .env.local-model .env

# Restart with new model
docker compose up --build
```

### 🔧 Performance Tuning

#### Memory Optimization

```yaml
# Add to compose.yml for local agent optimization
services:
  devduck-agent:
    environment:
      # Model optimization settings
      - TORCH_HOME=/app/models
      - HF_HOME=/app/models
      - TRANSFORMERS_CACHE=/app/models
      - LOCAL_MODEL_DEVICE=auto
      - LOCAL_MODEL_PRECISION=fp16  # Use half precision
      - LOCAL_MODEL_MAX_LENGTH=512  # Limit context length
    deploy:
      resources:
        limits:
          memory: 6G  # Adjust based on model size
        reservations:
          memory: 2G
```

#### CPU Optimization

```bash
# Create optimization script
cat > optimize_local_agent.py << 'EOF'
#!/usr/bin/env python3
import os
import torch

def optimize_local_performance():
    """Apply local agent performance optimizations."""
    
    # Set optimal thread count for PyTorch
    torch.set_num_threads(min(4, os.cpu_count()))
    
    # Enable optimized attention (if available)
    if hasattr(torch.backends, 'cuda'):
        torch.backends.cuda.matmul.allow_tf32 = True
    
    # Set memory growth (if using GPU)
    if torch.cuda.is_available():
        torch.cuda.empty_cache()
        print("✅ CUDA optimizations applied")
    
    print("✅ CPU optimizations applied")
    print(f"📊 Using {torch.get_num_threads()} threads")

if __name__ == '__main__':
    optimize_local_performance()
EOF

# Run optimization
docker compose exec devduck-agent python optimize_local_agent.py
```

## Advanced Local Agent Use Cases

### 🚀 Real-time Code Assistance

#### Exercise 4: Interactive Development Helper

Create scenarios where the Local Agent acts as a real-time coding assistant:

**Scenario 1: Syntax Checking**
```
You: Is this JavaScript code syntactically correct?

function calculateTotal(items) {
  let total = 0;
  for (item of items) {
    total += item.price
  }
  return total;
}
```

**Scenario 2: Quick Refactoring**
```
You: Convert this to arrow function syntax:

function greet(name) {
  return "Hello, " + name;
}
```

**Scenario 3: Error Explanation**
```
You: What's wrong with this Python code?

def process_list(items):
    for i in range(len(items))
        print(items[i])
```

### 🎯 Template and Boilerplate Generation

#### Exercise 5: Rapid Prototyping

**API Endpoint Template:**
```
You: Create a basic Express.js API endpoint for user registration
```

**Database Schema:**
```
You: Generate a MongoDB schema for a blog post
```

**Configuration Files:**
```
You: Create a package.json for a Node.js REST API project
```

### 📚 Documentation and Learning Aid

#### Exercise 6: Learning Assistant

**Concept Clarification:**
```
You: Explain the difference between let, const, and var in JavaScript
```

**Quick References:**
```
You: Show me common array methods in JavaScript with examples
```

**Best Practices:**
```
You: What are Python naming conventions for variables and functions?
```

## Local Agent Customization

### 🛠️ Custom Prompts and Templates

#### Create Specialized Prompts

```python
# Create local_agent_templates.py
class LocalAgentTemplates:
    """Custom templates for Local Agent specialization."""
    
    CODE_REVIEW_PROMPT = """
    You are a code review assistant. For the given code:
    1. Check for syntax errors
    2. Suggest improvements
    3. Identify potential bugs
    4. Keep responses concise and actionable
    """
    
    QUICK_HELP_PROMPT = """
    Provide quick, practical help. Include:
    1. Direct answer to the question
    2. Simple code example if applicable
    3. One-line explanation
    No lengthy explanations needed.
    """
    
    TEMPLATE_GENERATOR_PROMPT = """
    Generate clean, minimal code templates.
    Include:
    1. Essential structure only
    2. Clear placeholder comments
    3. Basic error handling
    4. Standard naming conventions
    """

# Usage example
def use_specialized_prompt(query, template_type="quick_help"):
    templates = LocalAgentTemplates()
    prompt = getattr(templates, f"{template_type.upper()}_PROMPT")
    
    return f"{prompt}\n\nQuery: {query}"
```

### 📊 Performance Monitoring

#### Create Local Agent Dashboard

```python
# Create local_agent_monitor.py
import psutil
import time
import json

class LocalAgentMonitor:
    def __init__(self):
        self.start_time = time.time()
        self.request_count = 0
        self.response_times = []
    
    def log_request(self, duration):
        self.request_count += 1
        self.response_times.append(duration)
    
    def get_stats(self):
        uptime = time.time() - self.start_time
        
        return {
            "uptime_seconds": uptime,
            "total_requests": self.request_count,
            "avg_response_time": sum(self.response_times) / len(self.response_times) if self.response_times else 0,
            "requests_per_minute": (self.request_count / uptime) * 60 if uptime > 0 else 0,
            "memory_usage_mb": psutil.Process().memory_info().rss / 1024 / 1024,
            "cpu_percent": psutil.cpu_percent()
        }
    
    def print_stats(self):
        stats = self.get_stats()
        print("🏠 Local Agent Statistics:")
        print(f"   Uptime: {stats['uptime_seconds']:.0f}s")
        print(f"   Requests: {stats['total_requests']}")
        print(f"   Avg Response: {stats['avg_response_time']:.3f}s")
        print(f"   Rate: {stats['requests_per_minute']:.1f} req/min")
        print(f"   Memory: {stats['memory_usage_mb']:.1f} MB")
        print(f"   CPU: {stats['cpu_percent']:.1f}%")

# Usage
monitor = LocalAgentMonitor()

# Simulate monitoring
for _ in range(10):
    start = time.time()
    # Simulate request processing
    time.sleep(0.1)
    monitor.log_request(time.time() - start)

monitor.print_stats()
```

## Optimization Strategies

### 🎛️ Configuration Tuning

#### Model Selection Guidelines

| Use Case | Recommended Model | Response Time | Memory Usage |
|----------|------------------|---------------|--------------|
| **Quick Help** | DialoGPT-small | <0.5s | 1-2 GB |
| **Code Completion** | DialoGPT-medium | 1-2s | 2-4 GB |
| **Detailed Explanations** | DialoGPT-large | 2-5s | 4-6 GB |
| **Specialized Tasks** | Custom fine-tuned | Variable | Variable |

#### Performance Optimization Checklist

```bash
# Create optimization checklist script
cat > local_agent_optimization.sh << 'EOF'
#!/bin/bash

echo "🔧 Local Agent Optimization Checklist"
echo "====================================="

# Check 1: Memory availability
MEM_TOTAL=$(free -m | awk 'NR==2{print $2}')
MEM_AVAILABLE=$(free -m | awk 'NR==2{print $7}')
echo "Memory: ${MEM_AVAILABLE}MB / ${MEM_TOTAL}MB available"

if [ $MEM_AVAILABLE -lt 4000 ]; then
    echo "⚠️  Consider using smaller model (DialoGPT-small)"
else
    echo "✅ Memory sufficient for medium/large models"
fi

# Check 2: CPU cores
CPU_CORES=$(nproc)
echo "CPU Cores: $CPU_CORES"

if [ $CPU_CORES -lt 4 ]; then
    echo "⚠️  Limited CPU - optimize thread count"
else
    echo "✅ CPU suitable for multi-threading"
fi

# Check 3: Disk space for models
DISK_SPACE=$(df -BG /app/models 2>/dev/null | awk 'NR==2{print $4}' | sed 's/G//')
echo "Disk Space: ${DISK_SPACE}GB available for models"

if [ "$DISK_SPACE" -lt 5 ]; then
    echo "⚠️  Limited disk space - clean old models"
else
    echo "✅ Sufficient disk space"
fi

# Check 4: Model loading time
echo "Testing model loading time..."
START_TIME=$(date +%s)
docker compose exec devduck-agent python -c "import torch; print('Model check complete')" 2>/dev/null
END_TIME=$(date +%s)
LOAD_TIME=$((END_TIME - START_TIME))

echo "Model load test: ${LOAD_TIME}s"

if [ $LOAD_TIME -gt 30 ]; then
    echo "⚠️  Slow model loading - consider smaller model"
else
    echo "✅ Model loading performance acceptable"
fi

EOF

chmod +x local_agent_optimization.sh
./local_agent_optimization.sh
```

### 🚀 Caching Strategies

#### Implement Response Caching

```python
# Create local_cache_manager.py
import hashlib
import json
import time
from typing import Optional, Dict, Any

class LocalResponseCache:
    def __init__(self, max_size: int = 1000, ttl: int = 300):
        self.cache: Dict[str, Dict[str, Any]] = {}
        self.max_size = max_size
        self.ttl = ttl
    
    def _generate_key(self, query: str) -> str:
        """Generate cache key from query."""
        return hashlib.md5(query.lower().strip().encode()).hexdigest()
    
    def get(self, query: str) -> Optional[str]:
        """Get cached response if available and valid."""
        key = self._generate_key(query)
        
        if key not in self.cache:
            return None
        
        entry = self.cache[key]
        
        # Check TTL
        if time.time() - entry['timestamp'] > self.ttl:
            del self.cache[key]
            return None
        
        entry['hits'] += 1
        return entry['response']
    
    def set(self, query: str, response: str) -> None:
        """Cache a response."""
        # Evict oldest entries if cache is full
        if len(self.cache) >= self.max_size:
            oldest_key = min(self.cache.keys(), 
                           key=lambda k: self.cache[k]['timestamp'])
            del self.cache[oldest_key]
        
        key = self._generate_key(query)
        self.cache[key] = {
            'response': response,
            'timestamp': time.time(),
            'hits': 0
        }
    
    def stats(self) -> Dict[str, Any]:
        """Get cache statistics."""
        total_hits = sum(entry['hits'] for entry in self.cache.values())
        
        return {
            'size': len(self.cache),
            'max_size': self.max_size,
            'total_hits': total_hits,
            'hit_rate': total_hits / max(1, len(self.cache)),
            'ttl': self.ttl
        }

# Example usage
cache = LocalResponseCache()

# Simulate caching
test_queries = [
    "What is Python?",
    "Hello",
    "Basic for loop example"
]

for query in test_queries:
    # Check cache first
    cached_response = cache.get(query)
    
    if cached_response:
        print(f"💾 Cache hit for: {query[:30]}...")
    else:
        print(f"🔍 Cache miss for: {query[:30]}...")
        # Simulate response generation
        response = f"Generated response for: {query}"
        cache.set(query, response)

print(f"\n📊 Cache stats: {cache.stats()}")
```

## Troubleshooting Local Agent Issues

### 🐛 Common Problems

#### Issue 1: Model Loading Failures

**Symptoms:**
- Container crashes during startup
- "Model not found" errors
- Memory allocation errors

**Diagnosis:**
```bash
# Check model download status
docker compose logs devduck-agent | grep -i "model"

# Check disk space
docker compose exec devduck-agent df -h /app/models

# Check memory usage during startup
docker stats devduck-agent
```

**Solutions:**
```bash
# Use smaller model
export LOCAL_MODEL_NAME=microsoft/DialoGPT-small

# Increase memory limit
# Edit compose.yml:
# deploy:
#   resources:
#     limits:
#       memory: 8G

# Pre-download model
docker compose exec devduck-agent python -c "from transformers import AutoTokenizer, AutoModelForCausalLM; AutoTokenizer.from_pretrained('microsoft/DialoGPT-small'); AutoModelForCausalLM.from_pretrained('microsoft/DialoGPT-small')"
```

#### Issue 2: Slow Response Times

**Diagnosis:**
```bash
# Profile response times
curl -w "@curl-format.txt" -s -o /dev/null -X POST \
  -H "Content-Type: application/json" \
  -d '{"message":"Hello","conversation_id":"test"}' \
  http://localhost:8000/chat

# Create curl-format.txt
cat > curl-format.txt << 'EOF'
time_namelookup:  %{time_namelookup}s
time_connect:     %{time_connect}s
time_appconnect:  %{time_appconnect}s
time_pretransfer: %{time_pretransfer}s
time_redirect:    %{time_redirect}s
time_starttransfer: %{time_starttransfer}s
time_total:       %{time_total}s
EOF
```

**Solutions:**
- Switch to smaller, faster model
- Implement response caching
- Optimize container resources
- Use GPU acceleration if available

## Next Steps

Excellent progress! You've mastered:

- ✅ Local Agent capabilities and limitations
- ✅ Model management and optimization
- ✅ Performance monitoring and tuning
- ✅ Caching strategies for improved response times
- ✅ Troubleshooting common issues

In the next section, you'll explore the Cerebras Agent and learn how to leverage cloud-based AI for complex analysis and advanced reasoning tasks.

Ready to dive into cloud AI capabilities? Let's explore Cerebras! 🧠🚀

---

:::tip[Local Agent Mastery]
You now understand how to optimize and utilize the Local Agent for fast, efficient processing. The combination of local and cloud agents gives you the best of both worlds - speed and sophistication!
:::
