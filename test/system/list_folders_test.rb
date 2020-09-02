require 'test_helper'
require 'e_courier/services/fetch_emails'
require 'e_courier/services/list_folders'
require 'e_courier/models/email'
require 'e_courier/models/folder'
require 'net/imap'
require 'time'


module ECourier
  class ListFoldersTest < MiniTest::Test
    @@service = ListFolders.new
    @@service.execute

    def test_list_folders
      assert_kind_of Folder, @@service.folders.first
    end

    def test_folder_has_emails
      inbox = @@service.folders.select {|f| f.name == 'INBOX'}
      # binding.pry
      assert_kind_of Email, inbox.first.emails.first
    end
  end
end
