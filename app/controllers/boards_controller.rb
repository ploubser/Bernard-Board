class BoardsController < ApplicationController
  # GET /boards
  # GET /boards.xml
  def index
    @boards = Board.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @boards }
    end
  end

  # GET /boards/1
  # GET /boards/1.xml
  def show
    @board = Board.find(params[:id])

    redirect_to :controller => "griditems", :action => :index, :fullscreen => true, :load_board => @board.name
    #respond_to do |format|
      #format.html # show.html.erb
      #format.xml  { render :xml => @boards }
    #end
  end

  # GET /boards/new
  # GET /boards/new.xml
  def new
    @boards = Board.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @boards }
    end
  end

  # GET /boards/1/edit
  def edit
    @boards = Board.find(params[:id])
  end

  # POST /boards
  # POST /boards.xml
  def create
    @boards = Board.new(params[:boards])

    respond_to do |format|
      if @boards.save
        flash[:notice] = 'Board was successfully created.'
        format.html { redirect_to(@boards) }
        format.xml  { render :xml => @boards, :status => :created, :location => @boards }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @boards.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boards/1
  # PUT /boards/1.xml
  def update
    @boards = Board.find(params[:id])

    respond_to do |format|
      if @boards.update_attributes(params[:boards])
        flash[:notice] = 'Board was successfully updated.'
        format.html { redirect_to(@boards) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @boards.errors, :status => :unprocessable_entity }
      end
    end
  end

  def delete_board
      Board.delete_all("name = '#{params[:name]}'") 
      BoardItem.delete_all("board = '#{params[:name]}'")
      render :update do |page|
          page.reload
      end
  end

end
