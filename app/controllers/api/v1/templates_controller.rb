module Api 
    module V1
        class TemplatesController < ApplicationController

            # rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
            def index
                #render json: Template.all
                #templates = Template.all
                templates = Template.limit(params[:limit]).offset(params[:offset])
                render json: TemplatesRepresenter.new(templates).as_json
            end

            def create
                #binding.irb da mas info
                #template = Template.new(nombre: 'Prueba numero dos', descripcion: 'esta es una segunda prueba desde el controlador')
                #template = Template.new(nombre: params[:nombre], descripcion: params[:descripcion])
                user = User.create!(user_params)
                template = Template.new(template_params.merge(user_id: user.id))

                if template.save
                    render json: TemplateRepresenter.new(template).as_json, status: :created
                    #render json: template, status: :created
                    #render json: template, status: :201
                else
                    render json: template.errors, status: :unprocessable_entity
                    #status: :unproccessable_entity es 422
                end
            end

            def destroy
                Template.find(params[:id]).destroy! 
                head :no_content
            # Poco generico
            #rescue ActiveRecord::RecordNotDestroyed....application_controller
            end

            private 

            def user_params
                params.require(:user).permit(:nombre, :email, :username)
            end

            def template_params
                params.require(:template).permit(:nombre, :descripcion)
            end
        end
    end
end