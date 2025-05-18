-- 文件目录
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- 设置自定义快捷键映射，类似NERDTree
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")
      
      local function opts(desc)
        return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      
      -- 默认快捷键
      vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
      vim.keymap.set('n', '<CR>', api.node.open.edit, opts('打开'))
      vim.keymap.set('n', 'S', api.node.open.horizontal, opts('打开: 水平分屏'))
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('打开: 垂直分屏'))
      vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('关闭父文件夹'))
      vim.keymap.set('n', 'a', api.fs.create, opts('新建文件/文件夹'))
      vim.keymap.set('n', 'c', api.fs.copy.node, opts('复制'))
      vim.keymap.set('n', 'p', api.fs.paste, opts('粘贴'))
      vim.keymap.set('n', 'q', api.tree.close, opts('关闭'))
      vim.keymap.set('n', 'r', api.fs.rename, opts('重命名'))
      vim.keymap.set('n', 'R', api.tree.reload, opts('刷新'))
      vim.keymap.set('n', 'y', api.fs.copy.filename, opts('复制文件名'))
      vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('复制相对路径'))
      
      -- 类似NERDTree的快捷键
      vim.keymap.set('n', 'o', api.node.open.edit, opts('打开文件/目录'))
      vim.keymap.set('n', 'go', api.node.open.no_window_picker, opts('打开文件但光标保留在目录树'))
      vim.keymap.set('n', 't', api.node.open.tab, opts('在新标签页中打开'))
      vim.keymap.set('n', 'T', function()
        api.node.open.tab()
        api.tree.focus()
      end, opts('新标签页中打开但焦点保持在目录树'))
      vim.keymap.set('n', 'i', api.node.open.horizontal, opts('水平分屏打开'))
      vim.keymap.set('n', 'gi', function()
        api.node.open.horizontal()
        api.tree.focus()
      end, opts('水平分屏打开但光标保留在目录树'))
      vim.keymap.set('n', 's', api.node.open.vertical, opts('垂直分屏打开'))
      vim.keymap.set('n', 'gs', function()
        api.node.open.vertical()
        api.tree.focus()
      end, opts('垂直分屏打开但光标保留在目录树'))
      
      -- 递归打开选中的目录
      vim.keymap.set('n', 'O', function()
        -- 获取当前节点
        local node = api.tree.get_node_under_cursor()
        if node.type == "directory" then
          -- 如果节点已经打开，则展开所有子目录
          if node.open then
            -- 遍历展开所有子目录
            local function expand_all_subdirs(nodes)
              for _, child in ipairs(nodes) do
                if child.type == "directory" and not child.open then
                  api.node.open.edit()
                  api.tree.expand_all()
                end
              end
            end
            
            -- 展开当前目录下的所有子目录
            api.tree.expand_all()
          else
            -- 如果节点关闭，先打开再递归展开
            api.node.open.edit()
            vim.defer_fn(function()
              api.tree.expand_all()
            end, 10)
          end
        end
      end, opts('递归打开选中的目录'))
      
      vim.keymap.set('n', 'x', api.node.navigate.parent_close, opts('关闭父目录'))
      vim.keymap.set('n', 'X', api.tree.collapse_all, opts('递归关闭所有子节点'))
      vim.keymap.set('n', 'P', api.tree.change_root_to_node, opts('设置为根节点'))
      vim.keymap.set('n', 'p', api.node.navigate.parent, opts('跳转到父节点'))
      vim.keymap.set('n', 'K', function() 
        api.node.navigate.sibling.prev()
        while api.node.get_node_under_cursor().type ~= 'directory' do
          api.node.navigate.sibling.prev()
        end
      end, opts('向上跳转到目录'))
      vim.keymap.set('n', 'J', function() 
        api.node.navigate.sibling.next()
        while api.node.get_node_under_cursor().type ~= 'directory' do
          api.node.navigate.sibling.next()
        end
      end, opts('向下跳转到目录'))
      vim.keymap.set('n', '<C-K>', api.node.navigate.sibling.prev, opts('向上跳转到上一个兄弟节点'))
      vim.keymap.set('n', '<C-J>', api.node.navigate.sibling.next, opts('向下跳转到下一个兄弟节点'))
      vim.keymap.set('n', 'r', api.fs.rename, opts('重命名'))
      vim.keymap.set('n', 'R', api.tree.reload, opts('刷新根目录'))
      vim.keymap.set('n', 'm', api.marks.toggle, opts('添加/移除书签'))
      vim.keymap.set('n', 'q', api.tree.close, opts('关闭目录树'))
      vim.keymap.set('n', 'A', function()
        local view = require("nvim-tree.view")
        if view.is_visible() and view.get_width() > 35 then
          view.resize("-999999")
        else
          view.resize("+999999")
        end
      end, opts('放大/最小化目录树'))
      vim.keymap.set('n', 'd', api.fs.remove, opts('删除文件或目录'))
      vim.keymap.set('n', 'n', function()
        api.fs.create(true)
      end, opts('创建文件'))
      vim.keymap.set('n', 'N', function()
        api.fs.create(false)
      end, opts('创建目录'))
    end

    nvimtree.setup({
      on_attach = my_on_attach,
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
          quit_on_open = false, -- 打开文件时不关闭树
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "开关文件浏览器" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "根据当前文件开关文件浏览器" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "折叠文件浏览器" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "更新文件浏览器" }) -- refresh file explorer
  end
}
