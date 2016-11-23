require 'rails_helper'
require 'json_expressions/rspec'

RSpec.describe TaggingsController, type: :controller do

  describe "GET #index" do
    subject {get :index, format: :json}

    it "checks index response" do
      subject
      json = JSON.parse(response.body)
      expect(response).to be_success
    end

  end

  describe "GET #show" do

    let(:tagging) {Tagging.create("entity_type":"Product", "entity_id": "1246", "tags": ['Large', 'Pink', 'Bike'])}
    subject { get :show, id: tagging.id, format: :json }
    it "show tagging json" do
      subject
      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json['entity_type']).to eq("Product")
    end 

  end

  describe "TAGGING APIs" do

    it 'should return correct response for "/index"' do
      result  = RestClient.get('http://localhost:3000/taggings')
      expected_data = JSON.parse(IO.read('requests/index.json'))
      expect(result).to match_json_expression(expected_data)
    end

    it 'should return correct response for "/taggings/Product/1234"' do
      result = RestClient.get('http://localhost:3000/taggings/Product/1234')
      expected_data = JSON.parse(IO.read('requests/show_Product_1234.json'))
      expect(result).to match_json_expression(expected_data)
    end

    it 'should return correct response for "/stats"' do
      result  = RestClient.get('http://localhost:3000/stats')
      expected_data = JSON.parse(IO.read('requests/stats.json'))
      expect(result).to match_json_expression(expected_data)
    end

    it 'should return correct response for "/stats/Product/1234"' do
      result = RestClient.get('http://localhost:3000/stats/Product/1234') 
      expected_data = JSON.parse(IO.read('requests/stats_Product_1234.json'))
      expect(result).to match_json_expression(expected_data)
    end

    it 'should return correct response for "/post"' do
      #begin
        result = RestClient.post('http://localhost:3000/taggings', {"entity_type": "Article", "entity_id": "1245", "tags": "['sports', 'football']"}.to_json, {content_type: :json, accept: :json})
        puts "result:" + result.inspect
        result1 = RestClient.get('http://localhost:3000/taggings/Article/1245')
        expected_data = JSON.parse(IO.read('requests/post_Article_1245.json'))
        expect(result1).to match_json_expression(expected_data)
      #rescue RestClient::ExceptionWithResponse => e
      #end     
    end

    it 'should return correct response for "/put"' do
      #begin
        result = RestClient.put('http://localhost:3000/taggings/Article/1245', {"entity_type": "Article", "entity_id": "1245", "tags": "['sports', 'basketball']"}.to_json, {content_type: :json, accept: :json})
        result1 = RestClient.get('http://localhost:3000/taggings/Article/1245')
        expected_data = JSON.parse(IO.read('requests/put_Article_1245.json'))
        expect(result1).to match_json_expression(expected_data)
      #rescue RestClient::ExceptionWithResponse => e
      #end
    end

    it 'should return correct response for "/delete"' do
      begin
        result = RestClient.delete('http://localhost:3000/taggings/Article/1245')
      rescue RestClient::ExceptionWithResponse => e
      end
      result = RestClient.get('http://localhost:3000/stats')
      expected_data = JSON.parse(IO.read('requests/stats.json'))
      expect(result).to match_json_expression(expected_data)
    end
  end

end
