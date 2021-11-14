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
    read_file
  end

  def readble?
    @valid = validate_matrix_square
    @valid
  end

  private

  def validate_matrix_square
    matrix_rows_size = @matrix.length
    matrix_amount_items = @matrix.flatten.size
    matrix_amount_items == (matrix_rows_size * matrix_rows_size)
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
