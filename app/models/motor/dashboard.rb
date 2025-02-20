# frozen_string_literal: true

module Motor
  class Dashboard < ::Motor::ApplicationRecord
    audited

    belongs_to :author, polymorphic: true, optional: true

    has_many :taggable_tags, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggable_tags, class_name: 'Motor::Tag'

    attribute :preferences, default: -> { HashWithIndifferentAccess.new }
    serialize :preferences, HashSerializer

    scope :active, -> { where(deleted_at: nil) }

    def queries
      Motor::Query.where(id: preferences[:layout].pluck(:query_id))
    end
  end
end
