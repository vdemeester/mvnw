# Maven (awesome) wrapper

The idea is simple : Maven is a great tool, but sometimes a bit too "slow" or inadapted for my workflow. *But* I like it and the *"convention over configuration"* is what's keeping me using [maven][] instead of [gradle][] or others cool build tool out there. This is where this project fits : wrap the maven command (``mvn``) to make it a little bit more awesome. The command that are currently implemented are the one I needed and use often, but feel free to propose others (fork and pull request ``;-)``).

_Note :_ This tool currently make the assumption that you are using [git][] as version control system, in the future why not support more version control system.

The features aimed are the following :

* Add useful aliases for day-to-day commands :
  * ``version:update-parent`` and commit
  * ``version:update-dependency-properties``, review the change and commit
* Add a hook/property system (simple but powerful). When mvn is called in a maven managed directory, read some files and folder (by convention) to get information about the project, stuff to do before or after commands, etc.
* Getting along [maven-release-plugin][] and [git-flow][] (or at least the git-flow workflow).

## Technical stuff

This is implemented based on [37signals/sub](http://github.com/37signals/sub). There should be a lot of simple commands and few that are basically just calling them in the right order (with the right workflow). Commands are mainly shell script to keep the _dependencies_ small (no need to have ruby, …).


