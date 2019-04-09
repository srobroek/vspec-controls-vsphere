# encoding: utf-8
# copyright: 2018, Sjors Robroek
hosts = attribute('hosts')
title 'PSC TESTS PSC-010'

# you add controls here


control 'PSC-010-01' do
  title "Verify the Deployment type of the PSC appliance"
  impact 0.5
  desc '
    Verify the deployment type of the Platform Service Controller appliance.
  '



  hosts.each do |h|
    path = "/rest/vcenter/system-config/deployment-type"
    c = h['config']['deploymenttype']
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
      its(['type']) { should cmp c}
    end 
  end
end

control 'PSC-010-02' do
  title "Verify the Time synchronisation method of the PSC appliance"
  impact 0.5
  desc '
    Verify the time synchronisation method of the Platform Service Controller appliance.
  '



  hosts.each do |h|
    path = "/rest/appliance/timesync"
    c = h['config']['timesync']
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
      its(['value']) { should cmp c }
    end 
  end 
end 

control 'PSC-010-03' do
  title "Verify the Timezone configuration of the PSC appliance"
  impact 0.5
  desc '
    Verify the timezone configuration of the Platform Service Controller appliance.
  '



  hosts.each do |h|

    path = "/rest/appliance/system/time/timezone"
    c = h['config']['timezone']
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

control 'PSC-010-04' do
  title "Verify the NTP servers of the PSC appliance"
  impact 0.5
  desc '
    Verify the NTP servers of the Platform Service Controller appliance.
  '



  hosts.each do |h|

    path = "/rest/appliance/ntp"
    arr = h['config']['ntpservers']
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
        its(['value']) { should cmp arr}
 #         expect(subject['value']).to match_array(arr)
    #end
      #Ruby is absolutely stupid when comparing arrays
      #its((['value']).to_s) { should cmp "#{compare}"}
    end
  end 
end 




# control 'PSC-010-03' do
#   title "Verify deployment type of the PSC appliance"
#   impact 0.5
#   desc '
#     Verify the network settings on the Platform Service Controller appliance.
#   '
#   path = "/rest/appliance/networking"


#   hosts.each do |h|

#     url = "https://#{h['name']}:#{h['config']['vamiport']}#{path}"
      
#     http_body = http(url,
#                   method: 'GET',
#                   ssl_verify: false,
#                   auth: {
#                     user: "#{h['auth']['vamiuser']}",
#                     pass: "#{h['auth']['vamipass']}"
#                   }
#                 )
#     describe "Verifying setting #{path} on #{h['name']}" do
#     subject {json({ content: http_body.body})}
#       compare = "#{h['dns']['mode']}"
#       its(['dns']['mode']) { should be "STATIC"}
#       compare = "#{h['dns']['servers']}"
#       its(['dns']['servers']) { should cmp "#{compare}"}
#     end 
#   end
# end
