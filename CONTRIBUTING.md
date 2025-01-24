# Contributing to @sailfin/sailfin

Thank you for considering contributing to @sailfin/sailfin! Your contributions are valuable to us, and this guide will help you understand our development process, how to report issues, and how to contribute code effectively.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Improving Documentation](#improving-documentation)
  - [Submitting Code Changes](#submitting-code-changes)
- [Development Setup](#development-setup)
  - [Prerequisites](#prerequisites)
  - [Setting Up the Project](#setting-up-the-project)
  - [Running Tests](#running-tests)
- [Coding Guidelines](#coding-guidelines)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Pull Request Process](#pull-request-process)
- [Thank You!](#thank-you)

## Code of Conduct

This project adheres to the Contributor Covenant [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [michael@sailfin.io](mailto:michael@sailfin.io).

## How Can I Contribute?

### Reporting Bugs

If you find a bug in the source code, you can help us by [submitting an issue](https://github.com/SailfinIO/sailfin/issues). Before submitting a bug report, please check if an issue already exists. If it does, add any additional information you have as a comment.

When reporting a bug, please include:

- **A clear and descriptive title** for the issue.
- **Steps to reproduce** the issue, so we can replicate it.
- **Expected behavior** vs. **actual behavior**.
- Any **relevant logs or screenshots**.
- The version of the package you are using.

### Suggesting Features

We welcome feature suggestions! To suggest a new feature, please [submit an issue](https://github.com/SailfinIO/sailfin/issues) and describe the feature you'd like to see, the problem it solves, and any relevant examples or use cases. This will help us understand the context and potential impact of the feature.

### Improving Documentation

Documentation is key to any open-source project. You can contribute by improving our documentation:

- **Fix typos or grammatical errors**.
- **Improve existing explanations**.
- **Add new examples** or use cases.

Submit documentation improvements directly as a [pull request](https://github.com/SailfinIO/sailfin/pulls).

### Submitting Code Changes

#### 1. Fork the Repository

Fork the [mail repository](https://github.com/SailfinIO/sailfin) on GitHub, and clone your fork to your local machine:

```bash
git clone https://github.com/your-username/sailfin.git
cd sailfin
```

#### 2. Create a Branch

Create a new branch to work on your feature or bug fix:

```bash
git checkout -b my-feature-branch
```

#### 3. Make Changes

Make your changes to the codebase. Ensure that your changes follow the [coding guidelines](#coding-guidelines).

#### 4. Run Tests

Before submitting a pull request, run the tests to ensure your changes don't break existing functionality:

```bash
npm run test
```

#### 5. Commit Changes

Commit your changes with a descriptive commit message:

```bash
git commit -am "Add new feature"
```

#### 6. Push Changes

Push your changes to your fork on GitHub:

```bash
git push origin my-feature-branch
```

#### 7. Submit a Pull Request

Submit a pull request from your fork to the `main` branch of the `sailfin` repository. Include a detailed description of your changes and why they should be merged.

## Development Setup

### Prerequisites

To set up the project for development, you need:

- [Node.js](https://nodejs.org) (v14 or higher)
- [NPM](https://www.npmjs.com) (v6 or higher)

### Setting Up the Project

To set up the project for development, clone the repository and install the dependencies:

```bash
git clone
cd sailfin
npm install
```

### Running Tests

To run the tests, use the following command:

```bash
npm run test
```

## Coding Guidelines

When contributing to the project, please follow these coding guidelines:

- Use [Prettier](https://prettier.io) to format your code.
- Write descriptive commit messages following the [commit message guidelines](#commit-message-guidelines).
- Ensure your code passes the linting and testing checks.

## Commit Message Guidelines

When writing commit messages, follow these guidelines:

- Use the present tense ("Add feature" not "Added feature").
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...").
- Limit the first line to 72 characters or less.
- Reference issues and pull requests in the body of the commit message.

## Pull Request Process

To submit a pull request:

1. Fork the repository and create a new branch.
2. Make your changes and run the tests.
3. Commit your changes with a descriptive commit message.
4. Push your changes to your fork on GitHub.
5. Submit a pull request to the `main` branch of the `@sailfin/sailfin` repository.

## Thank You!
