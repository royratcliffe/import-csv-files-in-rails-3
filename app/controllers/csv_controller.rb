class CsvController < ApplicationController
  def import
  end

  def upload
    # The original implementation stored import cells as records. This is
    # convenient but not very efficient in cases where the number of cells is
    # very large. Performance degrades considerably for say 100,000 cells
    # (from a table of 10,000 rows by 10 columns). Although CSV parsing is
    # fast, as promised by FasterCSV, large volumes of table insertions gives
    # rise to significant latency. Not good.
    #
    # The new uploading method stores the import table verbatim in an external
    # store, specifically Amazon's S3. Hence the tables live outside the
    # database. This approach relies on CSV parsing speed, because controllers
    # parse the entire CSV at every page view. The file is sequential, with
    # no easy way around that unless we plan to index the CSV or chop it up
    # somehow.
    redirect_to import_table_path(ImportTable.create(params[:upload]))
  end
end
