require './battle_app'

=begin
if ENV['SESSION_SECRET'] = nil
  ENV['SESSION_SECRET'] = SecureRandom.hex(64)
  echo "export SESSION_SECRET=#{ ENV['SESSION_SECRET'] }"  >> ~/.bashrc
end
=end
# Yet to work out how to implement this properly
# http://sinatrarb.com/intro.html#Using%20Sessions

run Battle
