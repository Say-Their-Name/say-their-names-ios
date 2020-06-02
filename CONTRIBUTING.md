# Say Their Name iOS Contribution Guide

Welcome! Thank you for being here and for willing to contribute to the cause.

Below you will find some information about the project that will help
get started with your contributions.

## Community

This project is run by a community of volunteers. The community communicates
via a slack workspace, and to-dos are maintained on respective Trello boards.

If you would like to join the slack workspace, use [this link](https://join.slack.com/t/saytheirnames/shared_invite/zt-eqjuatz7-fgh3zPRXIKiiXsC1Vf3oZA).

## Git workflow

The main branch is `development`, where all ongoing development work converges.
`master` branch is reserved for some more finished version of the app.

When working on something, create a new branch from `development`, and make a PR
back into `development` branch.

There are multiple people working from different timezones, so it's good to try
to keep your branch up-to-date by rebasing it on top of latest `development`.

Try to not let your work get stale and out of date.
The best approach is to make smaller PRs: for example, laying some foundation for
a feature, or refactoring, can be PR'd before continuing further with feature
development.

### Making a PR

When making a PR, add a meaningful title and description.

If any development is done on the UI (additions or non-trivial changes), please
include a screenshot of the change.

Tag `Say-Their-Name/ios` group as a reviewer, so all iOS contributors get a notification.

## The project

This project is a classic iOS app project, written in Swift with UIKit.

### UI development

This project uses UIKit to develop UIs. Using xibs and programmatic layout are both
acceptable, however programmatic layout is preferred due to improved maintainability.
Usage of storyboards is discouraged.

The app intends to follow iOS best practices such as dark mode, accessibility,
dynamic text. Please keep those in mind when developing the UI.
Using Auto Layout helps with making interfaces adaptive, so it's encouraged to use it.

### Unit testing

It is encouraged to include unit tests together with the code. That way we can
be sure that the code continues to work as the time goes.
Please cover at least some scenarios, or even pair with
someone on the task. Worst case, if unable to add tests,
please create a to-do task on the iOS Trello board.

There is no UI testing set up yet, though there is an ongoing effort.

### Third-party dependencies

The intention is to keep the amount of third-party dependencies to a minimum. However,
it's better to add a dependency rather than write or copy over untested code.
If in doubt, don't hesitate to consult with the community - there is usually a
reasonable solution :)

Currently CocoaPods is used as a dependency manager. That can be re-evaluated
when all libraries we use support Carthage or SPM.
