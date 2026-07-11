---
title: "Testing Your Containerized Application"
---

In this section, you'll learn how to implement and run automated tests for your containerized application using Testcontainers. This approach ensures that your tests run in an environment that closely matches production, leading to more reliable test results.

## Understanding Testcontainers

[Testcontainers](https://testcontainers.com/) is a library that provides lightweight, throwaway instances of common databases, message brokers, or anything else that can run in a Docker container. It's perfect for integration testing because:

- It creates isolated environments for each test
- It spins up actual services rather than mocks (when needed)
- It cleans up automatically after tests complete
- It's language-agnostic (though we'll use the JavaScript implementation)

## Prerequisites

Before running the tests, ensure you have:

- Docker Desktop installed and running
- Testcontainers Desktop installed (optional but recommended)
- Completed the [Development phase](/docker-workshop/product-catalog/develop)

## Setting Up Testcontainers Desktop (Optional)

1. Download and install [Testcontainers Desktop](https://testcontainers.com/desktop/)
2. Open the application
3. Ensure it can connect to your Docker instance

Testcontainers Desktop provides a visual interface for monitoring containers created during testing.

## Understanding the Test Structure

Our application uses two types of tests:

1. **Unit Tests**: Test individual functions without external dependencies
2. **Integration Tests**: Test complete features with actual dependencies (using Testcontainers)

The test files are located in:
- `test/src/unit/` - Unit tests
- `test/src/integration/` - Integration tests

Key integration test files:
- `containerSupport.js`: Manages container lifecycle for tests
- `kafkaSupport.js`: Provides Kafka testing utilities
- `productCreation.integration.test.js`: Tests product creation functionality

## Running the Tests

### Unit Tests

To run the unit tests:

```bash
npm run unit-test
```

These tests verify the behavior of individual functions without external dependencies.

### Integration Tests

To run the integration tests:

```bash
npm run integration-test
```

When you run integration tests, Testcontainers will:
1. Spin up required containers (PostgreSQL, Kafka, LocalStack)
2. Run the tests against these containers
3. Tear down the containers when tests complete

You can observe these containers in Docker Desktop or Testcontainers Desktop:

![Testcontainers in Action](https://github.com/user-attachments/assets/9277a932-2227-4cf2-97ab-758e1dd3ea38)

## Understanding the Integration Test Code

Let's examine the key components of the integration test:

### Container Setup

```javascript
// From containerSupport.js
async function setup() {
  // Start PostgreSQL container
  postgres = await new GenericContainer("postgres:15")
    .withExposedPorts(5432)
    .withEnvironment({ POSTGRES_PASSWORD: "postgres" })
    .start();
  
  // Start Kafka container
  kafka = await new GenericContainer("confluentinc/cp-kafka:7.4.0")
    .withExposedPorts(9092)
    .withEnvironment({
      KAFKA_ADVERTISED_LISTENERS: "PLAINTEXT://localhost:9092",
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
    })
    .start();
  
  // Start LocalStack (for S3)
  localstack = await new GenericContainer("localstack/localstack:2.2")
    .withExposedPorts(4566)
    .start();
  
  // Configure environment variables for tests
  process.env.DATABASE_URL = `postgres://postgres:postgres@localhost:${postgres.getMappedPort(5432)}/postgres`;
  process.env.KAFKA_BROKER = `localhost:${kafka.getMappedPort(9092)}`;
  process.env.S3_ENDPOINT = `http://localhost:${localstack.getMappedPort(4566)}`;
}
```

This code sets up isolated containers for each service our application depends on.

### Test Cases

```javascript
// From productCreation.integration.test.js
describe("Product creation", () => {
  it("should publish and return a product when creating a product", async () => {
    const product = {
      name: "Test Product",
      upc: "123456789012",
      price: 9.99
    };
    
    const createdProduct = await productService.createProduct(product);
    
    expect(createdProduct.id).toBeDefined();
    expect(createdProduct.name).toBe(product.name);
    expect(createdProduct.upc).toBe(product.upc);
    expect(createdProduct.price).toBe(product.price);
    
    const retrievedProduct = await productService.getProduct(createdProduct.id);
    expect(retrievedProduct).toEqual(createdProduct);
  });
  
  it("should publish a Kafka message when creating a product", async () => {
    const product = {
      name: "Kafka Test Product",
      upc: "123456789013",
      price: 19.99
    };
    
    await productService.createProduct(product);
    
    const message = await kafkaConsumer.waitForMessage("products", 5000);
    expect(message).toBeDefined();
    expect(message.action).toBe("product_created");
    expect(message.name).toBe(product.name);
    expect(message.upc).toBe(product.upc);
    expect(message.price).toBe(product.price);
  });
  
  // Additional tests...
});
```

These tests verify that:
1. Products can be created and retrieved
2. Kafka messages are published correctly
3. File uploads work as expected
4. Business rules (like preventing duplicate UPCs) are enforced

## Benefits of Testcontainers for Integration Testing

1. **Realistic Testing**: Tests run against actual services, not mocks
2. **Isolation**: Each test run gets fresh containers
3. **Portability**: Tests run the same way on any machine with Docker
4. **Parallelism**: Tests can run in parallel with isolated containers
5. **CI/CD Compatibility**: Works well in CI/CD pipelines

## Common Testing Patterns with Containers

1. **Database Testing**: Use a containerized database with a known schema and test data
2. **Message Queue Testing**: Verify message publishing and consuming with real message brokers
3. **API Testing**: Test API endpoints against containerized dependencies
4. **End-to-End Testing**: Use containers for all services to test complete workflows

## Troubleshooting

If you encounter issues with Testcontainers:

1. **Port Conflicts**: Ensure no other services are using the same ports
2. **Docker Connection**: Verify Docker is running and accessible
3. **Resource Limits**: Check if Docker has sufficient resources (CPU, memory)
4. **Network Issues**: Ensure containers can communicate with each other

## Next Steps

Now that you've learned how to test your application with Testcontainers, you can:

1. Add more tests to improve coverage
2. Integrate tests into your CI/CD pipeline
3. Move on to the [Build phase](/docker-workshop/product-catalog/build) to learn how to build and package your application for deployment
