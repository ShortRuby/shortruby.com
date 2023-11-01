# frozen_string_literal: true

class Avo::Resources::Subscriber < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :email, as: :text
    field :mailkick_subscriptions, as: :has_many
  end
end
