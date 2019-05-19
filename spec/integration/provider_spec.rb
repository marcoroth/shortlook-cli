RSpec.describe '`shortlook provider` command', type: :cli do
  it 'executes `shortlook help provider` command successfully' do
    output = `exe/shortlook help provider`
    expected_output = <<-OUT
Usage:
  shortlook provider NAME

Generate a scaffold ShortLook Provider
    OUT

    expect(output).to eq(expected_output)
  end
end
