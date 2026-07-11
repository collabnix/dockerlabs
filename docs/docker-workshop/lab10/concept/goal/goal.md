---
title: "Goal-Orientation in cagent - instruction + description"
---

Goal-orientation is **what drives the agent to keep working**. In cagent, goals are defined through two fields: `instruction` (the agent's mission) and `description` (how other agents know when to delegate to it).

## Step 1: Create a project with a clear objective

```bash
mkdir ~/goal-test && cd ~/goal-test

# Create a Flask app with multiple issues
cat > app.py << 'EOF'
from flask import Flask, jsonify

app = Flask(__name__)

users = [
    {"id": 1, "name": "Alice", "email": "alice@test.com"},
    {"id": 2, "name": "Bob", "email": "bob@test.com"},
]

@app.route("/users")
def get_users():
    return users  # BUG: should use jsonify

@app.route("/users/<id>")
def get_user(id):
    for u in users:
        if u["id"] == id:  # BUG: id is string, not int
            return u
    return "Not found"  # BUG: should return 404 JSON

@app.route("/health")
def health():
    return "ok"  # Should return JSON with status

if __name__ == "__main__":
    app.run(debug=True)
EOF

cat > requirements.txt << 'EOF'
flask
pytest
EOF
```

## Step 2: Create TWO agents with DIFFERENT goals for the SAME codebase

```yaml
# goal-security.yaml
version: "2"

agents:
  root:
    model: openai/gpt-5-mini
    description: Security-focused code reviewer
    instruction: |
      Your GOAL is security. You are a security auditor.
      
      Review app.py ONLY for security issues:
      - Hardcoded credentials
      - Missing input validation
      - Debug mode in production
      - Information leakage in error responses
      - Missing CORS/auth headers
      
      You STOP when you have identified all security risks
      and written a security-report.md file.
      
      You do NOT fix bugs. You do NOT add features.
      You ONLY report security issues.
    toolsets:
      - type: filesystem
      - type: shell
```

```yaml
# goal-quality.yaml
version: "2"

agents:
  root:
    model: openai/gpt-5-mini
    description: Code quality engineer
    instruction: |
      Your GOAL is code quality. You are a code quality engineer.
      
      Review app.py ONLY for code quality issues:
      - Proper return types (use jsonify for Flask)
      - Type handling (string vs int comparisons)
      - Proper HTTP status codes (404, 500)
      - Consistent response format
      - PEP 8 compliance
      
      Fix ALL quality issues directly in app.py.
      Run the app to verify your fixes work.
      
      You STOP when the code meets quality standards.
      
      You do NOT review for security. You do NOT write docs.
      You ONLY fix code quality.
    toolsets:
      - type: filesystem
      - type: shell
```

## Step 3: Run BOTH agents on the same codebase

```bash
export OPENAI_API_KEY=<your_key>

# First: security-focused goal
cagent run ./goal-security.yaml
```

Type:

```
Review app.py for security issues.
```

Then reset and run the second:

```bash
# Restore original app.py first
git checkout app.py  # or recreate it

# Second: quality-focused goal
cagent run ./goal-quality.yaml
```

Type:

```
Review app.py for code quality issues and fix them.
```

## What you should see

### Security agent (goal = find risks, write report)

```
✓ Read    app.py                      ← Reads the code
✓ Think   "debug=True is a security   ← Reasons about security
           risk in production"
✓ Think   "Error responses leak       ← Finds another risk
           internal info"
✓ Write   security-report.md          ← Delivers: a report
                                         (does NOT touch app.py)
Agent stops ✅ (goal: report written)
```

### Quality agent (goal = fix code, verify it works)

```
✓ Read    app.py                      ← Reads the same code
✓ Think   "get_users returns list     ← Reasons about quality
           instead of jsonify response"
✓ Edit    app.py                      ← Fixes: adds jsonify()
✓ Edit    app.py                      ← Fixes: int(id) conversion
✓ Edit    app.py                      ← Fixes: 404 JSON response
✓ Shell   python -c "import app"      ← Verifies: code works
Agent stops ✅ (goal: all quality issues fixed)
```

## Key Teaching Point

**Same codebase. Same toolsets. Different goals. Completely different behavior.**

| | Security Agent | Quality Agent |
|---|---|---|
| **Goal** | Find risks, write report | Fix code, verify it works |
| **instruction** | "Review ONLY for security" | "Fix ALL quality issues" |
| **Output** | `security-report.md` (new file) | Modified `app.py` (edited file) |
| **Stops when** | Report is written | Code passes quality check |
| **Touches app.py?** | ❌ Never | ✅ Edits it |

The `instruction` field is the agent's **mission statement** - it determines what the agent does, what it ignores, and when it considers the job done. Two agents with identical toolsets but different instructions will produce completely different outcomes.

## Bonus: Goal via description in multi-agent teams

In a multi-agent setup, `description` is how the root agent decides **who to delegate to**:

```yaml
agents:
  root:
    model: openai/gpt-5-mini
    instruction: |
      You have two specialists. Delegate appropriately.
    sub_agents: [security_reviewer, quality_engineer]

  security_reviewer:
    model: openai/gpt-5-mini
    description: Reviews code for security vulnerabilities  # ← root reads this
    instruction: |
      Your GOAL is to find security issues only...

  quality_engineer:
    model: openai/gpt-5-mini
    description: Fixes code quality and ensures best practices  # ← root reads this
    instruction: |
      Your GOAL is to fix code quality only...
```

When a user says "check this for security," the root agent reads the `description` fields and routes to `security_reviewer`. When they say "clean up this code," it routes to `quality_engineer`. The `description` is the agent's **API contract** - it advertises what this agent's goal is to the rest of the system.
