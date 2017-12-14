# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions
activate :livereload
activate :sprockets
activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end


import_path File.expand_path('bower_components', app.root)

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# github project pages deploy
activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.build_before = true # default: false
end


configure :build do
	set :relative_links, true
	activate :minify_css
	activate :minify_javascript
	activate :asset_hash
	# Relative assets needed to deploy to Github Pages
	activate :relative_assets
	# Name of the project where you working on
	set :site_url, "/shop_store"
end

# environment variable with Snipcart API Key
ENV["snipcart-api-key"] = "NWIxYmI4Y2QtMGRhOC00ZTdjLWI1YTctZmQ0NTI0MzJkM2NmNjM2Mjc0NTUxNDQwNTExMTM0"

# environment variable to keep the base site URL
ENV["base-url"] = "http://kikluz.com/shop_store/"
 # creating a template helper to generate a Snipcart button.
helpers do
  def snipcart_button (p, text)
    args = {
      :"class" => "snipcart-add-item button is-primary is-medium",
      :"data-item-id" => p.id,
      :"data-item-price" => p.price,
      :"data-item-name" => p.name,
      :"data-item-max-quantity" => p.max_quantity,
      :"data-item-url" => ENV["base-url"] + p.path,
      :"data-item-image" => p.image
    }

    content_tag :button, args do
      text
    end
  end
end


