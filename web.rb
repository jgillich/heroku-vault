require 'zip'
require 'open-uri'

# download vault
IO.copy_stream(open('https://releases.hashicorp.com/vault/0.3.1/vault_0.3.1_linux_amd64.zip'), '/tmp/vault.zip')
Zip::File.open('/tmp/vault.zip') do |zip_file|
  zip_file.each do |entry|
    puts "Extracting #{entry.name}"
    entry.extract(entry.name)
    system 'chmod +x  #{entry.name}'
  end
end

# rewrite config
config = File.read('config.hcl')
config = config.gsub /address.*$/, "address = \"0.0.0.0:#{ENV['PORT']}\""
File.write('config.hcl', config)

# go
exec 'vault server -config=config.hcl'
