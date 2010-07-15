class CsvController < ApplicationController
  def import
  end

  def upload
    # While under development, just respond by rendering some in-line text.
    # Send back the request parameters in JSON (JavaScript Object Notation)
    # format, i.e. something reasonably easy to parse with the human eye.
    render :text => params.to_json
  end
end
