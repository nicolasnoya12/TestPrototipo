class User < ApplicationRecord
    has_many :templates
    #validates :nombre, presence: true, length: {minimum: 3}
    #validates :descripcion, presence: true, length: {minimum: 5}
end
