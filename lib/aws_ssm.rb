# frozen_string_literal: true

####
#
# Credentials not explizitly configured:
# From an instance profile when running on EC2 or from the ECS credential provider when running in
# an ECS container with that feature enabled.
#
#####

class AwsSsm
  def self.client
    @client ||= Aws::SSM::Client.new(region: "eu-central-1")
  end

  def self.get_parameter(key)
    prefix = "/app/"
    @params ||= get_parameters(prefix)
    @params.fetch("#{prefix}#{key}")
  end

  def self.get_parameters(prefix, next_token: nil)
    response = client.get_parameters_by_path(
      path: prefix, recursive: true, with_decryption: true, next_token:
    )

    params = response.parameters.each_with_object({}) do |param, hash|
      hash[param.name] = param.value
    end

    params.tap do |p|
      p.merge!(get_parameters(prefix, next_token: response.next_token)) if response.next_token
    end
  end
end
