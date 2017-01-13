# # encoding: utf-8

# Inspec test for recipe electricbrain::api_test

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html


describe user('electricbrain') do
    it { should exist }
end


describe file("/opt/electric-brain") do
    it { should exist }
end

describe file("/opt/electric-brain/server/index.js") do
    it { should exist }
end
