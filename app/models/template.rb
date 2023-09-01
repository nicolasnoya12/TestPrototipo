class Template < ApplicationRecord
    validates :nombre, presence: true, length: {minimum: 3}
    validates :descripcion, presence: true, length: {minimum: 5}
    belongs_to :user
end
