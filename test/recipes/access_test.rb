# # encoding: utf-8

# Inspec test for recipe electricbrain::access

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe user('root') do
    it { should exist }
end

describe user('bradley') do
    it { should exist }
end

describe user('ubuntu') do
    it { should_not exist }
end
