module ECourier
	class Email
    attr_reader :to, :from, :sent_at, :subject, :body
		def initialize options = {}
      @to = options[:to]
      @from = options[:from]
      @sent_at = options[:sent_at]
      @subject = options[:subject]
      @body = options[:body]
    end
	end
end
