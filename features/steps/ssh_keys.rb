require "sshkey"

class Spinach::Features::SshKeys < Spinach::FeatureSteps
  include ApiTasks

  step 'I make request with method create' do
    upload_ssh_key
  end

  step 'I have a key' do
    upload_ssh_key
  end

  def upload_ssh_key
    @key = @response = @instance.create ssh_key: {title: 'test key', key: @ssh_key.ssh_public_key }
    assert_created
  end

  step 'I make request with method get' do
    @response = @instance.get @key.id
  end

  step 'I make request with method edit' do
    @response = @instance.edit @key.id, ssh_key: { title: 'stage server' }
  end

  step 'I make request with method delete' do
    @response = @instance.delete @key.id
  end

  step 'I make request with method list' do
    @response = @instance.list
  end

  step 'I have "Assembla::Client::Users::Keys" instance' do
    @instance = Assembla::Client::Users::Keys.new
  end

  step 'I have a generated ssh key' do
    @ssh_key = SSHKey.generate type: 'dsa'
  end
end
