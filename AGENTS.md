Use Yarn 4 for JavaScript tooling. The CLI is in packages/git-mora.
Run the smallest checks covering the change. Cargo build and check outputs are separate; use scripts/cargo.sh inside the package.
The devcontainer uses GIT_MORA_CARGO_TARGET_ROOT=/var/cache/git-mora/cargo-target.
