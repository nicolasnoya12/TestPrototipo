class TemplatesRepresenter
    def initialize(templates)
        @templates = templates
    end

    def as_json
        templates.map do |template|
            {
                id: template.id,
                nombre: template.nombre,
                descripcion: template.descripcion,
                #user_nombre: template.user.nombre,
                user_email: template.user.email,
                #user_username: template.user.username
                user_username_name: user_username_name(template)

            }
        end
    end

    private 

    attr_reader :templates

    def user_username_name(template)
        "#{template.user.nombre} #{template.user.username}"
    end
end