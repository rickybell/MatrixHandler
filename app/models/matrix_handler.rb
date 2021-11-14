# MatrixHandler class
class MatrixHandler
  include ActiveModel::Validations
  include ActiveRecord::Callbacks

  validates :params, presence: true
  validates :matrix, presence: true
  validates :file, presence: true
  validate :validate_matrix_square, on: :read

  # , :read_file
  validates_presence_of :params, :matrix, :file
  after_create :read_file

  attr_accessor :params, :matrix, :file

  @valid = false

  def initialize(params = nil)
    @params = params
    errors.add(:body, 'Invalid file parameter.') if read_file
  end

  def handlable?
    @valid = validate_matrix_square
    @valid
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
    matrix_rows_size = @matrix.length
    matrix_amount_items = @matrix.flatten.size
    if matrix_amount_items == (matrix_rows_size * matrix_rows_size)
      errors.add(:body, 'Invalid matrix.')
      true
    else
      false
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
