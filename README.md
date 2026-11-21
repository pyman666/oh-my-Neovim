# oh-my-Neovim

从 `~/.vimrc` 迁移过来的 LazyVim 配置。**同一份配置同时适配 Windows 和 macOS**；输入法切换等平台差异由插件内部按 OS 分支处理，配置层不按平台分叉。

## 环境

- Neovim 0.12+（当前安装在 `~/.local/bin/nvim`）
- LazyVim + lazy.nvim（首次启动自动 bootstrap）
- 配色：everforest
- 缩进：`tabstop=4`，数字统一十进制，开启相对行号

## 安装

```sh
git clone https://github.com/pyman666/oh-my-Neovim.git ~/.config/nvim
nvim
```

首次启动会：

1. 从 `lua/config/machine.example.lua` 生成 `lua/config/machine.lua`（不进 git）
2. 安装 lazy.nvim / LazyVim 及插件
3. 安装插件（需要能访问 GitHub；走代理请自行在系统中开全局 proxy）

## 本机配置：`machine.lua`

`lua/config/machine.example.lua` 是模板，`machine.lua` 是本机值，已加入 `.gitignore`。换机器后改 `machine.lua` 即可；删掉它重启会从模板重新生成。

模板里按 OS 分支提供本机值：

| 平台 | Python | winget | 输入法 |
| --- | --- | --- | --- |
| Windows | Anaconda python.exe 绝对路径 | winget 安装根目录 | `en` / `zh`（locale id） |
| macOS | 不用 | 不用 | `im-select` 路径 + ABC / 简体拼音 ID |

这些只是"值"，不分叉插件来源；插件代码本身是一套，运行时自己选后端。

## 输入法切换

插件：[pyman666/vim-im-switch](https://github.com/pyman666/vim-im-switch)，**两个平台共用同一份代码**：

- Windows：`Python + PostMessageW(WM_INPUTLANGCHANGEREQUEST)`，异步切输入法
- macOS：`im-select`（`TISSelectInputSource`），异步切输入源
- 都不模拟按键、不切 IME 内部模式

行为：

- 进插入模式 → 中文
- 离开插入模式 / 按 `Esc` → 英文
- 退出 Neovim → 恢复中文
- `:IMSwitch en|zh|get` 可手动切换 / 查询

macOS 需要先装 `im-select`：

```sh
brew tap daipeihust/tap && brew install im-select
# 或手动下载二进制到 ~/.local/bin/im-select && chmod +x
```

## 网络与工具（国内环境）

- Mason 的自动安装和 registry 自动刷新已关闭（`lua/plugins/mason.lua`）；`stylua` / `shfmt` / `tree-sitter` 手动装在 `~/.local/bin`。
- macOS 上 `~/.npm/_cacache` 有过去的 root 属主文件，会让 npm 装 `json-lsp` 报 `EACCES`；配置里给 Neovim 子进程换到 `~/.npm-cache-nvim`，不改全局 npm 配置。Windows 无此问题。

## 从原 vimrc 迁移的功能

LazyVim 已自带的（lualine / gitsigns / ts-comments / nvim-lspconfig 等）不再重复安装。另外补了：

- `vim-sleuth`、`vim-easy-align`、`vim-bookmarks`、`vim-table-mode`（`<leader>ta`）
- `mini.surround` 替代 surround，原生 `gc` 替代 commentary
- 原 `<leader>tr`（NERDTree）改为 LazyVim 文件树 `<leader>fe`
- 关闭拼写检查（中文文档不再满屏红波浪线）
- 打开真实文件自动 `cd` 到 git 仓库根目录

## 目录

```text
~/.config/nvim/
├── init.lua                    # 入口：生成并加载 machine.lua
└── lua/
    ├── config/
    │   ├── lazy.lua            # lazy.nvim / LazyVim bootstrap、npm 缓存
    │   ├── machine.example.lua # 本机配置模板（进 git）
    │   ├── machine.lua         # 本机值（不进 git）
    │   ├── options.lua         # 原 vimrc 选项 + winget PATH 探测
    │   ├── keymaps.lua         # 原 vimrc 键位
    │   └── autocmds.lua        # 关拼写、自动 cd 到 git root
    └── plugins/
        ├── user.lua            # 迁移的插件 + 输入法插件（统一来源）
        └── mason.lua           # 关闭 Mason 自动下载
```
