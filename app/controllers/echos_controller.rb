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

    file = params[:file]
    matrix = []
    File.open(file.tempfile, 'r') do |f|
      f.each_line do |line|
        matrix.push(eval("[#{line}]"))
      end
    end

    result[:matrix_format] = matrix.map { |row| row.join(',') }.join("\n")
    result[:flatten] = matrix.join(',')
    result[:invert] = matrix.transpose
    result[:sum] = matrix.flatten.sum
    result[:multiply] = matrix.flatten.inject(1, :*)

    render json: result, status: :ok
  end
end
