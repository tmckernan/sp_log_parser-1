# frozen_string_literal: true

require_relative '../errors/standard_file_error'
require_relative '../errors/file_not_found_error'
require_relative '../errors/unallowed_extension_error'

# Opens the allowed extensions files
# @return file handler [File]
class FileLoader
  ALLOWED_EXTENSIONS = %w[.log].freeze

  def load(file_path)
    raise StandardFileError, 'No file path provided' if file_path.nil? || file_path.empty?

    file_exists?(file_path)
    correct_extension?(file_path)

    File.new(file_path, 'r')
  end

  private

  def file_exists?(file_path)
    raise FileNotFoundError, "File not found [#{file_path}]" unless File.exist?(file_path)
  end

  def correct_extension?(file_path)
    return if ALLOWED_EXTENSIONS.include?(File.extname(file_path))

    raise UnallowedExtensionError, "File extension is unallowed. Allowed: #{ALLOWED_EXTENSIONS.join(', ')}"
  end
end
