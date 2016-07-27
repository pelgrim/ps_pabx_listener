require 'spec_helper'

describe PsPabxListener::Main do

  it 'creates a valid instance' do
    expect(PsPabxListener::Main.new(main_parameters)).to be_an_instance_of PsPabxListener::Main
  end

  it 'gets data until a given timeout is reached' do
    prepare_telnet
    main = PsPabxListener::Main.new(main_parameters)
    response = []
    main.get_data(1) { |data| response << data }
    expect(response.uniq).to eq ["10/10/10 not trash", "11/11/11 not trash"]
  end

  it 'continuously gets data until its required to stop' do
    prepare_telnet
    main = PsPabxListener::Main.new(main_parameters)
    response = []
    runner = Thread.new do
      main.each_data { |data| response << data }
    end
    sleep 1
    runner.exit
    expect(response.uniq).to eq ["10/10/10 not trash", "11/11/11 not trash"]
  end
end

def main_parameters *custom_params
  if custom_params[0].nil?
    params = {}
  else
    params = custom_params[0]
  end
  params[:host] ||= 'localhost'
  params[:user] ||= 'john'
  params[:password] ||= 'foo'
  params[:timeout] ||= false
  params
end
