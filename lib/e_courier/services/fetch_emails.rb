require 'net/imap'
require 'time'
require 'e_courier/helpers/imap_utils'

module ECourier
  class FetchEmails
    include IMAPUtils
    attr_reader :folder

    def initialize options = {}
      @folder = options[:folder] || 'INBOX'
      @imap = options[:imap]
      @keep_alive = options[:keep_alive] || false
    end

    def execute
      connect
      fetch_emails
      transfrom
    ensure
      @imap.disconnect unless @keep_alive
    end

    def emails
      @emails ||= []
    end

    private

    def connect
      unless @imap
        @imap = Net::IMAP.new(ENV['IMAP_HOST'], ENV['IMAP_PORT'], true)
        @imap.login(ENV['IMAP_USERNAME'], ENV['IMAP_PASSWORD'])
      end
    end

    def fetch_emails
      @email_data = []
      @imap.examine(@folder)
      puts "Fetching data from: #{@folder}"
      # @imap.search(["UID", "645"]).each do |id|
      @imap.search(["ALL"]).each do |id|
        print '.'
        envelope = @imap.fetch(id, "ENVELOPE")[0].attr["ENVELOPE"]
        uid = @imap.fetch(id, "UID")[0].attr["ENVELOPE"]
        flags = @imap.fetch(id, "FLAGS")[0].attr["ENVELOPE"]
        body = @imap.fetch(id, "BODY[TEXT]")[0].attr["BODY[TEXT]"]

        @email_data << {envelope: envelope,
                        uid: uid,
                        flags: flags,
                        body: body}
      end
    end

    def transfrom
      @email_data.each do |item|
        emails << Email.new({
          from: address(item[:envelope].from),
          to: address(item[:envelope].to),
          subject: item[:envelope].subject,
          sent_at: Time.parse(item[:envelope].date),
          body: item[:body].force_encoding('utf-8')
        })
      end
    end
  end
end
