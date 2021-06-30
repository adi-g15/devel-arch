# Dockerfile based on archlinux:base-devel

Additional User details, for use with makepkg etc. :
  * Username: 'builder'

Additional Packages: git, cmake, meson, [yay](https://github.com/Jguer/yay)

Provides you with an arch system, intentionally not using an ENTRYPOINT for now :)

## Usage

Most basic usage is:

```sh
docker run -it devel-arch
```

It provides you access to the bash shell to type in commands

> If you want a scripted workflow, replace the CMD with a ENTRYPOINT statement in the Dockerfile

## Customisations

* The `zsh` branch uses zsh as default shell, with oh-my-zsh included
* The `custom` branch are my own custom additions, if any

> The Dockerfile is quite short, modify it to your liking :)

