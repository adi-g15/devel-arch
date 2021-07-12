FROM archlinux:base-devel
RUN pacman -Syu --noconfirm --needed

RUN pacman -S git cmake meson ninja --needed --noconfirm

ENV USERNAME builder

# Adding user
RUN useradd -mU $USERNAME

# Add entry to sudoers file
RUN echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USERNAME

# Set workdir for further changes to /tmp, and install yay
WORKDIR /tmp

RUN git clone https://aur.archlinux.org/yay-bin.git --depth=1
RUN chown $USERNAME -R yay-bin
WORKDIR yay-bin
RUN sudo -u $USERNAME makepkg --noconfirm --syncdeps --install

WORKDIR /
CMD /bin/bash

