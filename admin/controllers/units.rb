Engineering::Admin.controllers :units do
  get :index do
    @title = "Units"
    @units = Unit.all
    render 'units/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'unit')
    @unit = Unit.new
    render 'units/new'
  end

  post :create do
    @unit = Unit.new(params[:unit])
    if @unit.save
      @title = pat(:create_title, :model => "unit #{@unit.id}")
      flash[:success] = pat(:create_success, :model => 'Unit')
      params[:save_and_continue] ? redirect(url(:units, :index)) : redirect(url(:units, :edit, :id => @unit.id))
    else
      @title = pat(:create_title, :model => 'unit')
      flash.now[:error] = pat(:create_error, :model => 'unit')
      render 'units/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "unit #{params[:id]}")
    @unit = Unit.find(params[:id])
    if @unit
      render 'units/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'unit', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "unit #{params[:id]}")
    @unit = Unit.find(params[:id])
    if @unit
      if @unit.update_attributes(params[:unit])
        flash[:success] = pat(:update_success, :model => 'Unit', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:units, :index)) :
          redirect(url(:units, :edit, :id => @unit.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'unit')
        render 'units/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'unit', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Units"
    unit = Unit.find(params[:id])
    if unit
      if unit.destroy
        flash[:success] = pat(:delete_success, :model => 'Unit', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'unit')
      end
      redirect url(:units, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'unit', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Units"
    unless params[:unit_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'unit')
      redirect(url(:units, :index))
    end
    ids = params[:unit_ids].split(',').map(&:strip).map(&:to_i)
    units = Unit.find(ids)
    
    if Unit.destroy units
    
      flash[:success] = pat(:destroy_many_success, :model => 'Units', :ids => "#{ids.to_sentence}")
    end
    redirect url(:units, :index)
  end
end
