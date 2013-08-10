json.array!(@organizations) do |organization|
  json.extract! organization, :name, :synopsis, :website, :email, :phone, :status, :slug, :submitter_name, :submitter_email, :submitter_phone
  json.url organization_url(organization, format: :json)
end
