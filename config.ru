require_relative "./app"
require "rack/static"

app = Rack::Builder.new do
  use Rack::Static,
    root: "public",
    urls: ["/404.html"],
    header_rules: [
      [%[html], {"content-type" => "text/html; charset=utf-8"}],
    ]
    run App.new
end

run app

