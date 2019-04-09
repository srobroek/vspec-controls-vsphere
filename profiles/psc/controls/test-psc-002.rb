# encoding: utf-8
# copyright: 2018, Sjors Robroek
hosts = attribute('hosts')
title 'PSC TESTS PSC-002'

# you add controls here




control 'PSC-002-01' do
  title "Verify the Health Status of the PSC"
  impact 0.5
  tag 'PSC','PSC-002'
  desc '
    Verify the Health Status for the Platform Service Controller. 
  '

  hosts.each do |h|

    url = "https://#{h['name']}:5480/rest/appliance/health/system"
      
    http_body = http(url,
                  method: 'GET',
                  ssl_verify: false,
                  auth: {
                    user: h['auth']['vamiuser'],
                    pass: h['auth']['vamipass']
                  }
                )

    describe "Querying data from #{url}" do
    subject {json({ content: http_body.body})}
      its(['value']) { should cmp "green"}
    end 
  end
end


control 'PSC-002-02' do
  title "Verify the CPU Status of the PSC"
  impact 0.5
  tag 'PSC','PSC-002'
  desc '
    Verify the CPU Status for the Platform Service Controller. 
  '



  hosts.each do |h|
    c ="green"
    path = "/rest/appliance/health/load"
    url = "https://#{h['name']}:#{h['config']['vamiport']}#{path}"
      
    http_body = http(url,
                  method: 'GET',
                  ssl_verify: false,
                  auth: {
                    user: h['auth']['vamiuser'],
                    pass: h['auth']['vamipass']
                  }
                )
    describe "Verifying setting #{path} on #{h['name']}" do
    subject {json({ content: http_body.body})}
      its(['value']) { should cmp c}
    end 
  end
end

control 'PSC-002-03' do
  title "Verify the Memory Status of the PSC"
  impact 0.5
  tag 'PSC','PSC-002'
  desc '
    Verify the Memory Status for the Platform Service Controller. 
  '
 


  hosts.each do |h|
    path = "/rest/appliance/health/mem"
    c ="green"
    url = "https://#{h['name']}:#{h['config']['vamiport']}#{path}"
      
    http_body = http(url,
                  method: 'GET',
                  ssl_verify: false,
                  auth: {
                    user: h['auth']['vamiuser'],
                    pass: h['auth']['vamipass']
                  }
                )
    describe "Verifying setting #{path} on #h['name']}" do
    subject {json({ content: http_body.body})}
      its(['value']) { should cmp c}
    end 
  end
end

control 'PSC-002-04' do
  title "Verify the SSO Domain of the PSC"
  impact 0.5
  tag 'PSC','PSC-002'
  desc '
    Verify the SSO domain configuration for the Platform Service Controller. 
  '



  hosts.each do |h|
    path = "/rest/vcenter/system-config/psc-registration"
    c =h['config']['ssodomain']
    url = "https://#{h['name']}:#{h['config']['vamiport']}#{path}"
      
    http_body = http(url,
                  method: 'GET',
                  ssl_verify: false,
                  auth: {
                    user: h['auth']['vamiuser'],
                    pass: h['auth']['vamipass']
                  }
                )
    describe "Verifying setting #{path} on #{h['name']}" do
    subject {json({ content: http_body.body})}
      its(['sso_domain']) { should cmp c}
    end 
  end
end

control 'PSC-002-05' do
  title "Verify the PSC service Health of the PSC"
  impact 0.5
  tag 'PSC','PSC-002'
  desc '
    Verify the PSC service Health Status for the Platform Service Controller. 
  '




  hosts.each do |h|
    path = "/rest/vcenter/services/pschealth"
    c ="started"
    url = "https://#{h['name']}:#{h['config']['vamiport']}#{path}"
      
    http_body = http(url,
                  method: 'GET',
                  ssl_verify: false,
                  auth: {
                    user: h['auth']['vamiuser'],
                    pass: h['auth']['vamipass']
                  }
                )
    describe "Verifying setting #{path} on #{h['name']}" do
    subject {json({ content: http_body.body})}
      its(['state']) { should cmp c}
    end 
  end
end

control 'PSC-002-06' do
  title "Verify the SSH service Status of the PSC"
  impact 0.5
  tag 'PSC','PSC-002'
  desc '
    Verify the SSH service status for the Platform Service Controller. 
  '



  hosts.each do |h|
    path = "/rest/appliance/access/ssh"
    c =h['access']['ssh']
    url = "https://#{h['name']}:#{h['config']['vamiport']}#{path}"
      
    http_body = http(url,
                  method: 'GET',
                  ssl_verify: false,
                  auth: {
                    user: h['auth']['vamiuser'],
                    pass: h['auth']['vamipass']
                  }
                )
    describe "Verifying setting #{path} on #{h['name']}" do
    subject {json({ content: http_body.body})}
      its(['value']) { should cmp c}
    end 
  end
end



control 'PSC-002-07' do
  title "Verify the DCUI service Status of the PSC"
  impact 0.5
  tag 'PSC','PSC-002'
  desc '
    Verify the DCUI service status for the Platform Service Controller. 
  '




  hosts.each do |h|
    path = "/rest/appliance/access/dcui"
    c =h['access']['dcui']
    url = "https://#{h['name']}:#{h['config']['vamiport']}#{path}"
      
    http_body = http(url,
                  method: 'GET',
                  ssl_verify: false,
                  auth: {
                    user: h['auth']['vamiuser'],
                    pass: h['auth']['vamipass']
                  }
                )
    describe "Verifying setting #{path} on #{h['name']}" do
    subject {json({ content: http_body.body})}
      its(['value']) { should cmp c}
    end 
  end
end


control 'PSC-002-08' do
  title "Verify the Console CLI service Status of the PSC"
  impact 0.5
  tag 'PSC','PSC-002'
  desc '
    Verify the Console CLI service status for the Platform Service Controller. 
  '



  hosts.each do |h|
    path = "/rest/appliance/access/consolecli"
    c =h['access']['consolecli']
    url = "https://#{h['name']}:#{h['config']['vamiport']}#{path}"
      
    http_body = http(url,
                  method: 'GET',
                  ssl_verify: false,
                  auth: {
                    user: h['auth']['vamiuser'],
                    pass: h['auth']['vamipass']
                  }
                )
    describe "Verifying setting #{path} on #{h['name']}" do
    subject {json({ content: http_body.body})}
      its(['value']) { should cmp c}
    end 
  end
end

control 'PSC-002-09' do
  title "Verify the Bash Shell service Status of the PSC"
  impact 0.5
  tag 'PSC','PSC-002'
  desc '
    Verify the Bash Shell service status for the Platform Service Controller. 
  '



  hosts.each do |h|
    path = "/rest/appliance/access/shell"
    c =h['access']['shell']
    url = "https://#{h['name']}:#{h['config']['vamiport']}#{path}"
      
    http_body = http(url,
                  method: 'GET',
                  ssl_verify: false,
                  auth: {
                    user: h['auth']['vamiuser'],
                    pass: h['auth']['vamipass']
                  }
                )
    describe "Verifying setting #{path} on #{h['name']}" do
    subject {json({ content: http_body.body})}
      its(['enabled']) { should cmp c}
    end 
  end
end
