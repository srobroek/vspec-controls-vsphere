# encoding: utf-8
# copyright: 2018, Sjors Robroek
hosts = attribute('hosts')
title 'PSC TESTS PSC-001'

# you add controls here




control 'PSC-001-01' do
  title 'Verify connection to the PSC VAMI'
  impact 0.5
  tag 'PSC','PSC-001'
  desc '
    Verify connection to the management interface of the Platform Services Controller Appliance.
  '
  

  
  hosts.each do |h|

    url = "https://#{h['name']}:5480/rest/appliance/health/system"
      
    describe "Performing a HTTP GET to #{url}" do
      subject { http(url,
                  method: 'GET',
                  ssl_verify: false
                  ) } 
      its('status') { should cmp 403 }
      its('headers.content-Type') { should cmp 'application/json' }
    end 
  end
end

# you add controls here

control 'PSC-001-02' do
  title 'Verify authentication to the PSC VAMI'
  impact 0.5
  tag 'PSC','PSC-001'
  desc '
    Verify connection to the management interface of the Platform Services Controller Appliance. 
  '

  hosts.each do |h|

    url = "https://#{h['name']}:5480/rest/appliance/health/system"
      
    describe "Performing a HTTP GET to #{url}" do
    subject {http(url,
                  method: 'GET',
                  ssl_verify: false,
                  auth: {
                    user: "#{h['auth']['vamiuser']}",
                    pass: "#{h['auth']['vamipass']}"
                  }
                ) } 
      its('status') { should cmp 200 }
      its('headers.content-Type') { should cmp 'application/json' }
    end 
  end
end

