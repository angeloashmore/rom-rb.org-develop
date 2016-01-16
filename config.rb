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

  def copyright
    "&copy; 2014-#{Time.now.year} Ruby Object Mapper"
  end
end

# General configuration
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :markdown_engine, :redcarpet
set :markdown, :tables => true, :autolink => true, :gh_blockcode => true,
    :fenced_code_blocks => true

activate :syntax, css_class: 'syntax'
activate :external_pipeline,
  name: :webpack,
  command: build? ? './node_modules/webpack/bin/webpack.js --bail' : './node_modules/webpack/bin/webpack.js --watch -d',
  source: '.tmp/dist',
  latency: 1
activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.build_before = true
end

# Development-specific configuration
configure :development do
  activate :livereload
end

# Build-specific configuration
configure :build do
  ignore { |path| path =~ /\.scss$/ }
end
