---
title: "Reasoning in cagent - think, todo, memory"
---

Reasoning is **how the agent thinks through problems**. cagent has three built-in reasoning tools - `think` (scratchpad), `todo` (planning), and `memory` (context retention).

## Step 1: Create a complex project that requires planning

```bash
mkdir ~/reasoning-test && cd ~/reasoning-test

# Create multiple files with interconnected issues
cat > user.py << 'EOF'
class User:
    def __init__(self, name, email, age):
        self.name = name
        self.email = email
        self.age = age

    def is_adult(self):
        return self.age >= 18

    def get_display_name(self):
        return self.name.upper()  # BUG 1: Should not force uppercase

    def validate_email(self):
        return "@" in self.email  # BUG 2: Too simple, no domain check
EOF

cat > order.py << 'EOF'
from user import User

class Order:
    def __init__(self, user, items):
        self.user = user
        self.items = items

    def total(self):
        total = 0
        for item in self.items:
            total += item["price"]  # BUG 3: Doesn't handle quantity
        return total

    def apply_discount(self, percent):
        return self.total() * percent  # BUG 4: Should be total * (1 - percent/100)

    def summary(self):
        return f"Order for {self.user.get_display_name()}: ${self.total()}"
EOF

cat > test_app.py << 'EOF'
from user import User
from order import Order

def test_display_name():
    u = User("Alice", "alice@example.com", 25)
    assert u.get_display_name() == "Alice", f"Got {u.get_display_name()}"

def test_email_validation():
    u = User("Bob", "bob@", 30)
    assert u.validate_email() == False, "bob@ should be invalid"

def test_order_total():
    u = User("Alice", "alice@example.com", 25)
    items = [{"name": "Book", "price": 10, "qty": 2}, {"name": "Pen", "price": 5, "qty": 3}]
    o = Order(u, items)
    assert o.total() == 35, f"Expected 35, got {o.total()}"

def test_discount():
    u = User("Alice", "alice@example.com", 25)
    items = [{"name": "Book", "price": 100, "qty": 1}]
    o = Order(u, items)
    assert o.apply_discount(20) == 80, f"Expected 80, got {o.apply_discount(20)}"

if __name__ == "__main__":
    tests = [test_display_name, test_email_validation, test_order_total, test_discount]
    for t in tests:
        try:
            t()
            print(f"✓ {t.__name__}")
        except AssertionError as e:
            print(f"✗ {t.__name__}: {e}")
EOF
```

## Step 2: Create the reasoning agent

```yaml
# reasoning.yaml
version: "2"

agents:
  root:
    model: openai/gpt-5-mini
    description: Methodical debugger that plans before acting
    instruction: |
      You are a methodical debugging agent. You MUST reason carefully:

      1. First, use your TODO tool to create a plan of all steps needed
      2. Use your THINK tool before each fix to reason about the root cause
      3. Use your MEMORY tool to track what you've fixed so far
      4. Fix bugs ONE at a time, running tests after each fix
      5. Update your TODO after each step

      There are 4 bugs across 2 files. Find and fix ALL of them.
      Do NOT rush. Plan first, think through each bug, then act.
    toolsets:
      - type: filesystem
      - type: shell
```

## Step 3: Run it

```bash
export OPENAI_API_KEY=<your_key>
cagent run ./reasoning.yaml
```

Then type:

```
There are 4 bugs across user.py and order.py. Run tests, plan your approach, and fix them one by one.
```

## What you should see

```
✓ Shell    python test_app.py         ← Perceives: 4 failing tests
✓ Todo     Create plan:               ← REASONING: Plans the approach
             [ ] Fix get_display_name
             [ ] Fix validate_email  
             [ ] Fix order total
             [ ] Fix apply_discount
✓ Read     user.py                    ← Perceives the code
✓ Think    "get_display_name forces   ← REASONING: Analyzes root cause
            uppercase but test expects
            original case. Remove .upper()"
✓ Edit     user.py                    ← Acts: fixes bug 1
✓ Shell    python test_app.py         ← Verifies: 1 pass, 3 fail
✓ Memory   "Fixed bug 1: removed      ← REASONING: Stores context
            .upper() from display name"
✓ Todo     Update:                    ← REASONING: Tracks progress
             [✓] Fix get_display_name
             [ ] Fix validate_email
             [ ] Fix order total
             [ ] Fix apply_discount
✓ Think    "validate_email only checks ← REASONING: Next root cause
            for @ but bob@ has no domain.
            Need to check for text after @"
✓ Edit     user.py                    ← Acts: fixes bug 2
...continues until all 4 fixed...
```

## Key Teaching Point

| Reasoning Tool | What it does | Without it |
|---|---|---|
| `think` | Scratchpad to reason step-by-step | Agent jumps to conclusions, makes wrong fixes |
| `todo` | Creates and tracks a multi-step plan | Agent loses track, skips bugs, repeats work |
| `memory` | Retains context across the session | Agent forgets what it already fixed |

The critical insight: **these are NOT external tools** - they're built into the cagent runtime. Every agent gets them automatically. They're what separates a reasoning agent from a simple autocomplete.
