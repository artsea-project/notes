# Styleguide: How to Write Commit Messages

We follow the **Conventional Commits** standard. Each commit should consist of a type, an optional scope, and a short description.

**Format:** `<type>(optional-scope): <short description>`

## Commit Types

* **feat**: A new feature for the user.
* **fix**: A bug fix.
* **docs**: Documentation only changes (e.g., README.md).
* **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc. – not to be confused with CSS styles!).
* **refactor**: A code change that neither fixes a bug nor adds a feature (e.g., simplifying logic).
* **perf**: A code change that improves performance.
* **test**: Adding missing tests or correcting existing tests.
* **build**: Changes that affect the build system or external dependencies (e.g., npm, webpack, maven).
* **ci**: Changes to CI configuration files and scripts (e.g., GitHub Actions, Jenkins, Travis).
* **chore**: Other changes that don't modify source or test files (e.g., updating `.gitignore`).
* **revert**: Reverts a previous commit.

## Examples

* `feat: add registration form validation`
* `fix(api): resolve 404 error when fetching user profile`
* `docs: update installation instructions in README`
* `refactor: extract authorization logic into a separate service`

---
*Tip: Use the imperative mood in the description (e.g., "add" instead of "added" or "adds").*