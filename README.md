# Maven (awesome) wrapper

The idea is simple : Maven is a great tool, but sometimes a bit too "slow" or inadapted for my workflow. *But* I like it and the *"convention over configuration"* is what's keeping me using [maven][] instead of [gradle][] or others cool build tool out there. This is where this project fits : wrap the maven command (``mvn``) to make it a little bit more awesome. The command that are currently implemented are the one I needed and use often, but feel free to propose others (fork and pull request ``;-)``).

_Note :_ This tool currently make the assumption that you are using [git][] as version control system, in the future why not support more version control system.

The features aimed are the following :

* Add useful aliases for day-to-day commands :
  * ``version:update-parent`` and commit
  * ``version:update-dependency-properties``, review the change and commit
* Add a hook/property system (simple but powerful). When mvn is called in a maven managed directory, read some files and folder (by convention) to get information about the project, stuff to do before or after commands, etc.
* Getting along [maven-release-plugin][] and [git-flow][] (or at least the git-flow workflow).

## Table of Contents

* [Installation](#installation)
  * [Basic Github Checkout](#basic-github-checkout)
  * [Upgrading](#upgrading)
* [Technical stuff](#technical-stuff)

## Installation

### Basic Github Checkout

This will get you going with the latest version of mvnw and make it easy to fork and contribute any changes back upstream.

1. Check out mvnw in ``.mvnw``.

```bash
$ git clone git://github.com/vdemeester/mvnw.git ~/.mvnw
```

2. Add ``~/.mvnw/bin`` to your ``$PATH`` for access to the ``mvnw`` command.

```bash
$ echo 'export PATH="$HOME/.mvnw/bin:$PATH"' >> ~/.bash_profile
```

__Zsh note__: Modify your ~/.zshenv file instead of ~/.bash_profile.

__Ubuntu note__: Ubuntu uses ~/.profile for enabling certain path changes. This file won't be read if you create a ~/.bash_profile. Therefore, it's recommended that you add this line and the one in point 3 below to your ~/.profile. This has the added advantage of working under both bash and zsh.

3. Add mvnw init to your shell to enable autocompletion and stuff.

```bash
$ echo 'eval "$(mvnw init -)"' >> ~/.bash_profile
```

__Zsh note__: Modify your ~/.zshenv file instead of ~/.bash_profile.

__Ubuntu note__: Same as Ubuntu note for point 2 above.


### Upgrading

If you've installed mvnw manually using git, you can upgrade your installation to the cutting-edge version at any time.

```bash
$ cd ~/.mvnw
$ git pull
```

## Technical stuff

This is implemented based on [37signals/sub](http://github.com/37signals/sub). There should be a lot of simple commands and few that are basically just calling them in the right order (with the right workflow). Commands are mainly shell script to keep the _dependencies_ small (no need to have ruby, …).

[maven]: http://maven.apache.org/
[git]: http://git-scm.com
[gradle]: http://www.gradle.org/
[maven-versions-plugin]: http://mojo.codehaus.org/versions-maven-plugin/
[maven-release-plugin]: http://maven.apache.org/plugins/maven-release-plugin/
[git-flow]: https://github.com/nvie/gitflow
