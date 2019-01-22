require_relative '../models/entry'

 RSpec.describe Entry do
   #Specs to test the Entry attributes
   describe 'attributes' do
     #Define an instance of the Entry class for testing
     let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }

     #Each 'it' represents a unique test
     #NAME TESTS
     it 'responds to name' do
       #Each test ends with 'expect()' method
       #Will check if 'entry.name' is valid code
       expect(entry).to respond_to(:name)
     end

     it 'reports its name' do
       expect(entry.name).to eq('Ada Lovelace')
     end

     #PHONE NUMBER TESTS
     it 'responds to phone number' do
       expect(entry).to respond_to(:phone_number)
     end

     it 'reports its phone number' do
       expect(entry.phone_number).to eq('010.012.1815')
     end

     #EMAIL TESTS
     it 'responds to email' do
       expect(entry).to respond_to(:email)
     end

     it 'reports its email' do
      expect(entry.email).to eq('augusta.king@lovelace.com')
     end
   end

   #Specs to test #to_s method
   describe '#to_s' do
     it 'prints an entry as a string' do
       entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
       expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
       expect(entry.to_s).to eq(expected_string)
     end
   end
 end
