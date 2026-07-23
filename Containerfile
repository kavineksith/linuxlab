# linuxlab practice container — works with podman or docker
#
# Build:
#   podman build -t linuxlab -f Containerfile .
#   # or: docker build -t linuxlab -f Containerfile .
#
# Run (interactive shell, non-root lab user, persistent progress):
#   podman run -it --rm \
#     -v linuxlab-home:/home/labuser \
#     linuxlab
#
# Notes:
#   - Tasks marked ENVIRON="native" in their meta.sh (systemd services,
#     ufw firewall, LVM/loop devices, AppArmor, auditd, real network
#     interface changes, the containers-on-host category) need a real
#     host or VM with the right kernel privileges — this container has
#     no init system, no NET_ADMIN by default, and no access to the
#     host's loop/audit/apparmor subsystems. 'lab show <id>' warns you
#     when a task doesn't fit. lvm2, apparmor(-utils), and auditd are
#     still installed here so the container works out of the box if
#     you run it with `--privileged --cap-add=ALL` on a Linux host —
#     otherwise treat those categories as "run on a real VM instead".
#   - Everything else (permissions, processes, text processing, users/
#     groups, log parsing, sudoers, personal crontab, rsync backups)
#     works fine here unprivileged.

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    LAB_ROOT=/opt/linuxlab

RUN apt-get update && apt-get install -y --no-install-recommends \
        sudo \
        cron \
        bash \
        coreutils \
        findutils \
        grep \
        gawk \
        sed \
        procps \
        psmisc \
        iproute2 \
        net-tools \
        openssh-client \
        openssh-server \
        vim-tiny \
        nano \
        less \
        man-db \
        curl \
        ca-certificates \
        python3 \
        netcat-openbsd \
        dnsutils \
        logrotate \
        ufw \
        file \
        rsync \
        lvm2 \
        apparmor \
        apparmor-utils \
        auditd \
    && rm -rf /var/lib/apt/lists/*

# Non-root learner account with sudo (password 'labuser' — change in real deployments)
RUN useradd -m -s /bin/bash labuser \
    && echo "labuser:labuser" | chpasswd \
    && usermod -aG sudo labuser \
    && echo "labuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/labuser \
    && chmod 440 /etc/sudoers.d/labuser

COPY --chown=root:root . /opt/linuxlab
RUN chmod +x /opt/linuxlab/bin/lab \
    && find /opt/linuxlab/tasks -name 'setup.sh' -o -name 'check.sh' | xargs chmod +x \
    && ln -s /opt/linuxlab/bin/lab /usr/local/bin/lab

USER labuser
WORKDIR /home/labuser
ENV PATH="/usr/local/bin:${PATH}"

CMD ["/bin/bash", "-l"]
