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
end
