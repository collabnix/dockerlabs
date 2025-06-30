# Modern Docker Labs Platform

A modern, interactive learning platform for Docker built with React + TypeScript.

## 🚀 Features

- **Interactive Learning**: Modern UI with left sidebar navigation
- **One-Click Commands**: Copy Docker commands with a single click
- **Syntax Highlighting**: Dockerfile, YAML, and Bash code highlighting
- **Progress Tracking**: Track your learning progress across labs
- **Mobile Responsive**: Learn Docker on any device
- **Beginner Friendly**: Structured learning path from basics to advanced

## 📚 Available Labs

### Beginners Track (2/5 labs migrated) ✅
1. **Docker Hello World**: Your First Container
2. **Working with Docker Images**: Search, pull, inspect, and manage

### Coming Soon
- Dockerfile Basics: Building Your First Image
- Docker Volumes: Managing Persistent Data
- Docker Compose: Multi-Container Applications

## 🛠 Development

```bash
# Install dependencies (when package.json is complete)
npm install

# Start development server
npm start

# Build for production
npm run build
```

## 🗂 Project Structure

```
src/
├── types/lab.ts              # TypeScript interfaces
├── labs/beginners/           # Beginner lab implementations
├── components/               # React UI components (coming soon)
└── utils/labRegistry.ts      # Lab management utilities
```

## 🤝 Contributing

1. Follow the Lab interface for new labs
2. Test all commands with Docker Desktop
3. Ensure mobile-responsive content
4. Include proper error handling examples

## 📄 License

Inherits license from main dockerlabs repository.
