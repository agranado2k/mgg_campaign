require "test_helper"

class CampaignDetailsTest < Minitest::Test
  def setup
    Repositories::Repository.register(:vote, Repositories::VoteInMemoryRepo.new)
    Repositories::Repository.register(:campaign, Repositories::CampaignInMemoryRepo.new)
    vote_attr_1 = {Campaign: "ssss_uk_01B", Validity: "during", Choice: "Jane", CONN: "MIG01TU", MSISDN: "00777779489999", GUID: "190E96A8-89CA-41F8-9611-91F3490ACCA4", Shortcode: 63334}
    vote_attr_2 = {Campaign: "ssss_uk_01B", Validity: "pre", Choice: "Jane", CONN: "MIG01TU", MSISDN: "00777779489999", GUID: "190E96A8-89CA-41F8-9611-91F3490ACCA4", Shortcode: 63334}
    vote_attr_3 = {Campaign: "ssss_uk_01B", Validity: "during", Choice: "GRAYSON", CONN: "MIG01OU", MSISDN: "00777771739999", GUID: "36E30841-0B9A-47FF-9A13-AA97A27A2E18", Shortcode: 63339}
    Repositories::Repository.for(:vote).new_entity(vote_attr_1)
    Repositories::Repository.for(:vote).new_entity(vote_attr_2)
    Repositories::Repository.for(:vote).new_entity(vote_attr_3)
    @votes = Repositories::Repository.for(:vote).all
    campaign_attr = {name: "ssss_uk_01B", votes: @votes}
    @campaign = Repositories::Repository.for(:campaign).new_entity(campaign_attr)

    @campaign_detail = UseCases::CampaignDetails.new
  end

  def test_campagin_detail
    pos_result = [{choice: "Jane", valid_votes: 1, invalid_votes: 1},
                  {choice: "GRAYSON", valid_votes: 1, invalid_votes: 0}]

    assert_equal pos_result, @campaign_detail.detail(@campaign)
  end

  def test_evalute_votes
    pos_result = [{choice: "Jane", valid_votes: 1, invalid_votes: 1},
                  {choice: "GRAYSON", valid_votes: 1, invalid_votes: 0}]

    assert_equal pos_result, @campaign_detail.count_votes(@votes)
  end

  def test_result_for_one_invalid_vote
    vote_attr = {Campaign: "ssss_uk_01B", Validity: "pre", Choice: "Jane", CONN: "MIG01TU", MSISDN: "00777779489999", GUID: "190E96A8-89CA-41F8-9611-91F3490ACCA4", Shortcode: 63334}
    vote = Repositories::Repository.for(:vote).new_entity(vote_attr)
    pre_result = {}
    pos_result = {"Jane" => {choice: "Jane", valid_votes: 0, invalid_votes: 1}}

    assert_equal pos_result, @campaign_detail.eval_vote(vote, pre_result)
  end

  def test_result_for_one_valid_vote
    vote_attr = {Campaign: "ssss_uk_01B", Validity: "during", Choice: "Jane", CONN: "MIG01TU", MSISDN: "00777779489999", GUID: "190E96A8-89CA-41F8-9611-91F3490ACCA4", Shortcode: 63334}
    vote = Repositories::Repository.for(:vote).new_entity(vote_attr)
    pre_result = {}
    pos_result = {"Jane" => {choice: "Jane", valid_votes: 1, invalid_votes: 0}}

    assert_equal pos_result, @campaign_detail.eval_vote(vote, pre_result)
  end

  def test_vote_during_as_valid
    vote_attr = {Campaign: "ssss_uk_01B", Validity: "during", Choice: "Jane", CONN: "MIG01TU", MSISDN: "00777779489999", GUID: "190E96A8-89CA-41F8-9611-91F3490ACCA4", Shortcode: 63334}
    vote = Repositories::Repository.for(:vote).new_entity(vote_attr)

    assert @campaign_detail.vote_valid?(vote)
  end

  def test_vote_pre_as_invalid
    vote_attr = {Campaign: "ssss_uk_01B", Validity: "pre", Choice: "Jane", CONN: "MIG01TU", MSISDN: "00777779489999", GUID: "190E96A8-89CA-41F8-9611-91F3490ACCA4", Shortcode: 63334}
    vote = Repositories::Repository.for(:vote).new_entity(vote_attr)

    refute @campaign_detail.vote_valid?(vote)
  end

  def test_vote_pos_as_invalid
    vote_attr = {Campaign: "ssss_uk_01B", Validity: "pos", Choice: "Jane", CONN: "MIG01TU", MSISDN: "00777779489999", GUID: "190E96A8-89CA-41F8-9611-91F3490ACCA4", Shortcode: 63334}
    vote = Repositories::Repository.for(:vote).new_entity(vote_attr)

    refute @campaign_detail.vote_valid?(vote)
  end
end
