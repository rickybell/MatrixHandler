# EchosController class
class EchosController < ApplicationController
  def show
    matrix_handler = MatrixHandler.new(params)

    if matrix_handler.handlable?
      result = {
        matrix_format: matrix_handler.matrix_format,
        invert: matrix_handler.invert,
        flatten: matrix_handler.flatten,
        sum: matrix_handler.sum,
        multiply: matrix_handler.multiply
      }

      render json: result, status: :ok
    else
      render json: matrix_handler.errors, status: 500
    end
  end
end
