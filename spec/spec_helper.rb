$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ps_pabx_listener'

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
