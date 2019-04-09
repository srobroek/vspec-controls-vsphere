# encoding: utf-8
# copyright: 2018, Sjors Robroek
hosts = attribute('hosts')
title 'PSC TESTS PSC-004'

# you add controls here


control 'PSC-004-01' do
  title "Verify connection to the PSC administration interface"
  impact 0.5
  desc '
    Connect to the Platform Services Controller administration interface.
  '
  path = "/rest/appliance/update"


  hosts.each do |h|
    compare = "#{h['config']['version']}"
    url = "https://#{h['name']}:#{h['config']['vamiport']}#{path}"
      
    http_body = http(url,
                  method: 'GET',
                  ssl_verify: false,
                  auth: {
                    user: "#{h['auth']['vamiuser']}",
                    pass: "#{h['auth']['vamipass']}"
                  }
                )
    describe "Verifying setting #{path} on #{h['name']}" do
    subject {json({ content: http_body.body})}
      its(['version']) { should cmp "#{compare}"}
    end 
  end
end
