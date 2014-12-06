#!/usr/bin/env ruby
require 'rubydns'

INTERFACES = [
  [:udp, '0.0.0.0', 5300],
  [:tcp, '0.0.0.0', 5300]
]

RESOLVERS = [
  [:udp, '8.8.8.8', 53],
  [:tcp, '8.8.8.8', 53]
]

PROXY_SERVER_IP = ARGV[0]

Name = Resolv::DNS::Name
IN = Resolv::DNS::Resource::IN

RubyDNS.run_server(listen: INTERFACES) do
  # Use a Celluloid supervisor so the system recovers if the actor dies
  fallback_resolver_supervisor =
    RubyDNS::Resolver.supervise(RESOLVERS)

  # Fail the resolution of certain domains ;)
  match(/netflix.com/) do |transaction, match_data|
    logger.info 'Redirecting to proxy...'
    transaction.respond!(PROXY_SERVER_IP)
  end

  # Default DNS handler
  otherwise do |transaction|
    logger.info 'Passing DNS request upstream...'
    transaction.passthrough!(fallback_resolver_supervisor.actors.first)
  end
end
