return {
	init_options = {},
	before_init = function(_, config)
		local project_root = vim.fs.normalize(config.root_dir)
		local app_root = vim.fs.dirname(project_root)
		local stub_paths = {}

		for name, kind in vim.fs.dir(app_root) do
			if kind == 'directory' then
				local module_root = vim.fs.joinpath(app_root, name)
				local include_path = vim.fs.joinpath(module_root, 'include')

				if vim.fs.normalize(module_root) ~= project_root
					and vim.uv.fs_stat(include_path)
				then
					table.insert(stub_paths, include_path)
				end
			end
		end

		config.init_options = config.init_options or {}
		config.init_options['indexer.stub_paths'] = stub_paths
	end,
}
