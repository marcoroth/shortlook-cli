require 'shortlook/commands/provider'

RSpec.describe Shortlook::Commands::Provider do
  it 'executes `provider` command successfully' do
    output = StringIO.new
    name = "Facebook"
    command = Shortlook::Commands::Provider.new(name)

    # TODO: check how to enter input to the interactive prompt
    # command.execute(output: output)
    # expect(output.string).to eq("OK\n")
  end
end
