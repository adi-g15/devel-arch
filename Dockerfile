FROM archlinux:base-devel
RUN pacman -Syu --noconfirm --needed

RUN pacman -S git cmake meson ninja wget --needed --noconfirm

ENV USERNAME builder

# Adding user
RUN useradd -mU $USERNAME

# Add entry to sudoers file
RUN echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USERNAME

# Set workdir for further changes to /tmp
WORKDIR /tmp

# Add yay
RUN git clone https://aur.archlinux.org/yay-bin.git --depth=1
RUN chown $USERNAME -R yay-bin
WORKDIR yay-bin
RUN sudo -u $USERNAME makepkg --noconfirm --syncdeps --install

# Add zsh and oh-my-zsh
RUN pacman -S --noconfirm --needed zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
WORKDIR /home/$USERNAME
RUN su $USERNAME -c 'sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
RUN chsh -s /bin/zsh root
RUN chsh -s /bin/zsh $USERNAME

# Clean repos cloned to /tmp
RUN rm -rf /tmp/yay*

WORKDIR /
CMD /bin/zsh

