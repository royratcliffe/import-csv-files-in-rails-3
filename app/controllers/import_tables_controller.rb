class ImportTablesController < ApplicationController
  # GET /import_tables
  # GET /import_tables.xml
  def index
    @import_tables = ImportTable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @import_tables }
    end
  end

  # GET /import_tables/1
  # GET /import_tables/1.xml
  def show
    @import_table = ImportTable.find(params[:id])
    @import_cells = @import_table.import_cells
    @row_index_max = @import_cells.map { |cell| cell.row_index }.max
    @column_index_max = @import_cells.map { |cell| cell.column_index }.max
    @tables = ActiveRecord::Base.connection.tables.select { |t| t != 'schema_migrations' }

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @import_table }
    end
  end

  # GET /import_tables/new
  # GET /import_tables/new.xml
  def new
    @import_table = ImportTable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @import_table }
    end
  end

  # GET /import_tables/1/edit
  def edit
    @import_table = ImportTable.find(params[:id])
  end

  # POST /import_tables
  # POST /import_tables.xml
  def create
    @import_table = ImportTable.new(params[:import_table])

    respond_to do |format|
      if @import_table.save
        format.html { redirect_to(@import_table, :notice => 'Import table was successfully created.') }
        format.xml  { render :xml => @import_table, :status => :created, :location => @import_table }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @import_table.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /import_tables/1
  # PUT /import_tables/1.xml
  def update
    @import_table = ImportTable.find(params[:id])

    respond_to do |format|
      if @import_table.update_attributes(params[:import_table])
        format.html { redirect_to(@import_table, :notice => 'Import table was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @import_table.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /import_tables/1
  # DELETE /import_tables/1.xml
  def destroy
    @import_table = ImportTable.find(params[:id])
    @import_table.destroy

    respond_to do |format|
      format.html { redirect_to(import_tables_url) }
      format.xml  { head :ok }
    end
  end
  
  def merge
    # Uncomment the following line if you want to debug this method. However,
    # do not forget to uncomment the gem 'ruby-debug' in Gemfile also; this
    # assumes you have the ruby-debug gem installed too, and do the usual
    # thing if not, i.e. sudo gem install ruby-debug. Calling "debugger"
    # inserts a break point when the server hits this point in the
    # application. From that point you can interrogate the Rails state, single
    # step over or into message-sends and so forth. Very useful for debugging!
    #
    # debugger
    
    import_table = ImportTable.find(params[:id])
    import_cells = import_table.import_cells
    row_index_max = import_cells.map { |cell| cell.row_index }.max
    column_index_max = import_cells.map { |cell| cell.column_index }.max
    
    # Pull the merge parameters from the POST request. The form sets up the
    # column mappings and merge table choice. Then use a little bit of
    # ActiveRecord introspection to derive the table's class name followed by
    # the class object. We will use this latter object to instantiate the
    # merged records.
    merge = params[:merge]
    merge_table = merge[:table]
    klass = ActiveRecord::Base.const_get(ActiveRecord::Base.class_name(merge_table))
    
    # Determine which columns have been mapped. Ignore the rest. Intersect the
    # requested column names with actual column names. Perhaps we should abort
    # and display some error message if the intersection proves empty because
    # the user did not select any columns.
    inverted_merge = merge.invert
    column_names = inverted_merge.keys & klass.column_names
    
    # Finally, create new instances, one per row. Iterate the rows, then for
    # each row, iterate the mapped columns. Select the matching cell and
    # update the record's corresponding column. Redirect to the merged table
    # when done.
    0.upto(row_index_max) do |row_index|
      row = import_cells.select { |cell| cell.row_index == row_index }
      instance = klass.new
      column_names.each do |column_name|
        column_index = inverted_merge[column_name].to_i
        contents = row.select { |cell| cell.column_index == column_index }[0].contents
        instance[column_name] = contents
      end
      instance.save
    end
    eval "redirect_to #{merge_table}_path"
  end
end
