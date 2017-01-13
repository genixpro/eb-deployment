# # encoding: utf-8

# Inspec test for recipe electricbrain::node

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe command("node -v") do
  its('stdout') { should eq "v6.3.1\n" }
end


describe command("npm") do
    it { should exist }
end

describe command("bower") do
    it { should exist }
end

describe command("grunt") do
    it { should exist }
end
