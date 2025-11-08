# Development Template

A comprehensive template repository for creating new GitHub projects with pre-configured development environment and best practices.

## Features

- **Cross-platform development support** - Configured for macOS, Windows, and Linux
- **VS Code integration** - Pre-configured settings, extensions, and DevContainer support
- **GitHub templates** - Issue and Pull Request templates for better project management
- **Code formatting** - EditorConfig for consistent code style across editors
- **Docker support** - DevContainer configuration for consistent development environments

## What's Included

### Development Environment

- `.editorconfig` - Consistent code formatting across different editors
- `.vscode/` - VS Code specific settings and recommended extensions
- `.devcontainer/` - Docker-based development environment configuration

### GitHub Integration

- `.github/ISSUE_TEMPLATE/` - Standardized issue templates
- `.github/PULL_REQUEST_TEMPLATE.md` - Pull request template
- `.github/workflows/` - Ready for CI/CD workflow configurations

### Project Configuration

- `.gitignore` - Comprehensive ignore rules for macOS, Windows, and Linux
- `src/` - Source code directory structure

## Getting Started

1. **Use this template** - Click "Use this template" button on GitHub
2. **Clone your new repository**

   ```bash
   git clone https://github.com/yourusername/your-new-project.git
   cd your-new-project
   ```

3. **Install dependencies**

   ```bash
   npm install
   ```

   This will install the required development tools (Husky, Prettier, Commitlint, etc.).

4. **Customize for your project**
   - Update this README.md with your project details
   - Modify `.devcontainer/devcontainer.example.json` and rename to `devcontainer.json`
   - Add your source code to the `src/` directory
   - Configure GitHub workflows in `.github/workflows/`

## DevContainer Setup

This template includes a DevContainer configuration for consistent development environments:

1. Copy `.devcontainer/devcontainer.example.json` to `.devcontainer/devcontainer.json`
2. Customize the configuration as needed
3. Open in VS Code and select "Reopen in Container"

## Customization

### Issue Templates

Edit `.github/ISSUE_TEMPLATE/task.md` to match your project's needs.

### Pull Request Template

Modify `.github/PULL_REQUEST_TEMPLATE.md` for your workflow requirements.

### VS Code Extensions

Update `.vscode/extensions.json` with extensions specific to your project type.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This template is provided as-is for creating new projects. Add your own license file as needed.
