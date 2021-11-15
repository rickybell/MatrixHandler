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

      let(:empty_file) do
        path = Rails.root.join('spec', 'fixtures', 'empty_file.csv')
        fixture_file_upload(path,'text/csv')
      end

      it 'params don\'t include a uploaded file.' do
        @params = ActionController::Parameters.new
        @matrix_handler = MatrixHandler.new(nil)
        expect(@matrix_handler).not_to be_valid
      end

      it 'if uploaded file content doesn\'t be square matrix' do
        params = ActionController::Parameters.new(file: fake_matrix)
        @matrix_handler = MatrixHandler.new(params)
        expect(@matrix_handler.handlable?).to be(false)
      end
      it 'if uploaded file is empty' do
        params = ActionController::Parameters.new(file: empty_file)
        @matrix_handler = MatrixHandler.new(params)
        expect(@matrix_handler.handlable?).to be(false)
      end
    end
  end
  describe 'Format Methods' do
    let(:csv_file) do
      path = Rails.root.join('spec', 'fixtures', 'test_matrix.csv')
      fixture_file_upload(path, 'text/csv')
    end

    before do
      allow(ActionDispatch::Http::UploadedFile).to receive(:new).and_return(csv_file)
      params = ActionController::Parameters.new(file: csv_file)
      @matrix_handler = MatrixHandler.new(params)
    end

    describe 'matrix_format' do
      it 'should print matrix rows separated by coma.' do
        expect(@matrix_handler.matrix_format).equal?("1,2,3\n4,5,6\n7,8,9")
      end
    end

    describe 'flatten' do
      it 'should print matrix itens separated by coma.' do
        expect(@matrix_handler.flatten).equal?('1,2,3,4,5,6,7,8,9')
      end
    end

    describe 'invert' do
      it 'should print matrix invert columns and rows.' do
        expect(@matrix_handler.invert).equal?('[[1,4,7],[2,5,8],[3,6,9]]')
      end
    end

    describe 'sum' do
      it 'should print matrix sum items.' do
        expect(@matrix_handler.sum).equal?(45)
      end
    end

    describe 'multiply' do
      it 'should print matrix multiply of items.' do
        expect(@matrix_handler.multiply).equal? 362_880
      end
    end
  end
end
