# EchosController class
class EchosController < ApplicationController
  def show
    result = {
      matrix_format: '',
      invert: '',
      flatten: '',
      sum: '',
      multiply: ''
    }

    # file = params[:file].tempfile
    # matrix = []
    # File.open(file, 'r') do |f|
    #   f.each_line do |line|
    #     matrix.push(eval("[#{line}]"))
    #   end
    # end

    # result[:matrix_format] = matrix.map { |row| row.join(',') }.join("\n")
    # result[:flatten] = matrix.join(',')
    # result[:invert] = matrix.transpose
    # result[:sum] = matrix.flatten.sum
    # result[:multiply] = matrix.flatten.inject(1, :*)

    matrix_handler = MatrixHandler.new(params)
    matrix = matrix_handler.matrix

    Rails.logger.debug matrix_handler.matrix.inspect
    result = {}

    result[:matrix_format] = matrix.map { |row| row.join(',') }.join("\n")
    result[:flatten] = matrix.join(',')
    result[:invert] = matrix.transpose
    result[:sum] = matrix.flatten.sum
    result[:multiply] = matrix.flatten.inject(1, :*)

    render json: result, status: :ok
  end
end
