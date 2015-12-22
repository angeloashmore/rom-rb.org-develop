# Per-page layout changes:
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Helpers
helpers do
  def nav_link_to(link_text, url, options = {})
    root = options.delete(:root)
    is_active = (!root && current_page.url.start_with?(url)) ||
                current_page.url == url
    options[:class] ||= ''
    options[:class] << '--is-active' if is_active
    link_to(link_text, url, options)
  end
end

# General configuration
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'

activate :directory_indexes

# Development-specific configuration
configure :development do
  activate :livereload
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
end
