require 'spec_helper'

describe PsPabxListener::Listener do

  before(:all) do
    @telnet = double("telnet")
  end

  it 'requires a host' do
    expect {PsPabxListener::Listener.new(nil,'john','foo')}.to raise_error("Invalid host")
  end

  it 'requires an user' do
    expect {PsPabxListener::Listener.new('localhost',nil,'foo')}.to raise_error("Invalid user")
  end

  it 'requires a password' do
    expect {PsPabxListener::Listener.new('localhost','john',nil)}.to raise_error("Invalid password")
  end

  it 'accepts a valid timeout value' do
    expect(PsPabxListener::Listener.new('localhost','john','foo',10)).to be_an_instance_of(PsPabxListener::Listener)
  end

  it 'connects to a PABX' do
    prepare_telnet
    listener = PsPabxListener::Listener.new('localhost','john','foo')
    listener.start
    expect(listener.started).to be true
  end

  it 'disconnects from a PABX' do
    prepare_telnet
    listener = PsPabxListener::Listener.new('localhost','john','foo')
    listener.start
    listener.stop
    expect(listener.started).to be false
  end

  it 'discards irrelevant information' do
    prepare_telnet
    listener = PsPabxListener::Listener.new('localhost','john','foo')
    listener.start
    expect(listener.get).to eq ["10/10/10 not trash"]
  end

end

def prepare_telnet timeout=false
  telnet = double('telnet', null_object: true)
  allow(telnet).to receive(:close).and_return(:true)
  allow(telnet).to receive(:waitfor).
    with(/(-|Rejected)/).
    and_return('-')
  allow(telnet).to receive(:cmd).
    with({"String" => "john", "Match" => /[Pp]ass(?:word|phrase)[:]*\z/n}).
    and_return("Trash\n")
  allow(telnet).to receive(:cmd).
    with('foo').and_return("10/10/10 not trash\n")
  allow(Net::Telnet).to receive(:new).with(
    'Host' => 'localhost',
    'Port' => 2300,
    'Prompt' => /(\n|\r)/,
    'Timeout' => timeout,
    'Waittime' => timeout).and_return(telnet)
end
