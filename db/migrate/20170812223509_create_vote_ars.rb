class CreateVoteArs < ActiveRecord::Migration[5.1]
  def change
    create_table :vote_ars do |t|
      t.belongs_to :campaign_ar
      t.string :campaign
      t.string :validity
      t.string :choice
      t.string :conn
      t.string :msisdn
      t.string :guid
      t.integer :short_code

      t.timestamps
    end
  end
end
