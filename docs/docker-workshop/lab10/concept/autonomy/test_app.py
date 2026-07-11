from app import add, multiply

def test_add():
    assert add(2, 3) == 5, f"Expected 5, got {add(2, 3)}"

def test_multiply():
    assert multiply(4, 5) == 20, f"Expected 20, got {multiply(4, 5)}"

if __name__ == "__main__":
    test_add()
    print("test_add passed")
    test_multiply()
    print("test_multiply passed")
    print("All tests passed!")
