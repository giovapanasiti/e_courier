require 'net/imap'
require 'time'
require 'e_courier/helpers/imap_utils'
require 'e_courier/services/fetch_emails'

module ECourier
  class ListFolders
    include IMAPUtils

    def execute
      connect
      list_folders do |folder|
        fetch_emails folder
      end
    end

    def folders
      @folders ||= []
    end

    private

    def connect
      @imap = Net::IMAP.new(ENV['IMAP_HOST'], ENV['IMAP_PORT'], true)
      @imap.login(ENV['IMAP_USERNAME'], ENV['IMAP_PASSWORD'])
      # TODO: Throw and error message in case the env hasn't all the info to connect to the imap
    end

    def list_folders &block
      list = @imap.list "*", "*" # fetch ALL the folders
      # @imap.list "", "INBOX" <- fetch all the folders in inbox
      list.each do |folder_data|
        folder = Folder.new(folder_data.name)
        folders << folder
        yield folder
      end
    end

    def fetch_emails folder
      service = FetchEmails.new folder: folder.name, keep_alive: true
      service.execute

      folder.add_emails service.emails
    end

  end
end
