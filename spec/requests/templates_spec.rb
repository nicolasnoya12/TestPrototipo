require 'rails_helper'

describe 'Templates API', type: :request do
    before(:each) do
          ActiveRecord::Base.connection.tables.each do |table|
          ActiveRecord::Base.connection.execute("TRUNCATE #{table} RESTART IDENTITY CASCADE")
        end
      end
    
    let!(:first_user) { FactoryBot.create(:user, nombre: 'Nacho', email: 'nacho@gmail', username: 'user1') }
    let!(:second_user) { FactoryBot.create(:user, nombre: 'Paula', email: 'pau@gmail', username: 'user2') }
    describe 'GET /templates' do
        before do
            FactoryBot.create(:template, nombre: 'Prueba spec template 1', descripcion: 'Esta es la prueba de testing 1', user: first_user)
            FactoryBot.create(:template, nombre: 'Prueba spec template 2', descripcion: 'Esta es la prueba de testing 2', user: second_user)
        end
        it 'returns all templates' do

            get '/api/v1/templates'
            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(2)
            expect(response_body).to eq(
                [
                    {
                        'id' => 1,
                        'nombre' => 'Prueba spec template 1',
                        'descripcion' => 'Esta es la prueba de testing 1',
                        'user_email' => 'nacho@gmail',
                        'user_username_name' => 'Nacho user1'
                    },
                    {
                        'id' => 2,
                        'nombre' => 'Prueba spec template 2',
                        'descripcion' => 'Esta es la prueba de testing 2',
                        'user_email' => 'pau@gmail',
                        'user_username_name' => 'Paula user2'
                    }
                ]
            )
        end
    end

    describe 'POST /templates' do
        it 'create a new template' do
            expect {
                post '/api/v1/templates', params: {
                    template: {nombre: 'pruebita', descripcion: 'desc pruebita'},
                    user: {nombre: 'nico noya', email: 'nico@gm', username: "niconoy7"}
                }
            }.to change { Template.count }.from(0).to(1)

            expect(response).to have_http_status(:created)
            expect(User.count).to eq(3)
            expect(response_body).to eq(
                {
                    'id' => 1,
                    'nombre' => 'pruebita',
                    'descripcion' => 'desc pruebita',
                    'user_email' => 'nico@gm',
                    'user_username_name' => 'nico noya niconoy7'
                }
            )
        end
    end

    describe 'DELETE /templates/:id' do
        let!(:template) { FactoryBot.create(:template, nombre: 'Prueba spec 1', descripcion: "Esta es la prueba de testing 1", user: first_user)}

        it 'delete a template' do
            #template = FactoryBot.create(:template, nombre: 'Prueba spec 1', descripcion: "Esta es la prueba de testing 1");
            # delete '/api/v1/templates/1', params: {template: {nombre: 'pruebita', descripcion: 'desc pruebita'}}

            expect{
                delete "/api/v1/templates/#{template.id}"
            }.to change { Template.count }.from(1).to(0)
            expect(response).to have_http_status(:no_content)

        end
    end

end