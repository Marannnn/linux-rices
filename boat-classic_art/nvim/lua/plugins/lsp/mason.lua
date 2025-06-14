return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "csharp_ls", "html" }
			})
		end

	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
		end
	},
		{
		  'hrsh7th/nvim-cmp',
		  dependencies = {
		    'hrsh7th/cmp-nvim-lsp',
		    'L3MON4D3/LuaSnip',
		    'saadparwaiz1/cmp_luasnip',
		    'hrsh7th/cmp-buffer',
		    'hrsh7th/cmp-path',
		},
		config = function()
      local cmp = require("cmp")
      cmp.setup({
    window = {
	completion = cmp.config.window.bordered(),
       documentation = cmp.config.window.bordered(),
    },
    
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })
  end 
}

}
