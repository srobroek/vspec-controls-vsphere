# encoding: utf-8
# copyright: 2018, Sjors Robroek
hosts = attribute('hosts')
title 'PSC TESTS PSC-003'

# you add controls here


control 'PSC-003-01' do
  title "Verify the version of the PSC"
  impact 0.5
  tag 'PSC','PSC-003'
  desc '
   Verify the version of the Platform Service Controller. 
  '



  hosts.each do |h|
    path = "/rest/appliance/update"
    c = h['config']['version']
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
      its(['version']) { should cmp c}
    end 
  end
end
