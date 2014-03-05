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
* [Usage](#usage)
  * [mvnw update-parent](#mvnw-update-parent)
  * [mvnw update-properties](#mvnw-update-properties)
  * [others](#others)
* [Hooks](#hooks)
  * [source hook](#source-hook)
  * [command hook](#command-hook)
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

## Usage

``mvnw`` contains a set of subcommand. If the first argument specified is not
one of these command, it runs ``mvn`` with the arguments specified ; that way
it can be used in place of the ``mvn`` command.

Most of the time it's possible to pass additionnal arguments to the subcommand
that will be _forward_ to the ``mvn`` command(s), using ``--``.

```sh
$ mvnw update-properties -- -Dincludes=org.shortbrain.* -DprocessDependencyManagement=false
```

The most common subcommands (and the _public ones_) are :

### mvnw update-parent

Updates the parent of the current ``pom.xml`` by using the ``mvn
versions:update-parent`` and commit the updated pom.xml. It runs few check
like project version, state of the git repository, ``pom.xml`` precense, etc.

There is 3 hooks for this command :
* __pre__ for executing stuff before the actual run
* __validate__ for executing stuff after the parent update but before
  committing. If one of these hooks failed, the whole run is ended.
* __post__ for executing stuff after the actual run

### mvnw update-properties

Updates the properties used as versions in the current ``pom.xml`` by using the
``mvn versions:update-properties`` and commit the updated pom.xml. 
It runs few check like project version, state of the git repository, 
``pom.xml`` precense, etc.

There is 3 hooks for this command :
* __pre__ for executing stuff before the actual run
* __validate__ for executing stuff after the parent update but before
  committing. If one of these hooks failed, the whole run is ended.
* __post__ for executing stuff after the actual run

### others

* __project-version__ : return the version of the project.

## Hooks

``mvnw`` has a hook system that let you tune a bit its behavior. There is too
kind of hook : source and commands. ``mvnw`` will look for hooks in two folder
: ``$_MVNW_ROOT/hook.d`` (usually ``$HOME/.mvnw/hook.d``) and ``$PWD/.mvn.d``
(that way, you can embedded hooks for specific projects).

### source hook

``mvnw`` will look for a ``mvnrc`` file in the hooks folder and source it.
As it's a shell script that is source, what it is doing is up to you. But
there is a few environment variables you could set that will be used if
present by subcommands.

```sh
# additionnal args for mvnw in the update-properties subcommand
export UPDATE_PROPERTIES_ARGS="-DprocessDependencyManagement=false"
```

### command hook

``mvnw`` will execute command based on the subcommand and the step, looking
for ``$HOOK_PATH/$command/$step.*``. It executes the command so it can be 
written in any language as long as it is an executable file.

The steps should be documented for each command but here is an example for the
``update-properties`` command.

```sh
$ cat $PWD/.mvnw.d/update-properties/pre.hello.sh
#!/bin/sh
echo "Hello..."
$ cat $HOME/.mvnw/hook.d/update-properties/validate.test.sh
#!/bin/sh
# Runs compilation and tests
mvn clean test
```

## Technical stuff

This is implemented based on [37signals/sub](http://github.com/37signals/sub). There should be a lot of simple commands and few that are basically just calling them in the right order (with the right workflow). Commands are mainly shell script to keep the _dependencies_ small (no need to have ruby, …).

[maven]: http://maven.apache.org/
[git]: http://git-scm.com
[gradle]: http://www.gradle.org/
[maven-versions-plugin]: http://mojo.codehaus.org/versions-maven-plugin/
[maven-release-plugin]: http://maven.apache.org/plugins/maven-release-plugin/
[git-flow]: https://github.com/nvie/gitflow


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/vdemeester/mvnw/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

