# Contributing to DockerLabs

Thank you for your interest in contributing to DockerLabs! This guide will help you get started.

## How to Get Involved

1. **Join the Community**
   - Join our [Slack community](https://collabnix.slack.com) to connect with other contributors
   - Introduce yourself in the #general channel
   - Browse channels like #docker-networking, #docker-volumes, #docker101

2. **Find Your Area of Interest**
   - Browse the [DockerLabs documentation](https://dockerlabs.collabnix.com/)
   - Check out [open issues](https://github.com/collabnix/dockerlabs/issues) for areas that need help
   - Look for outdated content, broken links, or missing tutorials

## Ways to Contribute

### Documentation Improvements
- Fix typos and grammar errors
- Update outdated Docker commands or versions
- Add missing examples or explanations
- Improve existing tutorials with clearer steps

### New Content
- Write beginner-friendly Docker tutorials
- Create hands-on labs for specific Docker features
- Add real-world use cases and examples
- Contribute Docker Compose examples

### Bug Fixes
- Fix broken links in documentation
- Correct incorrect commands or configurations
- Update deprecated Docker features

## Contribution Process

### 1. Fork the Repository
```bash
# Fork on GitHub, then clone your fork
git clone https://github.com/YOUR_USERNAME/dockerlabs.git
cd dockerlabs

# Add upstream remote
git remote add upstream https://github.com/collabnix/dockerlabs.git
```

### 2. Create a Branch
```bash
# Create a new branch for your changes
git checkout -b fix/your-description

# Or for new features
git checkout -b feat/your-description
```

### 3. Make Your Changes
- Keep changes focused and small
- Follow the existing documentation style
- Add links to your new content in the appropriate README files

### 4. Submit a Pull Request
```bash
# Commit your changes
git add .
git commit -m "Brief description of changes"

# Push to your fork
git push origin your-branch-name
```

Then create a Pull Request on GitHub with:
- A clear title describing the change
- A brief description of what you changed and why
- Reference any related issues (e.g., "Fixes #123")

## Style Guidelines

### Documentation
- Use clear, concise language
- Include code examples where appropriate
- Use proper Markdown formatting
- Add frontmatter for Docusaurus pages:
  ```yaml
  ---
  layout: default
  title: Your Title
  description: collabnix | DockerLab | Your Description
  ---
  ```

### Code Examples
- Use working, tested examples
- Include comments explaining key concepts
- Show expected output when helpful

## Getting Help

- **Questions?** Ask in the [Slack community](https://collabnix.slack.com)
- **Issues?** Open a [GitHub issue](https://github.com/collabnix/dockerlabs/issues)
- **New to GitHub?** Check out [GitHub's guide](https://guides.github.com/activities/hello-world/)

## License

By contributing to DockerLabs, you agree that your contributions will be licensed under the [MIT License](https://github.com/collabnix/dockerlabs/blob/master/LICENSE.md).
