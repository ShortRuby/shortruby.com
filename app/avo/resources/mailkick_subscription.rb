class Avo::Resources::MailkickSubscription < Avo::BaseResource
  self.includes = []
  self.model_class = ::Mailkick::Subscription
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :subscriber_type, as: :text
    field :subscriber_id, as: :number
    field :list, as: :text
    field :subscriber, as: :belongs_to
  end
end
