FROM archlinux:base-devel
RUN pacman -Syu --noconfirm --needed

RUN pacman -S git cmake meson ninja --needed --noconfirm

ENV USERNAME builder
ENV PASSWD 123

# Adding user
RUN useradd -mU -G wheel $USERNAME
RUN printf "${PASSWD}/n${PASSWD}" | passwd $USERNAME

# Add entry to sudoers file
RUN echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Add yay
RUN sudo -u $USERNAME git clone https://aur.archlinux.org/yay-bin.git --depth=1
RUN cd yay-bin
RUN sudo -u $USERNAME makepkg -noconfirm --syncdeps --install

WORKDIR /
CMD /bin/bash

