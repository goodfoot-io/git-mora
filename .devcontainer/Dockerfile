# Same shared base as git-mesh / Git Span.
FROM devcontainer-base:node24.16-trixie
USER root
RUN apt-get update && apt-get install -y --no-install-recommends build-essential mold linux-perf chrony \
    && rm -rf /var/lib/apt/lists/*
COPY packages/git-mora/scripts/cc.mold-wrapper.sh /usr/local/bin/cc.mold-wrapper
RUN chmod +x /usr/local/bin/cc.mold-wrapper \
    && mkdir -p /var/cache/git-mora/cargo-target /var/lib/coaxial/opencode /var/lib/coaxial/cards-worktrees /var/lib/coaxial/rustup /var/lib/coaxial/cargo \
    && chown -R node:node /var/cache/git-mora /var/lib/coaxial \
    && echo "node ALL=(root) NOPASSWD: /usr/sbin/chronyd" > /etc/sudoers.d/node-chrony \
    && chmod 0440 /etc/sudoers.d/node-chrony
USER node
ENV NODE_OPTIONS=--max-old-space-size=4096
RUN npm install -g @anthropic-ai/claude-code @openai/codex
