# Say Their Names iOS Contribution Guide

Welcome! Thank you for being here and for willing to contribute to the cause.

Below you will find some information about the project that will help you
get started.

## Community

This project is run by a community of volunteers. The community communicates
via a slack workspace, and to-dos are maintained on respective Trello boards.
[Link to the iOS board](https://trello.com/b/XhG385ND/say-their-names-ios)

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

Add `Say-Their-Name/ios` group as a reviewer, so all iOS contributors get a notification.

### Reviewing a PR

Anyone is welcome to chip in with input on pull requests, the more the merrier.

When providing feedback try to be kind and keep in mind that everyone working on
the project is a volunteer.

When you provide non-critical feedback or optional suggestions, use "Comment" or
"Approve", reserving "Request Changes" only for critical must-fix issues that
should block the PR.

### Commits
We are using the following conventions to identify what the commit is doing:

- **CHORE:** Any code level improvement, that doesn't affect the user directly.
- **FIX:** Any bug fixes.
- **UI:** Any UI change that is not necessarily a feature or a bug.
- **FEAT:** Any new feature

The commits should be done as such:
 - **[TAG]** Description
 
**Example:**

- **[CHORE]** Added secret logic
- **[BUG]** Fixed delay when changing progress bar
- **[FEAT]** Added new mixer sounds

## The project

This project is a classic iOS app project, written in Swift with UIKit, using Xcode 11.5
with support for iOS 13 and above.

### Code style

The code is expected to abide by [Swift API design guidelines](https://swift.org/documentation/api-design-guidelines/),
though [bikeshedding](https://www.urbandictionary.com/define.php?term=bikeshedding) is highly discouraged.

Use of force-unwrapping is not recommended, at least replace it with `fatalError()`
with a meaningful error message.

Before making a PR, check that the code has access control (variables that can be private, are),
variables have meaningful names, etc.

When reviewing PRs, comments about code style are welcome, but keep in mind that
this project is developed by volunteers from all over the world.
Due to this there might not always be one consistent style throughout the project
(at least at first), so please try to be flexible.

### UI development

This project uses UIKit to develop UIs. Using programmatic layout is preferred
due to improved maintainability and possibility to easily resolve merge conflicts
from multiple contributors.
Usage of xibs and storyboards is discouraged, however in rare cases individual xibs
can be okay for very static UIs.

The app intends to follow iOS best practices such as dark mode, accessibility,
dynamic type. Please keep those in mind when developing the UI.
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

`Pods/` folder is checked in to the source control. That is needed so the project
can be run right away when checking out the repo without the need to install
additional tools. If there are any uncommitted changes inside the `Pods/`
folder, they most likely need to be committed.

## FAQ

### Who reviews / merges pull requests?

Anyone can review a pull request, but only reviews of members with write access to the repo count toward the required number of reviews. 

When the PR is all-green (got required approvals and CI passed), anyone can merge the PR, unless mentioned in the comments not to. 
If the PR has conflicts, sometimes one of the maintainers will resolve them to merge quickly, but generally the PR author is expected to bring the PR to a mergeable state and merge it.

### Who moves cards on the Trello board?

When you pick up a task, move the card from To-Do to In progress column, then to In Review when PR is created, and to Complete once the PR(s) are merged. 
Sometimes maintainers might move cards if they are left in outdated state. 

### Who are the maintainers? 

[@FranckNdame](https://github.com/FranckNdame) started the project together with [@ahmadkarkouti](https://github.com/ahmadkarkouti), and more and more people joined over time.
If you are active in the project, contribute regularly and keep up with what's happening, you can consider yourself a maintainer!

## Conclusion

Hopefully this document has given you an introduction to the project. 
If you have any questions not covered here, feel to ask them on the #ios channel in Slack (link above).
Feel free to submit Pull Requests to improve this document.

Looking forward to your contributions! 🙌
