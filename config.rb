# Per-page layout changes:
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/', layout: 'layout'
page '/learn/*', data: { sidebar: 'learn/sidebar' }
page '/blog/*', data: { sidebar: 'blog/sidebar' }
proxy '/learn/index.html', '/learn/introduction/index.html'

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

  def authors_twitter_url(author)
    config.authors_twitter_urls[author]
  end
end

# General configuration
set :layout, 'content'
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :markdown_engine, :redcarpet
set :markdown, :tables => true, :autolink => true, :gh_blockcode => true,
    :fenced_code_blocks => true
set :authors_twitter_urls, {
  'Don Morrison' => 'https://twitter.com/elskwid',
  'Piotr Solnica' => 'https://twitter.com/_solnic_',
  'Mark Rickerby' => 'https://twitter.com/maetl'
}
set :projects, %w[
  rom
  rom-cassandra
  rom-couchdb
  rom-csv
  rom-dm
  rom-event_store
  rom-git
  rom-http
  rom-influxdb
  rom-json
  rom-kafka
  rom-lotus
  rom-mongo
  rom-neo4j
  rom-rails
  rom-redis
  rom-rethinkdb
  rom-roda
  rom-sql
  rom-yaml
  rom-yesql
]

activate :blog,
  prefix: 'blog',
  layout: 'blog_article',
  permalink: '{title}.html',
  paginate: true,
  tag_template: 'blog/tag.html'
activate :syntax, css_class: 'syntax'
activate :directory_indexes
activate :external_pipeline,
  name: :webpack,
  command: build? ? './node_modules/webpack/bin/webpack.js --bail' : './node_modules/webpack/bin/webpack.js --watch -d',
  source: '.tmp/dist',
  latency: 1

# Development-specific configuration
configure :development do
  activate :livereload
end

# Build-specific configuration
configure :build do
  ignore { |path| path =~ /\.scss$/ }
end
