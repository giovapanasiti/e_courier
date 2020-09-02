require 'test_helper'
require 'e_courier/services/fetch_emails'
require 'e_courier/models/email'
require 'net/imap'
require 'time'

module ECourier
	class FetchEmailsTest < MiniTest::Test
    @@service = FetchEmails.new
    @@service.execute

		def test_fetches_emails
			assert_kind_of Email, @@service.emails.first
		end

    def test_email_has_proper_data
      assert_kind_of Time, @@service.emails.first.sent_at
    end
	end
end
