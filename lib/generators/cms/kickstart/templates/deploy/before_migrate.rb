public_path = "#{release_path}/public"
asset_path = "#{public_path}/assets"
shared_asset_path = "#{new_resource.shared_path}/assets"

run("mkdir -p #{shared_asset_path} && rm -rf #{asset_path} && cd #{public_path} && ln -s #{shared_asset_path}")

