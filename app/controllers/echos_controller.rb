# EchosController class
class EchosController < ApplicationController
  def show
    # result = {
    #   matrix_format: '',
    #   invert: '',
    #   flatten: '',
    #   sum: '',
    #   multiply: ''
    # }

    matrix_handler = MatrixHandler.new(params)
    # matrix = matrix_handler.matrix

    render json: matrix_handler.errors, status: 500 unless matrix_handler.handlable?

    result = {
      matrix_format: matrix_handler.matrix_format,
      invert: matrix_handler.invert,
      flatten: matrix_handler.flatten,
      sum: matrix_handler.sum,
      multiply: matrix_handler.multiply
    }

    # result[:matrix_format] = matrix.map { |row| row.join(',') }.join("\n")
    # result[:flatten] = matrix.join(',')
    # result[:invert] = matrix.transpose
    # result[:sum] = matrix.flatten.sum
    # result[:multiply] = matrix.flatten.inject(1, :*)

    render json: result, status: :ok
  end
end
