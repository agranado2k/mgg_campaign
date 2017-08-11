module UseCases
  class CampaignDetails
    def detail(campaign)
      count_votes(campaign.votes)
    end

    def count_votes(votes)
      votes.reduce({}){|r, vote| r = eval_vote(vote, r)}.values
    end

    def eval_vote(vote, result)
      result[vote.choice] = {choice: vote.choice, valid_votes: 0, invalid_votes: 0} if result[vote.choice].nil?
      vote_valid?(vote) ? result[vote.choice][:valid_votes] += 1 : result[vote.choice][:invalid_votes] += 1
      result
    end

    def vote_valid?(vote)
      vote.validity == "during"
    end
  end
end
