[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

<!-- PROJECT HEADER -->
<br />
<p align="center">
  <h3 align="center">🏃 Reusable Workflows</h3>

  <p align="center">
    ·
    <a href="https://github.com/Good-Games-Munich/reusable-workflows/issues">Report Bug</a>
    ·
    <a href="https://github.com/Good-Games-Munich/reusable-workflows/issues">Request Feature</a>
    ·
  </p>
</p>

<!-- ABOUT THE PROJECT -->

## About The Project

Reusable workflows. See [reusing-workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows).

## Workflows

### [Production deploy](.github/workflows/production-deploy.yml)

Deploys a service to production

#### Inputs

none.

#### Secrets

| Name              | Description                                           | Required | In organization |
| ----------------- | ----------------------------------------------------- | -------- | --------------- |
| `SSH_SERVER`      | SSH server to log in via SSH.                         | `true`   | `true`          |
| `SSH_PRIVATE_KEY` | SSH secret key to log in via SSH.                     | `true`   | `true`          |
| `ENVIRONMENT`     | Environment file string to be used during deployment. | `true`   | `false`         |

#### Environment deployment

It deploys to a environment with the name `production`.

#### Example

1. Setup all needed non organization secrets listed above (`In organization` are setup [here](https://github.com/organizations/Good-Games-Munich/settings/secrets/actions) already). See [Encrypted secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
2. Create a file at `github/workflows/production-deploy.yml` and copy paste:

```yaml
---
# https://github.github.io/actions-cheat-sheet/actions-cheat-sheet.pdf
# https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#name
name: "Deploy service to production"

# Define the trigger. https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#on
on:
  release:
    types:
      - created

# https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobs
jobs:
  deploy:
    # https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idstepsuses
    uses: Good-Games-Munich/reusable-workflows/.github/workflows/production-deploy.yml@main
    # https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idsecretsinherit
    secrets: inherit
```

<!-- CONTRIBUTING -->

## Contributing

Follow [contributing](https://github.com/Good-Games-Munich/.github/wiki/workflows#contributing).

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/Good-Games-Munich/reusable-workflows.svg?style=flat-square
[contributors-url]: https://github.com/Good-Games-Munich/reusable-workflows/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Good-Games-Munich/reusable-workflows.svg?style=flat-square
[forks-url]: https://github.com/Good-Games-Munich/reusable-workflows/network/members
[stars-shield]: https://img.shields.io/github/stars/Good-Games-Munich/reusable-workflows.svg?style=flat-square
[stars-url]: https://github.com/Good-Games-Munich/reusable-workflows/stargazers
[issues-shield]: https://img.shields.io/github/issues/Good-Games-Munich/reusable-workflows.svg?style=flat-square
[issues-url]: https://github.com/Good-Games-Munich/reusable-workflows/issues
