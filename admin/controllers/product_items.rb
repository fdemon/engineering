Engineering::Admin.controllers :product_items do
  get :index do
    @title = "Product_items"
    @product_items = ProductItem.all
    render 'product_items/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'product_item')
    @product_item = ProductItem.new
    render 'product_items/new'
  end

  post :create do
    @product_item = ProductItem.new(params[:product_item])
    if @product_item.save
      @title = pat(:create_title, :model => "product_item #{@product_item.id}")
      flash[:success] = pat(:create_success, :model => 'ProductItem')
      params[:save_and_continue] ? redirect(url(:product_items, :index)) : redirect(url(:product_items, :edit, :id => @product_item.id))
    else
      @title = pat(:create_title, :model => 'product_item')
      flash.now[:error] = pat(:create_error, :model => 'product_item')
      render 'product_items/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "product_item #{params[:id]}")
    @product_item = ProductItem.find(params[:id])
    if @product_item
      render 'product_items/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'product_item', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "product_item #{params[:id]}")
    @product_item = ProductItem.find(params[:id])
    if @product_item
      if @product_item.update_attributes(params[:product_item])
        flash[:success] = pat(:update_success, :model => 'Product_item', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:product_items, :index)) :
          redirect(url(:product_items, :edit, :id => @product_item.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'product_item')
        render 'product_items/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'product_item', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Product_items"
    product_item = ProductItem.find(params[:id])
    if product_item
      if product_item.destroy
        flash[:success] = pat(:delete_success, :model => 'Product_item', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'product_item')
      end
      redirect url(:product_items, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'product_item', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Product_items"
    unless params[:product_item_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'product_item')
      redirect(url(:product_items, :index))
    end
    ids = params[:product_item_ids].split(',').map(&:strip).map(&:to_i)
    product_items = ProductItem.find(ids)
    
    if ProductItem.destroy product_items
    
      flash[:success] = pat(:destroy_many_success, :model => 'Product_items', :ids => "#{ids.to_sentence}")
    end
    redirect url(:product_items, :index)
  end
end
