class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @list_of_products = current_user.products.order({ :created_at => :desc })

    render({ :template => "product_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_product = current_user.products.where({ :id => the_id }).at(0)

    render({ :template => "product_templates/show" })
  end

  def create
    the_product = Product.new
    the_product.name = params.fetch("query_name")
    the_product.brand = params.fetch("query_brand")
    the_product.open_date = params.fetch("query_open_date")
    the_product.pao_months = params.fetch("query_pao_months")
    the_product.notes = params.fetch("query_notes")
    the_product.photo = params.fetch("query_photo", nil)
    the_product.user_id = current_user.id
    the_product.category_id = params.fetch("query_category_id", nil)

    if the_product.valid?
      the_product.save
      redirect_to("/products", { :notice => "Product created successfully." })
    else
      redirect_to("/products", { :alert => the_product.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_product = current_user.products.where({ :id => the_id }).at(0)

    the_product.name = params.fetch("query_name")
    the_product.brand = params.fetch("query_brand")
    the_product.open_date = params.fetch("query_open_date")
    the_product.pao_months = params.fetch("query_pao_months")
    the_product.notes = params.fetch("query_notes")
    the_product.photo = params.fetch("query_photo", nil)
    the_product.category_id = params.fetch("query_category_id", nil)

    if the_product.valid?
      the_product.save
      redirect_to("/products/#{the_product.id}", { :notice => "Product updated successfully." })
    else
      redirect_to("/products/#{the_product.id}", { :alert => the_product.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_product = current_user.products.where({ :id => the_id }).at(0)

    the_product.destroy

    redirect_to("/products", { :notice => "Product deleted successfully." })
  end

  #can't seem to work directly with ai gem so had ot use http version
  def ai_lookup
    body = JSON.parse(request.body.read)
    product_name = body.fetch("product_name")

    response = HTTP
      .headers("Authorization" => "Bearer #{ENV["AICHAT_PROXY_KEY"]}")
      .post("https://prepend.me/api.openai.com/v1/chat/completions", json: {
                                                                       model: "gpt-4.1-mini",
                                                                       messages: [
                                                                         { role: "system", content: "You are a makeup product expert. When given a product name, return ONLY a JSON object with these fields: brand (string), pao_months (integer), category (one of: Skincare, Face, Eye, Lip, Nails, Hair, SPF, Body). No extra text, just the JSON." },
                                                                         { role: "user", content: "What are the details for this makeup product: #{product_name}" },
                                                                       ],
                                                                     })

    result = JSON.parse(response.body.to_s)

    content_string = result.dig("choices", 0, "message", "content")

    if content_string.nil?
      render json: { error: "Could not find product" }, status: 422
    else
      content_string = content_string.gsub(/```json\n?/, "").gsub(/```\n?/, "").strip
      render json: JSON.parse(content_string)
    end
  end

  def new
    render({ :template => "product_templates/new" })
  end

  def toss
    the_id = params.fetch("path_id")
    the_product = current_user.products.where({ :id => the_id }).at(0)
    the_product.tossed = true
    the_product.save
    redirect_to("/products", { :notice => "Product tossed!" })
  end
end
