Engineering::Admin.controllers :suppliers do
  get :index do
    @title = "Suppliers"
    @suppliers = Supplier.all
    render 'suppliers/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'supplier')
    @supplier = Supplier.new
    render 'suppliers/new'
  end

  post :create do
    @supplier = Supplier.new(params[:supplier])
    if @supplier.save
      @title = pat(:create_title, :model => "supplier #{@supplier.id}")
      flash[:success] = pat(:create_success, :model => 'Supplier')
      params[:save_and_continue] ? redirect(url(:suppliers, :index)) : redirect(url(:suppliers, :edit, :id => @supplier.id))
    else
      @title = pat(:create_title, :model => 'supplier')
      flash.now[:error] = pat(:create_error, :model => 'supplier')
      render 'suppliers/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "supplier #{params[:id]}")
    @supplier = Supplier.find(params[:id])
    if @supplier
      render 'suppliers/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'supplier', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "supplier #{params[:id]}")
    @supplier = Supplier.find(params[:id])
    if @supplier
      if @supplier.update_attributes(params[:supplier])
        flash[:success] = pat(:update_success, :model => 'Supplier', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:suppliers, :index)) :
          redirect(url(:suppliers, :edit, :id => @supplier.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'supplier')
        render 'suppliers/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'supplier', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Suppliers"
    supplier = Supplier.find(params[:id])
    if supplier
      if supplier.destroy
        flash[:success] = pat(:delete_success, :model => 'Supplier', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'supplier')
      end
      redirect url(:suppliers, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'supplier', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Suppliers"
    unless params[:supplier_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'supplier')
      redirect(url(:suppliers, :index))
    end
    ids = params[:supplier_ids].split(',').map(&:strip).map(&:to_i)
    suppliers = Supplier.find(ids)
    
    if Supplier.destroy suppliers
    
      flash[:success] = pat(:destroy_many_success, :model => 'Suppliers', :ids => "#{ids.to_sentence}")
    end
    redirect url(:suppliers, :index)
  end
end
