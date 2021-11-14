# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MatrixHandler, type: :model do
  describe 'validations' do
    describe 'should throw excpection' do
      let(:fake_matrix) do
        path = Rails.root.join('spec', 'fixtures', 'fake_matrix.csv')
        fixture_file_upload(path, 'text/csv')
      end

      let(:csv_file) do
        path = Rails.root.join('spec', 'fixtures', 'test_matrix.csv')
        fixture_file_upload(path, 'text/csv')
      end

      it 'params don\'t include a uploaded file.' do
        @params = ActionController::Parameters.new
        @matrix_handler = MatrixHandler.new(nil)
        expect(@matrix_handler).not_to be_valid
      end

      it 'if uploaded file content doesn\'t be square matrix' do
        params = ActionController::Parameters.new(file: fake_matrix)
        @matrix_handler = MatrixHandler.new(params)
        expect(@matrix_handler.readble?).to be(false)
      end
    end
  end
  describe 'Create' do
    before do
      let(:csv_file) do
        path = Rails.root.join('spec', 'fixtures', 'test_matrix.csv')
        fixture_file_upload(path, 'text/csv')
      end

      before(:each) do
        allow(ActionDispatch::Http::UploadedFile).to receive(:new).and_return(csv_file)
        @matrix_handler = MatrixHandler.new(csv_file)
      end
    end
    it 'if uploaded file content doesn\'t be square matrix' do
      expect(@matrix_handler).to_not be_valid
    end
  end
end
