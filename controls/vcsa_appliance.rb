# encoding: utf-8
# copyright: 2019, Sjors

title 'VCSA appliance checks'

# you can also use plain tests


# you add controls here
control 'VCSA-001-01' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Check VCSA services'             # A human-readable title
  desc 'Check for the service status on the vcsa appliance'
  describe "Service status of" do
    subject {vcsa()}
    its('ssh') { should cmp false }
    its('consolecli') { should cmp true}
    its('dcui') { should cmp true}
    its('shell') {should cmp false}
  end
end

control 'VCSA-001-02' do                        # A unique ID for this control
  impact 0.5                                # The criticality, if this control fails.
  title 'Check VCSA Health status'             # A human-readable title
  desc 'Check for the health on the vcsa appliance'
  describe "Health status of" do
    subject {vcsa()}
    its('system') { should cmp 'green'}
    its('software') { should_not cmp 'red'}
    its('load') { should cmp 'green'}
    its('memory') { should cmp 'green'}   
    its('service') {should cmp 'green'}
    its('database') {should cmp 'green'}
    its('storage') { should cmp 'green'}
    its('swap') { should cmp 'green' }

  end
end

control 'VCSA-001-03' do                        # A unique ID for this control
  impact 0.5                                # The criticality, if this control fails.
  title 'Check VCSA Update settings'             # A human-readable title
  desc 'Check for the update settings on the vcsa appliance'
  describe "Update setting" do
    subject {vcsa()}
    its('auto_update') { should cmp false}
  end
end

control 'VCSA-001-05' do                        # A unique ID for this control
  impact 0.5                                # The criticality, if this control fails.
  title 'Check VCSA Versions'             # A human-readable title
  desc 'Check for the update settings on the vcsa appliance'
  describe "Software property" do
    subject {vcsa()}
    its('version') { should cmp '6.7.0.21000'}
    its('build') { should cmp '11726888'}
  end
end
