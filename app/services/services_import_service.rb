module ServicesImportService
  MODEL_CLASS = Service
  KCSC_API_KEY = Rails.application.credentials.kcsc_api_key
  API_URL = 'https://www.kcsc.org.uk'
  PATH = '/api/self-care/all?key='
  ADDRESSES_PATH = '/api/self-care/addresses/all?key='

  def self.import
    response = RestClient.get "#{API_URL}#{PATH}#{KCSC_API_KEY}"
    return unless response_has_content?(response)

    addresses_response = RestClient.get "#{API_URL}#{ADDRESSES_PATH}#{KCSC_API_KEY}"
    kcsc_contacts = JSON.parse(response.body)['organisations']
    kcsc_contact_addresses = JSON.parse(addresses_response.body)['addresses']
    find_or_create_organisations(kcsc_contacts, kcsc_contact_addresses)
  end

  def self.response_has_content?(response)
    response.body && response.body != '{}'
  end

  def self.find_or_create_organisations(kcsc_contacts, kcsc_contact_addresses)
    kcsc_contacts.zip(kcsc_contact_addresses).each do |contact, address|
      model = MODEL_CLASS.find_or_initialize_by imported_id: id(contact)
      save_model_attributes model, contact, address
    end
  end

  def self.id(contact)
    Integer(contact['organisation']['Contact ID'])
  end

  def self.save_model_attributes(model, contact, address)
    model.imported_at = Time.current
    model.imported_from = API_URL
    model.name = contact['organisation']['Delivered by-Organization Name'].titleize
    model.description = description(contact)
    model.telephone = contact['organisation']['OfficeMain-Phone-General Phone']
    model.email = contact['organisation']['OfficeMain-Email']
    model.website = contact['organisation']['Website']
    model.publish_telephone = contact['organisation']['OfficeMain-Phone-General Phone'].blank? ? true : false
    model.publish_address = true
    model.address = full_address(address)
    model.postcode = address['address']['postal_code'] || ''
    model.latitude = address['address']['Latitude']
    model.longitude = address['address']['Longitude']
    model.save!
  end

  def self.full_address(address)
    return address['address']['Street Address'] if address['address']['city'].blank?
    return address['address']['city'] if address['address']['Street Address'].blank?
    "#{address['address']['Street Address']} #{address['address']['city']}"
  end

  def self.description(contact)
    description = contact['organisation']['Service Activities']
    description = contact['organisation']['Summary of Activities'] if description.blank?
    description = '' if description.blank?
    description
  end
end
