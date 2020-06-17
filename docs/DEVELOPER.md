# Contributing to the NBS(Nsuki Business Service)

First of all, welcome to Nsuki Engineering Team! :raised_hands:

## Contributers

Contributers are invited to manage issues, make corrections to the style guide, review pull requests, and
merge approved changes.

1. All changes must pass automatic checks and should be discussed and approved in a pull request before being merged.

## Git Commit Message

The following link is our commit message convention, please [read](https://chris.beams.io/posts/git-commit/)

## The Elixir Style Guide

This is the style guide that we are following for this project [elixir style guide](https://github.com/christopheradams/elixir_style_guide)

## Development Environment

I highly recommend installing Elixir (and Erlang) using [asdf](https://asdf-vm.com/#/), to manage Elixir/Erlang versions
1. Install [asdf](https://asdf-vm.com/#/core-manage-asdf-vm)

On a new terminal, install Erlang and Elixir plugins:

```bash
asdf plugin-add erlang
asdf plugin-add elixir
```

## Install Erlang and Elixir

```bash
asdf install erlang 22.2.7
asdf install elixir 1.10.3-otp-22
```
Then set them as the global version:
```bash
asdf global erlang 22.2.7
asdf global elixir 1.10.3-otp-22
```

## Install Docker

We need [docker](https://www.docker.com/) for running PostgreSQL

## Pull Requests Naming Convention
The pull requests name should be the same as the ticket/task name, example: [Root-01] Create documentation

## Definition of done

### 1. Definition of Done checklist for User Story

This is the first and the most basic level is a User Story, where we check compliance with the initial assumptions of single backlog item, which were described in it. On this stage we also control quality of written code and check if all necessary elements of our process were carried out, for example:

* Produced code for presumed functionalities
* Assumptions of User Story met
* Project builds without errors
* Unit tests written and passing
* Project deployed on the test environment identical to production platform
* Tests on devices/browsers listed in the project assumptions passed
* Feature ok-ed by UX designer
* QA performed & issues resolved
* Feature is tested against acceptance criteria
* Feature ok-ed by Product Owner
* Refactoring completed
* Any configuration or build changes documented
* Documentation updated
* Peer Code Review performed


### 2. Definition of Done checklist for Sprint

The second stage is Sprint, where we check the greater part of our work. Here we can see if all the implemented features fulfill their original assumptions and if all the required conditions for the production deployment were met.

* DoD of each single User story, included in the Sprint are met
* “to do’s” are completed
* All unit tests passing
* Product backlog updated
* Project deployed on the test environment identical to production platform
* Tests on devices/browsers listed in documentation passed
* Tests of backward compatibility passed
* The performance tests passed
* All bugs fixed
* Sprint marked as ready for the production deployment by the Product Owner


### 3. Definition of Done checklist for Release

* Code Complete
* Environments are prepared for release
* All unit & functional tests are green
* All the acceptance criterias are met
* QA is done & all issues resolved
* All “To Do” annotations must have been resolved
* OK from the team: UX designer, developer, software architect, project manager, product owner, QA, etc.
* Check that no unintegrated work in progress has been left in any development or staging environment.
* Check that TDD and continuous integration is verified and working


### Our Basic Definition of Done

You can find it [here](https://docs.google.com/document/d/1RZdRZd2ytN3ZZZmNTpboxP2X2agfuulIb4Jxx4k2__A/edit)