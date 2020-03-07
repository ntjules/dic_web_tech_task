require "webrick"

module WEBrick
  module HTTPServlet
    FileHandler.add_handler("rb", CGIHandler)
  end
end

server = WEBrick::HTTPServer.new({
  :DocumentRoot => ".",
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => "3000",
})
["INT", "TERM"].each { |signal|
  Signal.trap(signal) { server.shutdown }
}
server.mount("/test", WEBrick::HTTPServlet::ERBHandler, "test.html.erb")
server.mount("/", WEBrick::HTTPServlet::ERBHandler, "Landingpage.html.erb")
server.mount("/goya.cgi", WEBrick::HTTPServlet::CGIHandler, "goya.rb")
server.mount("/indicate.cgi", WEBrick::HTTPServlet::CGIHandler, "indicate.rb")
server.start
