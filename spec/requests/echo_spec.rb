# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SignUp Patient Flows', type: :request do
  describe 'POST /echo' do
    describe 'validations' do
      describe 'if matrix not square' do
        let(:fake_matrix) do
          path = Rails.root.join('spec', 'fixtures', 'fake_matrix.csv')
          fixture_file_upload(path, 'text/csv')
        end
        before do
          post '/echo', params: { file: fake_matrix }
        end
        it 'receive an error' do
          expect(response.status).equal?(500)
        end
        it 'have a message error' do
          res = JSON.parse(response.body)
          expect(res['body'][0]).equal?('Matrix doesn\' have same number of cols and rows.')
        end
      end
      describe 'if params file is empty' do
        let(:empty_file) do
          path = Rails.root.join('spec', 'fixtures', 'empty_file.csv')
          fixture_file_upload(path, 'text/csv')
        end
        before do
          post '/echo', params: { file: empty_file }
        end
        it 'receive an error' do
          expect(response.status).equal?(500)
        end
        it 'have a message error' do
          res = JSON.parse(response.body)
          expect(res['body'][0]).equal?('Matrix doesn\' have same number of cols and rows.')
        end
      end
    end
    describe 'should get response' do
      let(:csv_file) do
        path = Rails.root.join('spec', 'fixtures', 'test_matrix.csv')
        fixture_file_upload(path, 'text/csv')
      end
      before(:each) do
        post '/echo', params: { file: csv_file }
        @res = JSON.parse(response.body)
      end
      it 'be a successful' do
        expect(response).to be_successful
      end
      describe 'should get matrix in ' do
        it 'Formated in rows and cols.' do
          @res[:matrix_format].equal?("1,2,3\n4,5,6\n7,8,9")
        end
        it 'Invert.' do
          @res[:invert].equal?('[[1,4,7],[2,5,8],[3,6,9]]')
        end
        it 'Flatten.' do
          @res[:flatten].equal?('1,2,3,4,5,6,7,8,9')
        end
        it 'Sum of all items.' do
          @res[:sum].equal?(45)
        end
        it 'Multiply of all items.' do
          @res[:multiply].equal?(362_880)
        end
      end
    end
  end
end
