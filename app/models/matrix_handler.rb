# MatrixHandler class
class MatrixHandler
  include ActiveModel::Validations
  include ActiveRecord::Callbacks

  validates :params, presence: true
  validate :validate_params, on: :hand
  validate :validate_matrix_square, on: :hand

  # after_create :read_file

  attr_accessor :params, :matrix, :file

  @valid = false

  def initialize(params = nil)
    @params = params
    errors.add(:body, 'Invalid file parameter.') unless read_file
  end

  def handlable?
    return false unless validate_params

    return false unless validate_matrix_square

    true
  end

  def matrix_format
    @matrix.map { |row| row.join(',') }.join("\n")
  end

  def flatten
    @matrix.join(',')
  end

  def invert
    @matrix.transpose
  end

  def sum
    @matrix.flatten.sum
  end

  def multiply
    @matrix.flatten.inject(1, :*)
  end

  private

  def validate_matrix_square
    return false if @matrix.nil?

    matrix_rows_size = @matrix.length
    matrix_amount_items = @matrix.flatten.size
    if matrix_amount_items != (matrix_rows_size * matrix_rows_size)
      errors.add(:body, 'Matrix doesn\' have same number of cols and rows.')
      false
    else
      true
    end
  end

  def validate_params
    return if @params.nil? || @params[:file].nil?

    if File.zero?(@params[:file])
      errors.add(:body, 'Empty file.')
      false
    else
      true
    end
  end

  def read_file
    return if @params.nil? || @params[:file].nil?

    @file = @params[:file]

    return if @file.nil?

    @matrix = []

    File.open(@file, 'r') do |f|
      f.each_line do |line|
        @matrix.push(eval("[#{line}]"))
      end
    end
  end
end
