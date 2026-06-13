require "resolv"
require "ostruct"

class App
  def call(env)
    req = Rack::Request.new(env) #grab a request to enable inspection
    path = req.path_info

    case path
    when "/"
      url = req.params["url"]
      if url
        result = name_servers_for(url)
        if result.success  
          render("Home", url:, name_servers: result.payload)
        else
          render("Home", url:, announcement: result.error, status_code: 422)
        end
      else
        render("Home")
      end
    else
      handle_missing_path
    end
  end

  private

  def render(template, status_code:200,announcement: nil, **locals)
    @locals = locals
    @announcement = announcement
    @content = render_template(template)
    body = render_template("layout")
    headers = {"content-type" => "text/html; charset=utf-8"}

    [status_code, headers, [body]]
  end

  def render_template(template)
    template = File.read("./views/#{template}.html.erb")
    erb = ERB.new(template)
    erb.result(binding)
  end

  def handle_missing_path
    body = File.read("./public/404.html")
    headers = {"content-type" => "text/html; charset=utf-8"}
    [404, headers, [body]]
  end

  def name_servers_for(url)
    result = Struct.new(:success, :payload, :error, keyword_init: true)

    begin
      host = URI(url).host
      res = Resolv::DNS.new  
      payload = res.getresources(host, Resolv::DNS::Resource::IN::NS)
      raise Resolv::ResolvError, "Could not resolve DNS records for #{host}" if payload.empty?
      result.new(success: true, payload: payload)
    rescue Resolv::ResolvError, URI::InvalidURIError => error
      result.new(success: false, error: error.message)
    end
  end
end
