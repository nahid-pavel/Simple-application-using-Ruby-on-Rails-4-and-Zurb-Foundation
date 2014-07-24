class Contact < ActiveRecord::Base
has_no_table

column :name, :string
column :email, :string
column :content, :string

validates :name, presence: true

validates :content, presence: true, :length => {maximum:500}

validates :email,presence:true,  format: {:with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i}

def update_spreadsheet
	connection = GoogleDrive.login(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"])
	ss = connection.spreadsheet_by_title('Learn-Rails-Example')
	if ss.nil?
	ss = connection.create_spreadsheet('Learn-Rails-Example')
	end
	ws = ss.worksheets[0]
	last_row = 1 + ws.num_rows
	ws[last_row, 1] = Time.new
	ws[last_row, 2] = self.name
	ws[last_row, 3] = self.email
	ws[last_row, 4] = self.content
	ws.save
   end
end




