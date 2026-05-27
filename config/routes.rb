Rails.application.routes.draw do



  post("/insert_product", { :controller => "products", :action => "create" })
  get("/products/new", { :controller => "products", :action => "new" })

  get("/products", { :controller => "products", :action => "index" })
  get("/products/:path_id", { :controller => "products", :action => "show" })
  post("/modify_product/:path_id", { :controller => "products", :action => "update" })
  get("/delete_product/:path_id", { :controller => "products", :action => "destroy" })
  


  post("/insert_category", { :controller => "categories", :action => "create" })

  get("/categories", { :controller => "categories", :action => "index" })

  get("/categories/:path_id", { :controller => "categories", :action => "show" })

  post("/modify_category/:path_id", { :controller => "categories", :action => "update" })

  get("/delete_category/:path_id", { :controller => "categories", :action => "destroy" })

  post("/ai_lookup", { :controller => "products", :action => "ai_lookup" })

  devise_for :users

  root "products#index"
end
