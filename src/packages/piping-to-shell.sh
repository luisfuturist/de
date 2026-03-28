# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# bun
curl -fsSL https://bun.sh/install | bash

# pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim --headless +q

# Ruby
export PATH=\"$PATH:$(gem env path | sed 's#[^:]\+#&/bin#g')\"
