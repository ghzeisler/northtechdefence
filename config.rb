###
# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes
set :relative_links, true
helpers do
  def nav_active(current_page, page_link , title=nil, visibility = "")
    title ||= page_link
    if /\s/.match(current_page)
      current_page = current_page.split(/\s/)[0]
    end
      if current_page == page_link then css_class = "active" else css_class = "" end
      if page_link == "index"
        page_link = "/"
      else
        page_link = "" + page_link
      end
      content_tag(:li, link_to(title, page_link), :class => "#{css_class} #{visibility}")
  end

  def lightbox(class_name)
    files_lg = Dir.glob("source/products/#{class_name}/*_lg.png")
    files_sm = Dir.glob("source/products/#{class_name}/*_sm.png")
    lightbox_tags = "<script>
     $(document).ready(function() {
        $('.#{class_name}').magnificPopup({type:'image'});
    });
    </script>
    <div class='lightbox_products'>\n"
    files_lg.each_with_index do |file , i|
      file = file.sub("source", "")
      files_sm[i] = files_sm[i].gsub("source", "")
      img = (tag :img, :src => files_sm[i])
      lightbox_tags += link_to(img, file, :class => class_name) + "\n"
    end
    lightbox_tags += "\n</div>"
  end
end
ignore 'javascripts/bootstrap/*'

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'img'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  set :http_path, "/northtechdefence/img/"
end
