class LinkedInApi
    def initialize(user)
      @user = user
      @access_token = user.linkedin_token # Store token from OAuth callback
    end
  
    def publish(content)
      response = Faraday.post(
        'https://api.linkedin.com/v2/shares',
        {
          owner: "urn:li:person:#{@user.linkedin_uid}",
          text: { text: content }
        }.to_json,
        {
          'Authorization' => "Bearer #{@access_token}",
          'Content-Type' => 'application/json'
        }
      )
  
      OpenStruct.new(success?: response.success?, error: response.body)
    end
  end
  