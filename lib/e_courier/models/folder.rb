module ECourier
  class Folder
    attr_reader :name

    def initialize name
      @name = name
    end

    def emails
      @emails ||= []
    end

    def add_emails email_list
      @emails = emails.push(email_list).flatten
    end
  end
end
