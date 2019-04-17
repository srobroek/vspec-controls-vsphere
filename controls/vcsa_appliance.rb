# encoding: utf-8
# copyright: 2019, Sjors

title 'VCSA appliance checks'

# you can also use plain tests


# you add controls here
control 'VCSA-001-01' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Check VCSA authentication'             # A human-readable title
  desc 'Check for authentication against the VCSA appliance'
  
  describe vcsa do
    its('api_authentication') { should eq true }
  end
end

control 'VCSA-002-01' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Check VCSA service status'             # A human-readable title
  desc 'Check for the service status on the vcsa appliance'

  only_if('vcsa did not authenticate succesfully') do
    vcsa.api_authentication
  end

  describe "Service status of" do
    subject {vcsa}
    its('ssh') { should eq false }
    its('consolecli') { should eq true}
    its('dcui') { should eq true}
    its('shell') {should eq false}
  end
end


control 'VCSA-002-02' do                        # A unique ID for this control
  impact 0.5                                # The criticality, if this control fails.
  title 'Check VCSA Health status'             # A human-readable title
  desc 'Check for the health on the vcsa appliance'

    only_if('vcsa did not authenticate succesfully') do
    vcsa.api_authentication
  end

  describe "Health status of" do
    subject {vcsa}

    its('system') { should eq 'green'}
    its('software') { should_not eq 'red'}
    its('load') { should eq 'green'}
    its('memory') { should eq 'green'}   
    its('service') {should eq 'green'}
    its('database') {should eq 'green'}
    its('storage') { should eq 'green'}
    its('swap') { should eq 'green' }

  end
end

control 'VCSA-002-03' do                        # A unique ID for this control
  impact 0.5                                # The criticality, if this control fails.
  title 'Check SSO settings'             # A human-readable title
  desc 'Check for the SSO settings on the vcsa appliance'

    only_if('vcsa did not authenticate succesfully') do
    vcsa.api_authentication
  end


  describe vcsa do
    its('psc_address') { should eq 'vcsa-01.lab.vxsan.com'}
    its('sso_domain') { should eq 'LAB.VXSAN.COM'}
  end
end


control 'VCSA-003-01' do                        # A unique ID for this control
  impact 0.5                                # The criticality, if this control fails.
  title 'Check VCSA Versions'             # A human-readable title
  desc 'Check for the update settings on the vcsa appliance'

    only_if('vcsa did not authenticate succesfully') do
    vcsa.api_authentication
  end


  describe vcsa do
    its('version') { should eq '6.7.0.21000'}
    its('build') { should eq '11726888'}
    its('auto_update') { should eq false}
  end
end


control 'VCSA-004-01' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Check web authentication'             # A human-readable title
  desc 'Check for authentication against the vsphere web API'
  
  describe vcsa do
    its('web_authentication') { should eq true }
  end
end

control 'VCSA-006-01' do                        # A unique ID for this control
  impact 0.5                                # The criticality, if this control fails.
  title 'Check vsphere identity sources'             # A human-readable title
  desc 'Check the identity sources of the vSphere domain'

    only_if('vsphere did not authenticate succesfully') do
    vcsa.web_authentication
  end


  describe vcsa do
    its('identity_sources') { should include 'VXSAN'}
    its('identity_sources') { should_not include 'LAB.VXSAN.COM'}
    its('identity_sources') { should eq ["LAB.VXSAN.COM", "VXSAN"] }
  end
end

control 'VCSA-007-01' do                        # A unique ID for this control
  impact 0.5                                # The criticality, if this control fails.
  title 'Check the VCSA certificate configuration'             # A human-readable title
  desc 'Check the VCSA certificate configuration'


  describe sslcertificate do
    it { should exist}
    it { should be_trusted }
    its('issuer') { should eq "/CN=CA/DC=LAB/DC=VXSAN.COM/C=US/ST=California/O=vcsa-01.lab.vxsan.com/OU=VMware Engineering"}
    its('subject') { should eq "/CN=vcsa-01.lab.vxsan.com/C=US"}
    its('expiration_days') { should be > 365 }
    its('key_size') { should eq 2048}
    its('hash_algorithm') { should eq "SHA256"}
    its('key_algorithm') { should eq "RSA"}
  end
end








