# Contributing to Zuri Market DevOps

Thank you for your interest in contributing! This project is built to demonstrate a full-stack DevOps workflow with a backend API, frontend app, Docker, CI/CD, and deployment infrastructure.

## How to contribute

1. Fork the repository.
2. Create a new branch for your feature or fix:
   ```bash
git checkout -b feature/your-feature-name
```
3. Make your changes.
4. Run local verification:
   - Backend: `cd backend && npm install && npm test`
   - Frontend: `cd frontend && npm install && npm run build`
5. Commit your changes with a clear message.
6. Push the branch to your fork.
7. Open a pull request against `main`.

## Good contributions
- Fix bugs or improve code quality
- Add tests or validation steps
- Improve documentation or README content
- Add CI/CD automation, infrastructure, or deployment scripts
- Make Docker images reproducible and secure

## Pull request checklist
- [ ] Code compiles and runs locally
- [ ] No sensitive credentials are included
- [ ] Changes are documented if needed
- [ ] Build/test steps pass for both backend and frontend

## Notes
- This project uses GitHub Actions for CI/CD.
- DockerHub credentials should be managed using repository secrets.
- Keep the repository structure clear and avoid committing build artifacts.
