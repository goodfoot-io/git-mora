# Git Mora

Standalone development checkout extracted from `../git-mesh/packages/git-mora`.
The original checkout remains unchanged. Source is in `packages/git-mora`; the
five native distribution packages are in `npm/`. The small Yarn workspace keeps
the existing packaging, versioning, and release workflow intact, without Turbo.
Upstream repository metadata is retained until a dedicated remote is chosen.
No remote or commits have been created here.

## Development

Open this folder in VS Code and choose **Reopen in Container**. The initialize
command builds the sibling `../devcontainer-base` image if needed, just as Git
Span does. Docker Desktop and that shared base checkout are required.

The container mounts this checkout at `/workspace` and
`~/devcontainer/git-mora` at `/home/node`. Its Compose project, hostname, Cargo
build volume, Rust toolchain/cache volumes, opencode data, card worktrees, and
history volume are independent of Git Span. The base entrypoint redirects the
heavy home paths to `/var/lib/coaxial` volumes to avoid nested virtiofs mounts.
Docker socket access, Tailscale TUN networking, and the base SSH startup follow
the Git Span setup. The extension/browser and website stacks are omitted.

The initial home contains shell configuration and Git identity copied from Git
Span. Agent login state, SSH keys, histories, and Tailscale state are not copied;
authenticate tools in the new container as needed. `.devcontainer/.env` is an
ignored local copy of Git Span's environment with a new hostname. For another
checkout, copy `.env.example` to `.env` and supply credentials as needed.

Post-create installs the shared runtime tools, installs locked Yarn dependencies,
and builds/installs Mora plus its man pages into `~/.local`. Use:

```sh
yarn test
yarn lint
yarn build:local
yarn check:versions
```

Cargo tasks use `GIT_MORA_CARGO_TARGET_ROOT`, with separate `git-mora/build` and
`git-mora/check` directories and a shared lock. On a host, set this variable to a
writable cache directory. Linux requires `flock`, `build-essential`, and `mold`;
the image supplies them. The copied mold and locking helpers now live in Mora's
own scripts directory. Direct Cargo commands use `target-cache` by default.

The release workflow is retained. Configure a Git remote and publishing secrets
before using `yarn release`; it pushes a version tag.
