require 'spec_helper'

describe DiscourseApi::API::Topics do
  subject { DiscourseApi::Client.new("http://localhost:3000", "test_d7fd0429940", "test_user") }

  describe "#invite_user_to_topic" do
    before do
      stub_post("http://localhost:3000/t/12/invite?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("topic_invite_user.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.invite_user_to_topic(email: "fake_user@example.com", topic_id: 12)
      expect(a_post("http://localhost:3000/t/12/invite?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns success" do
      response = subject.invite_user_to_topic(email: "fake_user@example.com", topic_id: 12)
      expect(response[:body]['success']).to be_truthy
    end
  end

  describe "#latest_topics" do
    before do
      stub_get("http://localhost:3000/latest.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("latest.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.latest_topics
      expect(a_get("http://localhost:3000/latest.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested topics" do
      topics = subject.latest_topics
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end
  end

  describe "#new_topics" do
    before do
      stub_get("http://localhost:3000/new.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("new.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.new_topics
      expect(a_get("http://localhost:3000/new.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested topics" do
      subject.api_username = 'test_user'
      topics = subject.new_topics
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end
  end

  describe "#topic" do
    before do
      stub_get("http://localhost:3000/t/57.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("topic.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.topic(57)
      expect(a_get("http://localhost:3000/t/57.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested topic" do
      topic = subject.topic(57)
      expect(topic).to be_a Hash
      expect(topic["id"]).to eq(57)
    end
  end

  describe "#topics_by" do
    before do
      stub_get("http://localhost:3000/topics/created-by/test.json?api_key=test_d7fd0429940&api_username=test_user").to_return(body: fixture("topics_created_by.json"), headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.topics_by('test')
      expect(a_get("http://localhost:3000/topics/created-by/test.json?api_key=test_d7fd0429940&api_username=test_user")).to have_been_made
    end

    it "returns the requested topics" do
      topics = subject.topics_by('test')
      expect(topics).to be_an Array
      expect(topics.first).to be_a Hash
    end
  end
end
