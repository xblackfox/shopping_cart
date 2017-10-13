require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do

	describe 'GET #index' do
		it do
			# create(:product, image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/GOLD.jpg'))))
			create(:product)
			get :index
			# ERROR
			expect(assigns(:products)).to eq(Product.all)
			expect(response).to render_template(:index)
		end
	end

	describe 'GET #new' do
		it do
			get :new
			expect(assigns(:product).persisted?).to eq(false)
			# persisted is saved, not persisted is not saved
			expect(response).to render_template(:new)
		end
	end

	# describe 'POST #create' do
	# 	context 'with valid product params' do
	# 		it do
	# 			# factory 
	# 			product_params = attributes_for(:product).transform_keys(&:to_s)

	# 			params = { product: product_params }
				
	# 			# ERROR
	# 			post :create, params: params

	# 			# controller
	# 			product = assigns(:product)
	# 			attributes_of_product = product.attributes.slice(*product_params.keys)

	# 			expect(product.persisted?).to be_truthy
	# 			expect(attributes_of_product).to eq(product_params)
	# 			expect(response).to redirect_to(admin_products_path)

	# 		end
	# 	end
	# end
	# 	context 'with invalid student params' do
	# 		it do
	# 			student_params = attributes_for(:student, :invalid).transform_keys(&:to_s)

	# 			params = { student: student_params }

	# 			post :create, params: params

	# 			student = assigns(:student)

	# 			expect(student.persisted?).to be_falsey
	# 			expect(response).to render_template(:new)
	# 		end
	# 	end			

	# end

end 
