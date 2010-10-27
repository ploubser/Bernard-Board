class BoardsController < ApplicationController
  def index
      @boards = Board.paginate :page => params[:page], :order => 'created_at DESC'

    respond_to do |format|
      format.html
      format.xml  { render :xml => @boards }
      format.js {
        render :update do |page|
            page.replace_html 'container', :partial => 'board_results'
            page << "bindPaginate()"
        end
      }
    end
  end
  
  def show
    @board = Board.find(params[:id])

    redirect_to :controller => "griditems", :action => :index, :fullscreen => true, :load_board => @board.name
  end

  def new
    @boards = Board.new

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @boards }
    end
  end

  def edit
    @boards = Board.find(params[:id])
  end

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
